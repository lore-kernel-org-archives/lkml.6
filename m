Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754388AbeDMKz2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:55:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46892 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754372AbeDMKzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:55:24 -0400
From: Mark Brown <broonie@kernel.org>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: TSCS42xx: Cleanup private data members" to the asoc tree
In-Reply-To: <20180323233136.GA20651@t7-ThinkPad-E560>
Message-Id: <E1f6wMU-00072S-LY@debutante>
Date: Fri, 13 Apr 2018 11:55:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: TSCS42xx: Cleanup private data members

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

>From bc85b750bfc4a1ac69c145208f95dda03dc41d60 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Wed, 4 Apr 2018 16:49:51 -0500
Subject: [PATCH] ASoC: TSCS42xx: Cleanup private data members

Remove blrcm from private data
Remove dev from private data

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 5ad68e5538ae..bf207b0345f1 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -31,7 +31,6 @@ struct tscs42xx {
 
 	int bclk_ratio;
 	int samplerate;
-	unsigned int blrcm;
 	struct mutex audio_params_lock;
 
 	u8 coeff_ram[COEFF_RAM_SIZE];
@@ -41,8 +40,6 @@ struct tscs42xx {
 	struct mutex pll_lock;
 
 	struct regmap *regmap;
-
-	struct device *dev;
 };
 
 struct coeff_ram_ctl {
@@ -1404,12 +1401,11 @@ static int tscs42xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 	i2c_set_clientdata(i2c, tscs42xx);
-	tscs42xx->dev = &i2c->dev;
 
 	tscs42xx->regmap = devm_regmap_init_i2c(i2c, &tscs42xx_regmap);
 	if (IS_ERR(tscs42xx->regmap)) {
 		ret = PTR_ERR(tscs42xx->regmap);
-		dev_err(tscs42xx->dev, "Failed to allocate regmap (%d)\n", ret);
+		dev_err(&i2c->dev, "Failed to allocate regmap (%d)\n", ret);
 		return ret;
 	}
 
@@ -1417,21 +1413,21 @@ static int tscs42xx_i2c_probe(struct i2c_client *i2c,
 
 	ret = part_is_valid(tscs42xx);
 	if (ret <= 0) {
-		dev_err(tscs42xx->dev, "No valid part (%d)\n", ret);
+		dev_err(&i2c->dev, "No valid part (%d)\n", ret);
 		ret = -ENODEV;
 		return ret;
 	}
 
 	ret = regmap_write(tscs42xx->regmap, R_RESET, RV_RESET_ENABLE);
 	if (ret < 0) {
-		dev_err(tscs42xx->dev, "Failed to reset device (%d)\n", ret);
+		dev_err(&i2c->dev, "Failed to reset device (%d)\n", ret);
 		return ret;
 	}
 
 	ret = regmap_register_patch(tscs42xx->regmap, tscs42xx_patch,
 			ARRAY_SIZE(tscs42xx_patch));
 	if (ret < 0) {
-		dev_err(tscs42xx->dev, "Failed to apply patch (%d)\n", ret);
+		dev_err(&i2c->dev, "Failed to apply patch (%d)\n", ret);
 		return ret;
 	}
 
@@ -1439,10 +1435,10 @@ static int tscs42xx_i2c_probe(struct i2c_client *i2c,
 	mutex_init(&tscs42xx->coeff_ram_lock);
 	mutex_init(&tscs42xx->pll_lock);
 
-	ret = devm_snd_soc_register_component(tscs42xx->dev,
+	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_codec_dev_tscs42xx, &tscs42xx_dai, 1);
 	if (ret) {
-		dev_err(tscs42xx->dev, "Failed to register codec (%d)\n", ret);
+		dev_err(&i2c->dev, "Failed to register codec (%d)\n", ret);
 		return ret;
 	}
 
-- 
2.17.0
