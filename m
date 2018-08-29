Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4C0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B0020652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QncKWhRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B0020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeH3BcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:32:02 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52708 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeH3BcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:32:01 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 07/18] dmaengine: dma-jz4780: Add support for the JZ4770 SoC
Date:   Wed, 29 Aug 2018 23:32:49 +0200
Message-Id: <20180829213300.22829-8-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578392; bh=Bo4QLFP+heERzxmfk+bALQlbIcqrY3PX7UjMJAIMe+8=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QncKWhRRgt59HJ2apCmS4FIiwJVq3C4UWQ7lMFTDPRLfZfNWUhafX7+ow6mNNrOOynyZOmZeEXc/THM4DInpQ1tCTwrq0eBO6sbiZ5tSqYiY1eT6n7/6Pw5UlV1ah4bUpwOtyMIZszghukojioOv0kiT0XeKm5LLbzfVQE2rZn8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JZ4770 SoC has two DMA cores, each one featuring six DMA channels.
The major change is that each channel's clock can be enabled or disabled
through register writes.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---

Notes:
     v2: - Move transfer_ord_max variable to the new jz4780_dma_soc_data
           structure
         - The documentation update is now in patch 01/17
    
     v3: The Kconfig update was dropped thanks to patch 06/18
    
     v4: Pass jz4780_dma_soc_data structure pointer directly as devicetree
         match data; Add a 'flags' field in that structure and macros for
         it, to replace checking vs. the SoC version.
    
     v5: No change

 drivers/dma/dma-jz4780.c | 61 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7683de9fb9ee..184d1a2bf9ba 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -29,6 +29,9 @@
 #define JZ_DMA_REG_DIRQP	0x04
 #define JZ_DMA_REG_DDR		0x08
 #define JZ_DMA_REG_DDRS		0x0c
+#define JZ_DMA_REG_DCKE		0x10
+#define JZ_DMA_REG_DCKES	0x14
+#define JZ_DMA_REG_DCKEC	0x18
 #define JZ_DMA_REG_DMACP	0x1c
 #define JZ_DMA_REG_DSIRQP	0x20
 #define JZ_DMA_REG_DSIRQM	0x24
@@ -87,6 +90,11 @@
 
 #define JZ4780_DMA_CTRL_OFFSET	0x1000
 
+/* macros for use with jz4780_dma_soc_data.flags */
+#define JZ_SOC_DATA_ALLOW_LEGACY_DT	BIT(0)
+#define JZ_SOC_DATA_PROGRAMMABLE_DMA	BIT(1)
+#define JZ_SOC_DATA_PER_CHAN_PM		BIT(2)
+
 /**
  * struct jz4780_dma_hwdesc - descriptor structure read by the DMA controller.
  * @dcm: value for the DCM (channel command) register
@@ -133,6 +141,8 @@ struct jz4780_dma_chan {
 
 struct jz4780_dma_soc_data {
 	unsigned int nb_channels;
+	unsigned int transfer_ord_max;
+	unsigned long flags;
 };
 
 struct jz4780_dma_dev {
@@ -195,6 +205,20 @@ static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
 	writel(val, jzdma->ctrl_base + reg);
 }
 
+static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
+	unsigned int chn)
+{
+	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
+}
+
+static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
+	unsigned int chn)
+{
+	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
+}
+
 static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
 	struct jz4780_dma_chan *jzchan, unsigned int count,
 	enum dma_transaction_type type)
@@ -229,8 +253,10 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
 	kfree(desc);
 }
 
-static uint32_t jz4780_dma_transfer_size(unsigned long val, uint32_t *shift)
+static uint32_t jz4780_dma_transfer_size(struct jz4780_dma_chan *jzchan,
+	unsigned long val, uint32_t *shift)
 {
+	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 	int ord = ffs(val) - 1;
 
 	/*
@@ -242,8 +268,8 @@ static uint32_t jz4780_dma_transfer_size(unsigned long val, uint32_t *shift)
 	 */
 	if (ord == 3)
 		ord = 2;
-	else if (ord > 7)
-		ord = 7;
+	else if (ord > jzdma->soc_data->transfer_ord_max)
+		ord = jzdma->soc_data->transfer_ord_max;
 
 	*shift = ord;
 
@@ -295,7 +321,7 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 	 * divisible by the transfer size, and we must not use more than the
 	 * maximum burst specified by the user.
 	 */
-	tsz = jz4780_dma_transfer_size(addr | len | (width * maxburst),
+	tsz = jz4780_dma_transfer_size(jzchan, addr | len | (width * maxburst),
 				       &jzchan->transfer_shift);
 
 	switch (width) {
@@ -424,7 +450,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_memcpy(
 	if (!desc)
 		return NULL;
 
-	tsz = jz4780_dma_transfer_size(dest | src | len,
+	tsz = jz4780_dma_transfer_size(jzchan, dest | src | len,
 				       &jzchan->transfer_shift);
 
 	jzchan->transfer_type = JZ_DMA_DRT_AUTO;
@@ -485,6 +511,9 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 			(jzchan->curr_hwdesc + 1) % jzchan->desc->count;
 	}
 
+	/* Enable the channel's clock. */
+	jz4780_dma_chan_enable(jzdma, jzchan->id);
+
 	/* Use 4-word descriptors. */
 	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
 
@@ -532,6 +561,8 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 		jzchan->desc = NULL;
 	}
 
+	jz4780_dma_chan_disable(jzdma, jzchan->id);
+
 	vchan_get_all_descriptors(&jzchan->vchan, &head);
 
 	spin_unlock_irqrestore(&jzchan->vchan.lock, flags);
@@ -543,8 +574,10 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 static void jz4780_dma_synchronize(struct dma_chan *chan)
 {
 	struct jz4780_dma_chan *jzchan = to_jz4780_dma_chan(chan);
+	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 
 	vchan_synchronize(&jzchan->vchan);
+	jz4780_dma_chan_disable(jzdma, jzchan->id);
 }
 
 static int jz4780_dma_config(struct dma_chan *chan,
@@ -812,13 +845,16 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		jzdma->ctrl_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(jzdma->ctrl_base))
 			return PTR_ERR(jzdma->ctrl_base);
-	} else {
+	} else if (soc_data->flags & JZ_SOC_DATA_ALLOW_LEGACY_DT) {
 		/*
 		 * On JZ4780, if the second memory resource was not supplied,
 		 * assume we're using an old devicetree, and calculate the
 		 * offset to the control registers.
 		 */
 		jzdma->ctrl_base = jzdma->chn_base + JZ4780_DMA_CTRL_OFFSET;
+	} else {
+		dev_err(dev, "failed to get I/O memory\n");
+		return -EINVAL;
 	}
 
 	ret = platform_get_irq(pdev, 0);
@@ -879,7 +915,9 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	 */
 	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
 			  JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
-	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
+
+	if (soc_data->flags & JZ_SOC_DATA_PROGRAMMABLE_DMA)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
 
 	INIT_LIST_HEAD(&dd->channels);
 
@@ -935,11 +973,20 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {
+	.nb_channels = 6,
+	.transfer_ord_max = 6,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM,
+};
+
 static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
 	.nb_channels = 32,
+	.transfer_ord_max = 7,
+	.flags = JZ_SOC_DATA_ALLOW_LEGACY_DT | JZ_SOC_DATA_PROGRAMMABLE_DMA,
 };
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
+	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{},
 };
-- 
2.11.0

