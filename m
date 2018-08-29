Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84550C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4B1205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Z0PNlAPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4B1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeH3BcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:32:04 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53420 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeH3BcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:32:03 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 09/18] dmaengine: dma-jz4780: Add support for the JZ4725B SoC
Date:   Wed, 29 Aug 2018 23:32:51 +0200
Message-Id: <20180829213300.22829-10-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578394; bh=IvhXseR+rjjnSwuCq5YWS2DJ57/S3B88keuBOYZnRPU=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z0PNlAPFsqgt10BHU/dMW8DuuRLJVctiyFJtfKWN/tLyVBLHvaR+k2pHBxoDODXSsXtP+RIR8ceqMQB8PnTdAK+GWJx6RnHo7ZAtu3Dscw439tS66SAANV/xwRoOTPb95MwsqbEINu+ySTf9QESfR9aiKnp0lg5CwgXD4s8bcYk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JZ4725B has one DMA core starring six DMA channels.
As for the JZ4770, each DMA channel's clock can be enabled with
a register write, the difference here being that once started, it
is not possible to turn it off.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---

Notes:
     v2: - Add comments about channel enabling/disabling
         - The documentation update is now in patch 01/17
    
     v3: No change
    
     v4: Drop the SoC version ID and use the 'flags' field of the
         jz4780_dma_soc_data structure
    
     v5: No change

 drivers/dma/dma-jz4780.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 2d194dfa697e..565971c2a33c 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -94,6 +94,7 @@
 #define JZ_SOC_DATA_ALLOW_LEGACY_DT	BIT(0)
 #define JZ_SOC_DATA_PROGRAMMABLE_DMA	BIT(1)
 #define JZ_SOC_DATA_PER_CHAN_PM		BIT(2)
+#define JZ_SOC_DATA_NO_DCKES_DCKEC	BIT(3)
 
 /**
  * struct jz4780_dma_hwdesc - descriptor structure read by the DMA controller.
@@ -208,14 +209,23 @@ static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
 static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
 	unsigned int chn)
 {
-	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM)
-		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
+	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM) {
+		unsigned int reg;
+
+		if (jzdma->soc_data->flags & JZ_SOC_DATA_NO_DCKES_DCKEC)
+			reg = JZ_DMA_REG_DCKE;
+		else
+			reg = JZ_DMA_REG_DCKES;
+
+		jz4780_dma_ctrl_writel(jzdma, reg, BIT(chn));
+	}
 }
 
 static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
 	unsigned int chn)
 {
-	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM)
+	if ((jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM) &&
+			!(jzdma->soc_data->flags & JZ_SOC_DATA_NO_DCKES_DCKEC))
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
 }
 
@@ -978,6 +988,12 @@ static const struct jz4780_dma_soc_data jz4740_dma_soc_data = {
 	.transfer_ord_max = 5,
 };
 
+static const struct jz4780_dma_soc_data jz4725b_dma_soc_data = {
+	.nb_channels = 6,
+	.transfer_ord_max = 5,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC,
+};
+
 static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 6,
@@ -992,6 +1008,7 @@ static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
+	{ .compatible = "ingenic,jz4725b-dma", .data = &jz4725b_dma_soc_data },
 	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{},
-- 
2.11.0

