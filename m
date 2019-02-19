Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53850C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1376021903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzJpfRSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfBSGgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:36:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36507 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSGga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:36:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id k2so568563plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 22:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8OrcYERXqrJhFh4L92Nvocj/Ur13anWIcxP3BthudoM=;
        b=KzJpfRSrsemzdPFxybgJM85oia55750YXWhLNYoL/iVpGgqD18Q7grv/YHf/NvX+Nt
         +9ylUHGo/QKQplh8Ii1AfQ9tDBECe2rc0srPD4S0dJIRDtWhRZ/fpXihNGJvxKkWIzCN
         h4E96Zym3RFzogXvBUOTNPRB7TjVqoXmlIY3D7O4a5RuADcr0w1BGSpNAH3sViA+iIQ8
         lmWGQPzQt9ahZ9pWYtF020WzGkwz2uuSf7xZlWL/IPoXMfYukTMJYyWujqfsk6dB37/f
         UY6B0W2K9jtl3C62bT7KmjQv6HgDM4X3hlntt/ERYqKfOlrnRWLSKeRKfwcbBVk9oJO3
         F8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8OrcYERXqrJhFh4L92Nvocj/Ur13anWIcxP3BthudoM=;
        b=l1XjRcc5J8y8OB0Vo2Rml7q5YvOh5cPlUBNZdhjzJJgAAe/ZgA6Axt4FO+JG4rZiUg
         YDnnCHZ6RJd83YnZCgW5FMFPwflCa2amj7t7xxssvLSZnCFnxiNDzAdD02XOrSAqPtGt
         UNaobqOt292kgX30cslrh1UFLUtrBMwN3OmP+p8NqI8YCXZ+usxWh0gX4o+Jtc9hpJVJ
         SdaZ/pE+wB7RDLhlzZwRXLHJDIu3yvIPCc+2lUG4CERUVDNSv69PNZfGlllJgsmZNTci
         5QziB79IVRAOOYWr50nN9RXcm87p6GlIT0w/e8eNRQlf1cc/APEyxTd/9sOorq5dXCyY
         Zh+Q==
X-Gm-Message-State: AHQUAubPO/MU+4oHL5OJ7ngKp4vyxHnesraEpdI4eUE1NHklF3l1YnEl
        P7KM3Z/TnrnrwZ+Zfh5PD0Q=
X-Google-Smtp-Source: AHgI3IYNLcL1Ix0iiu8k6KqZvx26zEfXg8fsRINSu/zyrWQ97Gi7QnxnCVhK8rpX4RketJ3kRZ+MjQ==
X-Received: by 2002:a17:902:7890:: with SMTP id q16mr7269850pll.63.1550558189767;
        Mon, 18 Feb 2019 22:36:29 -0800 (PST)
Received: from vultr.guest ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 86sm32199367pfk.157.2019.02.18.22.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 22:36:29 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] checkpatch: warn on bad commit description in 'Fixes' tag
Date:   Tue, 19 Feb 2019 06:36:11 +0000
Message-Id: <20190219063611.19955-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some complaints about bad commit description in 'Fixes' tag.
Most cases are SHA1 should be at least 12 digits long. Let's extend
the existing check in checkpatch.pl to include commit description of
'Fixes' tag.

Reference: https://lkml.org/lkml/2019/2/18/1477
Signed-off-by: Changbin Du <changbin.du@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/checkpatch.pl | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b737ca9d7204..6f0156778a07 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2726,11 +2726,11 @@ sub process {
 		if ($in_commit_log && !$commit_log_possible_stack_dump &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
-		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
+                   ($line =~ /\b(?:commit|fixes:)\s+[0-9a-f]{5,}\b/i ||
 		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
 		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
 		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
-			my $init_char = "c";
+                       my $init_str = "commit";
 			my $orig_commit = "";
 			my $short = 1;
 			my $long = 0;
@@ -2742,29 +2742,29 @@ sub process {
 			my $orig_desc = "commit description";
 			my $description = "";
 
-			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
-				$init_char = $1;
+                       if ($line =~ /\b(commit|fixes:)\s+([0-9a-f]{5,})\b/i) {
+                               $init_str = $1;
 				$orig_commit = lc($2);
 			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
 				$orig_commit = lc($1);
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+                       $short = 0 if ($orig_commit =~ /\b[0-9a-f]{12,40}/i);
+                       $long = 1 if ($orig_commit =~ /\b[0-9a-f]{41,}/i);
+                       $space = 0 if ($line =~ /\b(?:commit|fixes:) [0-9a-f]/i);
+                       $case = 0 if ($line =~ /\b(?:Commit|commit|Fixes:)\s+[0-9a-f]{5,40}[^A-F]/);
+                       if ($line =~ /\b(?:commit|fixes:)\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
 				$orig_desc = $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
+                       } elsif ($line =~ /\b(?:commit|fixes:)\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
 				$orig_desc = $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
+                       } elsif ($line =~ /\b(?:commit|fixes:)\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+                               $line =~ /\b(?:commit|fixes:)\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
 				$orig_desc = $1;
 				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
 				$orig_desc .= " " . $1;
@@ -2776,8 +2776,16 @@ sub process {
 
 			if (defined($id) &&
 			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
+                               if (lc $init_str eq lc "commit") {
+                                       my @chars = split("", $init_str);
+                                       $init_str = "$chars[0]ommit";
+                               } else {
+                                       $init_str = "Fixes:"
+                               }
+
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+                                     "Please use git commit description style 'commit/Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: '${init_str} $id (\"$description\")'\n" .
+                                     $herecurr . "\nThis can be fixed by 'git config --global core.abbrev 12'.\n");
 			}
 		}
 
-- 
2.17.1

