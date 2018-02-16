Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbeBPUYC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:24:02 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35270 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeBPUXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:23:32 -0500
X-Google-Smtp-Source: AH8x226dHWSDTu2gVLNSupNHCBSFX4Pq48CVR9Cahyquz/l+429iMD5YWS+OhGLviWqvzx31BPaHhw==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: apw@canonical.com, joe@perches.com
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH 2/3] checkpatch: kconfig: check help texts for menuconfig and choice
Date: Fri, 16 Feb 2018 21:22:54 +0100
Message-Id: <20180216202255.25307-3-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180216202255.25307-1-ulfalizer@gmail.com>
References: <20180216202255.25307-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only Kconfig symbols are checked for a missing or short help
text, and are only checked if they are defined with the 'config'
keyword.

To make the check more general, extend it to also check help texts for
choices and for symbols defined with the 'menuconfig' keyword.

This increases the accuracy of the check for symbols that would already
have been checked as well, since e.g. a 'menuconfig' symbol after a help
text will be recognized as ending the preceding symbol/choice
definition.

To increase the accuracy of the check further, also recognize 'if',
'endif', 'menu', 'endmenu', 'endchoice', and 'source' as ending a
symbol/choice definition.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 scripts/checkpatch.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b404317daea..54b782fab4fd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2797,7 +2797,10 @@ sub process {
 # Only applies when adding the entry originally, after that we do not have
 # sufficient context to determine whether it is indeed long enough.
 		if ($realfile =~ /Kconfig/ &&
-		    $line =~ /^\+\s*config\s+/) {
+		    # 'choice' is usually the last thing on the line (though
+		    # Kconfig supports named choices), so use a word boundary
+		    # (\b) rather than a whitespace character (\s)
+		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
 			my $length = 0;
 			my $cnt = $realcnt;
 			my $ln = $linenr + 1;
@@ -2822,7 +2825,13 @@ sub process {
 				$f =~ s/#.*//;
 				$f =~ s/^\s+//;
 				next if ($f =~ /^$/);
-				if ($f =~ /^\s*config\s/) {
+
+				# This only checks context lines in the patch
+				# and so hopefully shouldn't trigger false
+				# positives, even though some of these are
+				# common words in help texts
+				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
+						  if|endif|menu|endmenu|source)\b/x) {
 					$is_end = 1;
 					last;
 				}
-- 
2.14.1
