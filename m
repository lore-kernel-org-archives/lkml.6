Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965395AbeBMRDf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:03:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36780 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965497AbeBMRBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:44 -0500
X-Google-Smtp-Source: AH8x227rPxzo4LVweqxqM+AFuaJJqyDFpHA6sAxou7pWYtwpCt8Z1SZ9m5wEc9k3+mTSgicTXeBsdg==
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
Subject: [PATCH v3 21/25] ASoC: qcom: q6afe-dai: add support to 4 MI2S ports
Date: Tue, 13 Feb 2018 16:58:33 +0000
Message-Id: <20180213165837.1620-22-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to 4 MI2S dais supported on LPASS IP.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 154 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 39badb701be0..b6db1ae654e8 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -139,6 +139,31 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int q6i2s_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
+	struct q6afe_i2s_cfg *i2s = &dai_data->port_config[dai->id].i2s_cfg;
+
+
+	i2s->sample_rate = params_rate(params);
+	i2s->bit_width = params_width(params);
+	i2s->num_channels = params_channels(params);
+
+	return 0;
+}
+
+static int q6i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
+	struct q6afe_i2s_cfg *i2s = &dai_data->port_config[dai->id].i2s_cfg;
+
+	i2s->fmt = fmt;
+
+	return 0;
+}
+
 static int q6afe_dai_startup(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
@@ -163,6 +188,34 @@ static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
 
 }
 
+static int q6afe_mi2s_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
+	int rc;
+
+	if (dai_data->is_port_started[dai->id]) {
+		/* stop the port and restart with new port config */
+		rc = q6afe_port_stop(dai_data->port[dai->id]);
+		if (rc < 0) {
+			dev_err(dai->dev, "fail to close AFE port\n");
+			return rc;
+		}
+	}
+
+	q6afe_i2s_port_prepare(dai_data->port[dai->id],
+			       &dai_data->port_config[dai->id].i2s_cfg);
+
+	rc = q6afe_port_start(dai_data->port[dai->id]);
+	if (rc < 0) {
+		dev_err(dai->dev, "fail to start AFE port %x\n", dai->id);
+		return rc;
+	}
+	dai_data->is_port_started[dai->id] = true;
+
+	return 0;
+}
+
 static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -224,6 +277,26 @@ static int q6slim_set_channel_map(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
+	struct q6afe_port *port = dai_data->port[dai->id];
+
+	switch (clk_id) {
+	case LPAIF_DIG_CLK:
+		return q6afe_port_set_sysclk(port, clk_id, 0, 5, freq, dir);
+	case LPAIF_BIT_CLK:
+	case LPAIF_OSR_CLK:
+		return q6afe_port_set_sysclk(port, clk_id,
+					     Q6AFE_LPASS_CLK_SRC_INTERNAL,
+					     Q6AFE_LPASS_CLK_ROOT_DEFAULT,
+					     freq, dir);
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"HDMI Playback", NULL, "HDMI_RX"},
 	{"Slimbus1 Playback", NULL, "SLIMBUS_1_RX"},
@@ -233,6 +306,10 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"Slimbus5 Playback", NULL, "SLIMBUS_5_RX"},
 	{"Slimbus6 Playback", NULL, "SLIMBUS_6_RX"},
 
+	{"Primary MI2S Playback", NULL, "PRI_MI2S_RX"},
+	{"Secondary MI2S Playback", NULL, "SEC_MI2S_RX"},
+	{"Tertiary MI2S Playback", NULL, "TERT_MI2S_RX"},
+	{"Quaternary MI2S Playback", NULL, "QUAT_MI2S_RX"},
 };
 
 static struct snd_soc_dai_ops q6hdmi_ops = {
@@ -242,6 +319,15 @@ static struct snd_soc_dai_ops q6hdmi_ops = {
 	.startup	= q6afe_dai_startup,
 };
 
+static struct snd_soc_dai_ops q6i2s_ops = {
+	.prepare	= q6afe_mi2s_prepare,
+	.hw_params	= q6i2s_hw_params,
+	.set_fmt	= q6i2s_set_fmt,
+	.shutdown	= q6afe_dai_shutdown,
+	.startup	= q6afe_dai_startup,
+	.set_sysclk	= q6afe_mi2s_set_sysclk,
+};
+
 static struct snd_soc_dai_ops q6slim_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6slim_hw_params,
@@ -422,6 +508,63 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_6_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Primary MI2S Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+			SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.id = PRIMARY_MI2S_RX,
+		.name = "PRI_MI2S_RX",
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Secondary MI2S Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+			SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.name = "SEC_MI2S_RX",
+		.id = SECONDARY_MI2S_RX,
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Tertiary MI2S Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+			SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.name = "TERT_MI2S_RX",
+		.id = TERTIARY_MI2S_RX,
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Quaternary MI2S Playback",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+			SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min =     8000,
+			.rate_max =     48000,
+		},
+		.name = "QUAT_MI2S_RX",
+		.id = QUATERNARY_MI2S_RX,
+		.ops = &q6i2s_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
 	},
 };
 
@@ -452,6 +595,17 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_RX", "Slimbus4 Playback", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_RX", "Slimbus5 Playback", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_RX", "Slimbus6 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_RX", "Quaternary MI2S Playback",
+						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TERT_MI2S_RX", "Tertiary MI2S Playback",
+						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_RX", "Secondary MI2S Playback",
+			     0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_RX_SD1",
+			"Secondary MI2S Playback SD1",
+			0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("PRI_MI2S_RX", "Primary MI2S Playback",
+			     0, 0, 0, 0),
 };
 
 static const struct snd_soc_component_driver q6afe_dai_component = {
-- 
2.15.1
