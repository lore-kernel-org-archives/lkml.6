Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeBSMTU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:19:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59808 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbeBSMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:19:18 -0500
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
Subject: Applied "ASoC: ak4458: replace codec to component" to the asoc tree
In-Reply-To: <87po51obt3.wl%kuninori.morimoto.gx@renesas.com>
Message-Id: <E1enkPR-0002of-4n@debutante>
Date: Mon, 19 Feb 2018 12:19:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ak4458: replace codec to component

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

>From c988e67507934e0198233729b7f326154b211a7f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Feb 2018 04:16:42 +0000
Subject: [PATCH] ASoC: ak4458: replace codec to component

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
 sound/soc/codecs/ak4458.c | 107 +++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index c9762162b53f..d2815ac9cffa 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -167,8 +167,8 @@ static const struct soc_enum ak4458_dif_enum =
 static int get_digfil(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = ak4458->digfil;
 
@@ -178,8 +178,8 @@ static int get_digfil(struct snd_kcontrol *kcontrol,
 static int set_digfil(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 	int num;
 
 	num = ucontrol->value.enumerated.item[0];
@@ -189,17 +189,17 @@ static int set_digfil(struct snd_kcontrol *kcontrol,
 	ak4458->digfil = num;
 
 	/* write SD bit */
-	snd_soc_update_bits(codec, AK4458_01_CONTROL2,
+	snd_soc_component_update_bits(component, AK4458_01_CONTROL2,
 			    AK4458_SD_MASK,
 			    ((ak4458->digfil & 0x02) << 4));
 
 	/* write SLOW bit */
-	snd_soc_update_bits(codec, AK4458_02_CONTROL3,
+	snd_soc_component_update_bits(component, AK4458_02_CONTROL3,
 			    AK4458_SLOW_MASK,
 			    (ak4458->digfil & 0x01));
 
 	/* write SSLOW bit */
-	snd_soc_update_bits(codec, AK4458_05_CONTROL4,
+	snd_soc_component_update_bits(component, AK4458_05_CONTROL4,
 			    AK4458_SSLOW_MASK,
 			    ((ak4458->digfil & 0x04) >> 2));
 
@@ -259,17 +259,17 @@ static const struct snd_soc_dapm_route ak4458_intercon[] = {
 	{"AK4458 AOUTD",	NULL,	"AK4458 DAC4"},
 };
 
-static int ak4458_rstn_control(struct snd_soc_codec *codec, int bit)
+static int ak4458_rstn_control(struct snd_soc_component *component, int bit)
 {
 	int ret;
 
 	if (bit)
-		ret = snd_soc_update_bits(codec,
+		ret = snd_soc_component_update_bits(component,
 					  AK4458_00_CONTROL1,
 					  AK4458_RSTN_MASK,
 					  0x1);
 	else
-		ret = snd_soc_update_bits(codec,
+		ret = snd_soc_component_update_bits(component,
 					  AK4458_00_CONTROL1,
 					  AK4458_RSTN_MASK,
 					  0x0);
@@ -280,8 +280,8 @@ static int ak4458_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 	int pcm_width = max(params_physical_width(params), ak4458->slot_width);
 	int nfs1;
 	u8 format;
@@ -290,7 +290,7 @@ static int ak4458_hw_params(struct snd_pcm_substream *substream,
 	ak4458->fs = nfs1;
 
 	/* Master Clock Frequency Auto Setting Mode Enable */
-	snd_soc_update_bits(codec, AK4458_00_CONTROL1, 0x80, 0x80);
+	snd_soc_component_update_bits(component, AK4458_00_CONTROL1, 0x80, 0x80);
 
 	switch (pcm_width) {
 	case 16:
@@ -321,19 +321,19 @@ static int ak4458_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, AK4458_00_CONTROL1,
+	snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
 			    AK4458_DIF_MASK, format);
 
-	ak4458_rstn_control(codec, 0);
-	ak4458_rstn_control(codec, 1);
+	ak4458_rstn_control(component, 0);
+	ak4458_rstn_control(component, 1);
 
 	return 0;
 }
 
 static int ak4458_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS: /* Slave Mode */
@@ -342,7 +342,7 @@ static int ak4458_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_CBS_CFM:
 	case SND_SOC_DAIFMT_CBM_CFS:
 	default:
-		dev_err(codec->dev, "Master mode unsupported\n");
+		dev_err(component->dev, "Master mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -354,13 +354,13 @@ static int ak4458_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		ak4458->fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 		break;
 	default:
-		dev_err(codec->dev, "Audio format 0x%02X unsupported\n",
+		dev_err(component->dev, "Audio format 0x%02X unsupported\n",
 			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
 		return -EINVAL;
 	}
 
-	ak4458_rstn_control(codec, 0);
-	ak4458_rstn_control(codec, 1);
+	ak4458_rstn_control(component, 0);
+	ak4458_rstn_control(component, 1);
 
 	return 0;
 }
@@ -369,27 +369,27 @@ static const int att_speed[] = { 4080, 2040, 510, 255 };
 
 static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 	int nfs, ndt, ret, reg;
 	int ats;
 
 	nfs = ak4458->fs;
 
-	reg = snd_soc_read(codec, AK4458_0B_CONTROL7);
+	reg = snd_soc_component_read32(component, AK4458_0B_CONTROL7);
 	ats = (reg & AK4458_ATS_MASK) >> AK4458_ATS_SHIFT;
 
 	ndt = att_speed[ats] / (nfs / 1000);
 
 	if (mute) {
-		ret = snd_soc_update_bits(codec, AK4458_01_CONTROL2,  0x01, 1);
+		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2,  0x01, 1);
 		mdelay(ndt);
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 	} else {
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
-		ret = snd_soc_update_bits(codec, AK4458_01_CONTROL2, 0x01, 0);
+		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2, 0x01, 0);
 		mdelay(ndt);
 	}
 
@@ -399,8 +399,8 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 static int ak4458_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots, int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 	int mode;
 
 	ak4458->slots = slots;
@@ -421,7 +421,7 @@ static int ak4458_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		break;
 	}
 
-	snd_soc_update_bits(codec, AK4458_0A_CONTROL6,
+	snd_soc_component_update_bits(component, AK4458_0A_CONTROL6,
 			    AK4458_MODE_MASK,
 			    mode);
 
@@ -493,9 +493,9 @@ static void ak4458_power_on(struct ak4458_priv *ak4458)
 	}
 }
 
-static void ak4458_init(struct snd_soc_codec *codec)
+static void ak4458_init(struct snd_soc_component *component)
 {
-	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 
 	/* External Mute ON */
 	if (ak4458->mute_gpiod)
@@ -503,30 +503,28 @@ static void ak4458_init(struct snd_soc_codec *codec)
 
 	ak4458_power_on(ak4458);
 
-	snd_soc_update_bits(codec, AK4458_00_CONTROL1,
+	snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
 			    0x80, 0x80);   /* ACKS bit = 1; 10000000 */
 
-	ak4458_rstn_control(codec, 1);
+	ak4458_rstn_control(component, 1);
 }
 
-static int ak4458_probe(struct snd_soc_codec *codec)
+static int ak4458_probe(struct snd_soc_component *component)
 {
-	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 
-	ak4458_init(codec);
+	ak4458_init(component);
 
 	ak4458->fs = 48000;
 
 	return 0;
 }
 
-static int ak4458_remove(struct snd_soc_codec *codec)
+static void ak4458_remove(struct snd_soc_component *component)
 {
-	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 
 	ak4458_power_off(ak4458);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -561,17 +559,19 @@ static int __maybe_unused ak4458_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
-struct snd_soc_codec_driver soc_codec_dev_ak4458 = {
-	.probe = ak4458_probe,
-	.remove = ak4458_remove,
-	.component_driver = {
-		.controls = ak4458_snd_controls,
-		.num_controls = ARRAY_SIZE(ak4458_snd_controls),
-		.dapm_widgets = ak4458_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(ak4458_dapm_widgets),
-		.dapm_routes = ak4458_intercon,
-		.num_dapm_routes = ARRAY_SIZE(ak4458_intercon),
-	},
+struct snd_soc_component_driver soc_codec_dev_ak4458 = {
+	.probe			= ak4458_probe,
+	.remove			= ak4458_remove,
+	.controls		= ak4458_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4458_snd_controls),
+	.dapm_widgets		= ak4458_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak4458_dapm_widgets),
+	.dapm_routes		= ak4458_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(ak4458_intercon),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config ak4458_regmap = {
@@ -616,7 +616,7 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(ak4458->mute_gpiod))
 		return PTR_ERR(ak4458->mute_gpiod);
 
-	ret = snd_soc_register_codec(ak4458->dev, &soc_codec_dev_ak4458,
+	ret = devm_snd_soc_register_component(ak4458->dev, &soc_codec_dev_ak4458,
 				     &ak4458_dai, 1);
 	if (ret < 0) {
 		dev_err(ak4458->dev, "Failed to register CODEC: %d\n", ret);
@@ -630,7 +630,6 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 
 static int ak4458_i2c_remove(struct i2c_client *i2c)
 {
-	snd_soc_unregister_codec(&i2c->dev);
 	pm_runtime_disable(&i2c->dev);
 
 	return 0;
-- 
2.16.1
