Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C853520859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="O1vMjcOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfAQWqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:46:13 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47704 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfAQWqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547765169; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PVwjhODYAGeltgvzngJ8dtO1QRgp91fRfTD4Ke5HM8I=;
        b=O1vMjcOamfxjqJMoO2mmVReD5JGwQIfUPdkaYnKVN2pYJ6uPqcO7rnRDfd4um6U10A5gal
        8Sw/GJzHOjCzshOvlI9uA/voxunGn8aF9/u3cxowJbknjslDQMXXcAMrgUgHNOIbi3/G45
        C8b5iSVgWVr0ah5xB8ywne+uJD0GnEU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/4] memory: jz4780_nemc: Add support for the JZ4725B
Date:   Thu, 17 Jan 2019 19:45:50 -0300
Message-Id: <20190117224550.18043-4-paul@crapouillou.net>
In-Reply-To: <20190117224550.18043-1-paul@crapouillou.net>
References: <20190117224550.18043-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the JZ4725B SoC from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/memory/jz4780-nemc.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index ef3f20e46590..c472a22d6df5 100644
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
 
+static const struct jz_soc_info jz4725b_soc_info = {
+	.tas_tah_cycles_max = 7,
+};
+
+static const struct jz_soc_info jz4780_soc_info = {
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
2.11.0

