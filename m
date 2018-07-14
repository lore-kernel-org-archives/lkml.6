Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF088208A6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF088208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbeGNAZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 20:25:35 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:50469 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731021AbeGNAZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 20:25:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3F9F318014AE5;
        Sat, 14 Jul 2018 00:08:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bed23_85b13cc47b257
X-Filterd-Recvd-Size: 3981
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Jul 2018 00:08:38 +0000 (UTC)
Message-ID: <50a05aaf44e5f86cbf687863dadaa26b45debe2d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Require commit text and warn on long commit
 text lines
From:   Joe Perches <joe@perches.com>
To:     pheragu@codeaurora.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     apw@canonical.com, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        ckadabi@codeaurora.org, David Keitel <dkeitel@codeaurora.org>
Date:   Fri, 13 Jul 2018 17:08:37 -0700
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

On Fri, 2018-07-13 at 16:28 -0700, pheragu@codeaurora.org wrote:
> On 2018-07-13 14:46, Joe Perches wrote:
> > On Fri, 2018-07-13 at 14:40 -0700, Prakruthi Deepak Heragu wrote:
> > > Commit text is almost always necessary to explain why a change is 
> > > needed.
> > 
> > This bit seems sensible, but perhaps it should just count the
> > number of lines after the end of email headers and before any
> > Signed-off-by:/Signature line
> > 
> 
> While committing the changes, one can just write the subject and not 
> write
> the commit text at all. So, if we just count the lines between email 
> headers
> and signed-off, we still do count lines which form the subject, but the
> commit text is still absent. Also, subject can be longer than one line. 
> So,
> just counting lines doesn't really guarantee the presence of commit 
> text.

Not true.
Look at $in_header_lines and $in_commit_log.

> > > Also, warn on commit text lines longer than 75 characters. The commit 
> > > text
> > > are indented and may wrap on a terminal if they are longer than 75
> > > characters.
> > 
> > This is already exists via
> > 
> > # Check for line lengths > 75 in commit log, warn once
> > 		if ($in_commit_log && !$commit_log_long_line &&
> > 		    length($line) > 75 &&
> > 
> 
> True, but this patch points out every line of the commit text that is
> exceeding the limit.

Which is bad because things like dump_stack() are added in
commit logs and those are already allowed to be > 75 chars.

Anyway, something like this probably works.  Please test.
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
