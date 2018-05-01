Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176639; cv=none;
        d=google.com; s=arc-20160816;
        b=IuKWTYurFHsUGzbGLkX9mOWKVb10vhbBWBrS6+3bIsLkbJEDHZAjPwvv2Uf00mUYo3
         2T7LBf7UJ5N0ASKMpHdpE3+BZyi/dWSWGQcNdGqqryRrrCVhz1CAHNlfM899jvKWPMdH
         hK+gY83PNzv2o99JzpF9t49YpcSArUxD4InBLuLyLn//LLsbgrSQ4JWwfewWjHKMnb3M
         2L2JY1FgpR752+aujvrsO3LoQlHQoCZSBXgCMTw1/XLLUO8LxEwqxB/vFTa4i7RAoaQ8
         hiRf98LaF/pEirsi/sK77kwyrrdgMguYiJhdygFkhllNEeA/1x2tfudum/yoqUqFmO4D
         rCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qypqWVFNNnH7yGiobOPnUnzcG3kw3sUOXeQ4A0R0RQg=;
        b=pofE2uOWaLeT2Ghq1PFNt8W5rh0u/OP0BwrhFIyYyY4nqyI2ZgLt6A+w6w2oElOzxh
         nqhx8XvYa8MDoKIs4QrQA0gvsHSsb0tIF25+DC7TWrWA7YXj83Za9s7/1zWs0ueKS8SA
         0FpLa8Aj1QjRX+kx6kJNxSj+zzD8kiDclM7T/Dm5igoV4VoTth0dtlWUNlCl8IjWVpVf
         N8v7wOTPjp6dOTz+ukr5Hh0rdXHxMARUMS9tUCgXUmCtRzI4yLKU2vMmL38thfJfX4G/
         iUzjal1UxNw6BZy2GdItE5S2Pmwius4n1R2FN6sPkiIbeHUMkgXlc0BrlheSHZtZdeBy
         8Daw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=E0x+HjOe;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=E0x+HjOe;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrpK+4Cks8QcIBCe1qdm9qqaQXqNKUxL3A3cyb5ZcKAHdoZNdELa4wyegzN+YQf1bd/8hzg5A==
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
Subject: [PATCH v7 10/24] ASoC: qdsp6: qdafe: Add SLIMBus port Support
Date: Tue,  1 May 2018 13:08:06 +0100
Message-Id: <20180501120820.11016-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263619730953069?=
X-GMAIL-MSGID: =?utf-8?q?1599263619730953069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to 6 SLIMBus AFE ports, which are used as
backend dais.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 129 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h |  14 +++++
 2 files changed, 143 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 635c51126dc3..be55b3ab045f 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -27,9 +27,45 @@
 #define AFE_PARAM_ID_HDMI_CONFIG	0x00010210
 #define AFE_MODULE_AUDIO_DEV_INTERFACE	0x0001020C
 
+#define AFE_PARAM_ID_CDC_SLIMBUS_SLAVE_CFG 0x00010235
+
+#define AFE_PARAM_ID_SLIMBUS_CONFIG    0x00010212
+
 /* Port IDs */
 #define AFE_API_VERSION_HDMI_CONFIG	0x1
 #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
+
+#define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
+
+/* SLIMbus Rx port on channel 0. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX      0x4000
+/* SLIMbus Tx port on channel 0. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX      0x4001
+/* SLIMbus Rx port on channel 1. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX      0x4002
+/* SLIMbus Tx port on channel 1. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX      0x4003
+/* SLIMbus Rx port on channel 2. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX      0x4004
+/* SLIMbus Tx port on channel 2. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX      0x4005
+/* SLIMbus Rx port on channel 3. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_RX      0x4006
+/* SLIMbus Tx port on channel 3. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX      0x4007
+/* SLIMbus Rx port on channel 4. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_RX      0x4008
+/* SLIMbus Tx port on channel 4. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX      0x4009
+/* SLIMbus Rx port on channel 5. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX      0x400a
+/* SLIMbus Tx port on channel 5. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX      0x400b
+/* SLIMbus Rx port on channel 6. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX      0x400c
+/* SLIMbus Tx port on channel 6. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX      0x400d
+
 #define TIMEOUT_MS 1000
 #define AFE_CMD_RESP_AVAIL	0
 #define AFE_CMD_RESP_NONE	1
@@ -80,8 +116,53 @@ struct afe_param_id_hdmi_multi_chan_audio_cfg {
 	u16 reserved;
 } __packed;
 
+struct afe_param_id_slimbus_cfg {
+	u32                  sb_cfg_minor_version;
+/* Minor version used for tracking the version of the SLIMBUS
+ * configuration interface.
+ * Supported values: #AFE_API_VERSION_SLIMBUS_CONFIG
+ */
+
+	u16                  slimbus_dev_id;
+/* SLIMbus hardware device ID, which is required to handle
+ * multiple SLIMbus hardware blocks.
+ * Supported values: - #AFE_SLIMBUS_DEVICE_1 - #AFE_SLIMBUS_DEVICE_2
+ */
+	u16                  bit_width;
+/* Bit width of the sample.
+ * Supported values: 16, 24
+ */
+	u16                  data_format;
+/* Data format supported by the SLIMbus hardware. The default is
+ * 0 (#AFE_SB_DATA_FORMAT_NOT_INDICATED), which indicates the
+ * hardware does not perform any format conversions before the data
+ * transfer.
+ */
+	u16                  num_channels;
+/* Number of channels.
+ * Supported values: 1 to #AFE_PORT_MAX_AUDIO_CHAN_CNT
+ */
+	u8  shared_ch_mapping[AFE_PORT_MAX_AUDIO_CHAN_CNT];
+/* Mapping of shared channel IDs (128 to 255) to which the
+ * master port is to be connected.
+ * Shared_channel_mapping[i] represents the shared channel assigned
+ * for audio channel i in multichannel audio data.
+ */
+	u32              sample_rate;
+/* Sampling rate of the port.
+ * Supported values:
+ * - #AFE_PORT_SAMPLE_RATE_8K
+ * - #AFE_PORT_SAMPLE_RATE_16K
+ * - #AFE_PORT_SAMPLE_RATE_48K
+ * - #AFE_PORT_SAMPLE_RATE_96K
+ * - #AFE_PORT_SAMPLE_RATE_192K
+ */
+} __packed;
+
+
 union afe_port_config {
 	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
+	struct afe_param_id_slimbus_cfg           slim_cfg;
 } __packed;
 
 struct q6afe_port {
@@ -117,6 +198,20 @@ struct afe_port_map {
 
 static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 	[HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX, HDMI_RX, 1, 1},
+	[SLIMBUS_0_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX,
+				SLIMBUS_0_RX, 1, 1},
+	[SLIMBUS_1_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX,
+				SLIMBUS_1_RX, 1, 1},
+	[SLIMBUS_2_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX,
+				SLIMBUS_2_RX, 1, 1},
+	[SLIMBUS_3_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_RX,
+				SLIMBUS_3_RX, 1, 1},
+	[SLIMBUS_4_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_RX,
+				SLIMBUS_4_RX, 1, 1},
+	[SLIMBUS_5_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX,
+				SLIMBUS_5_RX, 1, 1},
+	[SLIMBUS_6_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX,
+				SLIMBUS_6_RX, 1, 1},
 };
 
 static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
@@ -330,6 +425,31 @@ int q6afe_port_stop(struct q6afe_port *port)
 }
 EXPORT_SYMBOL_GPL(q6afe_port_stop);
 
+/**
+ * q6afe_slim_port_prepare() - Prepare slim afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: SLIM configuration for the afe port
+ *
+ */
+void q6afe_slim_port_prepare(struct q6afe_port *port,
+			     struct q6afe_slim_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+
+	pcfg->slim_cfg.sb_cfg_minor_version = AFE_API_VERSION_SLIMBUS_CONFIG;
+	pcfg->slim_cfg.sample_rate = cfg->sample_rate;
+	pcfg->slim_cfg.bit_width = cfg->bit_width;
+	pcfg->slim_cfg.num_channels = cfg->num_channels;
+	pcfg->slim_cfg.data_format = cfg->data_format;
+	pcfg->slim_cfg.shared_ch_mapping[0] = cfg->ch_mapping[0];
+	pcfg->slim_cfg.shared_ch_mapping[1] = cfg->ch_mapping[1];
+	pcfg->slim_cfg.shared_ch_mapping[2] = cfg->ch_mapping[2];
+	pcfg->slim_cfg.shared_ch_mapping[3] = cfg->ch_mapping[3];
+
+}
+EXPORT_SYMBOL_GPL(q6afe_slim_port_prepare);
+
 /**
  * q6afe_hdmi_port_prepare() - Prepare hdmi afe port.
  *
@@ -433,6 +553,15 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
 		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
 		break;
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX:
+		cfg_type = AFE_PARAM_ID_SLIMBUS_CONFIG;
+		break;
 	default:
 		dev_err(dev, "Invalid port id 0x%x\n", port_id);
 		return ERR_PTR(-EINVAL);
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 3bd991a7c42d..5659966c6b1e 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -11,6 +11,9 @@
 #define MSM_AFE_PORT_TYPE_TX 1
 #define AFE_MAX_PORTS AFE_PORT_MAX
 
+#define AFE_MAX_CHAN_COUNT	8
+#define AFE_PORT_MAX_AUDIO_CHAN_CNT	0x8
+
 struct q6afe_hdmi_cfg {
 	u16                  datatype;
 	u16                  channel_allocation;
@@ -18,8 +21,17 @@ struct q6afe_hdmi_cfg {
 	u16                  bit_width;
 };
 
+struct q6afe_slim_cfg {
+	u32	sample_rate;
+	u16	bit_width;
+	u16	data_format;
+	u16	num_channels;
+	u8	ch_mapping[AFE_MAX_CHAN_COUNT];
+};
+
 struct q6afe_port_config {
 	struct q6afe_hdmi_cfg hdmi;
+	struct q6afe_slim_cfg slim;
 };
 
 struct q6afe_port;
@@ -31,5 +43,7 @@ void q6afe_port_put(struct q6afe_port *port);
 int q6afe_get_port_id(int index);
 void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 			    struct q6afe_hdmi_cfg *cfg);
+void q6afe_slim_port_prepare(struct q6afe_port *port,
+			  struct q6afe_slim_cfg *cfg);
 
 #endif /* __Q6AFE_H__ */
-- 
2.16.2
