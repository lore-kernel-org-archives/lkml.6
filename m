Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754369AbeDMKzW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:55:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46802 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbeDMKzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:55:20 -0400
From: Mark Brown <broonie@kernel.org>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: TSCS42xx: Add CCF support to get sysclk" to the asoc tree
In-Reply-To: <20180327175040.GA26604@t7-ThinkPad-E560>
Message-Id: <E1f6wMR-00071Z-0P@debutante>
Date: Fri, 13 Apr 2018 11:55:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: TSCS42xx: Add CCF support to get sysclk

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

>From 8dc0e2a1f5c587f1afa227ec46012b92cea6d7a7 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Wed, 4 Apr 2018 16:49:52 -0500
Subject: [PATCH] ASoC: TSCS42xx: Add CCF support to get sysclk

The TSCS42xx relies on set_sysclk to get a unique clock id and rate,
which prevents it from being used with the simple-card.

Remove set_sysclk callback
Add CCF support to get clock id and rate
Add clocks and clock-names to device tree binding

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/tscs42xx.txt    |   6 +
 sound/soc/codecs/tscs42xx.c                   | 104 ++++++++++++------
 sound/soc/codecs/tscs42xx.h                   |   2 +-
 3 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tscs42xx.txt b/Documentation/devicetree/bindings/sound/tscs42xx.txt
index 2ac2f0996697..7eea32e9d078 100644
--- a/Documentation/devicetree/bindings/sound/tscs42xx.txt
+++ b/Documentation/devicetree/bindings/sound/tscs42xx.txt
@@ -8,9 +8,15 @@ Required Properties:
 	- reg : 	<0x71> for analog mic
 			<0x69> for digital mic
 
+	- clock-names:	Must one of  the following "mclk1", "xtal", "mclk2"
+
+	- clocks:	phandle of the clock that provides the codec sysclk
+
 Example:
 
 wookie: codec@69 {
 	compatible = "tempo,tscs42A2";
 	reg = <0x69>;
+	clock-names = "xtal";
+	clocks = <&audio_xtal>;
 };
diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index bf207b0345f1..d18ff17719cc 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/clk.h>
 #include <sound/tlv.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -40,6 +41,9 @@ struct tscs42xx {
 	struct mutex pll_lock;
 
 	struct regmap *regmap;
+
+	struct clk *sysclk;
+	int sysclk_src_id;
 };
 
 struct coeff_ram_ctl {
@@ -1251,13 +1255,46 @@ static int tscs42xx_set_dai_bclk_ratio(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int tscs42xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-	int clk_id, unsigned int freq, int dir)
+static const struct snd_soc_dai_ops tscs42xx_dai_ops = {
+	.hw_params	= tscs42xx_hw_params,
+	.mute_stream	= tscs42xx_mute_stream,
+	.set_fmt	= tscs42xx_set_dai_fmt,
+	.set_bclk_ratio = tscs42xx_set_dai_bclk_ratio,
+};
+
+static int part_is_valid(struct tscs42xx *tscs42xx)
 {
-	struct snd_soc_component *component = codec_dai->component;
+	int val;
 	int ret;
+	unsigned int reg;
+
+	ret = regmap_read(tscs42xx->regmap, R_DEVIDH, &reg);
+	if (ret < 0)
+		return ret;
 
-	switch (clk_id) {
+	val = reg << 8;
+	ret = regmap_read(tscs42xx->regmap, R_DEVIDL, &reg);
+	if (ret < 0)
+		return ret;
+
+	val |= reg;
+
+	switch (val) {
+	case 0x4A74:
+	case 0x4A73:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static int set_sysclk(struct snd_soc_component *component)
+{
+	struct tscs42xx *tscs42xx = snd_soc_component_get_drvdata(component);
+	unsigned long freq;
+	int ret;
+
+	switch (tscs42xx->sysclk_src_id) {
 	case TSCS42XX_PLL_SRC_XTAL:
 	case TSCS42XX_PLL_SRC_MCLK1:
 		ret = snd_soc_component_write(component, R_PLLREFSEL,
@@ -1285,6 +1322,7 @@ static int tscs42xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
+	freq = clk_get_rate(tscs42xx->sysclk);
 	ret = set_pll_ctl_from_input_freq(component, freq);
 	if (ret < 0) {
 		dev_err(component->dev,
@@ -1295,41 +1333,13 @@ static int tscs42xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops tscs42xx_dai_ops = {
-	.hw_params	= tscs42xx_hw_params,
-	.mute_stream	= tscs42xx_mute_stream,
-	.set_fmt	= tscs42xx_set_dai_fmt,
-	.set_bclk_ratio = tscs42xx_set_dai_bclk_ratio,
-	.set_sysclk	= tscs42xx_set_dai_sysclk,
-};
-
-static int part_is_valid(struct tscs42xx *tscs42xx)
+static int tscs42xx_probe(struct snd_soc_component *component)
 {
-	int val;
-	int ret;
-	unsigned int reg;
-
-	ret = regmap_read(tscs42xx->regmap, R_DEVIDH, &reg);
-	if (ret < 0)
-		return ret;
-
-	val = reg << 8;
-	ret = regmap_read(tscs42xx->regmap, R_DEVIDL, &reg);
-	if (ret < 0)
-		return ret;
-
-	val |= reg;
-
-	switch (val) {
-	case 0x4A74:
-	case 0x4A73:
-		return true;
-	default:
-		return false;
-	};
+	return set_sysclk(component);
 }
 
 static const struct snd_soc_component_driver soc_codec_dev_tscs42xx = {
+	.probe			= tscs42xx_probe,
 	.dapm_widgets		= tscs42xx_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(tscs42xx_dapm_widgets),
 	.dapm_routes		= tscs42xx_intercon,
@@ -1387,11 +1397,15 @@ static const struct reg_sequence tscs42xx_patch[] = {
 	{ R_AIC2, RV_AIC2_BLRCM_DAC_BCLK_LRCLK_SHARED },
 };
 
+static char const * const src_names[TSCS42XX_PLL_SRC_CNT] = {
+	"xtal", "mclk1", "mclk2"};
+
 static int tscs42xx_i2c_probe(struct i2c_client *i2c,
 		const struct i2c_device_id *id)
 {
 	struct tscs42xx *tscs42xx;
-	int ret = 0;
+	int src;
+	int ret;
 
 	tscs42xx = devm_kzalloc(&i2c->dev, sizeof(*tscs42xx), GFP_KERNEL);
 	if (!tscs42xx) {
@@ -1402,6 +1416,24 @@ static int tscs42xx_i2c_probe(struct i2c_client *i2c,
 	}
 	i2c_set_clientdata(i2c, tscs42xx);
 
+	for (src = TSCS42XX_PLL_SRC_XTAL; src < TSCS42XX_PLL_SRC_CNT; src++) {
+		tscs42xx->sysclk = devm_clk_get(&i2c->dev, src_names[src]);
+		if (!IS_ERR(tscs42xx->sysclk)) {
+			break;
+		} else if (PTR_ERR(tscs42xx->sysclk) != -ENOENT) {
+			ret = PTR_ERR(tscs42xx->sysclk);
+			dev_err(&i2c->dev, "Failed to get sysclk (%d)\n", ret);
+			return ret;
+		}
+	}
+	if (src == TSCS42XX_PLL_SRC_CNT) {
+		ret = -EINVAL;
+		dev_err(&i2c->dev, "Failed to get a valid clock name (%d)\n",
+				ret);
+		return ret;
+	}
+	tscs42xx->sysclk_src_id = src;
+
 	tscs42xx->regmap = devm_regmap_init_i2c(i2c, &tscs42xx_regmap);
 	if (IS_ERR(tscs42xx->regmap)) {
 		ret = PTR_ERR(tscs42xx->regmap);
diff --git a/sound/soc/codecs/tscs42xx.h b/sound/soc/codecs/tscs42xx.h
index d4a30bcbf64b..814c8f3c4a68 100644
--- a/sound/soc/codecs/tscs42xx.h
+++ b/sound/soc/codecs/tscs42xx.h
@@ -7,10 +7,10 @@
 #define __WOOKIE_H__
 
 enum {
-	TSCS42XX_PLL_SRC_NONE,
 	TSCS42XX_PLL_SRC_XTAL,
 	TSCS42XX_PLL_SRC_MCLK1,
 	TSCS42XX_PLL_SRC_MCLK2,
+	TSCS42XX_PLL_SRC_CNT,
 };
 
 #define R_HPVOLL        0x0
-- 
2.17.0
