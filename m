Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988B0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5388D2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5388D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeH2SpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:45:06 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:55014 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeH2SpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:45:06 -0400
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="16196385"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Aug 2018 07:47:39 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 29 Aug 2018 07:47:38 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <florian.meier@koalo.de>,
        <cristian.birsan@microchip.com>
Subject: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
Date:   Wed, 29 Aug 2018 17:47:26 +0300
Message-ID: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MikroElektronika PROTO audio codec board.

URL to the audio chip:
http://www.mikroe.com/add-on-boards/audio-voice/audio-codec-proto/

Signed-off-by: Florian Meier <florian.meier@koalo.de>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/Kconfig        |   7 ++
 sound/soc/atmel/Makefile       |   2 +
 sound/soc/atmel/mikroe-proto.c | 189 +++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 sound/soc/atmel/mikroe-proto.c

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 539ef33e670a..fbf4d3e42c18 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -97,4 +97,11 @@ config SND_ATMEL_SOC_I2S
 	help
 	  Say Y or M if you want to add support for Atmel ASoc driver for boards
 	  using I2S.
+
+config SND_SOC_MIKROE_PROTO
+	tristate "Support for Mikroe-PROTO board"
+	depends on OF
+	select SND_SOC_WM8731
+	help
+	  Say Y or M if you want to add support for Audio Codec Board PROTO (WM8731).
 endif
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
index cd87cb4bcff5..9f41bfa0fea3 100644
--- a/sound/soc/atmel/Makefile
+++ b/sound/soc/atmel/Makefile
@@ -17,6 +17,7 @@ snd-soc-sam9x5-wm8731-objs := sam9x5_wm8731.o
 snd-atmel-soc-classd-objs := atmel-classd.o
 snd-atmel-soc-pdmic-objs := atmel-pdmic.o
 snd-atmel-soc-tse850-pcm5142-objs := tse850-pcm5142.o
+snd-soc-mikroe-proto-objs := mikroe-proto.o
 
 obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
 obj-$(CONFIG_SND_ATMEL_SOC_WM8904) += snd-atmel-soc-wm8904.o
@@ -24,3 +25,4 @@ obj-$(CONFIG_SND_AT91_SOC_SAM9X5_WM8731) += snd-soc-sam9x5-wm8731.o
 obj-$(CONFIG_SND_ATMEL_SOC_CLASSD) += snd-atmel-soc-classd.o
 obj-$(CONFIG_SND_ATMEL_SOC_PDMIC) += snd-atmel-soc-pdmic.o
 obj-$(CONFIG_SND_ATMEL_SOC_TSE850_PCM5142) += snd-atmel-soc-tse850-pcm5142.o
+obj-$(CONFIG_SND_SOC_MIKROE_PROTO) += snd-soc-mikroe-proto.o
diff --git a/sound/soc/atmel/mikroe-proto.c b/sound/soc/atmel/mikroe-proto.c
new file mode 100644
index 000000000000..9d9dc1c8ac6b
--- /dev/null
+++ b/sound/soc/atmel/mikroe-proto.c
@@ -0,0 +1,189 @@
+/*
+ * ASoC driver for PROTO AudioCODEC (with a WM8731)
+ *
+ * Author:      Florian Meier, <koalo@koalo.de>
+ *	      Copyright 2013
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+
+#include "../codecs/wm8731.h"
+
+#define XTAL_RATE 12288000	/* This is fixed on this board */
+
+static const unsigned int wm8731_rates_12288000[] = {
+	8000, 32000, 48000, 96000,
+};
+
+static struct snd_pcm_hw_constraint_list wm8731_constraints_12288000 = {
+	.list = wm8731_rates_12288000,
+	.count = ARRAY_SIZE(wm8731_rates_12288000),
+};
+
+static int snd_proto_startup(struct snd_pcm_substream *substream)
+{
+	/* Setup constraints, because there is a 12.288 MHz XTAL on the board */
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   &wm8731_constraints_12288000);
+	return 0;
+}
+
+/* machine stream operations */
+static struct snd_soc_ops snd_proto_ops = {
+	.startup = snd_proto_startup,
+};
+
+static int snd_proto_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	/* Set proto sysclk */
+	int ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
+					 XTAL_RATE, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set WM8731 SYSCLK: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget snd_proto_widget[] = {
+	SND_SOC_DAPM_MIC("Microphone Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route snd_proto_route[] = {
+	/* speaker connected to LHPOUT/RHPOUT */
+	{"Headphone Jack", NULL, "LHPOUT"},
+	{"Headphone Jack", NULL, "RHPOUT"},
+
+	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
+	{"MICIN", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Microphone Jack"},
+};
+
+/* audio machine driver */
+static struct snd_soc_card snd_proto = {
+	.name		= "snd_mikroe_proto",
+	.owner		= THIS_MODULE,
+	.dapm_widgets	= snd_proto_widget,
+	.num_dapm_widgets = ARRAY_SIZE(snd_proto_widget),
+	.dapm_routes	= snd_proto_route,
+	.num_dapm_routes = ARRAY_SIZE(snd_proto_route),
+};
+
+static int snd_proto_probe(struct platform_device *pdev)
+{
+	struct snd_soc_dai_link *dai;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *codec_np, *cpu_np;
+	struct device_node *bitclkmaster = NULL;
+	struct device_node *framemaster = NULL;
+	unsigned int dai_fmt;
+	int ret = 0;
+
+	if (!np) {
+		dev_err(&pdev->dev, "No device node supplied\n");
+		return -EINVAL;
+	}
+
+	snd_proto.dev = &pdev->dev;
+	ret = snd_soc_of_parse_card_name(&snd_proto, "model");
+	if (ret)
+		return ret;
+
+	dai = devm_kzalloc(&pdev->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	snd_proto.dai_link = dai;
+	snd_proto.num_links = 1;
+
+	dai->name = "WM8731";
+	dai->stream_name = "WM8731 HiFi";
+	dai->codec_dai_name = "wm8731-hifi";
+	dai->init = &snd_proto_init;
+	dai->ops = &snd_proto_ops;
+
+	codec_np = of_parse_phandle(np, "audio-codec", 0);
+	if (!codec_np) {
+		dev_err(&pdev->dev, "audio-codec node missing\n");
+		return -EINVAL;
+	}
+	dai->codec_of_node = codec_np;
+
+	cpu_np = of_parse_phandle(np, "i2s-controller", 0);
+	if (!cpu_np) {
+		dev_err(&pdev->dev, "i2s-controller missing\n");
+		return -EINVAL;
+	}
+	dai->cpu_of_node = cpu_np;
+	dai->platform_of_node = cpu_np;
+
+	dai_fmt = snd_soc_of_parse_daifmt(np, NULL,
+					  &bitclkmaster, &framemaster);
+	if (bitclkmaster != framemaster) {
+		dev_err(&pdev->dev, "Must be the same bitclock and frame master\n");
+		return -EINVAL;
+	}
+	if (bitclkmaster) {
+		dai_fmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
+		if (codec_np == bitclkmaster)
+			dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+		else
+			dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+	}
+	of_node_put(bitclkmaster);
+	of_node_put(framemaster);
+	dai->dai_fmt = dai_fmt;
+
+	of_node_put(codec_np);
+	of_node_put(cpu_np);
+
+	ret = snd_soc_register_card(&snd_proto);
+	if (ret && ret != -EPROBE_DEFER)
+		dev_err(&pdev->dev,
+			"snd_soc_register_card() failed: %d\n", ret);
+
+	return ret;
+}
+
+static int snd_proto_remove(struct platform_device *pdev)
+{
+	return snd_soc_unregister_card(&snd_proto);
+}
+
+static const struct of_device_id snd_proto_of_match[] = {
+	{ .compatible = "mikroe,mikroe-proto", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, snd_proto_of_match);
+
+static struct platform_driver snd_proto_driver = {
+	.driver = {
+		.name   = "snd-mikroe-proto",
+		.owner  = THIS_MODULE,
+		.of_match_table = snd_proto_of_match,
+	},
+	.probe	  = snd_proto_probe,
+	.remove	 = snd_proto_remove,
+};
+
+module_platform_driver(snd_proto_driver);
+
+MODULE_AUTHOR("Florian Meier");
+MODULE_DESCRIPTION("ASoC Driver for PROTO board (WM8731)");
+MODULE_LICENSE("GPL");
-- 
2.17.1

