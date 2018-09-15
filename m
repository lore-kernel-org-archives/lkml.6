Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD8BECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F4420881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="tlW76OJN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sd.ai header.i=@sd.ai header.b="Wa7rW1MC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F4420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sd.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeIPCvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:51:36 -0400
Received: from s1-b4c1.socketlabs.email-od.com ([142.0.180.193]:59145 "EHLO
        s1-b4c1.socketlabs.email-od.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbeIPCvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:51:35 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Sep 2018 22:51:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1537047070; x=1539639070;
        h=x-thread-info:dkim-signature:from:to:cc:subject:date:message-id;
        bh=m9nd3Pak/HbOPPGipFt0brco0s63aO3j7N/vbsq7ERk=;
        b=tlW76OJNjPtSwhExIE+2RrZiU8FUWDm8lcDgS87TCsSHptDBF18sN2DIOVfxrRgYV7X0kIdlBqqNs0lOXL9VlRTAGfB75FeWIeGCvGbvHj32DS2wRHay+UnOciIMbRpOmV/DPnh05KW24DDjmzvn8HS7V+jbTGF/wVdCPdhUSc0=
X-Thread-Info: MTA3Zi4xMi4xMGQwMDAwMDAyNTllYjEubGludXgta2VybmVsPXZnZXIua2VybmVsLm9yZw==
Received: from r2.us-west-2a.aws.in.socketlabs.com (r2.us-west-2a.aws.in.socketlabs.com [54.186.58.227]) by mxh3.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Sat, 15 Sep 2018 17:16:01 -0400
Received: from c64.highlyillogical.org (mail.highlyillogical.org [5.9.81.41]) by r2.us-west-2a.aws.in.socketlabs.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Sat, 15 Sep 2018 17:15:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by c64.highlyillogical.org (Postfix) with ESMTP id E2ADD8C66002;
        Sat, 15 Sep 2018 22:15:56 +0100 (BST)
Received: from c64.highlyillogical.org ([127.0.0.1])
        by localhost (c64.highlyillogical.org [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xHOmLHyqlqUj; Sat, 15 Sep 2018 22:15:55 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by c64.highlyillogical.org (Postfix) with ESMTP id 980D48C66003;
        Sat, 15 Sep 2018 22:15:55 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.9.2 c64.highlyillogical.org 980D48C66003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sd.ai;
        s=E376C38A-3730-11E4-AE4A-C4ED6CE10E6B; t=1537046155;
        bh=m9nd3Pak/HbOPPGipFt0brco0s63aO3j7N/vbsq7ERk=;
        h=From:To:Subject:Date:Message-Id;
        b=Wa7rW1MCoRim47ZPRGJ/8fJ4z8xYioFu7nEkLqttsGfc+gD87eyIZ34xE2GFjyp74
         PJl4vyUDT+lVMQyC5tvyNulMqGi7O+tIRHHnw18C0hhaxUu9iluQOHaR+3qyK7mevn
         9SZi/Q+JTGiSn9EuAh9uczt/JAfgJDeq8vYR94QQ=
X-Virus-Scanned: amavisd-new at c64.highlyillogical.org
Received: from c64.highlyillogical.org ([127.0.0.1])
        by localhost (c64.highlyillogical.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RvKnuhCqn9WQ; Sat, 15 Sep 2018 22:15:55 +0100 (BST)
Received: from tachi.sd.ai (wombat.sd.ai [95.172.231.197])
        by c64.highlyillogical.org (Postfix) with ESMTPSA id 26B748C66002;
        Sat, 15 Sep 2018 22:15:55 +0100 (BST)
From:   Simon Detheridge <s@sd.ai>
Cc:     Simon Detheridge <s@sd.ai>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: cannonlake: Fix gpio base for GPP-E
Date:   Sat, 15 Sep 2018 22:15:18 +0100
Message-Id: <20180915211518.8155-1-s@sd.ai>
X-Mailer: git-send-email 2.16.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio base for GPP-E was set incorrectly to 258 instead of 256,
preventing the touchpad working on my Tong Fang GK5CN5Z laptop.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=200787
Signed-off-by: Simon Detheridge <s@sd.ai>
---
 drivers/pinctrl/intel/pinctrl-cannonlake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cannonlake.c b/drivers/pinctrl/intel/pinctrl-cannonlake.c
index fb1afe55bf53..8d48371caaa2 100644
--- a/drivers/pinctrl/intel/pinctrl-cannonlake.c
+++ b/drivers/pinctrl/intel/pinctrl-cannonlake.c
@@ -379,7 +379,7 @@ static const struct intel_padgroup cnlh_community1_gpps[] = {
 static const struct intel_padgroup cnlh_community3_gpps[] = {
 	CNL_GPP(0, 155, 178, 192),		/* GPP_K */
 	CNL_GPP(1, 179, 202, 224),		/* GPP_H */
-	CNL_GPP(2, 203, 215, 258),		/* GPP_E */
+	CNL_GPP(2, 203, 215, 256),		/* GPP_E */
 	CNL_GPP(3, 216, 239, 288),		/* GPP_F */
 	CNL_GPP(4, 240, 248, CNL_NO_GPIO),	/* SPI */
 };
-- 
2.16.4

