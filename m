Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA41C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E2C2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E2C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeGCO5N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:57:13 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:39664 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932458AbeGCO5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:57:10 -0400
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="16634815"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jul 2018 07:56:46 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 3 Jul 2018 07:56:46 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <alexandre.belloni@bootlin.com>,
        <nicolas.ferre@microchip.com>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quentin.schulz@bootlin.com>
CC:     <Cristian.Birsan@microchip.com>
Subject: [PATCH 1/2] ASoC: atmel-i2s: Remove unnecessary audio PLL clock (aclk)
Date:   Tue, 3 Jul 2018 17:56:30 +0300
Message-ID: <20180703145631.15246-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703145631.15246-1-codrin.ciubotariu@microchip.com>
References: <20180703145631.15246-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generated clock (gclk) driver is able to set aclk as its parent and
change its rate alone, if needed. This means that our driver no longer
needs to configure aclk and we can let gclk select and configure its
clock source.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/atmel-i2s.c | 46 ++++++-------------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index 5d3b5af9fd92..d88c1d995036 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -206,7 +206,6 @@ struct atmel_i2s_dev {
 	struct regmap				*regmap;
 	struct clk				*pclk;
 	struct clk				*gclk;
-	struct clk				*aclk;
 	struct snd_dmaengine_dai_dma_data	playback;
 	struct snd_dmaengine_dai_dma_data	capture;
 	unsigned int				fmt;
@@ -303,7 +302,7 @@ static int atmel_i2s_get_gck_param(struct atmel_i2s_dev *dev, int fs)
 {
 	int i, best;
 
-	if (!dev->gclk || !dev->aclk) {
+	if (!dev->gclk) {
 		dev_err(dev->dev, "cannot generate the I2S Master Clock\n");
 		return -EINVAL;
 	}
@@ -421,7 +420,7 @@ static int atmel_i2s_switch_mck_generator(struct atmel_i2s_dev *dev,
 					  bool enabled)
 {
 	unsigned int mr, mr_mask;
-	unsigned long aclk_rate;
+	unsigned long gclk_rate;
 	int ret;
 
 	mr = 0;
@@ -445,35 +444,18 @@ static int atmel_i2s_switch_mck_generator(struct atmel_i2s_dev *dev,
 		/* Disable/unprepare the PMC generated clock. */
 		clk_disable_unprepare(dev->gclk);
 
-		/* Disable/unprepare the PLL audio clock. */
-		clk_disable_unprepare(dev->aclk);
 		return 0;
 	}
 
 	if (!dev->gck_param)
 		return -EINVAL;
 
-	aclk_rate = dev->gck_param->mck * (dev->gck_param->imckdiv + 1);
+	gclk_rate = dev->gck_param->mck * (dev->gck_param->imckdiv + 1);
 
-	/* Fist change the PLL audio clock frequency ... */
-	ret = clk_set_rate(dev->aclk, aclk_rate);
+	ret = clk_set_rate(dev->gclk, gclk_rate);
 	if (ret)
 		return ret;
 
-	/*
-	 * ... then set the PMC generated clock rate to the very same frequency
-	 * to set the gclk parent to aclk.
-	 */
-	ret = clk_set_rate(dev->gclk, aclk_rate);
-	if (ret)
-		return ret;
-
-	/* Prepare and enable the PLL audio clock first ... */
-	ret = clk_prepare_enable(dev->aclk);
-	if (ret)
-		return ret;
-
-	/* ... then prepare and enable the PMC generated clock. */
 	ret = clk_prepare_enable(dev->gclk);
 	if (ret)
 		return ret;
@@ -668,28 +650,14 @@ static int atmel_i2s_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	/* Get audio clocks to generate the I2S Master Clock (I2S_MCK) */
-	dev->aclk = devm_clk_get(&pdev->dev, "aclk");
+	/* Get audio clock to generate the I2S Master Clock (I2S_MCK) */
 	dev->gclk = devm_clk_get(&pdev->dev, "gclk");
-	if (IS_ERR(dev->aclk) && IS_ERR(dev->gclk)) {
-		if (PTR_ERR(dev->aclk) == -EPROBE_DEFER ||
-		    PTR_ERR(dev->gclk) == -EPROBE_DEFER)
+	if (IS_ERR(dev->gclk)) {
+		if (PTR_ERR(dev->gclk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		/* Master Mode not supported */
-		dev->aclk = NULL;
 		dev->gclk = NULL;
-	} else if (IS_ERR(dev->gclk)) {
-		err = PTR_ERR(dev->gclk);
-		dev_err(&pdev->dev,
-			"failed to get the PMC generated clock: %d\n", err);
-		return err;
-	} else if (IS_ERR(dev->aclk)) {
-		err = PTR_ERR(dev->aclk);
-		dev_err(&pdev->dev,
-			"failed to get the PLL audio clock: %d\n", err);
-		return err;
 	}
-
 	dev->dev = &pdev->dev;
 	dev->regmap = regmap;
 	platform_set_drvdata(pdev, dev);
-- 
2.17.1

