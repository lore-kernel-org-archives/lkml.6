Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E13C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFFA20A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="cjOzKQhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFFA20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeHVUzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:55:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43288 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeHVUzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:55:45 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alex Smith <alex@alex-smith.me.uk>
Cc:     od@zcrc.me, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] memory: jz4780-nemc: Reduce size of const array
Date:   Wed, 22 Aug 2018 19:29:52 +0200
Message-Id: <20180822172953.11281-3-paul@crapouillou.net>
In-Reply-To: <20180822172953.11281-1-paul@crapouillou.net>
References: <20180822172953.11281-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534958996; bh=PXRuqSy14TycukUrpJYcg8s6UXXUOhkq2uyLT7ByAhs=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cjOzKQhN+i17IJ0mb9iKqIFrXVSel2dsdQBCDf7av0NfHre01wb1tjv1U2EpjUjd6rtUcvVBA3Uo3nKE4LTLiwIQwxY1AzHrVaSXi/83xSTtz0ysn4MP6DLSc4GyyjiAzqwV4+3R8EZkUMsrd+Qgl0Fwq/mE29GNMwGyKavCL9w=
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
2.18.0

