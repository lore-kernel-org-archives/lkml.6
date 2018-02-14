Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162235AbeBNSke (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:40:34 -0500
Received: from ms.lwn.net ([45.79.88.28]:54642 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161773AbeBNSk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:40:29 -0500
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        jani.nikula@linux.intel.com, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/8] docs: kernel-doc: Get rid of xml_escape() and friends
Date: Wed, 14 Feb 2018 11:40:02 -0700
Message-Id: <20180214184009.12657-2-corbet@lwn.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214184009.12657-1-corbet@lwn.net>
References: <20180214184009.12657-1-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XML escaping is a worry that came with DocBook, which we no longer have any
dealings with.  So get rid of the useless xml_escape()/xml_unescape()
functions.  No change to the generated output.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/kernel-doc | 65 ++++++++----------------------------------------------
 1 file changed, 9 insertions(+), 56 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index fee8952037b1..5aa4ce211fc6 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -553,10 +553,9 @@ sub output_highlight {
 	}
 	if ($line eq ""){
 	    if (! $output_preformatted) {
-		print $lineprefix, local_unescape($blankline);
+		print $lineprefix, $blankline;
 	    }
 	} else {
-	    $line =~ s/\\\\\\/\&/g;
 	    if ($output_mode eq "man" && substr($line, 0, 1) eq ".") {
 		print "\\&$line";
 	    } else {
@@ -751,9 +750,6 @@ sub output_highlight_rst {
     my $contents = join "\n",@_;
     my $line;
 
-    # undo the evil effects of xml_escape() earlier
-    $contents = xml_unescape($contents);
-
     eval $dohighlight;
     die $@ if $@;
 
@@ -1422,8 +1418,6 @@ sub push_parameter($$$$) {
 		}
 	}
 
-	$param = xml_escape($param);
-
 	# strip spaces from $param so that it is one continuous string
 	# on @parameterlist;
 	# this fixes a problem where check_sections() cannot find
@@ -1748,47 +1742,6 @@ sub process_proto_type($$) {
     }
 }
 
-# xml_escape: replace <, >, and & in the text stream;
-#
-# however, formatting controls that are generated internally/locally in the
-# kernel-doc script are not escaped here; instead, they begin life like
-# $blankline_html (4 of '\' followed by a mnemonic + ':'), then these strings
-# are converted to their mnemonic-expected output, without the 4 * '\' & ':',
-# just before actual output; (this is done by local_unescape())
-sub xml_escape($) {
-	my $text = shift;
-	if ($output_mode eq "man") {
-		return $text;
-	}
-	$text =~ s/\&/\\\\\\amp;/g;
-	$text =~ s/\</\\\\\\lt;/g;
-	$text =~ s/\>/\\\\\\gt;/g;
-	return $text;
-}
-
-# xml_unescape: reverse the effects of xml_escape
-sub xml_unescape($) {
-	my $text = shift;
-	if ($output_mode eq "man") {
-		return $text;
-	}
-	$text =~ s/\\\\\\amp;/\&/g;
-	$text =~ s/\\\\\\lt;/</g;
-	$text =~ s/\\\\\\gt;/>/g;
-	return $text;
-}
-
-# convert local escape strings to html
-# local escape strings look like:  '\\\\menmonic:' (that's 4 backslashes)
-sub local_unescape($) {
-	my $text = shift;
-	if ($output_mode eq "man") {
-		return $text;
-	}
-	$text =~ s/\\\\\\\\lt:/</g;
-	$text =~ s/\\\\\\\\gt:/>/g;
-	return $text;
-}
 
 sub map_filename($) {
     my $file;
@@ -1889,7 +1842,7 @@ sub process_file($) {
 		    $descr =~ s/^\s*//;
 		    $descr =~ s/\s*$//;
 		    $descr =~ s/\s+/ /g;
-		    $declaration_purpose = xml_escape($descr);
+		    $declaration_purpose = $descr;
 		    $in_purpose = 1;
 		} else {
 		    $declaration_purpose = "";
@@ -1944,7 +1897,7 @@ sub process_file($) {
 			print STDERR "${file}:$.: warning: contents before sections\n";
 			++$warnings;
 		    }
-		    dump_section($file, $section, xml_escape($contents));
+		    dump_section($file, $section, $contents);
 		    $section = $section_default;
 		}
 
@@ -1962,7 +1915,7 @@ sub process_file($) {
 		$leading_space = undef;
 	    } elsif (/$doc_end/) {
 		if (($contents ne "") && ($contents ne "\n")) {
-		    dump_section($file, $section, xml_escape($contents));
+		    dump_section($file, $section, $contents);
 		    $section = $section_default;
 		    $contents = "";
 		}
@@ -1981,7 +1934,7 @@ sub process_file($) {
 		# @parameter line to signify start of description
 		if ($1 eq "") {
 		    if ($section =~ m/^@/ || $section eq $section_context) {
-			dump_section($file, $section, xml_escape($contents));
+			dump_section($file, $section, $contents);
 			$section = $section_default;
 			$contents = "";
                         $new_start_line = $.;
@@ -1992,7 +1945,7 @@ sub process_file($) {
 		} elsif ($in_purpose == 1) {
 		    # Continued declaration purpose
 		    chomp($declaration_purpose);
-		    $declaration_purpose .= " " . xml_escape($1);
+		    $declaration_purpose .= " " . $1;
 		    $declaration_purpose =~ s/\s+/ /g;
 		} else {
 		    my $cont = $1;
@@ -2030,7 +1983,7 @@ sub process_file($) {
 	    # Documentation block end */
 	    } elsif (/$doc_inline_end/) {
 		if (($contents ne "") && ($contents ne "\n")) {
-		    dump_section($file, $section, xml_escape($contents));
+		    dump_section($file, $section, $contents);
 		    $section = $section_default;
 		    $contents = "";
 		}
@@ -2057,7 +2010,7 @@ sub process_file($) {
 		$contents = $2;
 		if ($contents ne "") {
 		    $contents .= "\n";
-		    dump_section($file, $section, xml_escape($contents));
+		    dump_section($file, $section, $contents);
 		    $section = $section_default;
 		    $contents = "";
 		}
@@ -2072,7 +2025,7 @@ sub process_file($) {
 	} elsif ($state == STATE_DOCBLOCK) {
 		if (/$doc_end/)
 		{
-			dump_doc_section($file, $section, xml_escape($contents));
+			dump_doc_section($file, $section, $contents);
 			$section = $section_default;
 			$contents = "";
 			$function = "";
-- 
2.14.3
