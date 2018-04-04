Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeDDVuH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:50:07 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36054 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbeDDVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:50:04 -0400
X-Google-Smtp-Source: AIpwx49mwNuwVTuOifCP62ZfQ7/tx2x5EqMvRxy7AV2AiTkuipJYCWBzZ5IXRszOkCjlTvgM9ugDUg==
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [alsa-devel][RESEND PATCH 2/3 v3] ASoC: TSCS42xx: Cleanup private data members
Date: Wed,  4 Apr 2018 16:49:51 -0500
Message-Id: <20180404214952.12636-2-steven.eckhoff.opensource@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180404214952.12636-1-steven.eckhoff.opensource@gmail.com>
References: <20180404214952.12636-1-steven.eckhoff.opensource@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove blrcm from private data
Remove dev from private data

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
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
2.15.1
