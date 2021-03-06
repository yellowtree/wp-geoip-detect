#!/bin/bash

# @param string SVNURL

# Variables List
TITLE=$(head -n1 changelog.txt)
LICENSE=$(cat changelog.txt | grep "License URI:" | awk -F// '{ print $2 }' |  cat changelog.txt | grep "License URI:" | cut -d: -f2,3)
#echo $TITLE $LICENSE

# Remove Previous Files
if [ -e /tmp/file ] || [ -e /tmp/file1 ] || [ -e /tmp/file2 ]
then
        rm /tmp/file* &> /dev/null
fi




# Add Images
#curl -I $1/assets/banner-772x250.png 2> /dev/null | grep '200 OK' &> /dev/null
#if [ $? -eq 0 ]
#then
#	echo "![alt text]($1/assets/banner-772x250.png)" &> /tmp/file
#	echo >> /tmp/file
#fi
#curl -I $1/assets/banner-772x250.jpg 2> /dev/null | grep '200 OK' &> /dev/null
#if [ $? -eq 0 ]
#then
#	echo "![alt text]($1/assets/banner-772x250.jpg)" &> /tmp/file
#	echo >> /tmp/file
#fi
#curl -I $1/assets/banner-772x250.jpeg 2> /dev/null | grep '200 OK' &> /dev/null
#if [ $? -eq 0 ]
#then
#	echo "![alt text]($1/assets/banner-772x250.jpeg)" &> /tmp/file
#	echo >> /tmp/file
#fi


# Send All The Line Except The Lines All Ready Present in Temp File
cat changelog.txt >> /tmp/file


# Delete Unwanted Stuff
sed '/^Tags:/,/^Stable tag:/d' /tmp/file &>/tmp/file1
sed '/^== Upgrade/,/$/d' /tmp/file1 &> /tmp/file2

# Add New Line (Needed To Proper Solutions)
#sed -i '/Donate/ i\License: [GPLv2 or later] (http://www.gnu.org/licenses/gpl-2.0.html)' /tmp/file2

# Add New Lines For Line Breaks In Github
sed 's/Contributors/\'$'\n&/g' /tmp/file2 &> /tmp/file1
sed 's/License/\'$'\n&/g' /tmp/file1 &> /tmp/file2
sed 's/Donate/\'$'\n&/g' /tmp/file2 &> /tmp/file1



# Replace === to #
sed 's/===/#/g' /tmp/file1 &> /tmp/file2

# REplace == to ##
sed 's/==/##/g' /tmp/file2 &> /tmp/file1

# Replave = to #### From Description To The End Of File
#sed 's/^= /# /g' /tmp/file1 &> /tmp/file2
#sed 's/ =/ #/g' /tmp/file2 &> /tmp/file1


# Make Text Bold
sed 's/[Cc]ontributors:/* **Contributors:**/' /tmp/file2 &> /tmp/file1
sed 's/[Dd]onate [Ll]ink:/* **Donate Link:**/' /tmp/file1 &> /tmp/file2
sed 's/[Ll]icense:/* **License:**/' /tmp/file2 &> CHANGELOG.md

