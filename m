Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbeDTKFv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:05:51 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:14068 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754560AbeDTKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:05:36 -0400
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC: <dannenberg@ti.com>, <afd@ti.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH 3/3] ASoC: tas6424: Add support for the mute pin
Date: Fri, 20 Apr 2018 12:04:44 +0200
Message-ID: <1524218684-19752-4-git-send-email-jjhiblot@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mute can be connected to GPIO. In that case we have to drive it to the
correct value

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 .../devicetree/bindings/sound/ti,tas6424.txt       |  1 +
 sound/soc/codecs/tas6424.c                         | 37 +++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
index 82c6d48..527e356 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas6424.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -9,6 +9,7 @@ Required properties:
 	- disable-auto-diagnostics: disable DC auto diagnostics (faster power
 	  on, but less safe as shortage won't be detected)
 	- standby-gpio: GPIO used to shut the TAS6424 down.
+	- mute-gpio: GPIO used to mute all the outputs
 
 Example:
 
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 926259a..cf84b1c 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -46,6 +46,7 @@ struct tas6424_data {
 	unsigned int last_warn;
 	bool no_auto_diags;
 	struct gpio_desc *standby_gpio;
+	struct gpio_desc *mute_gpio;
 };
 
 /*
@@ -252,10 +253,16 @@ static int tas6424_set_dai_tdm_slot(struct snd_soc_dai *dai,
 static int tas6424_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
+	struct tas6424_data *tas6424 = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
 	dev_dbg(component->dev, "%s() mute=%d\n", __func__, mute);
 
+	if (tas6424->mute_gpio) {
+		gpiod_set_value_cansleep(tas6424->mute_gpio, mute ? 1 : 0);
+		return 0;
+	}
+
 	if (mute)
 		val = TAS6424_ALL_STATE_MUTE;
 	else
@@ -290,6 +297,7 @@ static int tas6424_power_on(struct snd_soc_component *component)
 {
 	struct tas6424_data *tas6424 = snd_soc_component_get_drvdata(component);
 	int ret;
+	u8 chan_states;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(tas6424->supplies),
 				    tas6424->supplies);
@@ -306,7 +314,18 @@ static int tas6424_power_on(struct snd_soc_component *component)
 		return ret;
 	}
 
-	snd_soc_component_write(component, TAS6424_CH_STATE_CTRL, TAS6424_ALL_STATE_MUTE);
+	if (tas6424->mute_gpio) {
+		gpiod_set_value_cansleep(tas6424->mute_gpio, 0);
+		/*
+		 * channels are muted via the mute pin, don't also. Don't also
+		 * mute them via the registers so that subsequent register
+		 * access is not necessary to un-mute the channels
+		 */
+		chan_states = TAS6424_ALL_STATE_PLAY;
+	} else {
+		chan_states = TAS6424_ALL_STATE_MUTE;
+	}
+	snd_soc_component_write(component, TAS6424_CH_STATE_CTRL, chan_states);
 
 	/* any time we come out of HIZ, the output channels automatically run DC
 	 * load diagnostics, wait here until this completes
@@ -650,6 +669,22 @@ static int tas6424_i2c_probe(struct i2c_client *client,
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
2.7.4
