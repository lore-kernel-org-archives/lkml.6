Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeBSMTW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:19:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeBSMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:19:19 -0500
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Akshu Agrawal <akshu.agrawal@amd.com>,
        Harsha Priya <harshapriya.n@intel.com>, linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
        Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mihai Serban <mihai.serban@nxp.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Naveen Manohar <naveen.m@intel.com>, Dylan Reid <dgreid@chromium.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: ak5558: replace codec to component" to the asoc tree
In-Reply-To: <87o9klobs9.wl%kuninori.morimoto.gx@renesas.com>
Message-Id: <E1enkPH-0002nD-6F@debutante>
Date: Mon, 19 Feb 2018 12:18:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ak5558: replace codec to component

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

>From 3f15aa198fb88a6a0db8c7ba136637d566effb55 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Feb 2018 04:17:16 +0000
Subject: [PATCH] ASoC: ak5558: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak5558.c | 67 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 225173ff4efa..f2248315677e 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -25,7 +25,7 @@
 
 /* AK5558 Codec Private Data */
 struct ak5558_priv {
-	struct snd_soc_codec codec;
+	struct snd_soc_component component;
 	struct regmap *regmap;
 	struct i2c_client *i2c;
 	struct gpio_desc *reset_gpiod; /* Reset & Power down GPIO */
@@ -116,9 +116,9 @@ static const struct snd_soc_dapm_route ak5558_intercon[] = {
 	{"SDTO", NULL, "ADC Ch8"},
 };
 
-static int ak5558_set_mcki(struct snd_soc_codec *codec)
+static int ak5558_set_mcki(struct snd_soc_component *component)
 {
-	return snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS,
+	return snd_soc_component_update_bits(component, AK5558_02_CONTROL1, AK5558_CKS,
 				   AK5558_CKS_AUTO);
 }
 
@@ -126,13 +126,13 @@ static int ak5558_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak5558_priv *ak5558 = snd_soc_component_get_drvdata(component);
 	u8 bits;
 	int pcm_width = max(params_physical_width(params), ak5558->slot_width);
 
 	/* set master/slave audio interface */
-	bits = snd_soc_read(codec, AK5558_02_CONTROL1);
+	bits = snd_soc_component_read32(component, AK5558_02_CONTROL1);
 	bits &= ~AK5558_BITS;
 
 	switch (pcm_width) {
@@ -146,14 +146,14 @@ static int ak5558_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_BITS, bits);
+	snd_soc_component_update_bits(component, AK5558_02_CONTROL1, AK5558_BITS, bits);
 
 	return 0;
 }
 
 static int ak5558_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u8 format;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -169,7 +169,7 @@ static int ak5558_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* set master/slave audio interface */
-	format = snd_soc_read(codec, AK5558_02_CONTROL1);
+	format = snd_soc_component_read32(component, AK5558_02_CONTROL1);
 	format &= ~AK5558_DIF;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -186,7 +186,7 @@ static int ak5558_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_DIF, format);
+	snd_soc_component_update_bits(component, AK5558_02_CONTROL1, AK5558_DIF, format);
 
 	return 0;
 }
@@ -195,8 +195,8 @@ static int ak5558_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots,
 			       int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak5558_priv *ak5558 = snd_soc_component_get_drvdata(component);
 	int tdm_mode;
 
 	ak5558->slots = slots;
@@ -217,7 +217,7 @@ static int ak5558_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		break;
 	}
 
-	snd_soc_update_bits(codec, AK5558_03_CONTROL2, AK5558_MODE_BITS,
+	snd_soc_component_update_bits(component, AK5558_03_CONTROL2, AK5558_MODE_BITS,
 			    tdm_mode);
 	return 0;
 }
@@ -285,21 +285,19 @@ static void ak5558_power_on(struct ak5558_priv *ak5558)
 	usleep_range(1000, 2000);
 }
 
-static int ak5558_probe(struct snd_soc_codec *codec)
+static int ak5558_probe(struct snd_soc_component *component)
 {
-	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	struct ak5558_priv *ak5558 = snd_soc_component_get_drvdata(component);
 
 	ak5558_power_on(ak5558);
-	return ak5558_set_mcki(codec);
+	return ak5558_set_mcki(component);
 }
 
-static int ak5558_remove(struct snd_soc_codec *codec)
+static void ak5558_remove(struct snd_soc_component *component)
 {
-	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	struct ak5558_priv *ak5558 = snd_soc_component_get_drvdata(component);
 
 	ak5558_power_off(ak5558);
-
-	return 0;
 }
 
 static int __maybe_unused ak5558_runtime_suspend(struct device *dev)
@@ -331,18 +329,19 @@ const struct dev_pm_ops ak5558_pm = {
 				pm_runtime_force_resume)
 };
 
-struct snd_soc_codec_driver soc_codec_dev_ak5558 = {
-	.probe = ak5558_probe,
-	.remove = ak5558_remove,
-
-	.component_driver = {
-		.controls = ak5558_snd_controls,
-		.num_controls = ARRAY_SIZE(ak5558_snd_controls),
-		.dapm_widgets = ak5558_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(ak5558_dapm_widgets),
-		.dapm_routes = ak5558_intercon,
-		.num_dapm_routes = ARRAY_SIZE(ak5558_intercon),
-	},
+struct snd_soc_component_driver soc_codec_dev_ak5558 = {
+	.probe			= ak5558_probe,
+	.remove			= ak5558_remove,
+	.controls		= ak5558_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak5558_snd_controls),
+	.dapm_widgets		= ak5558_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak5558_dapm_widgets),
+	.dapm_routes		= ak5558_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(ak5558_intercon),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config ak5558_regmap = {
@@ -376,7 +375,8 @@ static int ak5558_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(ak5558->reset_gpiod))
 		return PTR_ERR(ak5558->reset_gpiod);
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_ak5558,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				     &soc_codec_dev_ak5558,
 				     &ak5558_dai, 1);
 	if (ret)
 		return ret;
@@ -388,7 +388,6 @@ static int ak5558_i2c_probe(struct i2c_client *i2c)
 
 static int ak5558_i2c_remove(struct i2c_client *i2c)
 {
-	snd_soc_unregister_codec(&i2c->dev);
 	pm_runtime_disable(&i2c->dev);
 
 	return 0;
-- 
2.16.1
