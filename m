Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2F4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CF8208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CYV6ocda";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CYV6ocda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CF8208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbeGJSUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:20:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbeGJSUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:20:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA51860B28; Tue, 10 Jul 2018 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531244551;
        bh=HWR1R+yfWHRtD9g2TH4xqUg0jf9wc1D642tkpmTJReY=;
        h=From:To:Cc:Subject:Date:From;
        b=CYV6ocdanqmgXr71aARB9/ehi6/gXD3Zh1zEcSwKweObysOxWBH0i89T5R77Yq/HG
         QN+4s2c21uLvCdwJmmVyqOsjifZf+I1PA+qE/wOR1fKpzqVCroUZXUJ77weL6Orbt6
         G5czMAqFpvqoQmP4qhkN49T3hC6L3he3gWq6/8NE=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFBE260791;
        Tue, 10 Jul 2018 17:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531244551;
        bh=HWR1R+yfWHRtD9g2TH4xqUg0jf9wc1D642tkpmTJReY=;
        h=From:To:Cc:Subject:Date:From;
        b=CYV6ocdanqmgXr71aARB9/ehi6/gXD3Zh1zEcSwKweObysOxWBH0i89T5R77Yq/HG
         QN+4s2c21uLvCdwJmmVyqOsjifZf+I1PA+qE/wOR1fKpzqVCroUZXUJ77weL6Orbt6
         G5czMAqFpvqoQmP4qhkN49T3hC6L3he3gWq6/8NE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFBE260791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH] checkpatch: Handle long multi-line macros better
Date:   Tue, 10 Jul 2018 10:42:04 -0700
Message-Id: <1531244524-16003-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the checkpatch throws an error on long macro expressions which
is more than one line i.e the opening and the closing bracket pair not
being on the same line. This patch gives the dangling backslash the
benefit of doubt and allows it to consider the closing paranthesis on the
next line as part of the macro expression and doesn't throw an error.

Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 scripts/checkpatch.pl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 599ae61..158c96d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5038,7 +5038,7 @@ sub process {
 		if ($realfile !~ m@/vmlinux.lds.h$@ &&
 		    $line =~ /^.\s*\#\s*define\s*$Ident(\()?/) {
 			my $ln = $linenr;
-			my $cnt = $realcnt;
+			my $cnt = $realcnt - 1;
 			my ($off, $dstat, $dcond, $rest);
 			my $ctx = '';
 			my $has_flow_statement = 0;
@@ -5075,6 +5075,11 @@ sub process {
 			{
 			}
 
+			# Extremely long macros may fall off the end of the
+			# available context without closing.  Give a dangling
+			# backslash the benefit of the doubt and allow it
+			# to gobble any hanging close-parens.
+			$dstat =~ s/\(.+\\$/1/;
 			# Flatten any obvious string concatentation.
 			while ($dstat =~ s/($String)\s*$Ident/$1/ ||
 			       $dstat =~ s/$Ident\s*($String)/$1/)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

