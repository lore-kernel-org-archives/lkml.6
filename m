Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7DCC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778F123F4B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="msVGwaxd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="msVGwaxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778F123F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeGDSUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:20:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45596 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeGDSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:20:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C561F60B24; Wed,  4 Jul 2018 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530728401;
        bh=KOes/5/GG5l6FtmtxD2S5wtOrfKOXe1tcavXmk25+kE=;
        h=From:To:Cc:Subject:Date:From;
        b=msVGwaxdqRKXsXApaeawtNR3eEQe3kRuPVtbEeeSi5v0D7+kbtrSt+6IAIdppXl+/
         kkgQ0oY8Kyu8yihRV0ENJd8Y0h2u2E/0Yx2RS6sqLn9wJE/n7A1JXqrBjxVmBJNVZU
         jbRtyu7490fMp97bxmYJTEN+97xEUVuLGwevFZB8=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A90260B19;
        Wed,  4 Jul 2018 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530728401;
        bh=KOes/5/GG5l6FtmtxD2S5wtOrfKOXe1tcavXmk25+kE=;
        h=From:To:Cc:Subject:Date:From;
        b=msVGwaxdqRKXsXApaeawtNR3eEQe3kRuPVtbEeeSi5v0D7+kbtrSt+6IAIdppXl+/
         kkgQ0oY8Kyu8yihRV0ENJd8Y0h2u2E/0Yx2RS6sqLn9wJE/n7A1JXqrBjxVmBJNVZU
         jbRtyu7490fMp97bxmYJTEN+97xEUVuLGwevFZB8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A90260B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Israel Schlesinger <israels@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH] checkpatch: Add warnings for use of mdelay()
Date:   Wed,  4 Jul 2018 11:18:53 -0700
Message-Id: <1530728333-31590-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mdelay() is not a preferred API to be used to insert delay in the kernel
code unless the context is atomic. Instead, msleep() API can be used.
This patch introduces this warning.

Signed-off-by: Israel Schlesinger <israels@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c0550..14bba3f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5572,6 +5572,12 @@ sub process {
 			     "Comparing get_jiffies_64() is almost always wrong; prefer time_after64, time_before64 and friends\n" . $herecurr);
 		}
 
+# check the patch for use of mdelay
+		if ($line =~ /\bmdelay\s*\(/) {
+			WARN("MDELAY",
+			     "use of mdelay() found: msleep() is the preferred API.\n" . $herecurr );
+		}
+
 # warn about #ifdefs in C files
 #		if ($line =~ /^.\s*\#\s*if(|n)def/ && ($realfile =~ /\.c$/)) {
 #			print "#ifdef in C files should be avoided\n";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

