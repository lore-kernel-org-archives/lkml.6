Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965554AbeBMRCY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:02:24 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39834 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965534AbeBMRBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:48 -0500
X-Google-Smtp-Source: AH8x2272KzC2bs6hxH9HsveGqUDGWKaXsdm+st6mtIrN8A38RadTkyGvkJC42p7oXnGNWg1mRchl1A==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
        spatakok@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 24/25] ASoC: qcom: apq8096: Add db820c machine driver
Date: Tue, 13 Feb 2018 16:58:36 +0000
Message-Id: <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to DB820c machine driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig   |   8 +++
 sound/soc/qcom/apq8096.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 sound/soc/qcom/apq8096.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8c2d65e0a28e..fa4b575c086c 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -77,3 +77,11 @@ config SND_SOC_QDSP6
 	 This will enable sound soc platform specific
 	 audio drivers. This includes q6asm, q6adm,
 	 q6afe interfaces to DSP using apr.
+
+config SND_SOC_MSM8996
+	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
+	depends on QCOM_APR
+	select SND_SOC_QDSP6V2
+	default n
+	help
+	 To add support for SoC audio on MSM8996 and APQ8096 boards
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
new file mode 100644
index 000000000000..b12d2398557a
--- /dev/null
+++ b/sound/soc/qcom/apq8096.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/soc/qcom/apr.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+
+static int msm8996_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+					      struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	return 0;
+}
+
+static int apq8096_sbc_parse_of(struct snd_soc_card *card)
+{
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *link;
+	struct device_node *np, *codec, *platform, *cpu, *node  = dev->of_node;
+	int ret, num_links;
+	bool is_fe;
+
+
+	ret = snd_soc_of_parse_card_name(card, "qcom,model");
+	if (ret)
+		dev_err(dev, "Error parsing card name: %d\n", ret);
+
+	if (of_property_read_bool(dev->of_node, "qcom,audio-routing"))
+		ret = snd_soc_of_parse_audio_routing(card,
+					"qcom,audio-routing");
+
+	/* Populate links */
+	num_links = of_get_child_count(node);
+
+	dev_info(dev, "Found %d child audio dai links..\n", num_links);
+	/* Allocate the private data and the DAI link array */
+	card->dai_link = devm_kzalloc(dev, sizeof(*link) * num_links,
+			    GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	card->num_links	= num_links;
+
+	link = card->dai_link;
+
+	for_each_child_of_node(node, np) {
+		is_fe = false;
+		if (of_property_read_bool(np, "is-fe"))
+			is_fe = true;
+
+		if (is_fe) {
+			/* BE is dummy */
+			link->codec_of_node	= NULL;
+			link->codec_dai_name	= "snd-soc-dummy-dai";
+			link->codec_name	= "snd-soc-dummy";
+
+			/* FE settings */
+			link->dynamic		= 1;
+			link->dpcm_playback = 1;
+
+		} else {
+			link->no_pcm = 1;
+			link->dpcm_playback = 1;
+			link->ignore_suspend = 1;
+			link->ignore_pmdown_time = 1;
+			link->be_hw_params_fixup = msm8996_be_hw_params_fixup;
+		}
+
+		cpu = of_get_child_by_name(np, "cpu");
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+
+		if (!cpu) {
+			dev_err(dev, "Can't find cpu DT node\n");
+			return -EINVAL;
+		}
+
+		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!link->cpu_of_node) {
+			dev_err(card->dev, "error getting cpu phandle\n");
+			return -EINVAL;
+		}
+
+		link->platform_of_node = of_parse_phandle(platform,
+							  "sound-dai", 0);
+		if (!link->platform_of_node) {
+			dev_err(card->dev, "error getting platform phandle\n");
+			return -EINVAL;
+		}
+
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
+		if (ret) {
+			dev_err(card->dev, "error getting cpu dai name\n");
+			return ret;
+		}
+
+		if (codec) {
+			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+
+			if (ret < 0) {
+				dev_err(card->dev, "error getting codec dai name\n");
+				return ret;
+			}
+		}
+
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			return ret;
+		}
+
+		link->stream_name = link->name;
+		link++;
+	}
+
+	return ret;
+}
+
+static int msm_snd_apq8096_probe(struct apr_device *adev)
+{
+	int ret;
+	struct snd_soc_card *card;
+
+	card = devm_kzalloc(&adev->dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	card->dev = &adev->dev;
+
+	ret = apq8096_sbc_parse_of(card);
+	if (ret) {
+		dev_err(&adev->dev, "Error parsing OF data\n");
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_card(&adev->dev, card);
+	if (ret)
+		dev_err(&adev->dev, "sound card register failed (%d)!\n", ret);
+	else
+		dev_err(&adev->dev, "sound card register Sucessfull\n");
+
+	return ret;
+}
+
+static const struct of_device_id msm_snd_apq8096_dt_match[] = {
+	{.compatible = "qcom,apq8096-sndcard"},
+	{}
+};
+
+static struct apr_driver msm_snd_apq8096_driver = {
+	.probe  = msm_snd_apq8096_probe,
+	.driver = {
+		.name = "msm-snd-apq8096",
+		.owner = THIS_MODULE,
+		.of_match_table = msm_snd_apq8096_dt_match,
+	},
+};
+module_apr_driver(msm_snd_apq8096_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("APQ8096 ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.15.1
