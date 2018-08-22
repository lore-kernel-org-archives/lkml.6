Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C32C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B831820A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="bATAp7kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B831820A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeHVUzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:55:49 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43468 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeHVUzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:55:45 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alex Smith <alex@alex-smith.me.uk>
Cc:     od@zcrc.me, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/4] memory: jz4780_nemc: Add support for the JZ4725B
Date:   Wed, 22 Aug 2018 19:29:53 +0200
Message-Id: <20180822172953.11281-4-paul@crapouillou.net>
In-Reply-To: <20180822172953.11281-1-paul@crapouillou.net>
References: <20180822172953.11281-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534958997; bh=oQswJ69nSDL1/HI0P5sU4Ee/USYyuRq74KDcihGk/fA=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bATAp7kcYp32lDk0eEabi+3TFMTLrCfy7VLOv8vPpTzIksMm8FMix9l8y7t8DC0/6HK9l2G5zeRImh89F36eb9mCMlNBbZZtjxl1yeM3xpgG4aGRIehPve+VUmKd+GYUtFpNIBz1Q7OBfGnc5qdR8caluC8EL1+HEPddZOAIrkg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NEMC module in the JZ4725B is very similar to the one in the JZ4780.
The only difference I could spot was that the TAS/TAH timings are
limited to 7 clock ticks on the JZ4725B instead of 15 on the JZ4780.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/memory/jz4780-nemc.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index ef3f20e46590..c52d254988dc 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -44,9 +44,14 @@
 #define NEMC_NFCSR_NFCEn(n)	BIT((((n) - 1) << 1) + 1)
 #define NEMC_NFCSR_TNFEn(n)	BIT(16 + (n) - 1)
 
+struct jz4780_nemc_soc_info {
+	uint8_t tas_tah_cycles_max;
+};
+
 struct jz4780_nemc {
 	spinlock_t lock;
 	struct device *dev;
+	const struct jz4780_nemc_soc_info *soc_info;
 	void __iomem *base;
 	struct clk *clk;
 	uint32_t clk_period;
@@ -202,7 +207,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
 	if (of_property_read_u32(node, "ingenic,nemc-tAS", &val) == 0) {
 		smcr &= ~NEMC_SMCR_TAS_MASK;
 		cycles = jz4780_nemc_ns_to_cycles(nemc, val);
-		if (cycles > 15) {
+		if (cycles > nemc->soc_info->tas_tah_cycles_max) {
 			dev_err(nemc->dev, "tAS %u is too high (%u cycles)\n",
 				val, cycles);
 			return false;
@@ -214,7 +219,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
 	if (of_property_read_u32(node, "ingenic,nemc-tAH", &val) == 0) {
 		smcr &= ~NEMC_SMCR_TAH_MASK;
 		cycles = jz4780_nemc_ns_to_cycles(nemc, val);
-		if (cycles > 15) {
+		if (cycles > nemc->soc_info->tas_tah_cycles_max) {
 			dev_err(nemc->dev, "tAH %u is too high (%u cycles)\n",
 				val, cycles);
 			return false;
@@ -278,6 +283,10 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 	if (!nemc)
 		return -ENOMEM;
 
+	nemc->soc_info = device_get_match_data(dev);
+	if (!nemc->soc_info)
+		return -EINVAL;
+
 	spin_lock_init(&nemc->lock);
 	nemc->dev = dev;
 
@@ -370,8 +379,17 @@ static int jz4780_nemc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct jz4780_nemc_soc_info jz4725b_soc_info = {
+	.tas_tah_cycles_max = 7,
+};
+
+static const struct jz4780_nemc_soc_info jz4780_soc_info = {
+	.tas_tah_cycles_max = 15,
+};
+
 static const struct of_device_id jz4780_nemc_dt_match[] = {
-	{ .compatible = "ingenic,jz4780-nemc" },
+	{ .compatible = "ingenic,jz4725b-nemc", .data = &jz4725b_soc_info, },
+	{ .compatible = "ingenic,jz4780-nemc", .data = &jz4780_soc_info, },
 	{},
 };
 
-- 
2.18.0

