Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B701AC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D2720852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D2720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeGZDhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:37:23 -0400
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:45419 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728529AbeGZDhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:37:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1987A100E86C4;
        Thu, 26 Jul 2018 02:22:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kitty74_6fe0c62c84a56
X-Filterd-Recvd-Size: 2622
Received: from XPS-9350 (unknown [172.58.19.150])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Jul 2018 02:22:48 +0000 (UTC)
Message-ID: <1b099f4d8373aa583a17011992676bf0f3f09eee.camel@perches.com>
Subject: [PATCH] checkpatch: Warn when a patch doesn't have a description
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, ckadabi@codeaurora.org,
        David Keitel <dkeitel@codeaurora.org>
Date:   Wed, 25 Jul 2018 19:22:47 -0700
In-Reply-To: <6ed46f85a7577e1d4a48e81f67fd7581@codeaurora.org>
References: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
         <6799952fbd3639c764c112bde961b5e00270a52d.camel@perches.com>
         <6ed46f85a7577e1d4a48e81f67fd7581@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Potential patches should have a commit description.
Emit a warning when there isn't one.

Suggested-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b5c875d7132b..8b5f3dae31c9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2240,6 +2240,7 @@ sub process {
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 	my $has_commit_log = 0;		#Encountered lines before patch
+	my $commit_log_lines = 0;	#Number of commit log lines
 	my $commit_log_possible_stack_dump = 0;
 	my $commit_log_long_line = 0;
 	my $commit_log_has_diff = 0;
@@ -2497,6 +2498,18 @@ sub process {
 
 		$cnt_lines++ if ($realcnt != 0);
 
+# Verify the existence of a commit log if appropriate
+# 2 is used because a $signature is counted in $commit_log_lines
+		if ($in_commit_log) {
+			if ($line !~ /^\s*$/) {
+				$commit_log_lines++;	#could be a $signature
+			}
+		} else if ($has_commit_log && $commit_log_lines < 2) {
+			WARN("COMMIT_MESSAGE",
+			     "Missing commit description - Add an appropriate one\n");
+			$commit_log_lines = 2;	#warn only once
+		}
+
 # Check if the commit log has what seems like a diff which can confuse patch
 		if ($in_commit_log && !$commit_log_has_diff &&
 		    (($line =~ m@^\s+diff\b.*a/[\w/]+@ &&
