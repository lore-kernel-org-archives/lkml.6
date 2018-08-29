Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C75FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30946205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TqNqMngy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30946205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeH3Bde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:33:34 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52954 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeH3Bb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:31:59 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 04/18] dmaengine: dma-jz4780: Separate chan/ctrl registers
Date:   Wed, 29 Aug 2018 23:32:46 +0200
Message-Id: <20180829213300.22829-5-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578389; bh=xn9k7BTi5k5uYSAWEGV1unqdzWglvTup/z/gtG03npk=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TqNqMngy8dq2BusXai73U9UasGGubZQIH68nT/tDZ468JxCiRQ/28CB6mQDMG3nqBv6f67+gzWeRSqQOFrL+/ZcGpp3BZ3rLRy0gXktZBxQxZeynXgRspurku5UaJbBpb61M2Mb6XHxlIRbMunJ2ylpPedsgrIDYXpUWeprfkOw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register area of the JZ4780 DMA core can be split into different
sections for different purposes:

* one set of registers is used to perform actions at the DMA core level,
that will generally affect all channels;

* one set of registers per DMA channel, to perform actions at the DMA
channel level, that will only affect the channel in question.

The problem rises when trying to support new versions of the JZ47xx
Ingenic SoC. For instance, the JZ4770 has two DMA cores, each one
with six DMA channels, and the register sets are interleaved:
<DMA0 chan regs> <DMA1 chan regs> <DMA0 ctrl regs> <DMA1 ctrl regs>

By using one memory resource for the channel-specific registers and
one memory resource for the core-specific registers, we can support
the JZ4770, by initializing the driver once per DMA core with different
addresses.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---

Notes:
     v2: - Add a fallback mechanism for JZ4780 if the second memory resource
           was not supplied in the devicetree.
         - The documentation update was moved to patch 01/17
    
     v3: No change
    
     v4: No change
    
     v5: No change

 drivers/dma/dma-jz4780.c | 112 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 9ec22cf15a33..adf4d5efced6 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -25,26 +25,26 @@
 #include "virt-dma.h"
 
 /* Global registers. */
-#define JZ_DMA_REG_DMAC		0x1000
-#define JZ_DMA_REG_DIRQP	0x1004
-#define JZ_DMA_REG_DDR		0x1008
-#define JZ_DMA_REG_DDRS		0x100c
-#define JZ_DMA_REG_DMACP	0x101c
-#define JZ_DMA_REG_DSIRQP	0x1020
-#define JZ_DMA_REG_DSIRQM	0x1024
-#define JZ_DMA_REG_DCIRQP	0x1028
-#define JZ_DMA_REG_DCIRQM	0x102c
+#define JZ_DMA_REG_DMAC		0x00
+#define JZ_DMA_REG_DIRQP	0x04
+#define JZ_DMA_REG_DDR		0x08
+#define JZ_DMA_REG_DDRS		0x0c
+#define JZ_DMA_REG_DMACP	0x1c
+#define JZ_DMA_REG_DSIRQP	0x20
+#define JZ_DMA_REG_DSIRQM	0x24
+#define JZ_DMA_REG_DCIRQP	0x28
+#define JZ_DMA_REG_DCIRQM	0x2c
 
 /* Per-channel registers. */
 #define JZ_DMA_REG_CHAN(n)	(n * 0x20)
-#define JZ_DMA_REG_DSA(n)	(0x00 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DTA(n)	(0x04 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DTC(n)	(0x08 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DRT(n)	(0x0c + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DCS(n)	(0x10 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DCM(n)	(0x14 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DDA(n)	(0x18 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DSD(n)	(0x1c + JZ_DMA_REG_CHAN(n))
+#define JZ_DMA_REG_DSA		0x00
+#define JZ_DMA_REG_DTA		0x04
+#define JZ_DMA_REG_DTC		0x08
+#define JZ_DMA_REG_DRT		0x0c
+#define JZ_DMA_REG_DCS		0x10
+#define JZ_DMA_REG_DCM		0x14
+#define JZ_DMA_REG_DDA		0x18
+#define JZ_DMA_REG_DSD		0x1c
 
 #define JZ_DMA_DMAC_DMAE	BIT(0)
 #define JZ_DMA_DMAC_AR		BIT(2)
@@ -85,6 +85,8 @@
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
+#define JZ4780_DMA_CTRL_OFFSET	0x1000
+
 /**
  * struct jz4780_dma_hwdesc - descriptor structure read by the DMA controller.
  * @dcm: value for the DCM (channel command) register
@@ -140,7 +142,8 @@ struct jz4780_dma_soc_data {
 
 struct jz4780_dma_dev {
 	struct dma_device dma_device;
-	void __iomem *base;
+	void __iomem *chn_base;
+	void __iomem *ctrl_base;
 	struct clk *clk;
 	unsigned int irq;
 	const struct jz4780_dma_soc_data *soc_data;
@@ -173,16 +176,28 @@ static inline struct jz4780_dma_dev *jz4780_dma_chan_parent(
 			    dma_device);
 }
 
-static inline uint32_t jz4780_dma_readl(struct jz4780_dma_dev *jzdma,
+static inline uint32_t jz4780_dma_chn_readl(struct jz4780_dma_dev *jzdma,
+	unsigned int chn, unsigned int reg)
+{
+	return readl(jzdma->chn_base + reg + JZ_DMA_REG_CHAN(chn));
+}
+
+static inline void jz4780_dma_chn_writel(struct jz4780_dma_dev *jzdma,
+	unsigned int chn, unsigned int reg, uint32_t val)
+{
+	writel(val, jzdma->chn_base + reg + JZ_DMA_REG_CHAN(chn));
+}
+
+static inline uint32_t jz4780_dma_ctrl_readl(struct jz4780_dma_dev *jzdma,
 	unsigned int reg)
 {
-	return readl(jzdma->base + reg);
+	return readl(jzdma->ctrl_base + reg);
 }
 
-static inline void jz4780_dma_writel(struct jz4780_dma_dev *jzdma,
+static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
 	unsigned int reg, uint32_t val)
 {
-	writel(val, jzdma->base + reg);
+	writel(val, jzdma->ctrl_base + reg);
 }
 
 static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
@@ -477,17 +492,18 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 	}
 
 	/* Use 8-word descriptors. */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), JZ_DMA_DCS_DES8);
+	jz4780_dma_chn_writel(jzdma, jzchan->id,
+			      JZ_DMA_REG_DCS, JZ_DMA_DCS_DES8);
 
 	/* Write descriptor address and initiate descriptor fetch. */
 	desc_phys = jzchan->desc->desc_phys +
 		    (jzchan->curr_hwdesc * sizeof(*jzchan->desc->desc));
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DDA(jzchan->id), desc_phys);
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DDRS, BIT(jzchan->id));
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DDA, desc_phys);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DDRS, BIT(jzchan->id));
 
 	/* Enable the channel. */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id),
-			  JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS,
+			      JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
 }
 
 static void jz4780_dma_issue_pending(struct dma_chan *chan)
@@ -513,7 +529,7 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&jzchan->vchan.lock, flags);
 
 	/* Clear the DMA status and stop the transfer. */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), 0);
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
 	if (jzchan->desc) {
 		vchan_terminate_vdesc(&jzchan->desc->vdesc);
 		jzchan->desc = NULL;
@@ -562,8 +578,8 @@ static size_t jz4780_dma_desc_residue(struct jz4780_dma_chan *jzchan,
 		residue += desc->desc[i].dtc << jzchan->transfer_shift;
 
 	if (next_sg != 0) {
-		count = jz4780_dma_readl(jzdma,
-					 JZ_DMA_REG_DTC(jzchan->id));
+		count = jz4780_dma_chn_readl(jzdma, jzchan->id,
+					 JZ_DMA_REG_DTC);
 		residue += count << jzchan->transfer_shift;
 	}
 
@@ -610,8 +626,8 @@ static void jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 
 	spin_lock(&jzchan->vchan.lock);
 
-	dcs = jz4780_dma_readl(jzdma, JZ_DMA_REG_DCS(jzchan->id));
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), 0);
+	dcs = jz4780_dma_chn_readl(jzdma, jzchan->id, JZ_DMA_REG_DCS);
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
 
 	if (dcs & JZ_DMA_DCS_AR) {
 		dev_warn(&jzchan->vchan.chan.dev->device,
@@ -650,7 +666,7 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 	uint32_t pending, dmac;
 	int i;
 
-	pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
+	pending = jz4780_dma_ctrl_readl(jzdma, JZ_DMA_REG_DIRQP);
 
 	for (i = 0; i < jzdma->soc_data->nb_channels; i++) {
 		if (!(pending & (1<<i)))
@@ -660,12 +676,12 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 	}
 
 	/* Clear halt and address error status of all channels. */
-	dmac = jz4780_dma_readl(jzdma, JZ_DMA_REG_DMAC);
+	dmac = jz4780_dma_ctrl_readl(jzdma, JZ_DMA_REG_DMAC);
 	dmac &= ~(JZ_DMA_DMAC_HLT | JZ_DMA_DMAC_AR);
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DMAC, dmac);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC, dmac);
 
 	/* Clear interrupt pending status. */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DIRQP, 0);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DIRQP, 0);
 
 	return IRQ_HANDLED;
 }
@@ -790,9 +806,23 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	jzdma->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(jzdma->base))
-		return PTR_ERR(jzdma->base);
+	jzdma->chn_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(jzdma->chn_base))
+		return PTR_ERR(jzdma->chn_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res) {
+		jzdma->ctrl_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(jzdma->ctrl_base))
+			return PTR_ERR(jzdma->ctrl_base);
+	} else {
+		/*
+		 * On JZ4780, if the second memory resource was not supplied,
+		 * assume we're using an old devicetree, and calculate the
+		 * offset to the control registers.
+		 */
+		jzdma->ctrl_base = jzdma->chn_base + JZ4780_DMA_CTRL_OFFSET;
+	}
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
@@ -850,9 +880,9 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	 * Also set the FMSC bit - it increases MSC performance, so it makes
 	 * little sense not to enable it.
 	 */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DMAC,
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
 			  JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DMACP, 0);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
 
 	INIT_LIST_HEAD(&dd->channels);
 
-- 
2.11.0

