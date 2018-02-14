Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162253AbeBNSkh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:40:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:54702 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161773AbeBNSke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:40:34 -0500
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        jani.nikula@linux.intel.com, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 7/8] docs: kernel-doc: Finish moving STATE_* code out of process_file()
Date: Wed, 14 Feb 2018 11:40:08 -0700
Message-Id: <20180214184009.12657-8-corbet@lwn.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214184009.12657-1-corbet@lwn.net>
References: <20180214184009.12657-1-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move STATE_INLINE and STATE_DOCBLOCK code out of process_file(), which now
actually fits on a single screen.  Delete an unused variable and add a
couple of comments while I'm at it.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/kernel-doc | 139 +++++++++++++++++++++++++++++------------------------
 1 file changed, 77 insertions(+), 62 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2deddb876156..fb8fbdb25036 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1990,10 +1990,80 @@ sub process_proto($$) {
     }
 }
 
+#
+# STATE_DOCBLOCK: within a DOC: block.
+#
+sub process_docblock($$) {
+    my $file = shift;
+
+    if (/$doc_end/) {
+	dump_doc_section($file, $section, $contents);
+	$section = $section_default;
+	$contents = "";
+	$function = "";
+	%parameterdescs = ();
+	%parametertypes = ();
+	@parameterlist = ();
+	%sections = ();
+	@sectionlist = ();
+	$prototype = "";
+	$state = STATE_NORMAL;
+    } elsif (/$doc_content/) {
+	if ( $1 eq "" )	{
+	    $contents .= $blankline;
+	} else {
+	    $contents .= $1 . "\n";
+	}
+    }
+}
+
+#
+# STATE_INLINE: docbook comments within a prototype.
+#
+sub process_inline($$) {
+    my $file = shift;
+
+    # First line (state 1) needs to be a @parameter
+    if ($inline_doc_state == STATE_INLINE_NAME && /$doc_inline_sect/o) {
+	$section = $1;
+	$contents = $2;
+	$new_start_line = $.;
+	if ($contents ne "") {
+	    while (substr($contents, 0, 1) eq " ") {
+		$contents = substr($contents, 1);
+	    }
+	    $contents .= "\n";
+	}
+	$inline_doc_state = STATE_INLINE_TEXT;
+	# Documentation block end */
+    } elsif (/$doc_inline_end/) {
+	if (($contents ne "") && ($contents ne "\n")) {
+	    dump_section($file, $section, $contents);
+	    $section = $section_default;
+	    $contents = "";
+	}
+	$state = STATE_PROTO;
+	$inline_doc_state = STATE_INLINE_NA;
+	# Regular text
+    } elsif (/$doc_content/) {
+	if ($inline_doc_state == STATE_INLINE_TEXT) {
+	    $contents .= $1 . "\n";
+	    # nuke leading blank lines
+	    if ($contents =~ /^\s*$/) {
+		$contents = "";
+	    }
+	} elsif ($inline_doc_state == STATE_INLINE_NAME) {
+	    $inline_doc_state = STATE_INLINE_ERROR;
+	    print STDERR "${file}:$.: warning: ";
+	    print STDERR "Incorrect use of kernel-doc format: $_";
+	    ++$warnings;
+	}
+    }
+}
+
 
 sub process_file($) {
     my $file;
-    my $func;
     my $initial_section_counter = $section_counter;
     my ($orig_file) = @_;
 
@@ -2014,6 +2084,8 @@ sub process_file($) {
 	}
 	# Replace tabs by spaces
         while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
+
+	# Hand this line to the appropriate state handler
 	if ($state == STATE_NORMAL) {
 	    process_normal();
 	} elsif ($state == STATE_NAME) {
@@ -2021,72 +2093,15 @@ sub process_file($) {
 	} elsif ($state == STATE_BODY || $state == STATE_BODY_MAYBE) {
 	    process_body($file, $_);
 	} elsif ($state == STATE_INLINE) { # scanning for inline parameters
-	    # First line (state 1) needs to be a @parameter
-	    if ($inline_doc_state == STATE_INLINE_NAME && /$doc_inline_sect/o) {
-		$section = $1;
-		$contents = $2;
-                $new_start_line = $.;
-		if ($contents ne "") {
-		    while (substr($contents, 0, 1) eq " ") {
-			$contents = substr($contents, 1);
-		    }
-		    $contents .= "\n";
-		}
-		$inline_doc_state = STATE_INLINE_TEXT;
-	    # Documentation block end */
-	    } elsif (/$doc_inline_end/) {
-		if (($contents ne "") && ($contents ne "\n")) {
-		    dump_section($file, $section, $contents);
-		    $section = $section_default;
-		    $contents = "";
-		}
-		$state = STATE_PROTO;
-		$inline_doc_state = STATE_INLINE_NA;
-	    # Regular text
-	    } elsif (/$doc_content/) {
-		if ($inline_doc_state == STATE_INLINE_TEXT) {
-		    $contents .= $1 . "\n";
-		    # nuke leading blank lines
-		    if ($contents =~ /^\s*$/) {
-			$contents = "";
-		    }
-		} elsif ($inline_doc_state == STATE_INLINE_NAME) {
-		    $inline_doc_state = STATE_INLINE_ERROR;
-		    print STDERR "${file}:$.: warning: ";
-		    print STDERR "Incorrect use of kernel-doc format: $_";
-		    ++$warnings;
-		}
-	    }
+	    process_inline($file, $_);
 	} elsif ($state == STATE_PROTO) {
 	    process_proto($file, $_);
 	} elsif ($state == STATE_DOCBLOCK) {
-		if (/$doc_end/)
-		{
-			dump_doc_section($file, $section, $contents);
-			$section = $section_default;
-			$contents = "";
-			$function = "";
-			%parameterdescs = ();
-			%parametertypes = ();
-			@parameterlist = ();
-			%sections = ();
-			@sectionlist = ();
-			$prototype = "";
-			$state = STATE_NORMAL;
-		}
-		elsif (/$doc_content/)
-		{
-			if ( $1 eq "" )
-			{
-				$contents .= $blankline;
-			}
-			else
-			{
-				$contents .= $1 . "\n";
-			}
-		}
+	    process_docblock($file, $_);
 	}
     }
+
+    # Make sure we got something interesting.
     if ($initial_section_counter == $section_counter) {
 	if ($output_mode ne "none") {
 	    print STDERR "${file}:1: warning: no structured comments found\n";
-- 
2.14.3
