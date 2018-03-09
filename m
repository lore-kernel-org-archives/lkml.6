Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeCISDp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:03:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38898 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbeCISDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:03:43 -0500
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: add support for UniPhier PXs2 AIO" to the asoc tree
In-Reply-To: <20180309132116.4307-1-suzuki.katsuhiro@socionext.com>
Message-Id: <E1euMMh-0001zb-6a@debutante>
Date: Fri, 09 Mar 2018 18:03:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: add support for UniPhier PXs2 AIO

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8413b9e00aa33604aa661d7271c3c02c86beb994 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 9 Mar 2018 22:21:16 +0900
Subject: [PATCH] ASoC: uniphier: add support for UniPhier PXs2 AIO

This patch adds support for UniPhier AIO sound driver
which is included in UniPhier PXs2 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/uniphier,aio.txt     |   1 +
 sound/soc/uniphier/Kconfig                         |  11 +
 sound/soc/uniphier/Makefile                        |   2 +
 sound/soc/uniphier/aio-ld11.c                      |   2 +-
 sound/soc/uniphier/aio-pxs2.c                      | 320 +++++++++++++++++++++
 sound/soc/uniphier/aio.h                           |   2 +
 6 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/uniphier/aio-pxs2.c

diff --git a/Documentation/devicetree/bindings/sound/uniphier,aio.txt b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
index 73f6c27ae4f7..65d71cf6ef0f 100644
--- a/Documentation/devicetree/bindings/sound/uniphier,aio.txt
+++ b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible      : should be one of the following:
 		    "socionext,uniphier-ld11-aio"
 		    "socionext,uniphier-ld20-aio"
+		    "socionext,uniphier-pxs2-aio"
 - reg             : offset and length of the register set for the device.
 - interrupts      : should contain I2S or S/PDIF interrupt.
 - pinctrl-names   : should be "default".
diff --git a/sound/soc/uniphier/Kconfig b/sound/soc/uniphier/Kconfig
index 5da545b9bf2a..aa3592ee1358 100644
--- a/sound/soc/uniphier/Kconfig
+++ b/sound/soc/uniphier/Kconfig
@@ -30,6 +30,17 @@ config SND_SOC_UNIPHIER_LD11
 	  Select Y if you use such device.
 	  If unsure select "N".
 
+config SND_SOC_UNIPHIER_PXS2
+	tristate "UniPhier PXs2 Device Driver"
+	depends on SND_SOC_UNIPHIER
+	select SND_SOC_UNIPHIER_AIO
+	select SND_SOC_UNIPHIER_AIO_DMA
+	help
+	  This adds ASoC driver for Socionext UniPhier PXs2
+	  input and output that can be used with other codecs.
+	  Select Y if you use such device.
+	  If unsure select "N".
+
 config SND_SOC_UNIPHIER_EVEA_CODEC
 	tristate "UniPhier SoC internal audio codec"
 	depends on SND_SOC_UNIPHIER
diff --git a/sound/soc/uniphier/Makefile b/sound/soc/uniphier/Makefile
index 587a89700950..88169395f68a 100644
--- a/sound/soc/uniphier/Makefile
+++ b/sound/soc/uniphier/Makefile
@@ -1,9 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-soc-uniphier-aio-cpu-objs := aio-core.o aio-dma.o aio-cpu.o aio-compress.o
 snd-soc-uniphier-aio-ld11-objs := aio-ld11.o
+snd-soc-uniphier-aio-pxs2-objs := aio-pxs2.o
 
 obj-$(CONFIG_SND_SOC_UNIPHIER_AIO) += snd-soc-uniphier-aio-cpu.o
 obj-$(CONFIG_SND_SOC_UNIPHIER_LD11) += snd-soc-uniphier-aio-ld11.o
+obj-$(CONFIG_SND_SOC_UNIPHIER_PXS2) += snd-soc-uniphier-aio-pxs2.o
 
 snd-soc-uniphier-evea-objs := evea.o
 obj-$(CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC) += snd-soc-uniphier-evea.o
diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
index 8e40e6c2e42f..4c4dd3dd4dee 100644
--- a/sound/soc/uniphier/aio-ld11.c
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -418,7 +418,7 @@ MODULE_DEVICE_TABLE(of, uniphier_aio_of_match);
 
 static struct platform_driver uniphier_aio_driver = {
 	.driver = {
-		.name = "snd-uniphier-aio",
+		.name = "snd-uniphier-aio-ld11",
 		.of_match_table = of_match_ptr(uniphier_aio_of_match),
 	},
 	.probe    = uniphier_aio_probe,
diff --git a/sound/soc/uniphier/aio-pxs2.c b/sound/soc/uniphier/aio-pxs2.c
new file mode 100644
index 000000000000..69cd5b0af948
--- /dev/null
+++ b/sound/soc/uniphier/aio-pxs2.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Socionext UniPhier AIO ALSA driver for PXs2.
+//
+// Copyright (c) 2018 Socionext Inc.
+
+#include <linux/module.h>
+
+#include "aio.h"
+
+static const struct uniphier_aio_spec uniphier_aio_pxs2[] = {
+	/* for Line PCM In, Pin:AI1Dx */
+	{
+		.name = AUD_NAME_PCMIN1,
+		.gname = AUD_GNAME_LINE,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 16, 11, },
+			.ch    = { 16, 11, },
+			.iif   = { 0, 0, },
+			.iport = { 0, AUD_HW_PCMIN1, },
+		},
+	},
+
+	/* for Speaker/Headphone/Mic PCM In, Pin:AI2Dx */
+	{
+		.name = AUD_NAME_PCMIN2,
+		.gname = AUD_GNAME_AUX,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 17, 12, },
+			.ch    = { 17, 12, },
+			.iif   = { 1, 1, },
+			.iport = { 1, AUD_HW_PCMIN2, },
+		},
+	},
+
+	/* for HDMI PCM Out, Pin:AO1Dx (inner) */
+	{
+		.name = AUD_NAME_HPCMOUT1,
+		.gname = AUD_GNAME_HDMI,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 0, 0, },
+			.ch    = { 0, 0, },
+			.oif   = { 0, 0, },
+			.oport = { 3, AUD_HW_HPCMOUT1, },
+		},
+	},
+
+	/* for Line PCM Out, Pin:AO2Dx */
+	{
+		.name = AUD_NAME_PCMOUT1,
+		.gname = AUD_GNAME_LINE,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 1, 1, },
+			.ch    = { 1, 1, },
+			.oif   = { 1, 1, },
+			.oport = { 0, AUD_HW_PCMOUT1, },
+		},
+	},
+
+	/* for Speaker/Headphone/Mic PCM Out, Pin:AO3Dx */
+	{
+		.name = AUD_NAME_PCMOUT2,
+		.gname = AUD_GNAME_AUX,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 2, 2, },
+			.ch    = { 2, 2, },
+			.oif   = { 2, 2, },
+			.oport = { 1, AUD_HW_PCMOUT2, },
+		},
+	},
+
+	/* for HDMI Out, Pin:AO1IEC */
+	{
+		.name = AUD_NAME_HIECOUT1,
+		.swm = {
+			.type  = PORT_TYPE_SPDIF,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 6, 4, },
+			.ch    = { 6, 4, },
+			.oif   = { 6, 4, },
+			.oport = { 12, AUD_HW_HIECOUT1, },
+		},
+	},
+
+	/* for HDMI Out, Pin:AO1IEC, Compress */
+	{
+		.name = AUD_NAME_HIECCOMPOUT1,
+		.swm = {
+			.type  = PORT_TYPE_SPDIF,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 6, 4, },
+			.ch    = { 6, 4, },
+			.oif   = { 6, 4, },
+			.oport = { 12, AUD_HW_HIECOUT1, },
+		},
+	},
+
+	/* for S/PDIF Out, Pin:AO2IEC */
+	{
+		.name = AUD_NAME_IECOUT1,
+		.swm = {
+			.type  = PORT_TYPE_SPDIF,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 7, 5, },
+			.ch    = { 7, 5, },
+			.oif   = { 7, 5, },
+			.oport = { 13, AUD_HW_IECOUT1, },
+		},
+	},
+
+	/* for S/PDIF Out, Pin:AO2IEC */
+	{
+		.name = AUD_NAME_IECCOMPOUT1,
+		.swm = {
+			.type  = PORT_TYPE_SPDIF,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 7, 5, },
+			.ch    = { 7, 5, },
+			.oif   = { 7, 5, },
+			.oport = { 13, AUD_HW_IECOUT1, },
+		},
+	},
+};
+
+static const struct uniphier_aio_pll uniphier_aio_pll_pxs2[] = {
+	[AUD_PLL_A1]   = { .enable = true, },
+	[AUD_PLL_F1]   = { .enable = true, },
+	[AUD_PLL_A2]   = { .enable = true, },
+	[AUD_PLL_F2]   = { .enable = true, },
+	[AUD_PLL_APLL] = { .enable = true, },
+	[AUD_PLL_HSC0] = { .enable = true, },
+};
+
+static int uniphier_aio_pxs2_probe(struct snd_soc_dai *dai)
+{
+	int ret;
+
+	ret = uniphier_aio_dai_probe(dai);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_pll(dai, AUD_PLL_A1, 0, 0, 36864000);
+	if (ret < 0)
+		return ret;
+	ret = snd_soc_dai_set_pll(dai, AUD_PLL_F1, 0, 0, 36864000);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_pll(dai, AUD_PLL_A2, 0, 0, 33868800);
+	if (ret < 0)
+		return ret;
+	ret = snd_soc_dai_set_pll(dai, AUD_PLL_F2, 0, 0, 33868800);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver uniphier_aio_dai_pxs2[] = {
+	{
+		.name    = AUD_GNAME_HDMI,
+		.probe   = uniphier_aio_pxs2_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_HPCMOUT1,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_i2s_ops,
+	},
+	{
+		.name    = AUD_GNAME_LINE,
+		.probe   = uniphier_aio_pxs2_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_PCMOUT1,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.capture = {
+			.stream_name = AUD_NAME_PCMIN1,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_i2s_ops,
+	},
+	{
+		.name    = AUD_GNAME_AUX,
+		.probe   = uniphier_aio_pxs2_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_PCMOUT2,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.capture = {
+			.stream_name = AUD_NAME_PCMIN2,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_i2s_ops,
+	},
+	{
+		.name    = AUD_NAME_HIECOUT1,
+		.probe   = uniphier_aio_pxs2_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_HIECOUT1,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_spdif_ops,
+	},
+	{
+		.name    = AUD_NAME_IECOUT1,
+		.probe   = uniphier_aio_pxs2_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_IECOUT1,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_spdif_ops,
+	},
+	{
+		.name    = AUD_NAME_HIECCOMPOUT1,
+		.probe   = uniphier_aio_pxs2_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.compress_new = snd_soc_new_compress,
+		.playback = {
+			.stream_name = AUD_NAME_HIECCOMPOUT1,
+			.channels_min = 1,
+			.channels_max = 1,
+		},
+		.ops = &uniphier_aio_spdif_ops,
+	},
+	{
+		.name    = AUD_NAME_IECCOMPOUT1,
+		.probe   = uniphier_aio_pxs2_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.compress_new = snd_soc_new_compress,
+		.playback = {
+			.stream_name = AUD_NAME_IECCOMPOUT1,
+			.channels_min = 1,
+			.channels_max = 1,
+		},
+		.ops = &uniphier_aio_spdif_ops,
+	},
+};
+
+static const struct uniphier_aio_chip_spec uniphier_aio_pxs2_spec = {
+	.specs     = uniphier_aio_pxs2,
+	.num_specs = ARRAY_SIZE(uniphier_aio_pxs2),
+	.dais      = uniphier_aio_dai_pxs2,
+	.num_dais  = ARRAY_SIZE(uniphier_aio_dai_pxs2),
+	.plls      = uniphier_aio_pll_pxs2,
+	.num_plls  = ARRAY_SIZE(uniphier_aio_pll_pxs2),
+	.addr_ext  = 0,
+};
+
+static const struct of_device_id uniphier_aio_of_match[] = {
+	{
+		.compatible = "socionext,uniphier-pxs2-aio",
+		.data = &uniphier_aio_pxs2_spec,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, uniphier_aio_of_match);
+
+static struct platform_driver uniphier_aio_driver = {
+	.driver = {
+		.name = "snd-uniphier-aio-pxs2",
+		.of_match_table = of_match_ptr(uniphier_aio_of_match),
+	},
+	.probe    = uniphier_aio_probe,
+	.remove   = uniphier_aio_remove,
+};
+module_platform_driver(uniphier_aio_driver);
+
+MODULE_AUTHOR("Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier PXs2 AIO driver.");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index 2cd64273fb5b..793334675cb3 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -110,9 +110,11 @@ enum IEC61937_PC {
 #define AUD_NAME_IECOUT1         "aio-iecout1"
 #define AUD_NAME_CMASTER         "aio-cmaster"
 #define AUD_NAME_HIECCOMPOUT1    "aio-hieccompout1"
+#define AUD_NAME_IECCOMPOUT1     "aio-ieccompout1"
 
 #define AUD_GNAME_HDMI    "aio-hdmi"
 #define AUD_GNAME_LINE    "aio-line"
+#define AUD_GNAME_AUX     "aio-aux"
 #define AUD_GNAME_IEC     "aio-iec"
 
 #define AUD_CLK_IO        0
-- 
2.16.2
