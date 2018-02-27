Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeB0VZQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:25:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39279 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeB0VZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:25:11 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com
Subject: [PATCH v1 2/4] ASoC: codecs: pcm179x: Add support for PCM1789
Date: Tue, 27 Feb 2018 22:24:31 +0100
Message-Id: <20180227212433.2189-3-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180227212433.2189-1-mylene.josserand@bootlin.com>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCM1789 DAC support into pcm179x file.
This DAC is pretty much the same than PCM179x but some
registers are differents (such as mute registers split in
right/left).

One particularity about this DAC is that the clocks must be
always enabled. Also, an entire software reset is necessary
while starting to play a sound otherwise, the clocks are not
synchronized (so the DAC is not able to send data).

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 sound/soc/codecs/pcm179x-i2c.c |   7 +-
 sound/soc/codecs/pcm179x.c     | 164 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/pcm179x.h     |   1 +
 3 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
index 795a0657c097..83a2e1508df8 100644
--- a/sound/soc/codecs/pcm179x-i2c.c
+++ b/sound/soc/codecs/pcm179x-i2c.c
@@ -26,10 +26,13 @@
 static int pcm179x_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
-	struct regmap *regmap;
+	struct regmap *regmap = NULL;
 	int ret;
 
-	regmap = devm_regmap_init_i2c(client, &pcm179x_regmap_config);
+	if (id->driver_data == PCM1789)
+		regmap = devm_regmap_init_i2c(client, &pcm1789_regmap_config);
+	else
+		regmap = devm_regmap_init_i2c(client, &pcm179x_regmap_config);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index 81cbf09319f6..2285a51ff9e9 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -43,6 +43,17 @@
 #define PCM179X_MUTE_SHIFT	0
 #define PCM179X_ATLD_ENABLE	(1 << 7)
 
+#define PCM1789_FMT_CONTROL	0x11
+#define PCM1789_FLT_CONTROL	0x12
+#define PCM1789_REV_CONTROL	0x13
+#define PCM1789_SOFT_MUTE	0x14
+#define PCM1789_DAC_VOL_LEFT	0x18
+#define PCM1789_DAC_VOL_RIGHT	0x19
+#define PCM1789_FMT_MASK	0x07
+#define PCM1789_MUTE_MASK	0x03
+#define PCM1789_MUTE_L_EN	BIT(0)
+#define PCM1789_MUTE_R_EN	BIT(1)
+
 static const struct reg_default pcm179x_reg_defaults[] = {
 	{ 0x10, 0xff },
 	{ 0x11, 0xff },
@@ -54,11 +65,25 @@ static const struct reg_default pcm179x_reg_defaults[] = {
 	{ 0x17, 0x00 },
 };
 
+static const struct reg_default pcm1789_reg_defaults[] = {
+	{ PCM1789_FMT_CONTROL, 0x00 },
+	{ PCM1789_FLT_CONTROL, 0x00 },
+	{ PCM1789_REV_CONTROL, 0x00 },
+	{ PCM1789_SOFT_MUTE, 0x00 },
+	{ PCM1789_DAC_VOL_LEFT, 0xff },
+	{ PCM1789_DAC_VOL_RIGHT, 0xff },
+};
+
 static bool pcm179x_accessible_reg(struct device *dev, unsigned int reg)
 {
 	return reg >= 0x10 && reg <= 0x17;
 }
 
+static bool pcm1789_accessible_reg(struct device *dev, unsigned int reg)
+{
+	return reg >= PCM1789_FMT_CONTROL && reg <= PCM1789_DAC_VOL_RIGHT;
+}
+
 static bool pcm179x_writeable_reg(struct device *dev, unsigned int reg)
 {
 	bool accessible;
@@ -68,6 +93,15 @@ static bool pcm179x_writeable_reg(struct device *dev, unsigned int reg)
 	return accessible && reg != 0x16 && reg != 0x17;
 }
 
+static bool pcm1789_writeable_reg(struct device *dev, unsigned int reg)
+{
+	bool accessible;
+
+	accessible = pcm1789_accessible_reg(dev, reg);
+
+	return accessible && reg != 0x16 && reg != 0x17;
+}
+
 struct pcm179x_private {
 	struct regmap *regmap;
 	unsigned int format;
@@ -99,6 +133,24 @@ static int pcm179x_digital_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
+static int pcm1789_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm179x_private *priv = snd_soc_component_get_drvdata(component);
+	int ret, val;
+
+	if (mute)
+		val = ~(PCM1789_MUTE_L_EN | PCM1789_MUTE_R_EN);
+	else
+		val = PCM1789_MUTE_L_EN | PCM1789_MUTE_R_EN;
+	ret = regmap_update_bits(priv->regmap, PCM1789_SOFT_MUTE,
+				 PCM1789_MUTE_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
@@ -151,12 +203,76 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int pcm1789_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm179x_private *priv = snd_soc_component_get_drvdata(component);
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
 static const struct snd_soc_dai_ops pcm179x_dai_ops = {
 	.set_fmt	= pcm179x_set_dai_fmt,
 	.hw_params	= pcm179x_hw_params,
 	.digital_mute	= pcm179x_digital_mute,
 };
 
+static const struct snd_soc_dai_ops pcm1789_dai_ops = {
+	.set_fmt	= pcm179x_set_dai_fmt,
+	.hw_params	= pcm1789_hw_params,
+	.digital_mute	= pcm1789_digital_mute,
+};
+
 static const DECLARE_TLV_DB_SCALE(pcm179x_dac_tlv, -12000, 50, 1);
 
 static const struct snd_kcontrol_new pcm179x_controls[] = {
@@ -167,6 +283,12 @@ static const struct snd_kcontrol_new pcm179x_controls[] = {
 	SOC_SINGLE("DAC Rolloff Filter Switch", PCM179X_MODE_CONTROL, 1, 1, 0),
 };
 
+static const struct snd_kcontrol_new pcm1789_controls[] = {
+	SOC_DOUBLE_R_RANGE_TLV("DAC Playback Volume", PCM1789_DAC_VOL_LEFT,
+			       PCM1789_DAC_VOL_RIGHT, 0, 0xf, 0xff, 0,
+			       pcm179x_dac_tlv),
+};
+
 static const struct snd_soc_dapm_widget pcm179x_dapm_widgets[] = {
 SND_SOC_DAPM_OUTPUT("IOUTL+"),
 SND_SOC_DAPM_OUTPUT("IOUTL-"),
@@ -194,6 +316,19 @@ static struct snd_soc_dai_driver pcm179x_dai = {
 	.ops = &pcm179x_dai_ops,
 };
 
+static struct snd_soc_dai_driver pcm1789_dai = {
+	.name = "pcm1789-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 10000,
+		.rate_max = 200000,
+		.formats = PCM1792A_FORMATS, },
+	.ops = &pcm1789_dai_ops,
+};
+
 const struct regmap_config pcm179x_regmap_config = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
@@ -205,6 +340,17 @@ const struct regmap_config pcm179x_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(pcm179x_regmap_config);
 
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
 static const struct snd_soc_component_driver soc_component_dev_pcm179x = {
 	.controls		= pcm179x_controls,
 	.num_controls		= ARRAY_SIZE(pcm179x_controls),
@@ -218,6 +364,19 @@ static const struct snd_soc_component_driver soc_component_dev_pcm179x = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static const struct snd_soc_component_driver soc_component_dev_pcm1789 = {
+	.controls		= pcm1789_controls,
+	.num_controls		= ARRAY_SIZE(pcm1789_controls),
+	.dapm_widgets		= pcm179x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcm179x_dapm_widgets),
+	.dapm_routes		= pcm179x_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pcm179x_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
 int pcm179x_common_init(struct device *dev, struct regmap *regmap,
 			enum pcm17xx_type type)
 {
@@ -231,6 +390,11 @@ int pcm179x_common_init(struct device *dev, struct regmap *regmap,
 	pcm179x->regmap = regmap;
 	dev_set_drvdata(dev, pcm179x);
 
+	if (type == PCM1789)
+		return devm_snd_soc_register_component(dev,
+						       &soc_component_dev_pcm1789,
+						       &pcm1789_dai, 1);
+
 	return devm_snd_soc_register_component(dev,
 			&soc_component_dev_pcm179x, &pcm179x_dai, 1);
 }
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
index 8c08689e3b8b..a79726933a3f 100644
--- a/sound/soc/codecs/pcm179x.h
+++ b/sound/soc/codecs/pcm179x.h
@@ -26,6 +26,7 @@ enum pcm17xx_type {
 			  SNDRV_PCM_FMTBIT_S16_LE)
 
 extern const struct regmap_config pcm179x_regmap_config;
+extern const struct regmap_config pcm1789_regmap_config;
 
 int pcm179x_common_init(struct device *dev, struct regmap *regmap,
 			enum pcm17xx_type type);
-- 
2.11.0
