Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162282AbeBNSlI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:41:08 -0500
Received: from ms.lwn.net ([45.79.88.28]:54692 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162229AbeBNSke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:40:34 -0500
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        jani.nikula@linux.intel.com, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 6/8] docs: kernel-doc: Move STATE_PROTO processing into its own function
Date: Wed, 14 Feb 2018 11:40:07 -0700
Message-Id: <20180214184009.12657-7-corbet@lwn.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214184009.12657-1-corbet@lwn.net>
References: <20180214184009.12657-1-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the top-level prototype-processing code out of process_file().

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/kernel-doc | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index a6a7bb46ea29..2deddb876156 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1965,6 +1965,32 @@ sub process_body($$) {
 }
 
 
+#
+# STATE_PROTO: reading a function/whatever prototype.
+#
+sub process_proto($$) {
+    my $file = shift;
+
+    if (/$doc_inline_oneline/) {
+	$section = $1;
+	$contents = $2;
+	if ($contents ne "") {
+	    $contents .= "\n";
+	    dump_section($file, $section, $contents);
+	    $section = $section_default;
+	    $contents = "";
+	}
+    } elsif (/$doc_inline_start/) {
+	$state = STATE_INLINE;
+	$inline_doc_state = STATE_INLINE_NAME;
+    } elsif ($decl_type eq 'function') {
+	process_proto_function($_, $file);
+    } else {
+	process_proto_type($_, $file);
+    }
+}
+
+
 sub process_file($) {
     my $file;
     my $func;
@@ -2031,24 +2057,8 @@ sub process_file($) {
 		    ++$warnings;
 		}
 	    }
-	} elsif ($state == STATE_PROTO) {	# scanning for function '{' (end of prototype)
-	    if (/$doc_inline_oneline/) {
-		$section = $1;
-		$contents = $2;
-		if ($contents ne "") {
-		    $contents .= "\n";
-		    dump_section($file, $section, $contents);
-		    $section = $section_default;
-		    $contents = "";
-		}
-	    } elsif (/$doc_inline_start/) {
-		$state = STATE_INLINE;
-		$inline_doc_state = STATE_INLINE_NAME;
-	    } elsif ($decl_type eq 'function') {
-		process_proto_function($_, $file);
-	    } else {
-		process_proto_type($_, $file);
-	    }
+	} elsif ($state == STATE_PROTO) {
+	    process_proto($file, $_);
 	} elsif ($state == STATE_DOCBLOCK) {
 		if (/$doc_end/)
 		{
-- 
2.14.3
