Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C65C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB149206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB149206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbeGZX1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:27:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbeGZX1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:27:44 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 071FC40B;
        Thu, 26 Jul 2018 22:08:57 +0000 (UTC)
Date:   Thu, 26 Jul 2018 15:08:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, ckadabi@codeaurora.org,
        David Keitel <dkeitel@codeaurora.org>
Subject: Re: [PATCH] checkpatch: Warn when a patch doesn't have a
 description
Message-Id: <20180726150855.a9a3e81d5cdc4630c7f4ca2d@linux-foundation.org>
In-Reply-To: <1b099f4d8373aa583a17011992676bf0f3f09eee.camel@perches.com>
References: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
        <6799952fbd3639c764c112bde961b5e00270a52d.camel@perches.com>
        <6ed46f85a7577e1d4a48e81f67fd7581@codeaurora.org>
        <1b099f4d8373aa583a17011992676bf0f3f09eee.camel@perches.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 19:22:47 -0700 Joe Perches <joe@perches.com> wrote:

> Potential patches should have a commit description.
> Emit a warning when there isn't one.
> 
> ...
>
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2240,6 +2240,7 @@ sub process {
>  	my $in_header_lines = $file ? 0 : 1;
>  	my $in_commit_log = 0;		#Scanning lines before patch
>  	my $has_commit_log = 0;		#Encountered lines before patch
> +	my $commit_log_lines = 0;	#Number of commit log lines
>  	my $commit_log_possible_stack_dump = 0;
>  	my $commit_log_long_line = 0;
>  	my $commit_log_has_diff = 0;
> @@ -2497,6 +2498,18 @@ sub process {
>  
>  		$cnt_lines++ if ($realcnt != 0);
>  
> +# Verify the existence of a commit log if appropriate
> +# 2 is used because a $signature is counted in $commit_log_lines
> +		if ($in_commit_log) {
> +			if ($line !~ /^\s*$/) {
> +				$commit_log_lines++;	#could be a $signature
> +			}
> +		} else if ($has_commit_log && $commit_log_lines < 2) {
> +			WARN("COMMIT_MESSAGE",
> +			     "Missing commit description - Add an appropriate one\n");
> +			$commit_log_lines = 2;	#warn only once
> +		}
> +
>  # Check if the commit log has what seems like a diff which can confuse patch
>  		if ($in_commit_log && !$commit_log_has_diff &&
>  		    (($line =~ m@^\s+diff\b.*a/[\w/]+@ &&

This explodes all over the place.

Variable "$clean" is not imported at scripts/checkpatch.pl line 6565.
Variable "$clean" is not imported at scripts/checkpatch.pl line 6590.
Variable "$cnt_error" is not imported at scripts/checkpatch.pl line 6592.
Variable "$cnt_warn" is not imported at scripts/checkpatch.pl line 6592.
Variable "$cnt_chk" is not imported at scripts/checkpatch.pl line 6593.
Variable "$cnt_lines" is not imported at scripts/checkpatch.pl line 6594.
Variable "$clean" is not imported at scripts/checkpatch.pl line 6599.
Variable "$clean" is not imported at scripts/checkpatch.pl line 6618.
Variable "$clean" is not imported at scripts/checkpatch.pl line 6659.
Variable "$clean" is not imported at scripts/checkpatch.pl line 6665.
syntax error at scripts/checkpatch.pl line 2520, near "else if"
Global symbol "$herecurr" requires explicit package name (did you forget to declare "my $herecurr"?) at scripts/checkpatch.pl line 2533.
Global symbol "$herecurr" requires explicit package name (did you forget to declare "my $herecurr"?) at scripts/checkpatch.pl line 2584.
Global symbol "$herecurr" requires explicit package name (did you forget to declare "my $herecurr"?) at scripts/checkpatch.pl line 2588.
etc

I did this:

--- a/scripts/checkpatch.pl~checkpatch-warn-when-a-patch-doesnt-have-a-description-fix
+++ a/scripts/checkpatch.pl
@@ -2517,7 +2517,7 @@ sub process {
 			if ($line !~ /^\s*$/) {
 				$commit_log_lines++;	#could be a $signature
 			}
-		} else if ($has_commit_log && $commit_log_lines < 2) {
+		} elsif ($has_commit_log && $commit_log_lines < 2) {
 			WARN("COMMIT_MESSAGE",
 			     "Missing commit description - Add an appropriate one\n");
 			$commit_log_lines = 2;	#warn only once

But I worry that you didn't send out the version which you tested, so
please check.

