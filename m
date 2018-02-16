Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966327AbeBPMQ2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:16:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59916 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965852AbeBPMQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:16:24 -0500
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Mihai Serban <mihai.serban@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        fabio.estevam@nxp.com, robh@kernel.org, daniel.baluta@gmail.com,
        shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org,
        wakasugi.jb@om.asahi-kasei.co.jp, Mihai Serban <mihai.serban@nxp.com>,
        linux-imx@nxp.com, cosmin.samoila@nxp.com, daniel.baluta@nxp.com,
        mihai.serban@gmail.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: ak5558: Add support for AK5558 ADC driver" to the asoc tree
In-Reply-To: <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
Message-Id: <E1emewA-0006mr-Gs@debutante>
Date: Fri, 16 Feb 2018 12:16:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ak5558: Add support for AK5558 ADC driver

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

>From 920884777480739789bb94ce8aeab1bc1de30dc2 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 13 Feb 2018 16:29:33 +0200
Subject: [PATCH] ASoC: ak5558: Add support for AK5558 ADC driver

AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
for digital audio systems.

Datasheet is available at:

https://www.akm.com/akm/en/file/datasheet/AK5558VN.pdf

Initial patch includes support for normal and TDM modes.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
[initial coding for 3.18 kernel]
Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
[cleanups and porting to 4.9 kernel]
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
[tdm support]
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
[pm support, cleanups and porting to latest kernel]
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |   6 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/ak5558.c | 417 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak5558.h |  52 ++++++
 4 files changed, 477 insertions(+)
 create mode 100644 sound/soc/codecs/ak5558.c
 create mode 100644 sound/soc/codecs/ak5558.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2b331f7266ab..c29728c5f4e0 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -42,6 +42,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4642 if I2C
 	select SND_SOC_AK4671 if I2C
 	select SND_SOC_AK5386
+	select SND_SOC_AK5558 if I2C
 	select SND_SOC_ALC5623 if I2C
 	select SND_SOC_ALC5632 if I2C
 	select SND_SOC_BT_SCO
@@ -398,6 +399,11 @@ config SND_SOC_AK4671
 config SND_SOC_AK5386
 	tristate "AKM AK5638 CODEC"
 
+config SND_SOC_AK5558
+	tristate "AKM AK5558 CODEC"
+	depends on I2C
+	select REGMAP_I2C
+
 config SND_SOC_ALC5623
        tristate "Realtek ALC5623 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index da1571336f1e..3e71d40cca19 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -34,6 +34,7 @@ snd-soc-ak4641-objs := ak4641.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
 snd-soc-ak5386-objs := ak5386.o
+snd-soc-ak5558-objs := ak5558.o
 snd-soc-arizona-objs := arizona.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-cq93vc-objs := cq93vc.o
@@ -277,6 +278,7 @@ obj-$(CONFIG_SND_SOC_AK4641)	+= snd-soc-ak4641.o
 obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
 obj-$(CONFIG_SND_SOC_AK5386)	+= snd-soc-ak5386.o
+obj-$(CONFIG_SND_SOC_AK5558)	+= snd-soc-ak5558.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
new file mode 100644
index 000000000000..225173ff4efa
--- /dev/null
+++ b/sound/soc/codecs/ak5558.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Audio driver for AK5558 ADC
+ *
+ * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#include "ak5558.h"
+
+/* AK5558 Codec Private Data */
+struct ak5558_priv {
+	struct snd_soc_codec codec;
+	struct regmap *regmap;
+	struct i2c_client *i2c;
+	struct gpio_desc *reset_gpiod; /* Reset & Power down GPIO */
+	int slots;
+	int slot_width;
+};
+
+/* ak5558 register cache & default register settings */
+static const struct reg_default ak5558_reg[] = {
+	{ 0x0, 0xFF },	/*	0x00	AK5558_00_POWER_MANAGEMENT1	*/
+	{ 0x1, 0x01 },	/*	0x01	AK5558_01_POWER_MANAGEMENT2	*/
+	{ 0x2, 0x01 },	/*	0x02	AK5558_02_CONTROL1		*/
+	{ 0x3, 0x00 },	/*	0x03	AK5558_03_CONTROL2		*/
+	{ 0x4, 0x00 },	/*	0x04	AK5558_04_CONTROL3		*/
+	{ 0x5, 0x00 }	/*	0x05	AK5558_05_DSD			*/
+};
+
+static const char * const mono_texts[] = {
+	"8 Slot", "2 Slot", "4 Slot", "1 Slot",
+};
+
+static const struct soc_enum ak5558_mono_enum[] = {
+	SOC_ENUM_SINGLE(AK5558_01_POWER_MANAGEMENT2, 1,
+			ARRAY_SIZE(mono_texts), mono_texts),
+};
+
+static const char * const digfil_texts[] = {
+	"Sharp Roll-Off", "Show Roll-Off",
+	"Short Delay Sharp Roll-Off", "Short Delay Show Roll-Off",
+};
+
+static const struct soc_enum ak5558_adcset_enum[] = {
+	SOC_ENUM_SINGLE(AK5558_04_CONTROL3, 0,
+			ARRAY_SIZE(digfil_texts), digfil_texts),
+};
+
+static const struct snd_kcontrol_new ak5558_snd_controls[] = {
+	SOC_ENUM("AK5558 Monaural Mode", ak5558_mono_enum[0]),
+	SOC_ENUM("AK5558 Digital Filter", ak5558_adcset_enum[0]),
+};
+
+static const struct snd_soc_dapm_widget ak5558_dapm_widgets[] = {
+	/* Analog Input */
+	SND_SOC_DAPM_INPUT("AIN1"),
+	SND_SOC_DAPM_INPUT("AIN2"),
+	SND_SOC_DAPM_INPUT("AIN3"),
+	SND_SOC_DAPM_INPUT("AIN4"),
+	SND_SOC_DAPM_INPUT("AIN5"),
+	SND_SOC_DAPM_INPUT("AIN6"),
+	SND_SOC_DAPM_INPUT("AIN7"),
+	SND_SOC_DAPM_INPUT("AIN8"),
+
+	SND_SOC_DAPM_ADC("ADC Ch1", NULL, AK5558_00_POWER_MANAGEMENT1, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Ch2", NULL, AK5558_00_POWER_MANAGEMENT1, 1, 0),
+	SND_SOC_DAPM_ADC("ADC Ch3", NULL, AK5558_00_POWER_MANAGEMENT1, 2, 0),
+	SND_SOC_DAPM_ADC("ADC Ch4", NULL, AK5558_00_POWER_MANAGEMENT1, 3, 0),
+	SND_SOC_DAPM_ADC("ADC Ch5", NULL, AK5558_00_POWER_MANAGEMENT1, 4, 0),
+	SND_SOC_DAPM_ADC("ADC Ch6", NULL, AK5558_00_POWER_MANAGEMENT1, 5, 0),
+	SND_SOC_DAPM_ADC("ADC Ch7", NULL, AK5558_00_POWER_MANAGEMENT1, 6, 0),
+	SND_SOC_DAPM_ADC("ADC Ch8", NULL, AK5558_00_POWER_MANAGEMENT1, 7, 0),
+
+	SND_SOC_DAPM_AIF_OUT("SDTO", "Capture", 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route ak5558_intercon[] = {
+	{"ADC Ch1", NULL, "AIN1"},
+	{"SDTO", NULL, "ADC Ch1"},
+
+	{"ADC Ch2", NULL, "AIN2"},
+	{"SDTO", NULL, "ADC Ch2"},
+
+	{"ADC Ch3", NULL, "AIN3"},
+	{"SDTO", NULL, "ADC Ch3"},
+
+	{"ADC Ch4", NULL, "AIN4"},
+	{"SDTO", NULL, "ADC Ch4"},
+
+	{"ADC Ch5", NULL, "AIN5"},
+	{"SDTO", NULL, "ADC Ch5"},
+
+	{"ADC Ch6", NULL, "AIN6"},
+	{"SDTO", NULL, "ADC Ch6"},
+
+	{"ADC Ch7", NULL, "AIN7"},
+	{"SDTO", NULL, "ADC Ch7"},
+
+	{"ADC Ch8", NULL, "AIN8"},
+	{"SDTO", NULL, "ADC Ch8"},
+};
+
+static int ak5558_set_mcki(struct snd_soc_codec *codec)
+{
+	return snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS,
+				   AK5558_CKS_AUTO);
+}
+
+static int ak5558_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	u8 bits;
+	int pcm_width = max(params_physical_width(params), ak5558->slot_width);
+
+	/* set master/slave audio interface */
+	bits = snd_soc_read(codec, AK5558_02_CONTROL1);
+	bits &= ~AK5558_BITS;
+
+	switch (pcm_width) {
+	case 16:
+		bits |= AK5558_DIF_24BIT_MODE;
+		break;
+	case 32:
+		bits |= AK5558_DIF_32BIT_MODE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_BITS, bits);
+
+	return 0;
+}
+
+static int ak5558_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 format;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	default:
+		dev_err(dai->dev, "Clock mode unsupported");
+		return -EINVAL;
+	}
+
+	/* set master/slave audio interface */
+	format = snd_soc_read(codec, AK5558_02_CONTROL1);
+	format &= ~AK5558_DIF;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		format |= AK5558_DIF_I2S_MODE;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		format |= AK5558_DIF_MSB_MODE;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		format |= AK5558_DIF_MSB_MODE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_DIF, format);
+
+	return 0;
+}
+
+static int ak5558_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			       unsigned int rx_mask, int slots,
+			       int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	int tdm_mode;
+
+	ak5558->slots = slots;
+	ak5558->slot_width = slot_width;
+
+	switch (slots * slot_width) {
+	case 128:
+		tdm_mode = AK5558_MODE_TDM128;
+		break;
+	case 256:
+		tdm_mode = AK5558_MODE_TDM256;
+		break;
+	case 512:
+		tdm_mode = AK5558_MODE_TDM512;
+		break;
+	default:
+		tdm_mode = AK5558_MODE_NORMAL;
+		break;
+	}
+
+	snd_soc_update_bits(codec, AK5558_03_CONTROL2, AK5558_MODE_BITS,
+			    tdm_mode);
+	return 0;
+}
+
+#define AK5558_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static const unsigned int ak5558_rates[] = {
+	8000, 11025,  16000, 22050,
+	32000, 44100, 48000, 88200,
+	96000, 176400, 192000, 352800,
+	384000, 705600, 768000, 1411200,
+	2822400,
+};
+
+static const struct snd_pcm_hw_constraint_list ak5558_rate_constraints = {
+	.count = ARRAY_SIZE(ak5558_rates),
+	.list = ak5558_rates,
+};
+
+static int ak5558_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  &ak5558_rate_constraints);
+}
+
+static struct snd_soc_dai_ops ak5558_dai_ops = {
+	.startup        = ak5558_startup,
+	.hw_params	= ak5558_hw_params,
+
+	.set_fmt	= ak5558_set_dai_fmt,
+	.set_tdm_slot   = ak5558_set_tdm_slot,
+};
+
+static struct snd_soc_dai_driver ak5558_dai = {
+	.name = "ak5558-aif",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = AK5558_FORMATS,
+	},
+	.ops = &ak5558_dai_ops,
+};
+
+static void ak5558_power_off(struct ak5558_priv *ak5558)
+{
+	if (!ak5558->reset_gpiod)
+		return;
+
+	gpiod_set_value_cansleep(ak5558->reset_gpiod, 0);
+	usleep_range(1000, 2000);
+}
+
+static void ak5558_power_on(struct ak5558_priv *ak5558)
+{
+	if (!ak5558->reset_gpiod)
+		return;
+
+	gpiod_set_value_cansleep(ak5558->reset_gpiod, 1);
+	usleep_range(1000, 2000);
+}
+
+static int ak5558_probe(struct snd_soc_codec *codec)
+{
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	ak5558_power_on(ak5558);
+	return ak5558_set_mcki(codec);
+}
+
+static int ak5558_remove(struct snd_soc_codec *codec)
+{
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	ak5558_power_off(ak5558);
+
+	return 0;
+}
+
+static int __maybe_unused ak5558_runtime_suspend(struct device *dev)
+{
+	struct ak5558_priv *ak5558 = dev_get_drvdata(dev);
+
+	regcache_cache_only(ak5558->regmap, true);
+	ak5558_power_off(ak5558);
+
+	return 0;
+}
+
+static int __maybe_unused ak5558_runtime_resume(struct device *dev)
+{
+	struct ak5558_priv *ak5558 = dev_get_drvdata(dev);
+
+	ak5558_power_off(ak5558);
+	ak5558_power_on(ak5558);
+
+	regcache_cache_only(ak5558->regmap, false);
+	regcache_mark_dirty(ak5558->regmap);
+
+	return regcache_sync(ak5558->regmap);
+}
+
+const struct dev_pm_ops ak5558_pm = {
+	SET_RUNTIME_PM_OPS(ak5558_runtime_suspend, ak5558_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+struct snd_soc_codec_driver soc_codec_dev_ak5558 = {
+	.probe = ak5558_probe,
+	.remove = ak5558_remove,
+
+	.component_driver = {
+		.controls = ak5558_snd_controls,
+		.num_controls = ARRAY_SIZE(ak5558_snd_controls),
+		.dapm_widgets = ak5558_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(ak5558_dapm_widgets),
+		.dapm_routes = ak5558_intercon,
+		.num_dapm_routes = ARRAY_SIZE(ak5558_intercon),
+	},
+};
+
+static const struct regmap_config ak5558_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AK5558_05_DSD,
+	.reg_defaults = ak5558_reg,
+	.num_reg_defaults = ARRAY_SIZE(ak5558_reg),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int ak5558_i2c_probe(struct i2c_client *i2c)
+{
+	struct ak5558_priv *ak5558;
+	int ret = 0;
+
+	ak5558 = devm_kzalloc(&i2c->dev, sizeof(*ak5558), GFP_KERNEL);
+	if (!ak5558)
+		return -ENOMEM;
+
+	ak5558->regmap = devm_regmap_init_i2c(i2c, &ak5558_regmap);
+	if (IS_ERR(ak5558->regmap))
+		return PTR_ERR(ak5558->regmap);
+
+	i2c_set_clientdata(i2c, ak5558);
+	ak5558->i2c = i2c;
+
+	ak5558->reset_gpiod = devm_gpiod_get_optional(&i2c->dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(ak5558->reset_gpiod))
+		return PTR_ERR(ak5558->reset_gpiod);
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_ak5558,
+				     &ak5558_dai, 1);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&i2c->dev);
+
+	return 0;
+}
+
+static int ak5558_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+	pm_runtime_disable(&i2c->dev);
+
+	return 0;
+}
+
+static const struct of_device_id ak5558_i2c_dt_ids[] = {
+	{ .compatible = "asahi-kasei,ak5558"},
+	{ }
+};
+
+static struct i2c_driver ak5558_i2c_driver = {
+	.driver = {
+		.name = "ak5558",
+		.of_match_table = of_match_ptr(ak5558_i2c_dt_ids),
+		.pm = &ak5558_pm,
+	},
+	.probe_new = ak5558_i2c_probe,
+	.remove = ak5558_i2c_remove,
+};
+
+module_i2c_driver(ak5558_i2c_driver);
+
+MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>");
+MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");
+MODULE_DESCRIPTION("ASoC AK5558 ADC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/ak5558.h b/sound/soc/codecs/ak5558.h
new file mode 100644
index 000000000000..7c9e37374f39
--- /dev/null
+++ b/sound/soc/codecs/ak5558.h
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Audio driver header for AK5558
+ *
+ * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ */
+
+#ifndef _AK5558_H
+#define _AK5558_H
+
+#define AK5558_00_POWER_MANAGEMENT1    0x00
+#define AK5558_01_POWER_MANAGEMENT2    0x01
+#define AK5558_02_CONTROL1             0x02
+#define AK5558_03_CONTROL2             0x03
+#define AK5558_04_CONTROL3             0x04
+#define AK5558_05_DSD                  0x05
+
+/* AK5558_02_CONTROL1 fields */
+#define AK5558_DIF			GENMASK(1, 1)
+#define AK5558_DIF_MSB_MODE		(0 << 1)
+#define AK5558_DIF_I2S_MODE		(1 << 1)
+
+#define AK5558_BITS			GENMASK(2, 2)
+#define AK5558_DIF_24BIT_MODE		(0 << 2)
+#define AK5558_DIF_32BIT_MODE		(1 << 2)
+
+#define AK5558_CKS			GENMASK(6, 3)
+#define AK5558_CKS_128FS_192KHZ		(0 << 3)
+#define AK5558_CKS_192FS_192KHZ		(1 << 3)
+#define AK5558_CKS_256FS_48KHZ		(2 << 3)
+#define AK5558_CKS_256FS_96KHZ		(3 << 3)
+#define AK5558_CKS_384FS_96KHZ		(4 << 3)
+#define AK5558_CKS_384FS_48KHZ		(5 << 3)
+#define AK5558_CKS_512FS_48KHZ		(6 << 3)
+#define AK5558_CKS_768FS_48KHZ		(7 << 3)
+#define AK5558_CKS_64FS_384KHZ		(8 << 3)
+#define AK5558_CKS_32FS_768KHZ		(9 << 3)
+#define AK5558_CKS_96FS_384KHZ		(10 << 3)
+#define AK5558_CKS_48FS_768KHZ		(11 << 3)
+#define AK5558_CKS_64FS_768KHZ		(12 << 3)
+#define AK5558_CKS_1024FS_16KHZ		(13 << 3)
+#define AK5558_CKS_AUTO			(15 << 3)
+
+/* AK5558_03_CONTROL2 fields */
+#define AK5558_MODE_BITS	GENMASK(6, 5)
+#define AK5558_MODE_NORMAL	(0 << 5)
+#define AK5558_MODE_TDM128	(1 << 5)
+#define AK5558_MODE_TDM256	(2 << 5)
+#define AK5558_MODE_TDM512	(3 << 5)
+
+#endif
-- 
2.16.1
