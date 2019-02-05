Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4337CC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE0B20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wRzrpuFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBEDxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:53:07 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54484 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfBEDxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549338781; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Qi0CXh0MJuE0eRvFoNjOgETnBX4qpXUhFY6eH5R9zyQ=;
        b=wRzrpuFYlLkIP8/CeUMS/uMnHVzIZyBWOCT//PK5a5Dk1J2eCo32JB1qah3+8RhPbIVHZS
        rDmEajWkaKeaQGSWibcfB6uHbhS+kGNR6ks0fLa7Qy8lQ0rDer81yJpg4cxgdgq39IQZX0
        GmLqSleI4fBDSmD4c8KmgNi2YST6YVg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 4/4] memory: jz4780_nemc: Add support for the JZ4740
Date:   Tue,  5 Feb 2019 00:52:40 -0300
Message-Id: <20190205035240.31410-5-paul@crapouillou.net>
In-Reply-To: <20190205035240.31410-1-paul@crapouillou.net>
References: <20190205035240.31410-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the JZ4740 SoC from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---

v2: No change

v3: Support the JZ4740 instead of the JZ4725B (exact same functionality
    but JZ4740 is already fully upstream)

 drivers/memory/jz4780-nemc.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index 66b8b43eaeff..f3a19b9b76ac 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -44,9 +44,14 @@
 #define NEMC_NFCSR_NFCEn(n)	BIT((((n) - 1) << 1) + 1)
 #define NEMC_NFCSR_TNFEn(n)	BIT(16 + (n) - 1)
 
+struct jz_soc_info {
+	u8 tas_tah_cycles_max;
+};
+
 struct jz4780_nemc {
 	spinlock_t lock;
 	struct device *dev;
+	const struct jz_soc_info *soc_info;
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
 
+static const struct jz_soc_info jz4740_soc_info = {
+	.tas_tah_cycles_max = 7,
+};
+
+static const struct jz_soc_info jz4780_soc_info = {
+	.tas_tah_cycles_max = 15,
+};
+
 static const struct of_device_id jz4780_nemc_dt_match[] = {
-	{ .compatible = "ingenic,jz4780-nemc" },
+	{ .compatible = "ingenic,jz4740-nemc", .data = &jz4740_soc_info, },
+	{ .compatible = "ingenic,jz4780-nemc", .data = &jz4780_soc_info, },
 	{},
 };
 
-- 
2.11.0

