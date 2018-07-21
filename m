Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4E4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E17320856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xYh5DBAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E17320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeGUMAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:00:02 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42396 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeGUMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:00:02 -0400
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
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v3 03/18] dmaengine: dma-jz4780: Avoid hardcoding number of channels
Date:   Sat, 21 Jul 2018 13:06:28 +0200
Message-Id: <20180721110643.19624-4-paul@crapouillou.net>
In-Reply-To: <20180721110643.19624-1-paul@crapouillou.net>
References: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171259; bh=hciIk9gID7aV0NKrxOVE+5rhlcyIEKEEoUFxhmnxPeE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=xYh5DBAciLnkPTh6BaumB2w+kO+cSeF798nZsTWU5SlqHEg3X3jYKMfMDVe2i2IJOM8vQI26VZSOSFyldgPGH26ENJIlluPtJzmWx9WkFYQmqd2kqsNpxyl/CWbItRV3HUyY7tEHdw0CujlqF8Q/E5Fx57N/vMhjMAGcDXSWP9s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the work to support various other Ingenic JZ47xx SoC versions,
which don't feature the same number of DMA channels per core, we now
deduce the number of DMA channels available from the devicetree
compatible string.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 53 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 14 deletions(-)

 v2: - don't hardcode jz_version to ID_JZ4780 when not probed from DT,
       because it cannot happen
     - Put SoC-specific data into a jz4780_dma_soc_data structure

 v3: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 987899610b46..a26107c85ee7 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -23,8 +24,6 @@
 #include "dmaengine.h"
 #include "virt-dma.h"
 
-#define JZ_DMA_NR_CHANNELS	32
-
 /* Global registers. */
 #define JZ_DMA_REG_DMAC		0x1000
 #define JZ_DMA_REG_DIRQP	0x1004
@@ -135,14 +134,24 @@ struct jz4780_dma_chan {
 	unsigned int curr_hwdesc;
 };
 
+enum jz_version {
+	ID_JZ4780,
+};
+
+struct jz4780_dma_soc_data {
+	unsigned int nb_channels;
+};
+
 struct jz4780_dma_dev {
 	struct dma_device dma_device;
 	void __iomem *base;
 	struct clk *clk;
 	unsigned int irq;
+	enum jz_version version;
+	const struct jz4780_dma_soc_data *soc_data;
 
 	uint32_t chan_reserved;
-	struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
+	struct jz4780_dma_chan chan[];
 };
 
 struct jz4780_dma_filter_data {
@@ -648,7 +657,7 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 
 	pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
 
-	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
+	for (i = 0; i < jzdma->soc_data->nb_channels; i++) {
 		if (!(pending & (1<<i)))
 			continue;
 
@@ -728,7 +737,7 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 	data.channel = dma_spec->args[1];
 
 	if (data.channel > -1) {
-		if (data.channel >= JZ_DMA_NR_CHANNELS) {
+		if (data.channel >= jzdma->soc_data->nb_channels) {
 			dev_err(jzdma->dma_device.dev,
 				"device requested non-existent channel %u\n",
 				data.channel);
@@ -752,13 +761,27 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 	}
 }
 
+static const struct jz4780_dma_soc_data jz4780_dma_soc_data[] = {
+	[ID_JZ4780] = { .nb_channels = 32, },
+};
+
+static const struct of_device_id jz4780_dma_dt_match[] = {
+	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
+
 static int jz4780_dma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id = of_match_device(
+			jz4780_dma_dt_match, dev);
+	const struct jz4780_dma_soc_data *soc_data;
 	struct jz4780_dma_dev *jzdma;
 	struct jz4780_dma_chan *jzchan;
 	struct dma_device *dd;
 	struct resource *res;
+	enum jz_version version;
 	int i, ret;
 
 	if (!dev->of_node) {
@@ -766,10 +789,18 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
+	version = (enum jz_version)of_id->data;
+	soc_data = &jz4780_dma_soc_data[version];
+
+	jzdma = devm_kzalloc(dev, sizeof(*jzdma)
+				+ sizeof(*jzdma->chan) * soc_data->nb_channels,
+				GFP_KERNEL);
 	if (!jzdma)
 		return -ENOMEM;
 
+	jzdma->soc_data = soc_data;
+	jzdma->version = version;
+
 	platform_set_drvdata(pdev, jzdma);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -844,7 +875,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&dd->channels);
 
-	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
+	for (i = 0; i < soc_data->nb_channels; i++) {
 		jzchan = &jzdma->chan[i];
 		jzchan->id = i;
 
@@ -889,19 +920,13 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 
 	free_irq(jzdma->irq, jzdma);
 
-	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++)
+	for (i = 0; i < jzdma->soc_data->nb_channels; i++)
 		tasklet_kill(&jzdma->chan[i].vchan.task);
 
 	dma_async_device_unregister(&jzdma->dma_device);
 	return 0;
 }
 
-static const struct of_device_id jz4780_dma_dt_match[] = {
-	{ .compatible = "ingenic,jz4780-dma", .data = NULL },
-	{},
-};
-MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
-
 static struct platform_driver jz4780_dma_driver = {
 	.probe		= jz4780_dma_probe,
 	.remove		= jz4780_dma_remove,
-- 
2.11.0

