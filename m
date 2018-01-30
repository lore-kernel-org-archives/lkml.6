Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeA3TCC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:02:02 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54364 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeA3TCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:02:00 -0500
X-Google-Smtp-Source: AH8x2256wlwsjGCaOKvWug0qz0ajY/8a/tPfTSN9Ij9s20yeE2JxEfgeizSsMZEr9CQSb0p77PMOzQ==
From: Nicholas Brown <nickbroon@gmail.com>
X-Google-Original-From: Nicholas Brown <nick.brown@att.com>
To: apw@canonical.com, joe@perches.com
Cc: linux-kernel@vger.kernel.org, Nicholas Brown <nick.brown@att.com>
Subject: [PATCH] checkpatch: warn if changed lines exceeds a maximum size
Date: Tue, 30 Jan 2018 19:01:23 +0000
Message-Id: <20180130190123.9669-1-nick.brown@att.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1517335455.3063.28.camel@intl.att.com>
References: <1517335455.3063.28.camel@intl.att.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed lines is the total of inserted and deleted lines.
By default there is no limit, --max-changed-lines may be used to set a
value. Some users may wish to encourage that patches are split into
smaller parts using this.
See Documentation/process/submitting-patches.rst#split-changes

Signed-off-by: Nicholas Brown <nick.brown@att.com>
---
 scripts/checkpatch.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 31031f10fe56..2847109b4def 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -49,6 +49,7 @@ my @ignore = ();
 my $help = 0;
 my $configuration_file = ".checkpatch.conf";
 my $max_line_length = 80;
+my $max_changed_lines; # undef = no max
 my $ignore_perl_version = 0;
 my $minimum_perl_version = 5.10.0;
 my $min_conf_desc_length = 4;
@@ -92,6 +93,8 @@ Options:
   --ignore TYPE(,TYPE2...)   ignore various comma separated message types
   --show-types               show the specific message type in the output
   --max-line-length=n        set the maximum line length, if exceeded, warn
+  --max-changed-lines=n      set the maximum number of changed lines allowed,
+                             if exceeded, warn. (insertions + deletions)
   --min-conf-desc-length=n   set the min description length, if shorter, warn
   --root=PATH                PATH to the kernel tree root
   --no-summary               suppress the per-file summary
@@ -209,6 +212,7 @@ GetOptions(
 	'show-types!'	=> \$show_types,
 	'list-types!'	=> \$list_types,
 	'max-line-length=i' => \$max_line_length,
+	'max-changed-lines=i' => \$max_changed_lines,
 	'min-conf-desc-length=i' => \$min_conf_desc_length,
 	'root=s'	=> \$root,
 	'summary!'	=> \$summary,
@@ -2165,6 +2169,8 @@ sub process {
 	my $filename = shift;
 
 	my $linenr=0;
+	my $inserted_lines_total=0;
+	my $deleted_lines_total=0;
 	my $prevline="";
 	my $prevrawline="";
 	my $stashline="";
@@ -2233,6 +2239,14 @@ sub process {
 
 		push(@fixed, $rawline) if ($fix);
 
+		if ($rawline=~/^\+/) {
+		  $inserted_lines_total++
+		}
+
+		if ($rawline=~/^-/) {
+		  $deleted_lines_total++
+		}
+
 		if ($rawline=~/^\+\+\+\s+(\S+)/) {
 			$setup_docs = 0;
 			if ($1 =~ m@Documentation/admin-guide/kernel-parameters.rst$@) {
@@ -2306,6 +2320,11 @@ sub process {
 
 	$prefix = '';
 
+	if (defined $max_changed_lines &&
+	    ($inserted_lines_total+$deleted_lines_total > $max_changed_lines)) {
+	  WARN("MAX_CHANGED_LINES", "please split the change into smaller parts\n");
+	}
+
 	$realcnt = 0;
 	$linenr = 0;
 	$fixlinenr = -1;
-- 
2.14.1
