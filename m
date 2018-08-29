Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F45EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5225120652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="EFdVysQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5225120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeH3Bb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:31:59 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52708 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeH3Bb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:31:58 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 03/18] dmaengine: dma-jz4780: Avoid hardcoding number of channels
Date:   Wed, 29 Aug 2018 23:32:45 +0200
Message-Id: <20180829213300.22829-4-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578388; bh=b9QeTpvCZgiC4ukhwKE7+vuX9W5fKIHXO5uq4G8Nipc=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EFdVysQImfLk0rCgyiIgDTHs6Gl/lufGW+NqPUKkfJbUNzsyFahVMAPagd+CaW1Vy1y+QxAuPawHY/OvKeGnoAIM3CUJWXGBV8g/JjSHnyVMS8auuWB+6+U5DI5IJ172tzbamvE1YWvwfdPF7+HOgHs6x6dYIXXjdp6+VnroR00=
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

Notes:
     v2: - don't hardcode jz_version to ID_JZ4780 when not probed from DT,
           because it cannot happen
         - Put SoC-specific data into a jz4780_dma_soc_data structure
    
     v3: No change
    
     v4: Remove jz_version; pass the jz4780_dma_soc_data structure pointer
         as devicetree match data, and use device_get_match_data().
    
     v5: No change

 drivers/dma/dma-jz4780.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 987899610b46..9ec22cf15a33 100644
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
@@ -135,14 +134,19 @@ struct jz4780_dma_chan {
 	unsigned int curr_hwdesc;
 };
 
+struct jz4780_dma_soc_data {
+	unsigned int nb_channels;
+};
+
 struct jz4780_dma_dev {
 	struct dma_device dma_device;
 	void __iomem *base;
 	struct clk *clk;
 	unsigned int irq;
+	const struct jz4780_dma_soc_data *soc_data;
 
 	uint32_t chan_reserved;
-	struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
+	struct jz4780_dma_chan chan[];
 };
 
 struct jz4780_dma_filter_data {
@@ -648,7 +652,7 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 
 	pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
 
-	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
+	for (i = 0; i < jzdma->soc_data->nb_channels; i++) {
 		if (!(pending & (1<<i)))
 			continue;
 
@@ -728,7 +732,7 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 	data.channel = dma_spec->args[1];
 
 	if (data.channel > -1) {
-		if (data.channel >= JZ_DMA_NR_CHANNELS) {
+		if (data.channel >= jzdma->soc_data->nb_channels) {
 			dev_err(jzdma->dma_device.dev,
 				"device requested non-existent channel %u\n",
 				data.channel);
@@ -755,6 +759,7 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 static int jz4780_dma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct jz4780_dma_soc_data *soc_data;
 	struct jz4780_dma_dev *jzdma;
 	struct jz4780_dma_chan *jzchan;
 	struct dma_device *dd;
@@ -766,10 +771,17 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
+	soc_data = device_get_match_data(dev);
+	if (!soc_data)
+		return -EINVAL;
+
+	jzdma = devm_kzalloc(dev, sizeof(*jzdma)
+				+ sizeof(*jzdma->chan) * soc_data->nb_channels,
+				GFP_KERNEL);
 	if (!jzdma)
 		return -ENOMEM;
 
+	jzdma->soc_data = soc_data;
 	platform_set_drvdata(pdev, jzdma);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -844,7 +856,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&dd->channels);
 
-	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
+	for (i = 0; i < soc_data->nb_channels; i++) {
 		jzchan = &jzdma->chan[i];
 		jzchan->id = i;
 
@@ -889,15 +901,19 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 
 	free_irq(jzdma->irq, jzdma);
 
-	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++)
+	for (i = 0; i < jzdma->soc_data->nb_channels; i++)
 		tasklet_kill(&jzdma->chan[i].vchan.task);
 
 	dma_async_device_unregister(&jzdma->dma_device);
 	return 0;
 }
 
+static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
+	.nb_channels = 32,
+};
+
 static const struct of_device_id jz4780_dma_dt_match[] = {
-	{ .compatible = "ingenic,jz4780-dma", .data = NULL },
+	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
-- 
2.11.0

