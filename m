Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeBSMSU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:18:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58042 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeBSMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:18:18 -0500
From: Mark Brown <broonie@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        huang lin <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: dmic: Add optional wakeup delay" to the asoc tree
In-Reply-To: <20180216175312.88465-1-mka@chromium.org>
Message-Id: <E1enkOQ-0002gp-H9@debutante>
Date: Mon, 19 Feb 2018 12:18:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dmic: Add optional wakeup delay

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

>From 05c9b302eda71083840392d74ce62dd1e1f30621 Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Fri, 16 Feb 2018 09:53:12 -0800
Subject: [PATCH] ASoC: dmic: Add optional wakeup delay

On some systems a delay is needed after switching on the clocks, to allow
the output to stabilize and avoid a popping noise at the beginning of
the recording. Add the optional device tree property 'wakeup-delay-ms'
and apply the specified delay after enabling the mic. A blocking delay
can't be applied in dmic_daiops_trigger() since the function is called
in atomic context. Instead use a DAPM event handler to set the enable
GPIO and apply the delay in the handler.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/dmic.txt |  2 +
 sound/soc/codecs/dmic.c                          | 63 +++++++++++++-----------
 2 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
index f7bf65611453..e957b4136716 100644
--- a/Documentation/devicetree/bindings/sound/dmic.txt
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -8,6 +8,7 @@ Required properties:
 Optional properties:
 	- dmicen-gpios: GPIO specifier for dmic to control start and stop
 	- num-channels: Number of microphones on this DAI
+	- wakeup-delay-ms: Delay (in ms) after enabling the DMIC
 
 Example node:
 
@@ -15,4 +16,5 @@ Example node:
 		compatible = "dmic-codec";
 		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 		num-channels = <1>;
+		wakeup-delay-ms <50>;
 	};
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 32a8f71d51f1..bac5bbb2dd59 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
@@ -29,34 +30,33 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
-static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
-		int cmd, struct snd_soc_dai *dai)
-{
-	struct gpio_desc *dmic_en = snd_soc_dai_get_drvdata(dai);
+struct dmic {
+	struct gpio_desc *gpio_en;
+	int wakeup_delay;
+};
 
-	if (!dmic_en)
-		return 0;
+static int dmic_aif_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol, int event) {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct dmic *dmic = snd_soc_codec_get_drvdata(codec);
 
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		gpiod_set_value(dmic_en, 1);
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (dmic->gpio_en)
+			gpiod_set_value(dmic->gpio_en, 1);
+
+		if (dmic->wakeup_delay)
+			msleep(dmic->wakeup_delay);
 		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		gpiod_set_value(dmic_en, 0);
+	case SND_SOC_DAPM_POST_PMD:
+		if (dmic->gpio_en)
+			gpiod_set_value(dmic->gpio_en, 0);
 		break;
 	}
 
 	return 0;
 }
 
-static const struct snd_soc_dai_ops dmic_dai_ops = {
-	.trigger	= dmic_daiops_trigger,
-};
-
 static struct snd_soc_dai_driver dmic_dai = {
 	.name = "dmic-hifi",
 	.capture = {
@@ -68,26 +68,33 @@ static struct snd_soc_dai_driver dmic_dai = {
 			| SNDRV_PCM_FMTBIT_S24_LE
 			| SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops    = &dmic_dai_ops,
 };
 
 static int dmic_component_probe(struct snd_soc_component *component)
 {
-	struct gpio_desc *dmic_en;
+	struct dmic *dmic;
+
+	dmic = devm_kzalloc(component->dev, sizeof(*dmic), GFP_KERNEL);
+	if (!dmic)
+		return -ENOMEM;
+
+	dmic->gpio_en = devm_gpiod_get_optional(component->dev,
+						"dmicen", GPIOD_OUT_LOW);
+	if (IS_ERR(dmic->gpio_en))
+		return PTR_ERR(dmic->gpio_en);
 
-	dmic_en = devm_gpiod_get_optional(component->dev,
-					"dmicen", GPIOD_OUT_LOW);
-	if (IS_ERR(dmic_en))
-		return PTR_ERR(dmic_en);
+	device_property_read_u32(component->dev, "wakeup-delay-ms",
+				 &dmic->wakeup_delay);
 
-	snd_soc_component_set_drvdata(component, dmic_en);
+	snd_soc_component_set_drvdata(component, dmic);
 
 	return 0;
 }
 
 static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
-	SND_SOC_DAPM_AIF_OUT("DMIC AIF", "Capture", 0,
-			     SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT_E("DMIC AIF", "Capture", 0,
+			       SND_SOC_NOPM, 0, 0, dmic_aif_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_INPUT("DMic"),
 };
 
-- 
2.16.1
