Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbeBGR1E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:27:04 -0500
Received: from ms.lwn.net ([45.79.88.28]:41634 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754831AbeBGR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:27:02 -0500
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/8] docs: kernel-doc: Move STATE_NORMAL processing into its own function
Date: Wed,  7 Feb 2018 10:26:19 -0700
Message-Id: <20180207172624.24555-4-corbet@lwn.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180207172624.24555-1-corbet@lwn.net>
References: <20180207172624.24555-1-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Begin the process of splitting up the nearly 500-line process_file()
function by moving STATE_NORMAL processing to a separate function.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/kernel-doc | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index ad30c52f91ef..65150b7c8472 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1780,6 +1780,21 @@ sub process_export_file($) {
     close(IN);
 }
 
+#
+# Parsers for the various processing states.
+#
+# STATE_NORMAL: looking for the /** to begin everything.
+#
+sub process_normal() {
+    if (/$doc_start/o) {
+	$state = STATE_NAME;	# next line is always the function name
+	$in_doc_sect = 0;
+	$declaration_start_line = $. + 1;
+    }
+}
+
+
+
 sub process_file($) {
     my $file;
     my $identifier;
@@ -1807,11 +1822,7 @@ sub process_file($) {
 	# Replace tabs by spaces
         while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
 	if ($state == STATE_NORMAL) {
-	    if (/$doc_start/o) {
-		$state = STATE_NAME;	# next line is always the function name
-		$in_doc_sect = 0;
-		$declaration_start_line = $. + 1;
-	    }
+	    process_normal();
 	} elsif ($state == STATE_NAME) {# this line is the function name (always)
 	    if (/$doc_block/o) {
 		$state = STATE_DOCBLOCK;
-- 
2.14.3
