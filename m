Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeE3Qdh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:33:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44631 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753507AbeE3Qdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:33:35 -0400
X-Google-Smtp-Source: ADUXVKIfSx7eGTGaOw0aXFw2uj5n+eW8fAU3JgOm4LegDIQobwvPby08s3w/MZAKzM7iqCWAT3lolg==
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: apw@canonical.com, joe@perches.com,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH] checkpatch: validate Fixes tags
Date: Wed, 30 May 2018 12:33:31 -0400
Message-Id: <20180530163331.169328-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Apply commit syntax validation to Fixes tags:

Remove the existing exclusion match on " !~ /\bfixes ..." and
generalize keyword match to "[Cc]ommit|Fixes:".

Unlike commit tags, fixes tags must take up an entire line and
may not have line breaks.

When applied to a set of 2000+ recent patches, this added patches
with warnings:

  - 8x SHA1 too short
  - 4x line break in description
  - 3x missing parentheses
  - 3x extraneous double-quote in description (false positive)
  - 2x missing quotes
  - 1x using single instead of double quotes

It changed existing warnings only

  - 3x output Commit instead of commit

Also add a test for lines that start with the fixes keyword but do not
match the commit syntax condition. These are likely intended as tags,
but not based on SHA1. This added patches with warnings:

  - 3x keyword in message body on line by itself (false positive)
  - 1x points to url instead of SHA1
  - 1x has keyword commit before SHA1

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 scripts/checkpatch.pl | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2d42eb9cd1a5..70bc023cae42 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2513,6 +2513,14 @@ sub process {
 			$in_commit_log = 0;
 		}
 
+# Check format of Fixes line
+		if ($in_commit_log && $line =~ /^\s*fixes:/i) {
+			if ($line !~ /^\s*fixes:\s+[0-9a-f]{5,}/i) {
+				WARN("FIXES_LINE_SYNTAX",
+				     "Fixes line is not of form \"Fixes: <12+ chars of sha1> [...]");
+			}
+		}
+
 # Check if MAINTAINERS is being updated.  If so, there's probably no need to
 # emit the "does MAINTAINERS need updating?" message on file add/move/delete
 		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
@@ -2643,11 +2651,9 @@ sub process {
 		if ($in_commit_log && !$commit_log_possible_stack_dump &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
-		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
+		    ($line =~ /\b(?:commit|fixes:)\s+[0-9a-f]{5,}\b/i ||
 		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
-		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
-		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
-			my $init_char = "c";
+		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i))) {
 			my $orig_commit = "";
 			my $short = 1;
 			my $long = 0;
@@ -2658,19 +2664,29 @@ sub process {
 			my $id = '0123456789ab';
 			my $orig_desc = "commit description";
 			my $description = "";
+			my $keyword = "commit";
+			my $keywordcase = "[Cc]ommit";
+			my $pre = '';
+			my $post = '';
+
+			if ($line =~ /\bfixes:\s+[0-9a-f]{5,}\b/i) {
+				$keywordcase = "Fixes:";
+				$pre = '^';
+				$post = '$';
+			}
 
-			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
-				$init_char = $1;
+			if ($line =~ /\b($keywordcase)\s+([0-9a-f]{5,})\b/i) {
+				$keyword = $1;
 				$orig_commit = lc($2);
 			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
 				$orig_commit = lc($1);
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+			$short = 0 if ($line =~ /\b$keyword\s+[0-9a-f]{12,40}/i);
+			$long = 1 if ($line =~ /\b$keyword\s+[0-9a-f]{41,}/i);
+			$space = 0 if ($line =~ /\b$keyword [0-9a-f]/i);
+			$case = 0 if ($line =~ /\b$keywordcase\s+[0-9a-f]{5,40}[^A-F]/);
+			if ($line =~ /$pre\b$keyword\s+[0-9a-f]{5,}\s+\("([^"]+)"\)$post/i) {
 				$orig_desc = $1;
 				$hasparens = 1;
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
@@ -2694,7 +2710,7 @@ sub process {
 			if (defined($id) &&
 			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+				      "Please use git commit description style '$keyword <12+ chars of sha1> (\"<title line>\")' - ie: '$keyword $id (\"$description\")'\n" . $herecurr);
 			}
 		}
 
-- 
2.17.0.921.gf22659ad46-goog
