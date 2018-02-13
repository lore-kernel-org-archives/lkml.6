Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965591AbeBMRFj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:05:39 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43038 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965472AbeBMRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:34 -0500
X-Google-Smtp-Source: AH8x224zQkILJvzwJ0Si7tfjhDLg2xD57zrZ3qNLgbJfIsszQaXSJvoBDTxr6l4xtc/Ih0BgruOJTA==
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
Subject: [PATCH v3 13/25] ASoC: qcom: qdsp6: Add support to q6routing driver
Date: Tue, 13 Feb 2018 16:58:25 +0000
Message-Id: <20180213165837.1620-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to q6 routing driver which configures route
between ASM and AFE module using ADM apis.

This driver uses dapm widgets to setup the matrix between AFE ports and
ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/Makefile    |   2 +-
 sound/soc/qcom/qdsp6/q6adm.h     |   3 +
 sound/soc/qcom/qdsp6/q6routing.c | 355 +++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6routing.h |   9 +
 4 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.h

diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 61f089bc0d25..660afcab98fd 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
-obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
+obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o q6routing.o
 obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
 obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
diff --git a/sound/soc/qcom/qdsp6/q6adm.h b/sound/soc/qcom/qdsp6/q6adm.h
index 8f89210e2fcf..270cb9c0133a 100644
--- a/sound/soc/qcom/qdsp6/q6adm.h
+++ b/sound/soc/qcom/qdsp6/q6adm.h
@@ -14,6 +14,9 @@ struct route_payload {
 	int port_id[MAX_COPPS_PER_PORT];
 };
 
+int q6pcm_routing_probe(struct device *dev);
+int q6pcm_routing_remove(struct device *dev);
+
 void *q6adm_get_routing_data(struct device *dev);
 void q6adm_set_routing_data(struct device *dev, void *data);
 int q6adm_open(struct device *dev, int port_id, int path, int rate,
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
new file mode 100644
index 000000000000..828243c58569
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2017, The Linux Foundation
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/bitops.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/control.h>
+#include <sound/asound.h>
+#include <sound/pcm_params.h>
+#include "q6afe.h"
+#include "q6asm.h"
+#include "q6adm.h"
+#include "q6routing.h"
+
+struct session_data {
+	int state;
+	int port_id;
+	int path_type;
+	int app_type;
+	int acdb_id;
+	int sample_rate;
+	int bits_per_sample;
+	int channels;
+	int perf_mode;
+	int numcopps;
+	int fedai_id;
+	unsigned long copp_map;
+};
+
+struct msm_routing_data {
+	struct session_data sessions[MAX_SESSIONS];
+	struct session_data port_data[AFE_MAX_PORTS];
+	struct device *dev;
+	struct mutex lock;
+};
+
+static struct msm_routing_data *routing_data;
+
+/**
+ * q6routing_stream_open() - Register a new stream for route setup
+ *
+ * @fedai_id: Frontend dai id.
+ * @perf_mode: Performance mode.
+ * @stream_id: ASM stream id to map.
+ * @stream_type: Direction of stream
+ *
+ * Return: Will be an negative on error or a zero on success.
+ */
+int q6routing_stream_open(int fedai_id, int perf_mode,
+			   int stream_id, int stream_type)
+{
+	int j, topology, num_copps = 0;
+	struct route_payload payload;
+	int copp_idx;
+	struct session_data *session, *pdata;
+
+	if (!routing_data) {
+		pr_err("Routing driver not yet ready\n");
+		return -EINVAL;
+	}
+
+	session = &routing_data->sessions[stream_id - 1];
+	pdata = &routing_data->port_data[session->port_id];
+
+	mutex_lock(&routing_data->lock);
+	session->fedai_id = fedai_id;
+
+	session->path_type = pdata->path_type;
+	session->sample_rate = pdata->sample_rate;
+	session->channels = pdata->channels;
+	session->bits_per_sample = pdata->bits_per_sample;
+
+	payload.num_copps = 0; /* only RX needs to use payload */
+	topology = NULL_COPP_TOPOLOGY;
+	copp_idx = q6adm_open(routing_data->dev, session->port_id,
+			      session->path_type, session->sample_rate,
+			      session->channels, topology, perf_mode,
+			      session->bits_per_sample, 0, 0);
+
+	if (copp_idx < 0) {
+		mutex_unlock(&routing_data->lock);
+		return -EINVAL;
+	}
+
+	set_bit(copp_idx, &session->copp_map);
+
+	for_each_set_bit(j, &session->copp_map, MAX_COPPS_PER_PORT) {
+		payload.port_id[num_copps] = session->port_id;
+		payload.copp_idx[num_copps] = j;
+		num_copps++;
+	}
+
+	if (num_copps) {
+		payload.num_copps = num_copps;
+		payload.session_id = stream_id;
+		q6adm_matrix_map(routing_data->dev, session->path_type,
+				 payload, perf_mode);
+	}
+	mutex_unlock(&routing_data->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6routing_stream_open);
+
+static struct session_data *get_session_from_id(struct msm_routing_data *data,
+						int fedai_id)
+{
+	int i;
+
+	for (i = 0; i < MAX_SESSIONS; i++) {
+		if (fedai_id == data->sessions[i].fedai_id)
+			return &data->sessions[i];
+	}
+
+	return NULL;
+}
+/**
+ * q6routing_stream_close() - Deregister a stream
+ *
+ * @fedai_id: Frontend dai id.
+ * @stream_type: Direction of stream
+ *
+ * Return: Will be an negative on error or a zero on success.
+ */
+void q6routing_stream_close(int fedai_id, int stream_type)
+{
+	struct session_data *session;
+	int idx;
+
+	session = get_session_from_id(routing_data, fedai_id);
+	if (!session)
+		return;
+
+	for_each_set_bit(idx, &session->copp_map, MAX_COPPS_PER_PORT)
+		q6adm_close(routing_data->dev, session->port_id,
+			    session->perf_mode, idx);
+
+	session->fedai_id = -1;
+	session->copp_map = 0;
+}
+EXPORT_SYMBOL_GPL(q6routing_stream_close);
+
+static int msm_routing_get_audio_mixer(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm =
+	    snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+	int session_id = mc->shift;
+	struct snd_soc_platform *platform = snd_soc_dapm_to_platform(dapm);
+	struct msm_routing_data *priv = q6adm_get_routing_data(platform->dev);
+	struct session_data *session = &priv->sessions[session_id];
+
+	if (session->port_id != -1)
+		ucontrol->value.integer.value[0] = 1;
+	else
+		ucontrol->value.integer.value[0] = 0;
+
+	return 0;
+}
+
+static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm =
+				    snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_platform *platform = snd_soc_dapm_to_platform(dapm);
+	struct msm_routing_data *data = q6adm_get_routing_data(platform->dev);
+	struct soc_mixer_control *mc =
+		    (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_dapm_update *update = NULL;
+	int be_id = mc->reg;
+	int session_id = mc->shift;
+	struct session_data *session = &data->sessions[session_id];
+
+	if (ucontrol->value.integer.value[0]) {
+		session->port_id = be_id;
+		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, update);
+	} else {
+		session->port_id = -1;
+		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, update);
+	}
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+};
+
+static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
+	/* Frontend AIF */
+	SND_SOC_DAPM_AIF_IN("MM_DL1", "MultiMedia1 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL2", "MultiMedia2 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL3", "MultiMedia3 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL4", "MultiMedia4 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL5", "MultiMedia5 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL6", "MultiMedia6 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL7", "MultiMedia7 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL8", "MultiMedia8 Playback", 0, 0, 0, 0),
+
+	/* Mixer definitions */
+	SND_SOC_DAPM_MIXER("HDMI Mixer", SND_SOC_NOPM, 0, 0,
+			   hdmi_mixer_controls,
+			   ARRAY_SIZE(hdmi_mixer_controls)),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{"HDMI Mixer", "MultiMedia1", "MM_DL1"},
+	{"HDMI Mixer", "MultiMedia2", "MM_DL2"},
+	{"HDMI Mixer", "MultiMedia3", "MM_DL3"},
+	{"HDMI Mixer", "MultiMedia4", "MM_DL4"},
+	{"HDMI Mixer", "MultiMedia5", "MM_DL5"},
+	{"HDMI Mixer", "MultiMedia6", "MM_DL6"},
+	{"HDMI Mixer", "MultiMedia7", "MM_DL7"},
+	{"HDMI Mixer", "MultiMedia8", "MM_DL8"},
+	{"HDMI_RX", NULL, "HDMI Mixer"},
+};
+
+static int routing_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned int be_id = rtd->cpu_dai->id;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct msm_routing_data *data = q6adm_get_routing_data(platform->dev);
+	struct session_data *session;
+	int path_type;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		path_type = ADM_PATH_PLAYBACK;
+
+	if (be_id > AFE_MAX_PORTS)
+		return -EINVAL;
+
+	session = &data->port_data[be_id];
+
+	mutex_lock(&data->lock);
+
+	session->path_type = path_type;
+	session->sample_rate = params_rate(params);
+	session->channels = params_channels(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+			session->bits_per_sample = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+			session->bits_per_sample = 24;
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&data->lock);
+	return 0;
+}
+
+static struct snd_pcm_ops q6pcm_routing_ops = {
+	.hw_params = routing_hw_params,
+};
+
+static int msm_routing_probe(struct snd_soc_platform *platform)
+{
+	int i;
+
+	for (i = 0; i < MAX_SESSIONS; i++)
+		routing_data->sessions[i].port_id = -1;
+
+	return 0;
+}
+
+static struct snd_soc_platform_driver msm_soc_routing_platform = {
+	.ops = &q6pcm_routing_ops,
+	.probe = msm_routing_probe,
+	.component_driver = {
+		.name		= "q6routing-component",
+		.dapm_widgets = msm_qdsp6_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(msm_qdsp6_widgets),
+		.dapm_routes = intercon,
+		.num_dapm_routes = ARRAY_SIZE(intercon),
+	},
+};
+
+int q6pcm_routing_probe(struct device *dev)
+{
+	routing_data = kzalloc(sizeof(*routing_data), GFP_KERNEL);
+	if (!routing_data)
+		return -ENOMEM;
+
+	routing_data->dev = dev;
+
+	mutex_init(&routing_data->lock);
+	q6adm_set_routing_data(dev, routing_data);
+
+	return devm_snd_soc_register_platform(dev,
+					      &msm_soc_routing_platform);
+}
+EXPORT_SYMBOL_GPL(q6pcm_routing_probe);
+
+int q6pcm_routing_remove(struct device *dev)
+{
+	kfree(routing_data);
+
+	routing_data = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6pcm_routing_remove);
+MODULE_DESCRIPTION("Q6 Routing platform");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6routing.h b/sound/soc/qcom/qdsp6/q6routing.h
new file mode 100644
index 000000000000..aa41e4f45742
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6routing.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _Q6_PCM_ROUTING_H
+#define _Q6_PCM_ROUTING_H
+
+int q6routing_stream_open(int fedai_id, int perf_mode,
+			   int stream_id, int stream_type);
+void q6routing_stream_close(int fedai_id, int stream_type);
+
+#endif /*_Q6_PCM_ROUTING_H */
-- 
2.15.1
