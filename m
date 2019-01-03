Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3FDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC472070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pvF+P/bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbfACOES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:04:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56344 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbfACOEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:04:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x03E43Mg105842;
        Thu, 3 Jan 2019 08:04:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546524243;
        bh=wO4O+keUGsu8JqRwwYrSTsKEUZ1lb0DS/5jTQfIU1lI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pvF+P/bHYcoz05vDxSbAW/1SVwS57knlpmf/9BHPKVp+k1TO4Yu3LXneEK8ipfIKp
         oST7zoxj7Y/wYpOlsF1AH3P3buTja1kYopLEeLQT5Ou9OKU8UYJo/URjBi9ZhD6wCN
         4GBITp3ZVo+5Q1JGqm5jBGolF6EFx2kgSwgBaoY4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x03E43qd004696
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 08:04:03 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 3
 Jan 2019 08:04:02 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 3 Jan 2019 08:04:02 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x03E3rlP021111;
        Thu, 3 Jan 2019 08:04:00 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: ti: davinci-mcasp: Add support for GPIO mode of the pins
Date:   Thu, 3 Jan 2019 16:05:52 +0200
Message-ID: <20190103140552.29809-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103140552.29809-1-peter.ujfalusi@ti.com>
References: <20190103140552.29809-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All McASP pin can be configured as GPIO.
Add gpiochip support for McASP and only enable it when the
gpio-controller is present in the DT node.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 159 ++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index a6a470a76900..a3a67a8f0f54 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/davinci_asp.h>
 #include <linux/math64.h>
 #include <linux/bitmap.h>
+#include <linux/gpio/driver.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -54,6 +55,7 @@ static u32 context_regs[] = {
 	DAVINCI_MCASP_AHCLKXCTL_REG,
 	DAVINCI_MCASP_AHCLKRCTL_REG,
 	DAVINCI_MCASP_PDIR_REG,
+	DAVINCI_MCASP_PFUNC_REG,
 	DAVINCI_MCASP_RXMASK_REG,
 	DAVINCI_MCASP_TXMASK_REG,
 	DAVINCI_MCASP_RXTDM_REG,
@@ -108,6 +110,10 @@ struct davinci_mcasp {
 	/* Used for comstraint setting on the second stream */
 	u32	channels;
 
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio_chip;
+#endif
+
 #ifdef CONFIG_PM
 	struct davinci_mcasp_context context;
 #endif
@@ -818,9 +824,6 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	if (mcasp->version < MCASP_VERSION_3)
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
 
-	/* All PINS as McASP */
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
-
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
@@ -1845,6 +1848,147 @@ static u32 davinci_mcasp_rxdma_offset(struct davinci_mcasp_pdata *pdata)
 	return offset;
 }
 
+#ifdef CONFIG_GPIOLIB
+static int davinci_mcasp_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+
+	if (mcasp->num_serializer && offset < mcasp->num_serializer &&
+	    mcasp->serial_dir[offset] != INACTIVE_MODE) {
+		dev_err(mcasp->dev, "AXR%u pin is  used for audio\n", offset);
+		return -EBUSY;
+	}
+
+	/* Do not change the PIN yet */
+
+	return pm_runtime_get_sync(mcasp->dev);
+}
+
+static void davinci_mcasp_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+
+	/* Set the direction to input */
+	mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(offset));
+
+	/* Set the pin as McASP pin */
+	mcasp_clr_bits(mcasp, DAVINCI_MCASP_PFUNC_REG, BIT(offset));
+
+	pm_runtime_put_sync(mcasp->dev);
+}
+
+static int davinci_mcasp_gpio_direction_out(struct gpio_chip *chip,
+					    unsigned offset, int value)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	if (value)
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+	else
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PFUNC_REG);
+	if (!(val & BIT(offset))) {
+		/* Set the pin as GPIO pin */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PFUNC_REG, BIT(offset));
+
+		/* Set the direction to output */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(offset));
+	}
+
+	return 0;
+}
+
+static void davinci_mcasp_gpio_set(struct gpio_chip *chip, unsigned offset,
+				  int value)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+
+	if (value)
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+	else
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+}
+
+static int davinci_mcasp_gpio_direction_in(struct gpio_chip *chip,
+					   unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PFUNC_REG);
+	if (!(val & BIT(offset))) {
+		/* Set the direction to input */
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(offset));
+
+		/* Set the pin as GPIO pin */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PFUNC_REG, BIT(offset));
+	}
+
+	return 0;
+}
+
+static int davinci_mcasp_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDSET_REG);
+	if (val & BIT(offset))
+		return 1;
+
+	return 0;
+}
+
+static int davinci_mcasp_gpio_get_direction(struct gpio_chip *chip,
+					    unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDIR_REG);
+	if (val & BIT(offset))
+		return 0;
+
+	return 1;
+}
+
+static const struct gpio_chip davinci_mcasp_template_chip = {
+	.owner			= THIS_MODULE,
+	.request		= davinci_mcasp_gpio_request,
+	.free			= davinci_mcasp_gpio_free,
+	.direction_output	= davinci_mcasp_gpio_direction_out,
+	.set			= davinci_mcasp_gpio_set,
+	.direction_input	= davinci_mcasp_gpio_direction_in,
+	.get			= davinci_mcasp_gpio_get,
+	.get_direction		= davinci_mcasp_gpio_get_direction,
+	.base			= -1,
+	.ngpio			= 32,
+};
+
+static int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
+{
+	if (!of_property_read_bool(mcasp->dev->of_node, "gpio-controller"))
+		return 0;
+
+	mcasp->gpio_chip = davinci_mcasp_template_chip;
+	mcasp->gpio_chip.label = dev_name(mcasp->dev);
+	mcasp->gpio_chip.parent = mcasp->dev;
+#ifdef CONFIG_OF_GPIO
+	mcasp->gpio_chip.of_node = mcasp->dev->of_node;
+#endif
+
+	return devm_gpiochip_add_data(mcasp->dev, &mcasp->gpio_chip, mcasp);
+}
+
+#else /* CONFIG_GPIOLIB */
+static inline int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
+{
+	return 0;
+}
+#endif /* CONFIG_GPIOLIB */
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -2069,6 +2213,15 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mcasp_reparent_fck(pdev);
 
+	/* All PINS as McASP */
+	pm_runtime_get_sync(mcasp->dev);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
+	pm_runtime_put(mcasp->dev);
+
+	ret = davinci_mcasp_init_gpiochip(mcasp);
+	if (ret)
+		goto err;
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					&davinci_mcasp_component,
 					&davinci_mcasp_dai[pdata->op_mode], 1);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

