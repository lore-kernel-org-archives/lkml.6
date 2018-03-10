Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648874; cv=none;
        d=google.com; s=arc-20160816;
        b=Hzrdf0uGG/P2yuG8e3jIsklyo3ZYvW3hAE2PjFpa8YQRjttILbjXDf/7D8kr5bqh5E
         AVYmcT3i7f4D2EM5fD/2ETtOGv5odgltYcbc0lPh3UneWLG77WFV9SL/pgK7n4opjnqc
         /OqZVQ1wVJfdL25PZVTNWRQV9jVH0YpQRFii4/3T5+2YV/WG4Bi9R3bcILX0Va3Sgu4O
         GdW7d/C5OfA/DxtRjiGn1EQpblRv3raydJCMXKLI/snul/MejulCTEUtvp9ngo0oQHNx
         E/HVd2c2MkFevVnvMXWRLgJyvwX48sGxSub1BGCx+49DLvB9zlKOZ5grn3gzrBgeiLKT
         LpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=uqyoUR1p/br/KvQtd8ktAuiag1iH6GTZoj54LXb4NC0=;
        b=pGQyzRaEB/GLdYyYqPJ4KIvCJFx7iAcsty8zHe+32wX9yhcv1RjUdiZjGwgs0oUR/O
         D3rttukRxrAsLDEtM43XbbNxYgfwVmN1WKz+EpGUpkMTbXeSDHZtqM2F2opLLod1qplT
         hEx0qKFMTZjm8j5q/Vn4rQakHAbl3z8llaJVKwKfe3mRyduLGVO0Wm9ZlGSro5kWwwFP
         umFsPc5rR1hoMJNQxN82UQ48HgSCP4MLs/pTiSaAO1eWZcXmxAn7vs9kmm/fAvTLa6/8
         skIioNBw8oTqXV65O/lxoM85yBMMC1QWPFBum6ifHfsV0hlA1UivtskGFCCtdlWkB2gH
         t2Mg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hLeEMb8Y;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hLeEMb8Y;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELul6b8EL43SFMQnO+yi9kS/o3qd1SMoHumCz7euAKu89WPByqdwi2ool7Ij8zod+NKM26MxQw==
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
Subject: [PATCH v4 09/24] ASoC: qdsp6: q6afe: Add support to MI2S ports
Date: Sat, 10 Mar 2018 02:24:41 +0000
Message-Id: <20180310022456.26739-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515913712613182?=
X-GMAIL-MSGID: =?utf-8?q?1594515913712613182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to 4 MI2S ports on LPASS.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 228 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h |  13 +++
 2 files changed, 241 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index de50ddd9faa4..2da5e3b14e38 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -14,6 +14,10 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/soc/qcom/apr.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include "q6dsp-errno.h"
 #include "q6core.h"
 #include "q6afe.h"
@@ -28,7 +32,36 @@
 
 #define AFE_PARAM_ID_CDC_SLIMBUS_SLAVE_CFG 0x00010235
 
+#define AFE_PARAM_ID_LPAIF_CLK_CONFIG	0x00010238
+#define AFE_PARAM_ID_INTERNAL_DIGITAL_CDC_CLK_CONFIG	0x00010239
+
 #define AFE_PARAM_ID_SLIMBUS_CONFIG    0x00010212
+#define AFE_PARAM_ID_I2S_CONFIG	0x0001020D
+
+/* I2S config specific */
+#define AFE_API_VERSION_I2S_CONFIG	0x1
+#define AFE_PORT_I2S_SD0		0x1
+#define AFE_PORT_I2S_SD1		0x2
+#define AFE_PORT_I2S_SD2		0x3
+#define AFE_PORT_I2S_SD3		0x4
+#define AFE_PORT_I2S_SD0_MASK		BIT(0x1)
+#define AFE_PORT_I2S_SD1_MASK		BIT(0x2)
+#define AFE_PORT_I2S_SD2_MASK		BIT(0x3)
+#define AFE_PORT_I2S_SD3_MASK		BIT(0x4)
+#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(2, 1)
+#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(4, 3)
+#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(3, 1)
+#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(4, 1)
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
@@ -64,6 +97,19 @@
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
+
+#define Q6AFE_LPASS_MODE_CLK1_VALID 1
+#define Q6AFE_LPASS_MODE_CLK2_VALID 2
+#define Q6AFE_LPASS_CLK_SRC_INTERNAL 1
+#define Q6AFE_LPASS_CLK_ROOT_DEFAULT 0
 
 #define TIMEOUT_MS 1000
 #define AFE_CMD_RESP_AVAIL	0
@@ -160,10 +206,21 @@ struct afe_param_id_slimbus_cfg {
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
@@ -210,6 +267,22 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				SLIMBUS_4_RX, 1, 1},
 	[SLIMBUS_5_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX,
 				SLIMBUS_5_RX, 1, 1},
+	[QUATERNARY_MI2S_RX] = { AFE_PORT_ID_QUATERNARY_MI2S_RX,
+				QUATERNARY_MI2S_RX, 1, 1},
+	[QUATERNARY_MI2S_TX] = { AFE_PORT_ID_QUATERNARY_MI2S_TX,
+				QUATERNARY_MI2S_TX, 0, 1},
+	[SECONDARY_MI2S_RX] = { AFE_PORT_ID_SECONDARY_MI2S_RX,
+				SECONDARY_MI2S_RX, 1, 1},
+	[SECONDARY_MI2S_TX] = { AFE_PORT_ID_SECONDARY_MI2S_TX,
+				SECONDARY_MI2S_TX, 0, 1},
+	[TERTIARY_MI2S_RX] = { AFE_PORT_ID_TERTIARY_MI2S_RX,
+				TERTIARY_MI2S_RX, 1, 1},
+	[TERTIARY_MI2S_TX] = { AFE_PORT_ID_TERTIARY_MI2S_TX,
+				TERTIARY_MI2S_TX, 0, 1},
+	[PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
+				PRIMARY_MI2S_RX, 1, 1},
+	[PRIMARY_MI2S_TX] = { AFE_PORT_ID_PRIMARY_MI2S_TX,
+				PRIMARY_MI2S_RX, 0, 1},
 	[SLIMBUS_6_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX,
 				SLIMBUS_6_RX, 1, 1},
 };
@@ -448,6 +521,150 @@ void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 }
 EXPORT_SYMBOL_GPL(q6afe_hdmi_port_prepare);
 
+/**
+ * q6afe_i2s_port_prepare() - Prepare i2s afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: I2S configuration for the afe port
+ *
+  Return: Will be an negative on error and zero on success.
+ */
+int q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+	struct device *dev = port->afe->dev;
+	int num_sd_lines;
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
+	num_sd_lines = hweight_long(cfg->sd_line_mask);
+
+	switch (num_sd_lines) {
+	case 0:
+		dev_err(dev, "no line is assigned\n");
+		return -EINVAL;
+	case 1:
+		switch (cfg->sd_line_mask) {
+		case AFE_PORT_I2S_SD0_MASK:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_SD0;
+			break;
+		case AFE_PORT_I2S_SD1_MASK:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_SD1;
+			break;
+		case AFE_PORT_I2S_SD2_MASK:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_SD2;
+			break;
+		case AFE_PORT_I2S_SD3_MASK:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_SD3;
+			break;
+		default:
+			dev_err(dev, "Invalid SD lines\n");
+			return -EINVAL;
+		}
+		break;
+	case 2:
+		switch (cfg->sd_line_mask) {
+		case AFE_PORT_I2S_SD0_1_MASK:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_QUAD01;
+			break;
+		case AFE_PORT_I2S_SD2_3_MASK:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_QUAD23;
+			break;
+		default:
+			dev_err(dev, "Invalid SD lines\n");
+			return -EINVAL;
+		}
+		break;
+	case 3:
+		switch (cfg->sd_line_mask) {
+		case AFE_PORT_I2S_SD0_1_2_MASK:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_6CHS;
+			break;
+		default:
+			dev_err(dev, "Invalid SD lines\n");
+			return -EINVAL;
+		}
+		break;
+	case 4:
+		switch (cfg->sd_line_mask) {
+		case AFE_PORT_I2S_SD0_1_2_3_MASK:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_8CHS;
+
+			break;
+		default:
+			dev_err(dev, "Invalid SD lines\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(dev, "Invalid SD lines\n");
+		return -EINVAL;
+	}
+
+	switch (cfg->num_channels) {
+	case 1:
+	case 2:
+		switch (pcfg->i2s_cfg.channel_mode) {
+		case AFE_PORT_I2S_QUAD01:
+		case AFE_PORT_I2S_6CHS:
+		case AFE_PORT_I2S_8CHS:
+			pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_SD0;
+			break;
+		case AFE_PORT_I2S_QUAD23:
+				pcfg->i2s_cfg.channel_mode = AFE_PORT_I2S_SD2;
+			break;
+		}
+
+		if (cfg->num_channels == 2)
+			pcfg->i2s_cfg.mono_stereo = AFE_PORT_I2S_STEREO;
+		else
+			pcfg->i2s_cfg.mono_stereo = AFE_PORT_I2S_MONO;
+
+		break;
+	case 3:
+	case 4:
+		if (pcfg->i2s_cfg.channel_mode < AFE_PORT_I2S_QUAD01) {
+			dev_err(dev, "Invalid Channel mode\n");
+			return -EINVAL;
+		}
+		break;
+	case 5:
+	case 6:
+		if (pcfg->i2s_cfg.channel_mode < AFE_PORT_I2S_6CHS) {
+			dev_err(dev, "Invalid Channel mode\n");
+			return -EINVAL;
+		}
+		break;
+	case 7:
+	case 8:
+		if (pcfg->i2s_cfg.channel_mode < AFE_PORT_I2S_8CHS) {
+			dev_err(dev, "Invalid Channel mode\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6afe_i2s_port_prepare);
+
 /**
  * q6afe_port_start() - Start a afe port
  *
@@ -529,6 +746,17 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX:
 		cfg_type = AFE_PARAM_ID_SLIMBUS_CONFIG;
 		break;
+
+	case AFE_PORT_ID_PRIMARY_MI2S_RX:
+	case AFE_PORT_ID_PRIMARY_MI2S_TX:
+	case AFE_PORT_ID_SECONDARY_MI2S_RX:
+	case AFE_PORT_ID_SECONDARY_MI2S_TX:
+	case AFE_PORT_ID_TERTIARY_MI2S_RX:
+	case AFE_PORT_ID_TERTIARY_MI2S_TX:
+	case AFE_PORT_ID_QUATERNARY_MI2S_RX:
+	case AFE_PORT_ID_QUATERNARY_MI2S_TX:
+		cfg_type = AFE_PARAM_ID_I2S_CONFIG;
+		break;
 	default:
 		dev_err(dev, "Invalid port id 0x%x\n", port_id);
 		return ERR_PTR(-EINVAL);
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 155d6e47d7ce..05c61014abea 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -11,6 +11,8 @@
 #define MSM_AFE_PORT_TYPE_TX 1
 #define AFE_MAX_PORTS AFE_PORT_MAX
 
+#define Q6AFE_MAX_MI2S_LINES	4
+
 #define AFE_MAX_CHAN_COUNT	8
 #define AFE_PORT_MAX_AUDIO_CHAN_CNT	0x8
 
@@ -29,9 +31,19 @@ struct q6afe_slim_cfg {
 	u8	ch_mapping[AFE_MAX_CHAN_COUNT];
 };
 
+struct q6afe_i2s_cfg {
+	u32	sample_rate;
+	u16	bit_width;
+	u16	data_format;
+	u16	num_channels;
+	u32	sd_line_mask;
+	int fmt;
+};
+
 struct q6afe_port_config {
 	struct q6afe_hdmi_cfg hdmi;
 	struct q6afe_slim_cfg slim;
+	struct q6afe_i2s_cfg i2s_cfg;
 };
 
 struct q6afe_port;
@@ -45,5 +57,6 @@ void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 			    struct q6afe_hdmi_cfg *cfg);
 void q6afe_slim_port_prepare(struct q6afe_port *port,
 			  struct q6afe_slim_cfg *cfg);
+int q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg);
 
 #endif /* __Q6AFE_H__ */
-- 
2.15.1
