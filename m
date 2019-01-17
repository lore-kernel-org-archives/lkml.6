Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B92EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3DB20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="GaRT4P7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfAQWqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:46:10 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47682 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfAQWqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547765166; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M+/It5kTEdXJNplczT6lfSARNCXNp0MHT/K3+fn6ZJM=;
        b=GaRT4P7WFllQLmlamgMMJuZ3YN2sYutmmQBGumrBScMtRGZ0Zgu8zas7JMXUNi1b0XUQ/0
        OjKJw49bkdd/baw4pRdAGxxF0p6ScmXjEWf4xpuA5vpj+lvlWTNhVcv/V646yEC53clczT
        ewxAnhVYiqNMacn6liEhBdO0CCzZzNM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] memory: jz4780-nemc: Reduce size of const array
Date:   Thu, 17 Jan 2019 19:45:49 -0300
Message-Id: <20190117224550.18043-3-paul@crapouillou.net>
In-Reply-To: <20190117224550.18043-1-paul@crapouillou.net>
References: <20190117224550.18043-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum value found in that array is 15, there's no need to store
these values as uint32_t, a uint8_t is enough.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/memory/jz4780-nemc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index bcf06adefc96..ef3f20e46590 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -161,7 +161,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
 	 * Conversion of tBP and tAW cycle counts to values supported by the
 	 * hardware (round up to the next supported value).
 	 */
-	static const uint32_t convert_tBP_tAW[] = {
+	static const u8 convert_tBP_tAW[] = {
 		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
 
 		/* 11 - 12 -> 12 cycles */
@@ -232,7 +232,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
 			return false;
 		}
 
-		smcr |= convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;
+		smcr |= (u32)convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;
 	}
 
 	if (of_property_read_u32(node, "ingenic,nemc-tAW", &val) == 0) {
@@ -244,7 +244,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
 			return false;
 		}
 
-		smcr |= convert_tBP_tAW[cycles] << NEMC_SMCR_TAW_SHIFT;
+		smcr |= (u32)convert_tBP_tAW[cycles] << NEMC_SMCR_TAW_SHIFT;
 	}
 
 	if (of_property_read_u32(node, "ingenic,nemc-tSTRV", &val) == 0) {
-- 
2.11.0

