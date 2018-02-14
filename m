Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754737AbeBNSlq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:41:46 -0500
Received: from ms.lwn.net ([45.79.88.28]:54686 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162189AbeBNSkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:40:33 -0500
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        jani.nikula@linux.intel.com, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5/8] docs: kernel-doc: Move STATE_BODY processing to a separate function
Date: Wed, 14 Feb 2018 11:40:06 -0700
Message-Id: <20180214184009.12657-6-corbet@lwn.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214184009.12657-1-corbet@lwn.net>
References: <20180214184009.12657-1-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also group the pseudo-global $leading_space variable with its peers.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/kernel-doc | 193 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 101 insertions(+), 92 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index a27c7016f72d..a6a7bb46ea29 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -336,6 +336,7 @@ use constant {
 };
 my $state;
 my $in_doc_sect;
+my $leading_space;
 
 # Inline documentation state
 use constant {
@@ -1865,12 +1866,110 @@ sub process_name($$) {
     }
 }
 
+
+#
+# STATE_BODY and STATE_BODY_MAYBE: the bulk of a kerneldoc comment.
+#
+sub process_body($$) {
+    my $file = shift;
+
+    if (/$doc_sect/i) { # case insensitive for supported section names
+	$newsection = $1;
+	$newcontents = $2;
+
+	# map the supported section names to the canonical names
+	if ($newsection =~ m/^description$/i) {
+	    $newsection = $section_default;
+	} elsif ($newsection =~ m/^context$/i) {
+	    $newsection = $section_context;
+	} elsif ($newsection =~ m/^returns?$/i) {
+	    $newsection = $section_return;
+	} elsif ($newsection =~ m/^\@return$/) {
+	    # special: @return is a section, not a param description
+	    $newsection = $section_return;
+	}
+
+	if (($contents ne "") && ($contents ne "\n")) {
+	    if (!$in_doc_sect && $verbose) {
+		print STDERR "${file}:$.: warning: contents before sections\n";
+		++$warnings;
+	    }
+	    dump_section($file, $section, $contents);
+	    $section = $section_default;
+	}
+
+	$in_doc_sect = 1;
+	$state = STATE_BODY;
+	$contents = $newcontents;
+	$new_start_line = $.;
+	while (substr($contents, 0, 1) eq " ") {
+	    $contents = substr($contents, 1);
+	}
+	if ($contents ne "") {
+	    $contents .= "\n";
+	}
+	$section = $newsection;
+	$leading_space = undef;
+    } elsif (/$doc_end/) {
+	if (($contents ne "") && ($contents ne "\n")) {
+	    dump_section($file, $section, $contents);
+	    $section = $section_default;
+	    $contents = "";
+	}
+	# look for doc_com + <text> + doc_end:
+	if ($_ =~ m'\s*\*\s*[a-zA-Z_0-9:\.]+\*/') {
+	    print STDERR "${file}:$.: warning: suspicious ending line: $_";
+	    ++$warnings;
+	}
+
+	$prototype = "";
+	$state = STATE_PROTO;
+	$brcount = 0;
+    } elsif (/$doc_content/) {
+	# miguel-style comment kludge, look for blank lines after
+	# @parameter line to signify start of description
+	if ($1 eq "") {
+	    if ($section =~ m/^@/ || $section eq $section_context) {
+		dump_section($file, $section, $contents);
+		$section = $section_default;
+		$contents = "";
+		$new_start_line = $.;
+	    } else {
+		$contents .= "\n";
+	    }
+	    $state = STATE_BODY;
+	} elsif ($state == STATE_BODY_MAYBE) {
+	    # Continued declaration purpose
+	    chomp($declaration_purpose);
+	    $declaration_purpose .= " " . $1;
+	    $declaration_purpose =~ s/\s+/ /g;
+	} else {
+	    my $cont = $1;
+	    if ($section =~ m/^@/ || $section eq $section_context) {
+		if (!defined $leading_space) {
+		    if ($cont =~ m/^(\s+)/) {
+			$leading_space = $1;
+		    } else {
+			$leading_space = "";
+		    }
+		}
+		$cont =~ s/^$leading_space//;
+	    }
+	    $contents .= $cont . "\n";
+	}
+    } else {
+	# i dont know - bad line?  ignore.
+	print STDERR "${file}:$.: warning: bad line: $_";
+	++$warnings;
+    }
+}
+
+
 sub process_file($) {
     my $file;
     my $func;
     my $initial_section_counter = $section_counter;
     my ($orig_file) = @_;
-    my $leading_space;
 
     $file = map_filename($orig_file);
 
@@ -1894,97 +1993,7 @@ sub process_file($) {
 	} elsif ($state == STATE_NAME) {
 	    process_name($file, $_);
 	} elsif ($state == STATE_BODY || $state == STATE_BODY_MAYBE) {
-	    if (/$doc_sect/i) { # case insensitive for supported section names
-		$newsection = $1;
-		$newcontents = $2;
-
-		# map the supported section names to the canonical names
-		if ($newsection =~ m/^description$/i) {
-		    $newsection = $section_default;
-		} elsif ($newsection =~ m/^context$/i) {
-		    $newsection = $section_context;
-		} elsif ($newsection =~ m/^returns?$/i) {
-		    $newsection = $section_return;
-		} elsif ($newsection =~ m/^\@return$/) {
-		    # special: @return is a section, not a param description
-		    $newsection = $section_return;
-		}
-
-		if (($contents ne "") && ($contents ne "\n")) {
-		    if (!$in_doc_sect && $verbose) {
-			print STDERR "${file}:$.: warning: contents before sections\n";
-			++$warnings;
-		    }
-		    dump_section($file, $section, $contents);
-		    $section = $section_default;
-		}
-
-		$in_doc_sect = 1;
-		$state = STATE_BODY;
-		$contents = $newcontents;
-                $new_start_line = $.;
-		while (substr($contents, 0, 1) eq " ") {
-		    $contents = substr($contents, 1);
-		}
-		if ($contents ne "") {
-		    $contents .= "\n";
-		}
-		$section = $newsection;
-		$leading_space = undef;
-	    } elsif (/$doc_end/) {
-		if (($contents ne "") && ($contents ne "\n")) {
-		    dump_section($file, $section, $contents);
-		    $section = $section_default;
-		    $contents = "";
-		}
-		# look for doc_com + <text> + doc_end:
-		if ($_ =~ m'\s*\*\s*[a-zA-Z_0-9:\.]+\*/') {
-		    print STDERR "${file}:$.: warning: suspicious ending line: $_";
-		    ++$warnings;
-		}
-
-		$prototype = "";
-		$state = STATE_PROTO;
-		$brcount = 0;
-#		print STDERR "end of doc comment, looking for prototype\n";
-	    } elsif (/$doc_content/) {
-		# miguel-style comment kludge, look for blank lines after
-		# @parameter line to signify start of description
-		if ($1 eq "") {
-		    if ($section =~ m/^@/ || $section eq $section_context) {
-			dump_section($file, $section, $contents);
-			$section = $section_default;
-			$contents = "";
-                        $new_start_line = $.;
-		    } else {
-			$contents .= "\n";
-		    }
-		    $state = STATE_BODY;
-		} elsif ($state == STATE_BODY_MAYBE) {
-		    # Continued declaration purpose
-		    chomp($declaration_purpose);
-		    $declaration_purpose .= " " . $1;
-		    $declaration_purpose =~ s/\s+/ /g;
-		} else {
-		    my $cont = $1;
-		    if ($section =~ m/^@/ || $section eq $section_context) {
-			if (!defined $leading_space) {
-			    if ($cont =~ m/^(\s+)/) {
-				$leading_space = $1;
-			    } else {
-				$leading_space = "";
-			    }
-			}
-
-			$cont =~ s/^$leading_space//;
-		    }
-		    $contents .= $cont . "\n";
-		}
-	    } else {
-		# i dont know - bad line?  ignore.
-		print STDERR "${file}:$.: warning: bad line: $_";
-		++$warnings;
-	    }
+	    process_body($file, $_);
 	} elsif ($state == STATE_INLINE) { # scanning for inline parameters
 	    # First line (state 1) needs to be a @parameter
 	    if ($inline_doc_state == STATE_INLINE_NAME && /$doc_inline_sect/o) {
-- 
2.14.3
