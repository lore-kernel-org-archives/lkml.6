Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeD0SY2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:24:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45246 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757523AbeD0SY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:24:26 -0400
From: Mark Brown <broonie@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, afd@ti.com,
        dannenberg@ti.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: tas6424: Add support for the mute pin" to the asoc tree
In-Reply-To: <1524837349-16350-3-git-send-email-jjhiblot@ti.com>
Message-Id: <E1fC82Z-0004Hf-PP@debutante>
Date: Fri, 27 Apr 2018 19:24:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas6424: Add support for the mute pin

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

>From e969a6d222c9da87c6b5978674788faf5c58a07d Mon Sep 17 00:00:00 2001
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Date: Fri, 27 Apr 2018 15:55:48 +0200
Subject: [PATCH] ASoC: tas6424: Add support for the mute pin

mute can be connected to GPIO. In that case we have to drive it to the
correct value

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/ti,tas6424.txt  |  1 +
 sound/soc/codecs/tas6424.c                    | 37 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
index df71e414dc5b..eacb54f34188 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas6424.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -7,6 +7,7 @@ Required properties:
 	- reg: I2C slave address
 	- sound-dai-cells: must be equal to 0
 	- standby-gpios: GPIO used to shut the TAS6424 down.
+	- mute-gpios: GPIO used to mute all the outputs
 
 Example:
 
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 5abb17f8d3dd..89fd0c1b3903 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -45,6 +45,7 @@ struct tas6424_data {
 	unsigned int last_fault2;
 	unsigned int last_warn;
 	struct gpio_desc *standby_gpio;
+	struct gpio_desc *mute_gpio;
 };
 
 /*
@@ -251,10 +252,16 @@ static int tas6424_set_dai_tdm_slot(struct snd_soc_dai *dai,
 static int tas6424_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
+	struct tas6424_data *tas6424 = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	dev_dbg(component->dev, "%s() mute=%d\n", __func__, mute);
 
+	if (tas6424->mute_gpio) {
+		gpiod_set_value_cansleep(tas6424->mute_gpio, mute);
+		return 0;
+	}
+
 	if (mute)
 		val = TAS6424_ALL_STATE_MUTE;
 	else
@@ -289,6 +296,7 @@ static int tas6424_power_on(struct snd_soc_component *component)
 {
 	struct tas6424_data *tas6424 = snd_soc_component_get_drvdata(component);
 	int ret;
+	u8 chan_states;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(tas6424->supplies),
 				    tas6424->supplies);
@@ -305,7 +313,18 @@ static int tas6424_power_on(struct snd_soc_component *component)
 		return ret;
 	}
 
-	snd_soc_component_write(component, TAS6424_CH_STATE_CTRL, TAS6424_ALL_STATE_MUTE);
+	if (tas6424->mute_gpio) {
+		gpiod_set_value_cansleep(tas6424->mute_gpio, 0);
+		/*
+		 * channels are muted via the mute pin.  Don't also mute
+		 * them via the registers so that subsequent register
+		 * access is not necessary to un-mute the channels
+		 */
+		chan_states = TAS6424_ALL_STATE_PLAY;
+	} else {
+		chan_states = TAS6424_ALL_STATE_MUTE;
+	}
+	snd_soc_component_write(component, TAS6424_CH_STATE_CTRL, chan_states);
 
 	/* any time we come out of HIZ, the output channels automatically run DC
 	 * load diagnostics, wait here until this completes
@@ -645,6 +664,22 @@ static int tas6424_i2c_probe(struct i2c_client *client,
 		tas6424->standby_gpio = NULL;
 	}
 
+	/*
+	 * Get control of the mute pin and set it HIGH in order to start with
+	 * all the output muted.
+	 * Note: The actual pin polarity is taken care of in the GPIO lib
+	 * according the polarity specified in the DTS.
+	 */
+	tas6424->mute_gpio = devm_gpiod_get_optional(dev, "mute",
+						      GPIOD_OUT_HIGH);
+	if (IS_ERR(tas6424->mute_gpio)) {
+		if (PTR_ERR(tas6424->mute_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_info(dev, "failed to get nmute GPIO: %ld\n",
+			PTR_ERR(tas6424->mute_gpio));
+		tas6424->mute_gpio = NULL;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(tas6424->supplies); i++)
 		tas6424->supplies[i].supply = tas6424_supply_names[i];
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(tas6424->supplies),
-- 
2.17.0
