Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030284AbeBNN3I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:29:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34914 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030225AbeBNN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:29:04 -0500
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, jcsing.lee@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: Add support for HDMI audio on TM2 board" to the asoc tree
In-Reply-To: <20180212161538.22669-7-s.nawrocki@samsung.com>
Message-Id: <E1elx7O-0006on-2n@debutante>
Date: Wed, 14 Feb 2018 13:29:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: Add support for HDMI audio on TM2 board

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

>From 8d1513cef51a11dcf8ccb89d089515483a5ad397 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 12 Feb 2018 17:15:37 +0100
Subject: [PATCH] ASoC: samsung: Add support for HDMI audio on TM2 board

This patch defines I2S1 - HDMI DAI link and implements related
hw_params callback. The AUD PLL frequency is configured through
the CLK_SCLK_I2S1 leaf clock, the exynos5433 clock tree
definitions are updated in a separate patch.

The device tree parsing part is changed is a way it supports older
DTBs with just a single CPU DAI specified, without the HDMI link.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/tm2_wm5110.c | 152 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 129 insertions(+), 23 deletions(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index a55d18703fe7..b6a492f1ec02 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -210,6 +210,59 @@ static struct snd_soc_ops tm2_aif2_ops = {
 	.hw_free = tm2_aif2_hw_free,
 };
 
+static int tm2_hdmi_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned int bfs;
+	int bitwidth, ret;
+
+	bitwidth = snd_pcm_format_width(params_format(params));
+	if (bitwidth < 0) {
+		dev_err(rtd->card->dev, "Invalid bit-width: %d\n", bitwidth);
+		return bitwidth;
+	}
+
+	switch (bitwidth) {
+	case 48:
+		bfs = 64;
+		break;
+	case 16:
+		bfs = 32;
+		break;
+	default:
+		dev_err(rtd->card->dev, "Unsupported bit-width: %d\n", bitwidth);
+		return -EINVAL;
+	}
+
+	switch (params_rate(params)) {
+	case 48000:
+	case 96000:
+	case 192000:
+		break;
+	default:
+		dev_err(rtd->card->dev, "Unsupported sample rate: %d\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_OPCLK,
+					0, SAMSUNG_I2S_OPCLK_PCLK);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, SAMSUNG_I2S_DIV_BCLK, bfs);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops tm2_hdmi_ops = {
+	.hw_params = tm2_hdmi_hw_params,
+};
+
 static int tm2_mic_bias(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
@@ -405,6 +458,12 @@ static struct snd_soc_dai_link tm2_dai_links[] = {
 		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM,
 		.ignore_suspend = 1,
+	}, {
+		.name		= "HDMI",
+		.stream_name	= "i2s1",
+		.ops		= &tm2_hdmi_ops,
+		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS,
 	}
 };
 
@@ -412,7 +471,6 @@ static struct snd_soc_card tm2_card = {
 	.owner			= THIS_MODULE,
 
 	.dai_link		= tm2_dai_links,
-	.num_links		= ARRAY_SIZE(tm2_dai_links),
 	.controls		= tm2_controls,
 	.num_controls		= ARRAY_SIZE(tm2_controls),
 	.dapm_widgets		= tm2_dapm_widgets,
@@ -426,11 +484,14 @@ static struct snd_soc_card tm2_card = {
 
 static int tm2_probe(struct platform_device *pdev)
 {
+	struct device_node *cpu_dai_node[2] = {};
+	struct device_node *codec_dai_node[2] = {};
+	const char *cells_name = NULL;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card = &tm2_card;
 	struct tm2_machine_priv *priv;
-	struct device_node *cpu_dai_node, *codec_dai_node;
-	int ret, i;
+	struct of_phandle_args args;
+	int num_codecs, ret, i;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -464,47 +525,92 @@ static int tm2_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	cpu_dai_node = of_parse_phandle(dev->of_node, "i2s-controller", 0);
-	if (!cpu_dai_node) {
-		dev_err(dev, "i2s-controllers property invalid or missing\n");
-		ret = -EINVAL;
-		goto amp_node_put;
+	num_codecs = of_count_phandle_with_args(dev->of_node, "audio-codec",
+						 NULL);
+
+	/* Skip the HDMI link if not specified in DT */
+	if (num_codecs > 1) {
+		card->num_links = ARRAY_SIZE(tm2_dai_links);
+		cells_name = "#sound-dai-cells";
+	} else {
+		card->num_links = ARRAY_SIZE(tm2_dai_links) - 1;
 	}
 
-	codec_dai_node = of_parse_phandle(dev->of_node, "audio-codec", 0);
-	if (!codec_dai_node) {
-		dev_err(dev, "audio-codec property invalid or missing\n");
-		ret = -EINVAL;
-		goto cpu_dai_node_put;
+	for (i = 0; i < num_codecs; i++) {
+		struct of_phandle_args args;
+
+		ret = of_parse_phandle_with_args(dev->of_node, "i2s-controller",
+						 cells_name, i, &args);
+		if (!args.np) {
+			dev_err(dev, "i2s-controller property parse error: %d\n", i);
+			ret = -EINVAL;
+			goto dai_node_put;
+		}
+		cpu_dai_node[i] = args.np;
+
+		codec_dai_node[i] = of_parse_phandle(dev->of_node,
+						     "audio-codec", i);
+		if (!codec_dai_node[i]) {
+			dev_err(dev, "audio-codec property parse error\n");
+			ret = -EINVAL;
+			goto dai_node_put;
+		}
 	}
 
+	/* Initialize WM5110 - I2S and HDMI - I2S1 DAI links */
 	for (i = 0; i < card->num_links; i++) {
+		unsigned int dai_index = 0; /* WM5110 */
+
 		card->dai_link[i].cpu_name = NULL;
 		card->dai_link[i].platform_name = NULL;
-		card->dai_link[i].codec_of_node = codec_dai_node;
-		card->dai_link[i].cpu_of_node = cpu_dai_node;
-		card->dai_link[i].platform_of_node = cpu_dai_node;
+
+		if (num_codecs > 1 && i == card->num_links - 1)
+			dai_index = 1; /* HDMI */
+
+		card->dai_link[i].codec_of_node = codec_dai_node[dai_index];
+		card->dai_link[i].cpu_of_node = cpu_dai_node[dai_index];
+		card->dai_link[i].platform_of_node = cpu_dai_node[dai_index];
+	}
+
+	if (num_codecs > 1) {
+		/* HDMI DAI link (I2S1) */
+		i = card->num_links - 1;
+
+		ret = of_parse_phandle_with_fixed_args(dev->of_node,
+						"audio-codec", 0, 1, &args);
+		if (ret) {
+			dev_err(dev, "audio-codec property parse error\n");
+			goto dai_node_put;
+		}
+
+		ret = snd_soc_get_dai_name(&args, &card->dai_link[i].codec_dai_name);
+		if (ret) {
+			dev_err(dev, "Unable to get codec_dai_name\n");
+			goto dai_node_put;
+		}
 	}
 
 	ret = devm_snd_soc_register_component(dev, &tm2_component,
 				tm2_ext_dai, ARRAY_SIZE(tm2_ext_dai));
 	if (ret < 0) {
 		dev_err(dev, "Failed to register component: %d\n", ret);
-		goto codec_dai_node_put;
+		goto dai_node_put;
 	}
 
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register card: %d\n", ret);
-		goto codec_dai_node_put;
+		goto dai_node_put;
+	}
+
+dai_node_put:
+	for (i = 0; i < num_codecs; i++) {
+		of_node_put(codec_dai_node[i]);
+		of_node_put(cpu_dai_node[i]);
 	}
 
-codec_dai_node_put:
-	of_node_put(codec_dai_node);
-cpu_dai_node_put:
-	of_node_put(cpu_dai_node);
-amp_node_put:
 	of_node_put(card->aux_dev[0].codec_of_node);
+
 	return ret;
 }
 
-- 
2.16.1
