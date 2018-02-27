Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeB0VZh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:25:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39293 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbeB0VZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:25:14 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com
Subject: [PATCH v1 4/4] ASoC: codecs: pcm179x: Add trigger function to perform a reset
Date: Tue, 27 Feb 2018 22:24:33 +0100
Message-Id: <20180227212433.2189-5-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180227212433.2189-1-mylene.josserand@bootlin.com>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trigger function to perform a reset when we are starting to
play a sound. Thanks to that, the codec will not be in
desynchronization state anymore and the data will be sent correctly.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 sound/soc/codecs/pcm179x-i2c.c |  4 +++
 sound/soc/codecs/pcm179x.c     | 61 +++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/pcm179x.h     |  1 +
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
index 83a2e1508df8..f8b4b07ce7f2 100644
--- a/sound/soc/codecs/pcm179x-i2c.c
+++ b/sound/soc/codecs/pcm179x-i2c.c
@@ -65,6 +65,10 @@ static struct i2c_driver pcm179x_i2c_driver = {
 	.probe		= pcm179x_i2c_probe,
 };
 
+int pcm179x_i2c_remove(struct i2c_client *client)
+{
+	return pcm179x_common_exit(&client->dev);
+}
 module_i2c_driver(pcm179x_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC PCM179X I2C driver");
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index 0242dfd67b53..4c7f4010a144 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -30,6 +30,7 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <linux/of.h>
+#include <linux/workqueue.h>
 
 #include "pcm179x.h"
 
@@ -45,6 +46,7 @@
 #define PCM179X_MUTE_SHIFT	0
 #define PCM179X_ATLD_ENABLE	(1 << 7)
 
+#define PCM1789_MUTE_CONTROL	0x10
 #define PCM1789_FMT_CONTROL	0x11
 #define PCM1789_FLT_CONTROL	0x12
 #define PCM1789_REV_CONTROL	0x13
@@ -55,6 +57,7 @@
 #define PCM1789_MUTE_MASK	0x03
 #define PCM1789_MUTE_L_EN	BIT(0)
 #define PCM1789_MUTE_R_EN	BIT(1)
+#define PCM1789_MUTE_SRET	0x06
 
 static const struct reg_default pcm179x_reg_defaults[] = {
 	{ 0x10, 0xff },
@@ -83,7 +86,7 @@ static bool pcm179x_accessible_reg(struct device *dev, unsigned int reg)
 
 static bool pcm1789_accessible_reg(struct device *dev, unsigned int reg)
 {
-	return reg >= PCM1789_FMT_CONTROL && reg <= PCM1789_DAC_VOL_RIGHT;
+	return reg >= PCM1789_MUTE_CONTROL && reg <= PCM1789_DAC_VOL_RIGHT;
 }
 
 static bool pcm179x_writeable_reg(struct device *dev, unsigned int reg)
@@ -109,6 +112,8 @@ struct pcm179x_private {
 	unsigned int format;
 	unsigned int rate;
 	int reset;
+	struct work_struct work;
+	struct device *dev;
 };
 
 static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
@@ -264,6 +269,42 @@ static int pcm1789_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void pcm1789_work_queue(struct work_struct *work)
+{
+	struct pcm179x_private *priv = container_of(work,
+						    struct pcm179x_private,
+						    work);
+
+	/* Soft reset */
+	if (regmap_update_bits(priv->regmap, PCM1789_MUTE_CONTROL,
+			       0x3 << PCM1789_MUTE_SRET, 0) < 0)
+		dev_err(priv->dev, "Error while setting SRET");
+}
+
+static int pcm1789_trigger(struct snd_pcm_substream *substream, int cmd,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm179x_private *priv = snd_soc_component_get_drvdata(component);
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
 static const struct snd_soc_dai_ops pcm179x_dai_ops = {
 	.set_fmt	= pcm179x_set_dai_fmt,
 	.hw_params	= pcm179x_hw_params,
@@ -274,6 +315,7 @@ static const struct snd_soc_dai_ops pcm1789_dai_ops = {
 	.set_fmt	= pcm179x_set_dai_fmt,
 	.hw_params	= pcm1789_hw_params,
 	.digital_mute	= pcm1789_digital_mute,
+	.trigger	= pcm1789_trigger,
 };
 
 static const DECLARE_TLV_DB_SCALE(pcm179x_dac_tlv, -12000, 50, 1);
@@ -392,6 +434,7 @@ int pcm179x_common_init(struct device *dev, struct regmap *regmap,
 	if (!pcm179x)
 		return -ENOMEM;
 
+	pcm179x->dev = dev;
 	pcm179x->regmap = regmap;
 	dev_set_drvdata(dev, pcm179x);
 
@@ -410,16 +453,28 @@ int pcm179x_common_init(struct device *dev, struct regmap *regmap,
 		gpio_set_value(pcm179x->reset, 1);
 	}
 
-	if (type == PCM1789)
+	if (type == PCM1789) {
+		INIT_WORK(&pcm179x->work, pcm1789_work_queue);
 		return devm_snd_soc_register_component(dev,
 						       &soc_component_dev_pcm1789,
 						       &pcm1789_dai, 1);
-
+	}
 	return devm_snd_soc_register_component(dev,
 			&soc_component_dev_pcm179x, &pcm179x_dai, 1);
 }
 EXPORT_SYMBOL_GPL(pcm179x_common_init);
 
+int pcm179x_common_exit(struct device *dev)
+{
+	struct pcm179x_private *priv = dev_get_drvdata(dev);
+
+	if (&priv->work)
+		flush_work(&priv->work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcm179x_common_exit);
+
 MODULE_DESCRIPTION("ASoC PCM179X driver");
 MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
index a79726933a3f..2cc75313c822 100644
--- a/sound/soc/codecs/pcm179x.h
+++ b/sound/soc/codecs/pcm179x.h
@@ -30,5 +30,6 @@ extern const struct regmap_config pcm1789_regmap_config;
 
 int pcm179x_common_init(struct device *dev, struct regmap *regmap,
 			enum pcm17xx_type type);
+int pcm179x_common_exit(struct device *dev);
 
 #endif
-- 
2.11.0
