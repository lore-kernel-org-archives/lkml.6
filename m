Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934935AbeCEMsv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:48:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56171 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934149AbeCEMsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:48:47 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        michael@amarulasolutions.com
Subject: [PATCH v2 1/2] ASoC: codecs: Add support for PCM1789
Date: Mon,  5 Mar 2018 13:48:16 +0100
Message-Id: <20180305124817.7421-2-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180305124817.7421-1-mylene.josserand@bootlin.com>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Texas Instruments's PCM1789 DAC support.
It is a simple DAC and does not have many registers.

One particularity about this DAC is that the clocks must be
always enabled. Also, an entire software reset is necessary
while starting to play a sound otherwise, the clocks are not
synchronized (so the DAC is not able to send data).

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 sound/soc/codecs/Kconfig       |  12 ++
 sound/soc/codecs/Makefile      |   4 +
 sound/soc/codecs/pcm1789-i2c.c |  76 +++++++++++
 sound/soc/codecs/pcm1789.c     | 288 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/pcm1789.h     |  28 ++++
 5 files changed, 408 insertions(+)
 create mode 100644 sound/soc/codecs/pcm1789-i2c.c
 create mode 100644 sound/soc/codecs/pcm1789.c
 create mode 100644 sound/soc/codecs/pcm1789.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 822df8d3d4f9..0314a9faae36 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -112,6 +112,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_NAU8825 if I2C
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_PCM1681 if I2C
+	select SND_SOC_PCM1789_I2C if I2C
 	select SND_SOC_PCM179X_I2C if I2C
 	select SND_SOC_PCM179X_SPI if SPI_MASTER
 	select SND_SOC_PCM186X_I2C if I2C
@@ -676,6 +677,17 @@ config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
 	depends on I2C
 
+config SND_SOC_PCM1789
+	tristate
+
+config SND_SOC_PCM1789_I2C
+	tristate "Texas Instruments PCM1789 CODEC (I2C)"
+	depends on I2C
+	select SND_SOC_PCM1789
+	help
+	  Enable support for Texas Instruments PCM1789 CODEC.
+	  Select this if your PCM1789 is connected via an I2C bus.
+
 config SND_SOC_PCM179X
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bc9425b4ba0c..b1654909582f 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -108,6 +108,8 @@ snd-soc-nau8824-objs := nau8824.o
 snd-soc-nau8825-objs := nau8825.o
 snd-soc-hdmi-codec-objs := hdmi-codec.o
 snd-soc-pcm1681-objs := pcm1681.o
+snd-soc-pcm1789-codec-objs := pcm1789.o
+snd-soc-pcm1789-i2c-objs := pcm1789-i2c.o
 snd-soc-pcm179x-codec-objs := pcm179x.o
 snd-soc-pcm179x-i2c-objs := pcm179x-i2c.o
 snd-soc-pcm179x-spi-objs := pcm179x-spi.o
@@ -359,6 +361,8 @@ obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM179X)	+= snd-soc-pcm179x-codec.o
+obj-$(CONFIG_SND_SOC_PCM1789_I2C)	+= snd-soc-pcm1789-i2c.o
+obj-$(CONFIG_SND_SOC_PCM1789)	+= snd-soc-pcm1789-codec.o
 obj-$(CONFIG_SND_SOC_PCM179X_I2C)	+= snd-soc-pcm179x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM179X_SPI)	+= snd-soc-pcm179x-spi.o
 obj-$(CONFIG_SND_SOC_PCM186X)	+= snd-soc-pcm186x.o
diff --git a/sound/soc/codecs/pcm1789-i2c.c b/sound/soc/codecs/pcm1789-i2c.c
new file mode 100644
index 000000000000..9a34790cd0de
--- /dev/null
+++ b/sound/soc/codecs/pcm1789-i2c.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCM1789 ASoC I2C driver
+ *
+ * Copyright (c) Bootlin 2018
+ *
+ * Mylène Josserand <mylene.josserand@bootlin.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#include "pcm1789.h"
+
+static int pcm1789_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(client, &pcm1789_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
+	return pcm1789_common_init(&client->dev, regmap);
+}
+
+static int pcm1789_i2c_remove(struct i2c_client *client)
+{
+	return pcm1789_common_exit(&client->dev);
+}
+
+static const struct of_device_id pcm1789_of_match[] = {
+	{ .compatible = "ti,pcm1789", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm1789_of_match);
+
+static const struct i2c_device_id pcm1789_i2c_ids[] = {
+	{ "pcm1789", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcm1789_i2c_ids);
+
+static struct i2c_driver pcm1789_i2c_driver = {
+	.driver = {
+		.name	= "pcm1789",
+		.of_match_table = of_match_ptr(pcm1789_of_match),
+	},
+	.id_table	= pcm1789_i2c_ids,
+	.probe		= pcm1789_i2c_probe,
+	.remove	= pcm1789_i2c_remove,
+};
+
+module_i2c_driver(pcm1789_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC PCM1789 I2C driver");
+MODULE_AUTHOR("Mylène Josserand <mylene.josserand@bootlin.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm1789.c b/sound/soc/codecs/pcm1789.c
new file mode 100644
index 000000000000..93fad175c4ef
--- /dev/null
+++ b/sound/soc/codecs/pcm1789.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCM1789 ASoC codec driver
+ *
+ * Copyright (c) Bootlin 2018
+ *
+ * Mylène Josserand <mylene.josserand@bootlin.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/workqueue.h>
+
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "pcm1789.h"
+
+#define PCM1789_MUTE_CONTROL	0x10
+#define PCM1789_FMT_CONTROL	0x11
+#define PCM1789_SOFT_MUTE	0x14
+#define PCM1789_DAC_VOL_LEFT	0x18
+#define PCM1789_DAC_VOL_RIGHT	0x19
+
+#define PCM1789_FMT_MASK	0x07
+#define PCM1789_MUTE_MASK	0x03
+#define PCM1789_MUTE_SRET	0x06
+
+struct pcm1789_private {
+	struct regmap *regmap;
+	unsigned int format;
+	unsigned int rate;
+	struct gpio_desc *reset;
+	struct work_struct work;
+	struct device *dev;
+};
+
+static const struct reg_default pcm1789_reg_defaults[] = {
+	{ PCM1789_FMT_CONTROL, 0x00 },
+	{ PCM1789_SOFT_MUTE, 0x00 },
+	{ PCM1789_DAC_VOL_LEFT, 0xff },
+	{ PCM1789_DAC_VOL_RIGHT, 0xff },
+};
+
+static bool pcm1789_accessible_reg(struct device *dev, unsigned int reg)
+{
+	return reg >= PCM1789_MUTE_CONTROL && reg <= PCM1789_DAC_VOL_RIGHT;
+}
+
+static bool pcm1789_writeable_reg(struct device *dev, unsigned int reg)
+{
+	return pcm1789_accessible_reg(dev, reg);
+}
+
+static int pcm1789_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			       unsigned int format)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct pcm1789_private *priv = snd_soc_component_get_drvdata(component);
+
+	priv->format = format;
+
+	return 0;
+}
+
+static int pcm1789_digital_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct pcm1789_private *priv = snd_soc_component_get_drvdata(component);
+
+	return regmap_update_bits(priv->regmap, PCM1789_SOFT_MUTE,
+				  PCM1789_MUTE_MASK,
+				  mute ? 0 : PCM1789_MUTE_MASK);
+}
+
+static int pcm1789_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *codec_dai)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct pcm1789_private *priv = snd_soc_component_get_drvdata(component);
+	int val = 0, ret;
+
+	priv->rate = params_rate(params);
+
+	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch (params_width(params)) {
+		case 24:
+			val = 2;
+			break;
+		case 16:
+			val = 3;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		switch (params_width(params)) {
+		case 16:
+		case 24:
+		case 32:
+			val = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		switch (params_width(params)) {
+		case 16:
+		case 24:
+		case 32:
+			val = 1;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(component->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(priv->regmap, PCM1789_FMT_CONTROL,
+				 PCM1789_FMT_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void pcm1789_work_queue(struct work_struct *work)
+{
+	struct pcm1789_private *priv = container_of(work,
+						    struct pcm1789_private,
+						    work);
+
+	/* Perform a software reset to remove codec from desynchronized state */
+	if (regmap_update_bits(priv->regmap, PCM1789_MUTE_CONTROL,
+			       0x3 << PCM1789_MUTE_SRET, 0) < 0)
+		dev_err(priv->dev, "Error while setting SRET");
+}
+
+static int pcm1789_trigger(struct snd_pcm_substream *substream, int cmd,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm1789_private *priv = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		schedule_work(&priv->work);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops pcm1789_dai_ops = {
+	.set_fmt	= pcm1789_set_dai_fmt,
+	.hw_params	= pcm1789_hw_params,
+	.digital_mute	= pcm1789_digital_mute,
+	.trigger	= pcm1789_trigger,
+};
+
+static const DECLARE_TLV_DB_SCALE(pcm1789_dac_tlv, -12000, 50, 1);
+
+static const struct snd_kcontrol_new pcm1789_controls[] = {
+	SOC_DOUBLE_R_RANGE_TLV("DAC Playback Volume", PCM1789_DAC_VOL_LEFT,
+			       PCM1789_DAC_VOL_RIGHT, 0, 0xf, 0xff, 0,
+			       pcm1789_dac_tlv),
+};
+
+static const struct snd_soc_dapm_widget pcm1789_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("IOUTL+"),
+	SND_SOC_DAPM_OUTPUT("IOUTL-"),
+	SND_SOC_DAPM_OUTPUT("IOUTR+"),
+	SND_SOC_DAPM_OUTPUT("IOUTR-"),
+};
+
+static const struct snd_soc_dapm_route pcm1789_dapm_routes[] = {
+	{ "IOUTL+", NULL, "Playback" },
+	{ "IOUTL-", NULL, "Playback" },
+	{ "IOUTR+", NULL, "Playback" },
+	{ "IOUTR-", NULL, "Playback" },
+};
+
+static struct snd_soc_dai_driver pcm1789_dai = {
+	.name = "pcm1789-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 10000,
+		.rate_max = 200000,
+		.formats = PCM1789_FORMATS,
+	},
+	.ops = &pcm1789_dai_ops,
+};
+
+const struct regmap_config pcm1789_regmap_config = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= PCM1789_DAC_VOL_RIGHT,
+	.reg_defaults		= pcm1789_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(pcm1789_reg_defaults),
+	.writeable_reg		= pcm1789_writeable_reg,
+	.readable_reg		= pcm1789_accessible_reg,
+};
+EXPORT_SYMBOL_GPL(pcm1789_regmap_config);
+
+static const struct snd_soc_component_driver soc_component_dev_pcm1789 = {
+	.controls		= pcm1789_controls,
+	.num_controls		= ARRAY_SIZE(pcm1789_controls),
+	.dapm_widgets		= pcm1789_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcm1789_dapm_widgets),
+	.dapm_routes		= pcm1789_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pcm1789_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+int pcm1789_common_init(struct device *dev, struct regmap *regmap)
+{
+	struct pcm1789_private *pcm1789;
+
+	pcm1789 = devm_kzalloc(dev, sizeof(struct pcm1789_private),
+			       GFP_KERNEL);
+	if (!pcm1789)
+		return -ENOMEM;
+
+	pcm1789->regmap = regmap;
+	pcm1789->dev = dev;
+	dev_set_drvdata(dev, pcm1789);
+
+	pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(pcm1789->reset))
+		return PTR_ERR(pcm1789->reset);
+
+	gpiod_set_value_cansleep(pcm1789->reset, 0);
+	msleep(300);
+
+	INIT_WORK(&pcm1789->work, pcm1789_work_queue);
+
+	return devm_snd_soc_register_component(dev, &soc_component_dev_pcm1789,
+					       &pcm1789_dai, 1);
+}
+EXPORT_SYMBOL_GPL(pcm1789_common_init);
+
+int pcm1789_common_exit(struct device *dev)
+{
+	struct pcm1789_private *priv = dev_get_drvdata(dev);
+
+	if (&priv->work)
+		flush_work(&priv->work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcm1789_common_exit);
+
+MODULE_DESCRIPTION("ASoC PCM1789 driver");
+MODULE_AUTHOR("Mylène Josserand <mylene.josserand@free-electrons.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm1789.h b/sound/soc/codecs/pcm1789.h
new file mode 100644
index 000000000000..05c2c8ad2bad
--- /dev/null
+++ b/sound/soc/codecs/pcm1789.h
@@ -0,0 +1,28 @@
+/*
+ * definitions for PCM1789
+ *
+ * Copyright (c) Bootlin 2018
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __PCM1789_H__
+#define __PCM1789_H__
+
+#define PCM1789_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+			 SNDRV_PCM_FMTBIT_S16_LE)
+
+extern const struct regmap_config pcm1789_regmap_config;
+
+int pcm1789_common_init(struct device *dev, struct regmap *regmap);
+int pcm1789_common_exit(struct device *dev);
+
+#endif
-- 
2.11.0
