Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965566AbeBMREq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:04:46 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55549 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965478AbeBMRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:39 -0500
X-Google-Smtp-Source: AH8x225lqSXvH/+rw12ISd0aF4HP4lvapNieXrKcEOpAYDXsB/DpO9RdOAN4sMBy0uLH1yuXEAhYjg==
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
Subject: [PATCH v3 17/25] ASoC: qcom: q6afe-dai: add support to slim afe dais
Date: Tue, 13 Feb 2018 16:58:29 +0000
Message-Id: <20180213165837.1620-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to SLIMBus AFE backend dais.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 211 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index f6a618e9db9e..39badb701be0 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -59,6 +59,37 @@ static const struct snd_kcontrol_new q6afe_config_controls[] = {
 				 q6hdmi_format_put),
 };
 
+static int q6slim_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+
+	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
+	struct q6afe_slim_cfg *slim = &dai_data->port_config[dai->id].slim;
+
+	slim->num_channels = params_channels(params);
+	slim->sample_rate = params_rate(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_SPECIAL:
+		slim->bit_width = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		slim->bit_width = 24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		slim->bit_width = 32;
+		break;
+	default:
+		pr_err("%s: format %d\n",
+			__func__, params_format(params));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -150,6 +181,9 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 	if (dai->id == AFE_PORT_HDMI_RX)
 		q6afe_hdmi_port_prepare(dai_data->port[dai->id],
 					&dai_data->port_config[dai->id].hdmi);
+	else if (dai->id >= SLIMBUS_0_RX && dai->id <= SLIMBUS_6_TX)
+		q6afe_slim_port_prepare(dai_data->port[dai->id],
+					&dai_data->port_config[dai->id].slim);
 
 	rc = q6afe_port_start(dai_data->port[dai->id]);
 	if (rc < 0) {
@@ -161,8 +195,44 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int q6slim_set_channel_map(struct snd_soc_dai *dai,
+				unsigned int tx_num, unsigned int *tx_slot,
+				unsigned int rx_num, unsigned int *rx_slot)
+{
+	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
+	struct q6afe_port_config *pcfg = &dai_data->port_config[dai->id];
+	int i;
+
+	if (!rx_slot) {
+		pr_err("%s: rx slot not found\n", __func__);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < rx_num; i++) {
+		pcfg->slim.ch_mapping[i] =   rx_slot[i];
+		pr_debug("%s: find number of channels[%d] ch[%d]\n",
+		       __func__, i, rx_slot[i]);
+	}
+
+	pcfg->slim.num_channels = rx_num;
+
+	pr_debug("%s: SLIMBUS_%d_RX cnt[%d] ch[%d %d]\n", __func__,
+		(dai->id - SLIMBUS_0_RX) / 2, rx_num,
+		pcfg->slim.ch_mapping[0],
+		pcfg->slim.ch_mapping[1]);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"HDMI Playback", NULL, "HDMI_RX"},
+	{"Slimbus1 Playback", NULL, "SLIMBUS_1_RX"},
+	{"Slimbus2 Playback", NULL, "SLIMBUS_2_RX"},
+	{"Slimbus3 Playback", NULL, "SLIMBUS_3_RX"},
+	{"Slimbus4 Playback", NULL, "SLIMBUS_4_RX"},
+	{"Slimbus5 Playback", NULL, "SLIMBUS_5_RX"},
+	{"Slimbus6 Playback", NULL, "SLIMBUS_6_RX"},
+
 };
 
 static struct snd_soc_dai_ops q6hdmi_ops = {
@@ -172,6 +242,14 @@ static struct snd_soc_dai_ops q6hdmi_ops = {
 	.startup	= q6afe_dai_startup,
 };
 
+static struct snd_soc_dai_ops q6slim_ops = {
+	.prepare	= q6afe_dai_prepare,
+	.hw_params	= q6slim_hw_params,
+	.shutdown	= q6afe_dai_shutdown,
+	.startup	= q6afe_dai_startup,
+	.set_channel_map = q6slim_set_channel_map,
+};
+
 static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
 {
 	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
@@ -218,6 +296,132 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.name = "HDMI",
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.name = "SLIMBUS_0_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_0_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.playback = {
+			.stream_name = "Slimbus Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+	}, {
+		.playback = {
+			.stream_name = "Slimbus1 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_1_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_1_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus2 Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_2_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_2_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus3 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_3_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_3_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus4 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_4_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_4_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus5 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			 SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.name = "SLIMBUS_5_RX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_5_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Slimbus6 Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_192000 | SNDRV_PCM_RATE_44100,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
+		.ops = &q6slim_ops,
+		.name = "SLIMBUS_6_RX",
+		.id = SLIMBUS_6_RX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
 	},
 };
 
@@ -241,6 +445,13 @@ static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
 
 static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("HDMI_RX", "HDMI Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_0_RX", "Slimbus Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_1_RX", "Slimbus1 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_2_RX", "Slimbus2 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_3_RX", "Slimbus3 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_RX", "Slimbus4 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_RX", "Slimbus5 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_RX", "Slimbus6 Playback", 0, 0, 0, 0),
 };
 
 static const struct snd_soc_component_driver q6afe_dai_component = {
-- 
2.15.1
