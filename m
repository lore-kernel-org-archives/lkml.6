Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176649; cv=none;
        d=google.com; s=arc-20160816;
        b=mkj8rFbEecUnZk5jiFfDnXf4OUEXhpfgj7yN/o80BNXIX+/lTllvolRlR/Og9XwmkB
         FGDH/ZKhj7w8sPRoNszr1HVZWMI5E+BzXPKItsygYpd67WErnQmDWVfrXnkIpX3LLLYV
         z0CCP2IfMZIWbPg2VjAgn84gyEKgI3s8dtdLtbnVUFL9E0YZPkLhZ06VghT6tInKGBy2
         5K7kTu5e4xDw9Z/V2utQ3H4/0hOtTD3owXAMWONF8qwoKk54RKrNyoQ0CkMiQEfGtsN8
         w5nKMPuDvl99hBH938q3JQDc3+S47incOf939MeMTYmE3L9LvXBeHmztzULNP4hhw93O
         PPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gYxErC7EynVOB04k6PsXUnLD0F7Y5fjTdHA0ZAdGkp8=;
        b=rIzfifhoUaujwpeU0L69QHJgfACOuHVsOVWvb5/1gHRTljTseUH6vZuyzxKocTujY3
         6SMIUu+ZriAU9RCXb1ylPpQ94O3dIqFs9ru+OBDWevLH5WRU4L+yBK0Oak1GgD4I/jUi
         MQJjosL2kYMDZlElww4Xx7mjvt7RlG97e4IHyZMFxqLqXnAhrouvH5pDlGcdEDKp2HlB
         nz2uFT1H+jSu/Ph9RmiDtO8P7gVLnnKcKWdbsqquxq5+or3MmsmYq2/YM91TwCTSFYSt
         YA6xKTO2d64Ilja4neHnK5NrQAwBkbcNNkFR4zK/TegtDE13bEkxfPbPP6ZP2NCaVeJP
         xgsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YEltdecd;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YEltdecd;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr7a+yKiyE9fXWBer9JwJAQT4FEZVLbhS+v7RqBKo4bKAndb9bEm55k3J4Twb1bMrhVlQX/UQ==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org,
	bgoswami@codeaurora.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 17/24] ASoC: qdsp6: q6routing: Add q6routing driver
Date: Tue,  1 May 2018 13:08:13 +0100
Message-Id: <20180501120820.11016-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263630375020957?=
X-GMAIL-MSGID: =?utf-8?q?1599263630375020957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to q6 routing driver which configures route
between ASM and AFE module using ADM apis.

This driver uses dapm widgets to setup the matrix between AFE ports and
ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig           |   4 +
 sound/soc/qcom/qdsp6/Makefile    |   1 +
 sound/soc/qcom/qdsp6/q6routing.c | 393 +++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6routing.h |   9 +
 4 files changed, 407 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 941774abd94f..43f9ed85efa8 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -53,6 +53,9 @@ config SND_SOC_QDSP6_AFE
 config SND_SOC_QDSP6_ADM
 	tristate
 
+config SND_SOC_QDSP6_ROUTING
+	tristate
+
 config SND_SOC_QDSP6_ASM
 	tristate
 
@@ -63,6 +66,7 @@ config SND_SOC_QDSP6
 	select SND_SOC_QDSP6_CORE
 	select SND_SOC_QDSP6_AFE
 	select SND_SOC_QDSP6_ADM
+	select SND_SOC_QDSP6_ROUTING
 	select SND_SOC_QDSP6_ASM
 	help
 	 To add support for MSM QDSP6 Soc Audio.
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 01d9dcf3375c..0e8e2febb7ec 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
 obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
+obj-$(CONFIG_SND_SOC_QDSP6_ROUTING) += q6routing.o
 obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
new file mode 100644
index 000000000000..72863672f11f
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/bitops.h>
+#include <linux/component.h>
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
+#define DRV_NAME "q6routing-component"
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
+	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
+	struct msm_routing_data *priv = dev_get_drvdata(c->dev);
+	struct session_data *session = &priv->sessions[session_id];
+
+	if (session->port_id == mc->reg)
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
+	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
+	struct msm_routing_data *data = dev_get_drvdata(c->dev);
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
+	SOC_SINGLE_EXT("MultiMedia1", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", HDMI_RX,
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
+	SND_SOC_DAPM_AIF_OUT("MM_UL1", "MultiMedia1 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL2", "MultiMedia2 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL3", "MultiMedia3 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL4", "MultiMedia4 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL5", "MultiMedia5 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL6", "MultiMedia6 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL7", "MultiMedia7 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("MM_UL8", "MultiMedia8 Capture", 0, 0, 0, 0),
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
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct msm_routing_data *data = dev_get_drvdata(c->dev);
+	unsigned int be_id = rtd->cpu_dai->id;
+	struct session_data *session;
+	int path_type;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		path_type = ADM_PATH_PLAYBACK;
+	else
+		path_type = ADM_PATH_LIVE_REC;
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
+static int msm_routing_probe(struct snd_soc_component *c)
+{
+	int i;
+
+	for (i = 0; i < MAX_SESSIONS; i++)
+		routing_data->sessions[i].port_id = -1;
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver msm_soc_routing_component = {
+	.ops = &q6pcm_routing_ops,
+	.probe = msm_routing_probe,
+	.name = DRV_NAME,
+	.dapm_widgets = msm_qdsp6_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(msm_qdsp6_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
+};
+
+static int q6routing_dai_bind(struct device *dev, struct device *master,
+			      void *data)
+{
+	routing_data = kzalloc(sizeof(*routing_data), GFP_KERNEL);
+	if (!routing_data)
+		return -ENOMEM;
+
+	routing_data->dev = dev;
+
+	mutex_init(&routing_data->lock);
+	dev_set_drvdata(dev, routing_data);
+
+	return snd_soc_register_component(dev, &msm_soc_routing_component,
+					  NULL, 0);
+}
+
+static void q6routing_dai_unbind(struct device *dev, struct device *master,
+				 void *d)
+{
+	struct msm_routing_data *data = dev_get_drvdata(dev);
+
+	snd_soc_unregister_component(dev);
+
+	kfree(data);
+
+	routing_data = NULL;
+}
+
+static const struct component_ops q6routing_dai_comp_ops = {
+	.bind   = q6routing_dai_bind,
+	.unbind = q6routing_dai_unbind,
+};
+
+static int q6pcm_routing_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &q6routing_dai_comp_ops);
+}
+
+static int q6pcm_routing_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &q6routing_dai_comp_ops);
+	return 0;
+}
+
+static struct platform_driver q6pcm_routing_platform_driver = {
+	.driver = {
+		.name = "q6routing",
+	},
+	.probe = q6pcm_routing_probe,
+	.remove = q6pcm_routing_remove,
+};
+module_platform_driver(q6pcm_routing_platform_driver);
+
+MODULE_DESCRIPTION("Q6 Routing platform");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6routing.h b/sound/soc/qcom/qdsp6/q6routing.h
new file mode 100644
index 000000000000..35514e651130
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6routing.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _Q6_PCM_ROUTING_H
+#define _Q6_PCM_ROUTING_H
+
+int q6routing_stream_open(int fedai_id, int perf_mode,
+			   int stream_id, int stream_type);
+void q6routing_stream_close(int fedai_id, int stream_type);
+
+#endif /*_Q6_PCM_ROUTING_H */
-- 
2.16.2
