Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648875; cv=none;
        d=google.com; s=arc-20160816;
        b=kgFFLRG37L99AObjXW8Wl9Mn4rQWMCAcrPQRujUHdkCcHTzjVbC/OX0qFCHD7kuIPZ
         nQcsfUk+ExfinSRD5ub4+pvfOYeMTw/i4A2T1scLqNVhqNFgYdNkg0JvAz91KneW5AwV
         SxFeCUhsM8TB4zCVGb3Hj4xauqf9VWS9GbwphrJ6E626RI1WQk40JgzUeIkEIvZM1v0n
         a1IlePEX0ouiYaGGYVXRNIdAifJy+iaQUkYyzhqUic8AisZNV5TROqSCJX43XyBkYZiv
         OedQGqnpC7jjtDeEOFlag8w3EvE6NlA2YarfkggqRZ2ClxmqyWm/Q/EfmzTBkV8Qi3jo
         rykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=fMls88C4Lk9OuBgVBfoRD8vu2ASzjRy+dybaMsLdW+g=;
        b=08dKKEbut570d7QMK8GCERLObd/Mc5L4lEW+O19OIjf7WhNnHVSYbbX/0DhgDi7wlQ
         ARy7dch+uM9qY+aOWGfM2Cp+hfKAL1jC2nPqcrtbUzu98x+OET9wrspZFqAieNUxziM8
         4R2iEJR7aNyWCiMdzIIdaVtGO1CjOAhr/v0ZiBCBiO/Z4ZX84EIe9Q0qpa/7MTOIV5JE
         RPSojGoVBJI5F5T8zN2yISF0lrnX5A1236DA8djhrPereQHP6L/Xa6fQUT1lMtkaZRyH
         +UNFeWm/AlMgJQW2X1IXj5AoD0iCY0YefoqwSKj83Asst9KR7GsmgKvEqWdlwGGtXyie
         wA/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EcThlLNy;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EcThlLNy;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsUUYlxN/z5YS+gx5gbLmHSawsvRBw9UnaS0no23jh95rugX7eg0cLhS8yHd1dskAiyMQTCWw==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	bgoswami@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	srinivas.kandagatla@linaro.org
Subject: [PATCH v4 10/24] ASoC: qdsp6: q6afe: Add support to MI2S sysclks
Date: Sat, 10 Mar 2018 02:24:42 +0000
Message-Id: <20180310022456.26739-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515915133164752?=
X-GMAIL-MSGID: =?utf-8?q?1594515915133164752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to LPASS Bit clock, LPASS Digital
core clock and OSR clock. These clocks are required for both
MI2S and PCM setup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 211 ++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/q6afe.h | 131 +++++++++++++++++++++++++++
 2 files changed, 340 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 2da5e3b14e38..40ba53d13e98 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -26,6 +26,7 @@
 #define AFE_PORT_CMD_DEVICE_START	0x000100E5
 #define AFE_PORT_CMD_DEVICE_STOP	0x000100E6
 #define AFE_PORT_CMD_SET_PARAM_V2	0x000100EF
+#define AFE_SVC_CMD_SET_PARAM		0x000100f3
 #define AFE_PORT_CMDRSP_GET_PARAM_V2	0x00010106
 #define AFE_PARAM_ID_HDMI_CONFIG	0x00010210
 #define AFE_MODULE_AUDIO_DEV_INTERFACE	0x0001020C
@@ -68,6 +69,11 @@
 #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
 
 #define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
+/* Clock set API version */
+#define AFE_API_VERSION_CLOCK_SET 1
+#define Q6AFE_LPASS_CLK_CONFIG_API_VERSION	0x1
+#define AFE_MODULE_CLOCK_SET		0x0001028F
+#define AFE_PARAM_ID_CLOCK_SET		0x00010290
 
 /* SLIMbus Rx port on channel 0. */
 #define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX      0x4000
@@ -146,6 +152,13 @@ struct afe_port_param_data_v2 {
 	u16 reserved;
 } __packed;
 
+struct afe_svc_cmd_set_param {
+	uint32_t payload_size;
+	uint32_t payload_address_lsw;
+	uint32_t payload_address_msw;
+	uint32_t mem_map_handle;
+} __packed;
+
 struct afe_port_cmd_set_param_v2 {
 	u16 port_id;
 	u16 payload_size;
@@ -206,6 +219,23 @@ struct afe_param_id_slimbus_cfg {
  */
 } __packed;
 
+struct afe_clk_cfg {
+	u32                  i2s_cfg_minor_version;
+	u32                  clk_val1;
+	u32                  clk_val2;
+	u16                  clk_src;
+	u16                  clk_root;
+	u16                  clk_set_mode;
+	u16                  reserved;
+} __packed;
+
+struct afe_digital_clk_cfg {
+	u32                  i2s_cfg_minor_version;
+	u32                  clk_val;
+	u16                  clk_root;
+	u16                  reserved;
+} __packed;
+
 struct afe_param_id_i2s_cfg {
 	u32	i2s_cfg_minor_version;
 	u16	bit_width;
@@ -223,9 +253,43 @@ union afe_port_config {
 	struct afe_param_id_i2s_cfg	i2s_cfg;
 } __packed;
 
+
+struct afe_clk_set {
+	uint32_t clk_set_minor_version;
+	uint32_t clk_id;
+	uint32_t clk_freq_in_hz;
+	uint16_t clk_attri;
+	uint16_t clk_root;
+	uint32_t enable;
+};
+
+struct afe_lpass_clk_config_command {
+	struct apr_hdr			 hdr;
+	struct afe_port_cmd_set_param_v2 param;
+	struct afe_port_param_data_v2    pdata;
+	struct afe_clk_cfg clk_cfg;
+} __packed;
+
+struct afe_lpass_clk_config_command_v2 {
+	struct apr_hdr			hdr;
+	struct afe_svc_cmd_set_param	param;
+	struct afe_port_param_data_v2    pdata;
+	struct afe_clk_set		clk_cfg;
+} __packed;
+
+
+
+struct afe_lpass_digital_clk_config_command {
+	struct apr_hdr			 hdr;
+	struct afe_port_cmd_set_param_v2 param;
+	struct afe_port_param_data_v2    pdata;
+	struct afe_digital_clk_cfg clk_cfg;
+} __packed;
+
 struct q6afe_port {
 	wait_queue_head_t wait;
 	union afe_port_config port_cfg;
+	struct aprv2_ibasic_rsp_result_t result;
 	int token;
 	int id;
 	int cfg_type;
@@ -393,6 +457,46 @@ static int afe_apr_send_pkt(struct q6afe *afe, void *data,
 	return ret;
 }
 
+static int q6afe_port_set_param(struct q6afe_port *port, void *data,
+				   int param_id, int module_id, int psize)
+{
+	struct apr_hdr *hdr;
+	struct afe_svc_cmd_set_param *param;
+	struct afe_port_param_data_v2 *pdata;
+	struct q6afe *afe = port->afe;
+	u16 port_id = port->id;
+	int ret;
+
+	hdr = data;
+	param = data + sizeof(*hdr);
+	pdata = data + sizeof(*hdr) + sizeof(*param);
+
+	hdr->hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					      APR_HDR_LEN(APR_HDR_SIZE),
+					      APR_PKT_VER);
+	hdr->pkt_size = sizeof(*hdr) + sizeof(*param) +
+			sizeof(*pdata) + psize;
+	hdr->src_port = 0;
+	hdr->dest_port = 0;
+	hdr->token = port->token;
+	hdr->opcode = AFE_SVC_CMD_SET_PARAM;
+
+	param->payload_size = sizeof(*pdata) + psize;
+	param->payload_address_lsw = 0x00;
+	param->payload_address_msw = 0x00;
+	param->mem_map_handle = 0x00;
+	pdata->module_id = module_id;
+	pdata->param_id = param_id;
+	pdata->param_size = psize;
+
+	ret = afe_apr_send_pkt(afe, data, port);
+	if (ret)
+		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
+		       port_id, ret);
+
+	return ret;
+}
+
 static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
 				   int param_id, int psize)
 {
@@ -434,6 +538,110 @@ static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
 	return ret;
 }
 
+static int q6afe_set_lpass_clock(struct q6afe_port *port,
+				 struct afe_clk_cfg *cfg)
+{
+	struct afe_lpass_clk_config_command clk_cfg = {0};
+	int param_id = AFE_PARAM_ID_LPAIF_CLK_CONFIG;
+	struct q6afe *afe = port->afe;
+
+	if (!cfg) {
+		dev_err(afe->dev, "clock cfg is NULL\n");
+		return -EINVAL;
+	}
+
+	clk_cfg.clk_cfg = *cfg;
+
+	return q6afe_port_set_param_v2(port, &clk_cfg, param_id, sizeof(*cfg));
+}
+
+static int q6afe_set_lpass_clock_v2(struct q6afe_port *port,
+				 struct afe_clk_set *cfg)
+{
+	struct afe_lpass_clk_config_command_v2 clk_cfg = {0};
+	int param_id = AFE_PARAM_ID_CLOCK_SET;
+	int module_id = AFE_MODULE_CLOCK_SET;
+	struct q6afe *afe = port->afe;
+
+	if (!cfg) {
+		dev_err(afe->dev, "clock cfg is NULL\n");
+		return -EINVAL;
+	}
+
+	clk_cfg.clk_cfg = *cfg;
+
+	return q6afe_port_set_param(port, &clk_cfg, param_id,
+				       module_id, sizeof(*cfg));
+}
+
+static int q6afe_set_digital_codec_core_clock(struct q6afe_port *port,
+					      struct afe_digital_clk_cfg *cfg)
+{
+	struct afe_lpass_digital_clk_config_command clk_cfg = {0};
+	int param_id = AFE_PARAM_ID_INTERNAL_DIGITAL_CDC_CLK_CONFIG;
+	struct q6afe *afe = port->afe;
+
+	if (!cfg) {
+		dev_err(afe->dev, "clock cfg is NULL\n");
+		return -EINVAL;
+	}
+
+	clk_cfg.clk_cfg = *cfg;
+
+	return q6afe_port_set_param_v2(port, &clk_cfg, param_id, sizeof(*cfg));
+}
+
+int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
+			  int clk_src, int clk_root,
+			  unsigned int freq, int dir)
+{
+	struct afe_clk_cfg ccfg = {0,};
+	struct afe_clk_set cset = {0,};
+	struct afe_digital_clk_cfg dcfg = {0,};
+	int ret;
+
+	switch (clk_id) {
+	case LPAIF_DIG_CLK:
+		dcfg.i2s_cfg_minor_version = AFE_API_VERSION_I2S_CONFIG;
+		dcfg.clk_val = freq;
+		dcfg.clk_root = clk_root;
+		ret = q6afe_set_digital_codec_core_clock(port, &dcfg);
+		break;
+	case LPAIF_BIT_CLK:
+		ccfg.i2s_cfg_minor_version = AFE_API_VERSION_I2S_CONFIG;
+		ccfg.clk_val1 = freq;
+		ccfg.clk_src = clk_src;
+		ccfg.clk_root = clk_root;
+		ccfg.clk_set_mode = Q6AFE_LPASS_MODE_CLK1_VALID;
+		ret = q6afe_set_lpass_clock(port, &ccfg);
+		break;
+
+	case LPAIF_OSR_CLK:
+		ccfg.i2s_cfg_minor_version = AFE_API_VERSION_I2S_CONFIG;
+		ccfg.clk_val2 = freq;
+		ccfg.clk_src = clk_src;
+		ccfg.clk_root = clk_root;
+		ccfg.clk_set_mode = Q6AFE_LPASS_MODE_CLK2_VALID;
+		ret = q6afe_set_lpass_clock(port, &ccfg);
+		break;
+	case Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT ... Q6AFE_LPASS_CLK_ID_INT_MCLK_1:
+		cset.clk_set_minor_version = AFE_API_VERSION_CLOCK_SET;
+		cset.clk_id = clk_id;
+		cset.clk_freq_in_hz = freq;
+		cset.clk_attri = clk_src;
+		cset.clk_root = clk_root;
+		cset.enable = !!freq;
+		ret = q6afe_set_lpass_clock_v2(port, &cset);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6afe_port_set_sysclk);
+
 /**
  * q6afe_port_stop() - Stop a afe port
  *
@@ -526,8 +734,7 @@ EXPORT_SYMBOL_GPL(q6afe_hdmi_port_prepare);
  *
  * @port: Instance of afe port
  * @cfg: I2S configuration for the afe port
- *
-  Return: Will be an negative on error and zero on success.
+ * Return: Will be an negative on error and zero on success.
  */
 int q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg)
 {
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 05c61014abea..f21c89a25c29 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -16,6 +16,134 @@
 #define AFE_MAX_CHAN_COUNT	8
 #define AFE_PORT_MAX_AUDIO_CHAN_CNT	0x8
 
+#define Q6AFE_LPASS_CLK_SRC_INTERNAL 1
+#define Q6AFE_LPASS_CLK_ROOT_DEFAULT 0
+
+#define LPAIF_DIG_CLK	1
+#define LPAIF_BIT_CLK	2
+#define LPAIF_OSR_CLK	3
+
+/* Clock ID for Primary I2S IBIT */
+#define Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT                          0x100
+/* Clock ID for Primary I2S EBIT */
+#define Q6AFE_LPASS_CLK_ID_PRI_MI2S_EBIT                          0x101
+/* Clock ID for Secondary I2S IBIT */
+#define Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT                          0x102
+/* Clock ID for Secondary I2S EBIT */
+#define Q6AFE_LPASS_CLK_ID_SEC_MI2S_EBIT                          0x103
+/* Clock ID for Tertiary I2S IBIT */
+#define Q6AFE_LPASS_CLK_ID_TER_MI2S_IBIT                          0x104
+/* Clock ID for Tertiary I2S EBIT */
+#define Q6AFE_LPASS_CLK_ID_TER_MI2S_EBIT                          0x105
+/* Clock ID for Quartnery I2S IBIT */
+#define Q6AFE_LPASS_CLK_ID_QUAD_MI2S_IBIT                         0x106
+/* Clock ID for Quartnery I2S EBIT */
+#define Q6AFE_LPASS_CLK_ID_QUAD_MI2S_EBIT                         0x107
+/* Clock ID for Speaker I2S IBIT */
+#define Q6AFE_LPASS_CLK_ID_SPEAKER_I2S_IBIT                       0x108
+/* Clock ID for Speaker I2S EBIT */
+#define Q6AFE_LPASS_CLK_ID_SPEAKER_I2S_EBIT                       0x109
+/* Clock ID for Speaker I2S OSR */
+#define Q6AFE_LPASS_CLK_ID_SPEAKER_I2S_OSR                        0x10A
+
+/* Clock ID for QUINARY  I2S IBIT */
+#define Q6AFE_LPASS_CLK_ID_QUI_MI2S_IBIT			0x10B
+/* Clock ID for QUINARY  I2S EBIT */
+#define Q6AFE_LPASS_CLK_ID_QUI_MI2S_EBIT			0x10C
+/* Clock ID for SENARY  I2S IBIT */
+#define Q6AFE_LPASS_CLK_ID_SEN_MI2S_IBIT			0x10D
+/* Clock ID for SENARY  I2S EBIT */
+#define Q6AFE_LPASS_CLK_ID_SEN_MI2S_EBIT			0x10E
+/* Clock ID for INT0 I2S IBIT  */
+#define Q6AFE_LPASS_CLK_ID_INT0_MI2S_IBIT                       0x10F
+/* Clock ID for INT1 I2S IBIT  */
+#define Q6AFE_LPASS_CLK_ID_INT1_MI2S_IBIT                       0x110
+/* Clock ID for INT2 I2S IBIT  */
+#define Q6AFE_LPASS_CLK_ID_INT2_MI2S_IBIT                       0x111
+/* Clock ID for INT3 I2S IBIT  */
+#define Q6AFE_LPASS_CLK_ID_INT3_MI2S_IBIT                       0x112
+/* Clock ID for INT4 I2S IBIT  */
+#define Q6AFE_LPASS_CLK_ID_INT4_MI2S_IBIT                       0x113
+/* Clock ID for INT5 I2S IBIT  */
+#define Q6AFE_LPASS_CLK_ID_INT5_MI2S_IBIT                       0x114
+/* Clock ID for INT6 I2S IBIT  */
+#define Q6AFE_LPASS_CLK_ID_INT6_MI2S_IBIT                       0x115
+
+/* Clock ID for QUINARY MI2S OSR CLK  */
+#define Q6AFE_LPASS_CLK_ID_QUI_MI2S_OSR                         0x116
+
+/* Clock ID for Primary PCM IBIT */
+#define Q6AFE_LPASS_CLK_ID_PRI_PCM_IBIT                           0x200
+/* Clock ID for Primary PCM EBIT */
+#define Q6AFE_LPASS_CLK_ID_PRI_PCM_EBIT                           0x201
+/* Clock ID for Secondary PCM IBIT */
+#define Q6AFE_LPASS_CLK_ID_SEC_PCM_IBIT                           0x202
+/* Clock ID for Secondary PCM EBIT */
+#define Q6AFE_LPASS_CLK_ID_SEC_PCM_EBIT                           0x203
+/* Clock ID for Tertiary PCM IBIT */
+#define Q6AFE_LPASS_CLK_ID_TER_PCM_IBIT                           0x204
+/* Clock ID for Tertiary PCM EBIT */
+#define Q6AFE_LPASS_CLK_ID_TER_PCM_EBIT                           0x205
+/* Clock ID for Quartery PCM IBIT */
+#define Q6AFE_LPASS_CLK_ID_QUAD_PCM_IBIT                          0x206
+/* Clock ID for Quartery PCM EBIT */
+#define Q6AFE_LPASS_CLK_ID_QUAD_PCM_EBIT                          0x207
+/* Clock ID for Quinary PCM IBIT */
+#define Q6AFE_LPASS_CLK_ID_QUIN_PCM_IBIT                          0x208
+/* Clock ID for Quinary PCM EBIT */
+#define Q6AFE_LPASS_CLK_ID_QUIN_PCM_EBIT                          0x209
+/* Clock ID for QUINARY PCM OSR  */
+#define Q6AFE_LPASS_CLK_ID_QUI_PCM_OSR                            0x20A
+
+/** Clock ID for Primary TDM IBIT */
+#define Q6AFE_LPASS_CLK_ID_PRI_TDM_IBIT                           0x200
+/** Clock ID for Primary TDM EBIT */
+#define Q6AFE_LPASS_CLK_ID_PRI_TDM_EBIT                           0x201
+/** Clock ID for Secondary TDM IBIT */
+#define Q6AFE_LPASS_CLK_ID_SEC_TDM_IBIT                           0x202
+/** Clock ID for Secondary TDM EBIT */
+#define Q6AFE_LPASS_CLK_ID_SEC_TDM_EBIT                           0x203
+/** Clock ID for Tertiary TDM IBIT */
+#define Q6AFE_LPASS_CLK_ID_TER_TDM_IBIT                           0x204
+/** Clock ID for Tertiary TDM EBIT */
+#define Q6AFE_LPASS_CLK_ID_TER_TDM_EBIT                           0x205
+/** Clock ID for Quartery TDM IBIT */
+#define Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT                          0x206
+/** Clock ID for Quartery TDM EBIT */
+#define Q6AFE_LPASS_CLK_ID_QUAD_TDM_EBIT                          0x207
+/** Clock ID for Quinary TDM IBIT */
+#define Q6AFE_LPASS_CLK_ID_QUIN_TDM_IBIT                          0x208
+/** Clock ID for Quinary TDM EBIT */
+#define Q6AFE_LPASS_CLK_ID_QUIN_TDM_EBIT                          0x209
+/** Clock ID for Quinary TDM OSR */
+#define Q6AFE_LPASS_CLK_ID_QUIN_TDM_OSR                           0x20A
+
+/* Clock ID for MCLK1 */
+#define Q6AFE_LPASS_CLK_ID_MCLK_1                                 0x300
+/* Clock ID for MCLK2 */
+#define Q6AFE_LPASS_CLK_ID_MCLK_2                                 0x301
+/* Clock ID for MCLK3 */
+#define Q6AFE_LPASS_CLK_ID_MCLK_3                                 0x302
+/* Clock ID for MCLK4 */
+#define Q6AFE_LPASS_CLK_ID_MCLK_4                                 0x304
+/* Clock ID for Internal Digital Codec Core */
+#define Q6AFE_LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE            0x303
+/* Clock ID for INT MCLK0 */
+#define Q6AFE_LPASS_CLK_ID_INT_MCLK_0                             0x305
+/* Clock ID for INT MCLK1 */
+#define Q6AFE_LPASS_CLK_ID_INT_MCLK_1                             0x306
+
+/* Clock attribute for invalid use (reserved for internal usage) */
+#define Q6AFE_LPASS_CLK_ATTRIBUTE_INVALID		0x0
+/* Clock attribute for no couple case */
+#define Q6AFE_LPASS_CLK_ATTRIBUTE_COUPLE_NO		0x1
+/* Clock attribute for dividend couple case */
+#define Q6AFE_LPASS_CLK_ATTRIBUTE_COUPLE_DIVIDEND	0x2
+/* Clock attribute for divisor couple case */
+#define Q6AFE_LPASS_CLK_ATTRIBUTE_COUPLE_DIVISOR	0x3
+/* Clock attribute for invert and no couple case */
+#define Q6AFE_LPASS_CLK_ATTRIBUTE_INVERT_COUPLE_NO	0x4
+
 struct q6afe_hdmi_cfg {
 	u16                  datatype;
 	u16                  channel_allocation;
@@ -59,4 +187,7 @@ void q6afe_slim_port_prepare(struct q6afe_port *port,
 			  struct q6afe_slim_cfg *cfg);
 int q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg);
 
+int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
+			  int clk_src, int clk_root,
+			  unsigned int freq, int dir);
 #endif /* __Q6AFE_H__ */
-- 
2.15.1
