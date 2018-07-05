Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64123C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFFF2400F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VqE/lXKj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I+v7iXoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFFF2400F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeGESTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:19:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753812AbeGESTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:19:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 48D5960B19; Thu,  5 Jul 2018 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530814790;
        bh=2uqVOsCHcnPMKQGtBV6D3kkd1tnTg786zhLFaWrHsHo=;
        h=From:To:Cc:Subject:Date:From;
        b=VqE/lXKjcOcmI8csKeOcgJcFMlrMiwALFZiX32stQxxnhcmc5FuNx05uAl5maWj+G
         wWslzwZmtnH/WnRCtjgJ73D+HXEsIv+SLLvNJzaa1/y+gC82Skyzrv+g1n6yAVpOs4
         H+Keol5LlueB8EzCIZ2a2YAqc65n4KjcdSkzay4o=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A2DC607EB;
        Thu,  5 Jul 2018 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530814789;
        bh=2uqVOsCHcnPMKQGtBV6D3kkd1tnTg786zhLFaWrHsHo=;
        h=From:To:Cc:Subject:Date:From;
        b=I+v7iXoQ6Fp9ykaIuZJAe4oKcFlDtTO1q61X6xbLO+pdqNMx44VA2XtdlPx35A85i
         vqAU3pHCx6jHyIENZpE7B945aXBODRP4sOEp+yo15V5dC87CKCvIbNqnKncmvh3U2p
         Wuu93m8nG9kgOpIxxnd+120POTRcwmQW1i4vzIU8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A2DC607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH] checkpatch: Add exceptions for dsb keyword usage
Date:   Thu,  5 Jul 2018 11:19:36 -0700
Message-Id: <1530814776-16988-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mb() API can relpace the dsb() API in the kernel code. So, dsb() usage
is discouraged. However, there are exceptions when dsb is used in a
variable or a function name. Exceptions are when 'dsb' is prefixed with
class [-_>*\.] and/or suffixed with class [-_\.;].

Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c0550..978c752 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5372,6 +5372,12 @@ sub process {
 			     "Avoid line continuations in quoted strings\n" . $herecurr);
 		}
 
+# dsb is too ARMish, and should usually be mb.
+        if ($line =~ /[^-_>*\.]\bdsb\b[^-_\.;]/) {
+            WARN("ARM_BARRIER",
+                 "Use of dsb is discouranged: prefer mb.\n" .
+                 $herecurr);
+		}
 # warn about #if 0
 		if ($line =~ /^.\s*\#\s*if\s+0\b/) {
 			CHK("REDUNDANT_CODE",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

