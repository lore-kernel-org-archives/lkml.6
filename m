Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934899AbeBLMyY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:54:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55000 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934856AbeBLMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:54:21 -0500
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: add support for UniPhier LD11/LD20 AIO driver" to the asoc tree
In-Reply-To: <20180119092536.22501-7-suzuki.katsuhiro@socionext.com>
Message-Id: <E1elDce-00078L-I2@debutante>
Date: Mon, 12 Feb 2018 12:54:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: add support for UniPhier LD11/LD20 AIO driver

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

>From db4cb3d04eba91db48da0032c44b83ed7185973c Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 19 Jan 2018 18:25:33 +0900
Subject: [PATCH] ASoC: uniphier: add support for UniPhier LD11/LD20 AIO driver

This patch adds support for UniPhier AIO sound driver
which is included in UniPhier LD11/LD20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/Kconfig    |  11 ++
 sound/soc/uniphier/Makefile   |   2 +
 sound/soc/uniphier/aio-ld11.c | 431 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 444 insertions(+)
 create mode 100644 sound/soc/uniphier/aio-ld11.c

diff --git a/sound/soc/uniphier/Kconfig b/sound/soc/uniphier/Kconfig
index 1a55ccebd8f5..5da545b9bf2a 100644
--- a/sound/soc/uniphier/Kconfig
+++ b/sound/soc/uniphier/Kconfig
@@ -19,6 +19,17 @@ config SND_SOC_UNIPHIER_AIO
 	  Select Y if you use such device.
 	  If unsure select "N".
 
+config SND_SOC_UNIPHIER_LD11
+	tristate "UniPhier LD11/LD20 Device Driver"
+	depends on SND_SOC_UNIPHIER
+	select SND_SOC_UNIPHIER_AIO
+	select SND_SOC_UNIPHIER_AIO_DMA
+	help
+	  This adds ASoC driver for Socionext UniPhier LD11/LD20
+	  input and output that can be used with other codecs.
+	  Select Y if you use such device.
+	  If unsure select "N".
+
 config SND_SOC_UNIPHIER_EVEA_CODEC
 	tristate "UniPhier SoC internal audio codec"
 	depends on SND_SOC_UNIPHIER
diff --git a/sound/soc/uniphier/Makefile b/sound/soc/uniphier/Makefile
index 4448175c70ab..587a89700950 100644
--- a/sound/soc/uniphier/Makefile
+++ b/sound/soc/uniphier/Makefile
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-soc-uniphier-aio-cpu-objs := aio-core.o aio-dma.o aio-cpu.o aio-compress.o
+snd-soc-uniphier-aio-ld11-objs := aio-ld11.o
 
 obj-$(CONFIG_SND_SOC_UNIPHIER_AIO) += snd-soc-uniphier-aio-cpu.o
+obj-$(CONFIG_SND_SOC_UNIPHIER_LD11) += snd-soc-uniphier-aio-ld11.o
 
 snd-soc-uniphier-evea-objs := evea.o
 obj-$(CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC) += snd-soc-uniphier-evea.o
diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
new file mode 100644
index 000000000000..8e40e6c2e42f
--- /dev/null
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -0,0 +1,431 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Socionext UniPhier AIO ALSA driver for LD11/LD20.
+//
+// Copyright (c) 2016-2018 Socionext Inc.
+//
+// This program is free software; you can redistribute it and/or
+// modify it under the terms of the GNU General Public License
+// as published by the Free Software Foundation; version 2
+// of the License.
+//
+// This program is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+//
+// You should have received a copy of the GNU General Public License
+// along with this program; if not, see <http://www.gnu.org/licenses/>.
+
+#include <linux/module.h>
+
+#include "aio.h"
+
+static const struct uniphier_aio_spec uniphier_aio_ld11[] = {
+	/* for HDMI PCM In, Pin:AI1Dx */
+	{
+		.name = AUD_NAME_PCMIN1,
+		.gname = AUD_GNAME_HDMI,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 21, 14, },
+			.ch    = { 21, 14, },
+			.iif   = { 5, 3, },
+			.iport = { 0, AUD_HW_PCMIN1, },
+		},
+	},
+
+	/* for SIF In, Pin:AI2Dx */
+	{
+		.name = AUD_NAME_PCMIN2,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 22, 15, },
+			.ch    = { 22, 15, },
+			.iif   = { 6, 4, },
+			.iport = { 1, AUD_HW_PCMIN2, },
+		},
+	},
+
+	/* for Line In, Pin:AI3Dx */
+	{
+		.name = AUD_NAME_PCMIN3,
+		.gname = AUD_GNAME_LINE,
+		.swm = {
+			.type  = PORT_TYPE_EVE,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 23, 16, },
+			.ch    = { 23, 16, },
+			.iif   = { 7, 5, },
+			.iport = { 2, AUD_HW_PCMIN3, },
+		},
+	},
+
+	/* for S/PDIF In, Pin:AI1IEC */
+	{
+		.name = AUD_NAME_IECIN1,
+		.gname = AUD_GNAME_IEC,
+		.swm = {
+			.type  = PORT_TYPE_SPDIF,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 26, 17, },
+			.ch    = { 26, 17, },
+			.iif   = { 10, 6, },
+			.iport = { 3, AUD_HW_IECIN1, },
+		},
+	},
+
+	/* for Speaker, Pin:AO1Dx */
+	{
+		.name = AUD_NAME_HPCMOUT1,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 0, 0, },
+			.ch    = { 0, 0, },
+			.oif   = { 0, 0, },
+			.oport = { 0, AUD_HW_HPCMOUT1, },
+		},
+	},
+
+	/* for HDMI PCM, Pin:AO2Dx */
+	{
+		.name = AUD_NAME_PCMOUT1,
+		.gname = AUD_GNAME_HDMI,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 0, 0, },
+			.ch    = { 0, 0, },
+			.oif   = { 0, 0, },
+			.oport = { 3, AUD_HW_PCMOUT1, },
+		},
+	},
+
+	/* for Line Out, Pin:LO2_x */
+	{
+		.name = AUD_NAME_PCMOUT2,
+		.gname = AUD_GNAME_LINE,
+		.swm = {
+			.type  = PORT_TYPE_EVE,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 2, 2, },
+			.ch    = { 2, 2, },
+			.oif   = { 2, 2, },
+			.oport = { 1, AUD_HW_PCMOUT2, },
+		},
+	},
+
+	/* for Headphone, Pin:HP1_x */
+	{
+		.name = AUD_NAME_PCMOUT3,
+		.swm = {
+			.type  = PORT_TYPE_EVE,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 3, 3, },
+			.ch    = { 3, 3, },
+			.oif   = { 3, 3, },
+			.oport = { 2, AUD_HW_PCMOUT3, },
+		},
+	},
+
+	/* for HW Sampling Rate Converter */
+	{
+		.name = AUD_NAME_EPCMOUT2,
+		.swm = {
+			.type  = PORT_TYPE_CONV,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 7, 5, },
+			.ch    = { 7, 5, },
+			.oif   = { 7, 5, },
+			.oport = { 6, AUD_HW_EPCMOUT2, },
+			.och   = { 17, 12, },
+			.iif   = { 1, 1, },
+		},
+	},
+
+	/* for HW Sampling Rate Converter 2 */
+	{
+		.name = AUD_NAME_EPCMOUT3,
+		.swm = {
+			.type  = PORT_TYPE_CONV,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 8, 6, },
+			.ch    = { 8, 6, },
+			.oif   = { 8, 6, },
+			.oport = { 7, AUD_HW_EPCMOUT3, },
+			.och   = { 18, 13, },
+			.iif   = { 2, 2, },
+		},
+	},
+
+	/* for S/PDIF Out, Pin:AO1IEC */
+	{
+		.name = AUD_NAME_HIECOUT1,
+		.gname = AUD_GNAME_IEC,
+		.swm = {
+			.type  = PORT_TYPE_SPDIF,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 1, 1, },
+			.ch    = { 1, 1, },
+			.oif   = { 1, 1, },
+			.oport = { 12, AUD_HW_HIECOUT1, },
+		},
+	},
+
+	/* for S/PDIF Out, Pin:AO1IEC, Compress */
+	{
+		.name = AUD_NAME_HIECCOMPOUT1,
+		.gname = AUD_GNAME_IEC,
+		.swm = {
+			.type  = PORT_TYPE_SPDIF,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 1, 1, },
+			.ch    = { 1, 1, },
+			.oif   = { 1, 1, },
+			.oport = { 12, AUD_HW_HIECOUT1, },
+		},
+	},
+};
+
+static const struct uniphier_aio_pll uniphier_aio_pll_ld11[] = {
+	[AUD_PLL_A1]   = { .enable = true, },
+	[AUD_PLL_F1]   = { .enable = true, },
+	[AUD_PLL_A2]   = { .enable = true, },
+	[AUD_PLL_F2]   = { .enable = true, },
+	[AUD_PLL_APLL] = { .enable = true, },
+	[AUD_PLL_RX0]  = { .enable = true, },
+	[AUD_PLL_USB0] = { .enable = true, },
+	[AUD_PLL_HSC0] = { .enable = true, },
+};
+
+static int uniphier_aio_ld11_probe(struct snd_soc_dai *dai)
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
+static struct snd_soc_dai_driver uniphier_aio_dai_ld11[] = {
+	{
+		.name    = AUD_GNAME_HDMI,
+		.probe   = uniphier_aio_ld11_probe,
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
+			.rates       = SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_44100 |
+				SNDRV_PCM_RATE_32000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_i2s_ops,
+	},
+	{
+		.name    = AUD_NAME_PCMIN2,
+		.probe   = uniphier_aio_ld11_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
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
+		.name    = AUD_GNAME_LINE,
+		.probe   = uniphier_aio_ld11_probe,
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
+			.stream_name = AUD_NAME_PCMIN3,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_i2s_ops,
+	},
+	{
+		.name    = AUD_NAME_HPCMOUT1,
+		.probe   = uniphier_aio_ld11_probe,
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
+		.name    = AUD_NAME_PCMOUT3,
+		.probe   = uniphier_aio_ld11_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_PCMOUT3,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_i2s_ops,
+	},
+	{
+		.name    = AUD_NAME_HIECOUT1,
+		.probe   = uniphier_aio_ld11_probe,
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
+		.name    = AUD_NAME_EPCMOUT2,
+		.probe   = uniphier_aio_ld11_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_EPCMOUT2,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_44100 |
+				SNDRV_PCM_RATE_32000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_i2s_ops,
+	},
+	{
+		.name    = AUD_NAME_EPCMOUT3,
+		.probe   = uniphier_aio_ld11_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_EPCMOUT3,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_44100 |
+				SNDRV_PCM_RATE_32000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_i2s_ops,
+	},
+	{
+		.name    = AUD_NAME_HIECCOMPOUT1,
+		.probe   = uniphier_aio_ld11_probe,
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
+};
+
+static const struct uniphier_aio_chip_spec uniphier_aio_ld11_spec = {
+	.specs     = uniphier_aio_ld11,
+	.num_specs = ARRAY_SIZE(uniphier_aio_ld11),
+	.dais      = uniphier_aio_dai_ld11,
+	.num_dais  = ARRAY_SIZE(uniphier_aio_dai_ld11),
+	.plls      = uniphier_aio_pll_ld11,
+	.num_plls  = ARRAY_SIZE(uniphier_aio_pll_ld11),
+	.addr_ext  = 0,
+};
+
+static const struct uniphier_aio_chip_spec uniphier_aio_ld20_spec = {
+	.specs     = uniphier_aio_ld11,
+	.num_specs = ARRAY_SIZE(uniphier_aio_ld11),
+	.dais      = uniphier_aio_dai_ld11,
+	.num_dais  = ARRAY_SIZE(uniphier_aio_dai_ld11),
+	.plls      = uniphier_aio_pll_ld11,
+	.num_plls  = ARRAY_SIZE(uniphier_aio_pll_ld11),
+	.addr_ext  = 1,
+};
+
+static const struct of_device_id uniphier_aio_of_match[] = {
+	{
+		.compatible = "socionext,uniphier-ld11-aio",
+		.data = &uniphier_aio_ld11_spec,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-aio",
+		.data = &uniphier_aio_ld20_spec,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, uniphier_aio_of_match);
+
+static struct platform_driver uniphier_aio_driver = {
+	.driver = {
+		.name = "snd-uniphier-aio",
+		.of_match_table = of_match_ptr(uniphier_aio_of_match),
+	},
+	.probe    = uniphier_aio_probe,
+	.remove   = uniphier_aio_remove,
+};
+module_platform_driver(uniphier_aio_driver);
+
+MODULE_AUTHOR("Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier LD11/LD20 AIO driver.");
+MODULE_LICENSE("GPL v2");
-- 
2.16.1
