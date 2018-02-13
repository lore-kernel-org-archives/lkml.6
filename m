Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965546AbeBMREE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:04:04 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42112 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965488AbeBMRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:43 -0500
X-Google-Smtp-Source: AH8x225/m3XTj6yQLcLwbFBC4vrkgtUGGg1WZg3Doi8cwfir60GxZizosKQD5MQeKCg+xF3OVlOH0g==
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
Subject: [PATCH v3 19/25] ASoC: qcom: q6afe: add support to MI2S ports
Date: Tue, 13 Feb 2018 16:58:31 +0000
Message-Id: <20180213165837.1620-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/dt-bindings/sound/qcom,q6afe.h |  10 +++
 sound/soc/qcom/qdsp6/q6afe.c           | 111 +++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h           |  10 +++
 3 files changed, 131 insertions(+)

diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
index e9004ee39f72..3cd862262369 100644
--- a/include/dt-bindings/sound/qcom,q6afe.h
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -16,6 +16,16 @@
 #define SLIMBUS_4_TX    24
 #define SLIMBUS_5_RX    25
 #define SLIMBUS_5_TX    26
+#define QUATERNARY_MI2S_RX	34
+#define QUATERNARY_MI2S_TX	35
+#define SECONDARY_MI2S_RX	36
+#define SECONDARY_MI2S_TX	37
+#define TERTIARY_MI2S_RX	38
+#define TERTIARY_MI2S_TX	39
+#define PRIMARY_MI2S_RX		40
+#define PRIMARY_MI2S_TX		41
+#define SECONDARY_PCM_RX	42
+#define SECONDARY_PCM_TX	43
 #define SLIMBUS_6_RX    45
 #define SLIMBUS_6_TX    46
 
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 637390f5421e..c04caea5481c 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -14,6 +14,10 @@
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/soc/qcom/apr.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include "q6dsp-errno.h"
 #include "q6afe.h"
 
@@ -28,6 +32,24 @@
 #define AFE_PARAM_ID_CDC_SLIMBUS_SLAVE_CFG 0x00010235
 
 #define AFE_PARAM_ID_SLIMBUS_CONFIG    0x00010212
+#define AFE_PARAM_ID_I2S_CONFIG	0x0001020D
+
+/* I2S config specific */
+#define AFE_API_VERSION_I2S_CONFIG	0x1
+#define AFE_PORT_I2S_SD0		0x1
+#define AFE_PORT_I2S_SD1		0x2
+#define AFE_PORT_I2S_SD2		0x3
+#define AFE_PORT_I2S_SD3		0x4
+#define AFE_PORT_I2S_QUAD01		0x5
+#define AFE_PORT_I2S_QUAD23		0x6
+#define AFE_PORT_I2S_6CHS		0x7
+#define AFE_PORT_I2S_8CHS		0x8
+#define AFE_PORT_I2S_MONO		0x0
+#define AFE_PORT_I2S_STEREO		0x1
+#define AFE_PORT_CONFIG_I2S_WS_SRC_EXTERNAL	0x0
+#define AFE_PORT_CONFIG_I2S_WS_SRC_INTERNAL	0x1
+#define AFE_LINEAR_PCM_DATA				0x0
+
 
 /* Port IDs */
 #define AFE_API_VERSION_HDMI_CONFIG	0x1
@@ -63,6 +85,14 @@
 #define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX      0x400c
 /* SLIMbus Tx port on channel 6. */
 #define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX      0x400d
+#define AFE_PORT_ID_PRIMARY_MI2S_RX         0x1000
+#define AFE_PORT_ID_PRIMARY_MI2S_TX         0x1001
+#define AFE_PORT_ID_SECONDARY_MI2S_RX       0x1002
+#define AFE_PORT_ID_SECONDARY_MI2S_TX       0x1003
+#define AFE_PORT_ID_TERTIARY_MI2S_RX        0x1004
+#define AFE_PORT_ID_TERTIARY_MI2S_TX        0x1005
+#define AFE_PORT_ID_QUATERNARY_MI2S_RX      0x1006
+#define AFE_PORT_ID_QUATERNARY_MI2S_TX      0x1007
 
 #define TIMEOUT_MS 1000
 #define AFE_CMD_RESP_AVAIL	0
@@ -161,10 +191,21 @@ struct afe_param_id_slimbus_cfg {
  */
 } __packed;
 
+struct afe_param_id_i2s_cfg {
+	u32	i2s_cfg_minor_version;
+	u16	bit_width;
+	u16	channel_mode;
+	u16	mono_stereo;
+	u16	ws_src;
+	u32	sample_rate;
+	u16	data_format;
+	u16	reserved;
+} __packed;
 
 union afe_port_config {
 	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
 	struct afe_param_id_slimbus_cfg           slim_cfg;
+	struct afe_param_id_i2s_cfg	i2s_cfg;
 } __packed;
 
 struct q6afe_port {
@@ -207,6 +248,14 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				SLIMBUS_4_RX, 1, 1},
 	[SLIMBUS_5_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX,
 				SLIMBUS_5_RX, 1, 1},
+	[QUATERNARY_MI2S_RX] = { AFE_PORT_ID_QUATERNARY_MI2S_RX,
+				QUATERNARY_MI2S_RX, 1, 1},
+	[SECONDARY_MI2S_RX] = { AFE_PORT_ID_SECONDARY_MI2S_RX,
+				SECONDARY_MI2S_RX, 1, 1},
+	[TERTIARY_MI2S_RX] = { AFE_PORT_ID_TERTIARY_MI2S_RX,
+				TERTIARY_MI2S_RX, 1, 1},
+	[PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
+				PRIMARY_MI2S_RX, 1, 1},
 	[SLIMBUS_6_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX,
 				SLIMBUS_6_RX, 1, 1},
 };
@@ -513,6 +562,61 @@ void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 }
 EXPORT_SYMBOL_GPL(q6afe_hdmi_port_prepare);
 
+/**
+ * q6afe_i2s_port_prepare() - Prepare i2s afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: I2S configuration for the afe port
+ *
+ */
+void q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+
+	pcfg->i2s_cfg.i2s_cfg_minor_version = AFE_API_VERSION_I2S_CONFIG;
+	pcfg->i2s_cfg.sample_rate = cfg->sample_rate;
+	pcfg->i2s_cfg.bit_width = cfg->bit_width;
+	pcfg->i2s_cfg.data_format = AFE_LINEAR_PCM_DATA;
+
+	switch (cfg->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		pcfg->i2s_cfg.ws_src = AFE_PORT_CONFIG_I2S_WS_SRC_INTERNAL;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* CPU is slave */
+		pcfg->i2s_cfg.ws_src = AFE_PORT_CONFIG_I2S_WS_SRC_EXTERNAL;
+		break;
+	default:
+		break;
+	}
+
+	switch (cfg->num_channels) {
+	case 1:
+			pcfg->i2s_cfg.mono_stereo = AFE_PORT_I2S_MONO;
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_SD0;
+		break;
+	case 2:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_SD0;
+			pcfg->i2s_cfg.mono_stereo = AFE_PORT_I2S_STEREO;
+		break;
+	case 3:
+	case 4:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_QUAD01;
+		break;
+	case 5:
+	case 6:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_6CHS;
+			break;
+	case 7:
+	case 8:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_8CHS;
+			break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(q6afe_i2s_port_prepare);
+
 /**
  * q6afe_port_start() - Start a afe port
  *
@@ -562,6 +666,13 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX:
 		cfg_type = AFE_PARAM_ID_SLIMBUS_CONFIG;
 		break;
+
+	case AFE_PORT_ID_PRIMARY_MI2S_RX:
+	case AFE_PORT_ID_SECONDARY_MI2S_RX:
+	case AFE_PORT_ID_TERTIARY_MI2S_RX:
+	case AFE_PORT_ID_QUATERNARY_MI2S_RX:
+		cfg_type = AFE_PARAM_ID_I2S_CONFIG;
+		break;
 	default:
 		dev_err(dev, "Invalid port id 0x%x\n", port_id);
 		return ERR_PTR(-EINVAL);
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index aeacf1f2c9a9..9114d68a79cb 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -29,9 +29,18 @@ struct q6afe_slim_cfg {
 	u8	ch_mapping[AFE_MAX_CHAN_COUNT];
 };
 
+struct q6afe_i2s_cfg {
+	u32	sample_rate;
+	u16	bit_width;
+	u16	data_format;
+	u16	num_channels;
+	int fmt;
+};
+
 struct q6afe_port_config {
 	struct q6afe_hdmi_cfg hdmi;
 	struct q6afe_slim_cfg slim;
+	struct q6afe_i2s_cfg i2s_cfg;
 };
 
 struct q6afe_port;
@@ -50,5 +59,6 @@ void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 			    struct q6afe_hdmi_cfg *cfg);
 void q6afe_slim_port_prepare(struct q6afe_port *port,
 			  struct q6afe_slim_cfg *cfg);
+void q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg);
 
 #endif /* __Q6AFE_H__ */
-- 
2.15.1
