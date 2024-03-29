#.H1 indent.awk
#.H2 Synopsis
#.P gawk -f indent.awk file.sh
#.H2 Download
#.P Download from <a href="http://lawker.googlecode.com/svn/fridge/lib/awk/indent.awk">LAWKER</a>
#.h2 Description
#.P
# This is part of Phil's AWK tutorial at 
#<a href="http://www.bolthole.com/AWK.html">http://www.bolthole.com/AWK.html</a>.
# This program adjusts the indentation level based on which keywords are
# found in each line it encounters.
#.h2 Code
#.H3 doindent
#.PRE
function doindent(){
	tmpindent=indent;
	if(indent<0){
		print "ERROR; indent level == " indent
	}
	while(tmpindent >0){
		printf("    ");
		tmpindent-=1;
	}
}
#./PRE
#.H3 Out-denting
#.PRE
$1 == "done" 	{ indent -=1; }
$1 == "fi" 	{ indent -=1; }
$0 ~ /}/	{ if(indent!=0) indent-=1;  }
#./PRE
#.H3 Worker
#.P
# This is the 'default' action, that actually prints a line out.
# This gets called AS WELL AS any other matching clause, in the
# order they appear in this program.
# An "if" match is run AFTER we run this clause.
# A "done" match is run BEFORE we run this clause.
#.PRE
		{ 
		  doindent();
		  print $0;
		}
#./PRE
#.H3 In-denting
#.PRE
$0 ~ /if.*;[ ]*then/	{ indent+=1; }
$0 ~ /for.*;[ ]*do/	{ indent+=1; }
$0 ~ /while.*;[ ]*do/	{ indent+=1; }

$1 == "then"		{ indent+=1; }
$1 == "do"		{ indent+=1; }
$0 ~ /{$/		{ indent+=1; }
#./PRE
#.H2 Author
#.P Philip Brown  phil@bolthole.com
