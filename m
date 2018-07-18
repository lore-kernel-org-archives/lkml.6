Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D90CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE9120854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="iN1bxBqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE9120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGRTAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:00:01 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41618 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbeGRTAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:00:01 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 08/17] dmaengine: dma-jz4780: Add support for the JZ4725B SoC
Date:   Wed, 18 Jul 2018 20:20:14 +0200
Message-Id: <20180718182023.8182-9-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938053; bh=rx0Rp8o3lKHmlOAaWolX5YnxdeatZUSndvlO+bADjyA=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iN1bxBqBw43geI198c85ztmlyhllYNoYeFm0k9zMs7hEZpD2DFfAGGksnkQLLzO5zNr7Zmxcvb2hdDnB7sXdFu/OSV8IzF+6tc8GLcnN58Xqz94v/Piv0deAT2vku4f/sR7ecBSUvEaExGk6kTl1uZ0XgXYb8rikr9RwEkPIILc=
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
 drivers/dma/dma-jz4780.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

 v2: - Add comments about channel enabling/disabling
     - The documentation update is now in patch 01/17

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 084d4023637e..88ce3f0157f6 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -136,6 +136,7 @@ struct jz4780_dma_chan {
 
 enum jz_version {
 	ID_JZ4740,
+	ID_JZ4725B,
 	ID_JZ4770,
 	ID_JZ4780,
 };
@@ -209,8 +210,12 @@ static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
 static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
 	unsigned int chn)
 {
-	if (jzdma->version == ID_JZ4770)
+	if (jzdma->version == ID_JZ4770) {
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
+	} else if (jzdma->version == ID_JZ4725B) {
+		/* JZ4725B has no DCKES, it uses DCKE to enable channels */
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));
+	}
 }
 
 static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
@@ -218,6 +223,8 @@ static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
 {
 	if (jzdma->version == ID_JZ4770)
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
+
+	/* On JZ4725B it is not possible to stop a DMA channel once enabled */
 }
 
 static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
@@ -805,12 +812,14 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 
 static const struct jz4780_dma_soc_data jz4780_dma_soc_data[] = {
 	[ID_JZ4740] = { .nb_channels = 6, .transfer_ord_max = 5, },
+	[ID_JZ4725B] = { .nb_channels = 6, .transfer_ord_max = 5, },
 	[ID_JZ4770] = { .nb_channels = 6, .transfer_ord_max = 6, },
 	[ID_JZ4780] = { .nb_channels = 32, .transfer_ord_max = 7, },
 };
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
+	{ .compatible = "ingenic,jz4725b-dma", .data = (void *)ID_JZ4725B },
 	{ .compatible = "ingenic,jz4770-dma", .data = (void *)ID_JZ4770 },
 	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
 	{},
-- 
2.11.0

