Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176648; cv=none;
        d=google.com; s=arc-20160816;
        b=EwP8htAzd6HF+WEOFvoIWuOQlCyGICfpO3/SvoKoI8tOu7K6O4/cMKrp5zLN34vo1e
         fzSp8Cuu4VRNMT2kZDWXBK1icSpDtgb1XllH4DiHYujMSz30PcrmOFvhDnQQHBDjvw/f
         tt00kONCOOr6xIrNRVAPsshijme04qPqf4kdKO9lfQQnDSPq0ILfli4aHRv+HOCDojdZ
         KYg1AHk/aj5/51VEcF/NvaJnZzToJKAJkAqzy7pCo5s6w93fIebGe1qRdezs3K2i8KJs
         XXcWapCavIRVIqpCBjb4t3Z9fS3zlNO7zdksGv2Rf5v7FAswrTU7i/jMlK79doeWlDH9
         8Fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=HqPeH094G2TZ06SjqO9fCUQ/cEx0xabqU0N1KaPnykM=;
        b=wUvlXhrqWSqwmEYR0+TYpXO4qmUBeXYwFwB6M9zSYdC59ka0DwMLPDGtPoxpFcUzyk
         Wt99ps9na6h6GtLddvgmA6VwMyB/Uy0gKMdnY75Yli3Hf1wlHLIE3b8eCHvXO+f6tate
         nis0eKspGqR5r8Fn9cyKBNpBog5QJgQ37yVR9UxvuttEtj4/BAR8VUxWcmUeZ1dC2p2u
         N8jSW1jiDaK3OZuDWz1Zv0fkimdGJMDrjWfl4no5OKriSNvCZL6EXm8yyPPhYIiojlx5
         ddJnYcyRLeALQvTFZUcMTNTM53Fg+yF5GFWh6C8MQ78+VZA65/ymkMqJViX7J1ht6oAo
         1s7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cUjmAYrc;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cUjmAYrc;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpsZuesVqSCuKHYUfeJ8A+gcL3+uaDL64h9t1s93YqJwDQdWkH9Wqm8espwEq0dqHT2xStolg==
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
Subject: [PATCH v7 16/24] ASoC: qdsp6: q6asm: Add support to audio stream apis
Date: Tue,  1 May 2018 13:08:12 +0100
Message-Id: <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263628693117168?=
X-GMAIL-MSGID: =?utf-8?q?1599263628693117168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to open, write and media format commands
in the q6asm module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 839 ++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.h |  49 +++
 2 files changed, 887 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 5a573e927a5e..a3073de235e1 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -10,6 +10,8 @@
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
+#include <uapi/sound/asound.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -18,10 +20,36 @@
 #include "q6dsp-errno.h"
 #include "q6dsp-common.h"
 
+#define ASM_STREAM_CMD_CLOSE			0x00010BCD
+#define ASM_STREAM_CMD_FLUSH			0x00010BCE
+#define ASM_SESSION_CMD_PAUSE			0x00010BD3
+#define ASM_DATA_CMD_EOS			0x00010BDB
+#define ASM_NULL_POPP_TOPOLOGY			0x00010C68
+#define ASM_STREAM_CMD_FLUSH_READBUFS		0x00010C09
+#define ASM_STREAM_CMD_SET_ENCDEC_PARAM		0x00010C10
+#define ASM_STREAM_POSTPROC_TOPO_ID_NONE	0x00010C68
 #define ASM_CMD_SHARED_MEM_MAP_REGIONS		0x00010D92
 #define ASM_CMDRSP_SHARED_MEM_MAP_REGIONS	0x00010D93
 #define ASM_CMD_SHARED_MEM_UNMAP_REGIONS	0x00010D94
-
+#define ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2	0x00010D98
+#define ASM_DATA_EVENT_WRITE_DONE_V2		0x00010D99
+#define ASM_PARAM_ID_ENCDEC_ENC_CFG_BLK_V2	0x00010DA3
+#define ASM_SESSION_CMD_RUN_V2			0x00010DAA
+#define ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2	0x00010DA5
+#define ASM_DATA_CMD_WRITE_V2			0x00010DAB
+#define ASM_DATA_CMD_READ_V2			0x00010DAC
+#define ASM_SESSION_CMD_SUSPEND			0x00010DEC
+#define ASM_STREAM_CMD_OPEN_WRITE_V3		0x00010DB3
+#define ASM_STREAM_CMD_OPEN_READ_V3                 0x00010DB4
+#define ASM_DATA_EVENT_READ_DONE_V2 0x00010D9A
+#define ASM_STREAM_CMD_OPEN_READWRITE_V2        0x00010D8D
+
+
+#define ASM_LEGACY_STREAM_SESSION	0
+/* Bit shift for the stream_perf_mode subfield. */
+#define ASM_SHIFT_STREAM_PERF_MODE_FLAG_IN_OPEN_READ              29
+#define ASM_END_POINT_DEVICE_MATRIX	0
+#define ASM_DEFAULT_APP_TYPE		0
 #define ASM_SYNC_IO_MODE		0x0001
 #define ASM_ASYNC_IO_MODE		0x0002
 #define ASM_TUN_READ_IO_MODE		0x0004	/* tunnel read write mode */
@@ -45,6 +73,89 @@ struct avs_cmd_shared_mem_unmap_regions {
 	u32 mem_map_handle;
 } __packed;
 
+struct asm_data_cmd_media_fmt_update_v2 {
+	u32 fmt_blk_size;
+} __packed;
+
+struct asm_multi_channel_pcm_fmt_blk_v2 {
+	struct asm_data_cmd_media_fmt_update_v2 fmt_blk;
+	u16 num_channels;
+	u16 bits_per_sample;
+	u32 sample_rate;
+	u16 is_signed;
+	u16 reserved;
+	u8 channel_mapping[PCM_MAX_NUM_CHANNEL];
+} __packed;
+
+struct asm_stream_cmd_set_encdec_param {
+	u32                  param_id;
+	u32                  param_size;
+} __packed;
+
+struct asm_enc_cfg_blk_param_v2 {
+	u32                  frames_per_buf;
+	u32                  enc_cfg_blk_size;
+} __packed;
+
+struct asm_multi_channel_pcm_enc_cfg_v2 {
+	struct asm_stream_cmd_set_encdec_param  encdec;
+	struct asm_enc_cfg_blk_param_v2	encblk;
+	uint16_t  num_channels;
+	uint16_t  bits_per_sample;
+	uint32_t  sample_rate;
+	uint16_t  is_signed;
+	uint16_t  reserved;
+	uint8_t   channel_mapping[8];
+} __packed;
+
+struct asm_data_cmd_read_v2 {
+	u32                  buf_addr_lsw;
+	u32                  buf_addr_msw;
+	u32                  mem_map_handle;
+	u32                  buf_size;
+	u32                  seq_id;
+} __packed;
+
+struct asm_data_cmd_read_v2_done {
+	u32	status;
+	u32	buf_addr_lsw;
+	u32	buf_addr_msw;
+};
+
+struct asm_stream_cmd_open_read_v3 {
+	u32                    mode_flags;
+	u32                    src_endpointype;
+	u32                    preprocopo_id;
+	u32                    enc_cfg_id;
+	u16                    bits_per_sample;
+	u16                    reserved;
+} __packed;
+
+struct asm_data_cmd_write_v2 {
+	u32 buf_addr_lsw;
+	u32 buf_addr_msw;
+	u32 mem_map_handle;
+	u32 buf_size;
+	u32 seq_id;
+	u32 timestamp_lsw;
+	u32 timestamp_msw;
+	u32 flags;
+} __packed;
+
+struct asm_stream_cmd_open_write_v3 {
+	uint32_t mode_flags;
+	uint16_t sink_endpointype;
+	uint16_t bits_per_sample;
+	uint32_t postprocopo_id;
+	uint32_t dec_fmt_id;
+} __packed;
+
+struct asm_session_cmd_run_v2 {
+	u32 flags;
+	u32 time_lsw;
+	u32 time_msw;
+} __packed;
+
 struct audio_buffer {
 	phys_addr_t phys;
 	uint32_t used;
@@ -85,6 +196,22 @@ struct q6asm {
 	struct platform_device *pdev_dais;
 };
 
+static bool q6asm_is_valid_audio_client(struct audio_client *ac)
+{
+	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
+	int n;
+
+	if (!ac)
+		return false;
+
+	for (n = 1; n <= MAX_SESSIONS; n++) {
+		if (a->session[n] == ac)
+			return true;
+	}
+
+	return false;
+}
+
 static inline void q6asm_add_hdr(struct audio_client *ac, struct apr_hdr *hdr,
 				 uint32_t pkt_size, bool cmd_flg,
 				 uint32_t stream_id)
@@ -388,6 +515,154 @@ static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
 	return a->session[session_id];
 }
 
+static int32_t q6asm_stream_callback(struct apr_device *adev,
+				     struct apr_resp_pkt *data,
+				     int session_id)
+{
+	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+	struct aprv2_ibasic_rsp_result_t *result;
+	struct apr_hdr *hdr = &data->hdr;
+	struct audio_port_data *port;
+	struct audio_client *ac;
+	uint32_t token;
+	uint32_t client_event = 0;
+
+	ac = q6asm_get_audio_client(q6asm, session_id);
+	if (!ac)/* Audio client might already be freed by now */
+		return 0;
+
+	if (!q6asm_is_valid_audio_client(ac))
+		return -EINVAL;
+
+	result = data->payload;
+
+	switch (hdr->opcode) {
+	case APR_BASIC_RSP_RESULT:
+		token = hdr->token;
+		switch (result->opcode) {
+		case ASM_SESSION_CMD_PAUSE:
+			client_event = ASM_CLIENT_EVENT_CMD_PAUSE_DONE;
+			break;
+		case ASM_SESSION_CMD_SUSPEND:
+			client_event = ASM_CLIENT_EVENT_CMD_SUSPEND_DONE;
+			break;
+		case ASM_DATA_CMD_EOS:
+			client_event = ASM_CLIENT_EVENT_CMD_EOS_DONE;
+			break;
+			break;
+		case ASM_STREAM_CMD_FLUSH:
+			client_event = ASM_CLIENT_EVENT_CMD_FLUSH_DONE;
+			break;
+		case ASM_SESSION_CMD_RUN_V2:
+			client_event = ASM_CLIENT_EVENT_CMD_RUN_DONE;
+			break;
+
+		case ASM_STREAM_CMD_FLUSH_READBUFS:
+			if (token != ac->session) {
+				dev_err(ac->dev, "session invalid\n");
+				return -EINVAL;
+			}
+		case ASM_STREAM_CMD_CLOSE:
+			client_event = ASM_CLIENT_EVENT_CMD_CLOSE_DONE;
+			break;
+		case ASM_STREAM_CMD_OPEN_WRITE_V3:
+		case ASM_STREAM_CMD_OPEN_READ_V3:
+		case ASM_STREAM_CMD_OPEN_READWRITE_V2:
+		case ASM_STREAM_CMD_SET_ENCDEC_PARAM:
+		case ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2:
+			if (result->status != 0) {
+				dev_err(ac->dev,
+					"cmd = 0x%x returned error = 0x%x\n",
+					result->opcode, result->status);
+				ac->result = *result;
+				wake_up(&ac->cmd_wait);
+				return 0;
+			}
+			break;
+		default:
+			dev_err(ac->dev, "command[0x%x] not expecting rsp\n",
+				result->opcode);
+			break;
+		}
+
+		ac->result = *result;
+		wake_up(&ac->cmd_wait);
+
+		if (ac->cb)
+			ac->cb(client_event, hdr->token,
+			       data->payload, ac->priv);
+
+		return 0;
+
+	case ASM_DATA_EVENT_WRITE_DONE_V2:
+		port =  &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
+
+		client_event = ASM_CLIENT_EVENT_DATA_WRITE_DONE;
+
+		if (ac->io_mode & ASM_SYNC_IO_MODE) {
+			phys_addr_t phys;
+			unsigned long flags;
+
+			spin_lock_irqsave(&ac->buf_lock, flags);
+			if (!port->buf) {
+				spin_unlock_irqrestore(&ac->buf_lock, flags);
+				return 0;
+			}
+
+			phys = port->buf[hdr->token].phys;
+
+			if (lower_32_bits(phys) != result->opcode ||
+			    upper_32_bits(phys) != result->status) {
+				dev_err(ac->dev, "Expected addr %pa\n",
+					&port->buf[hdr->token].phys);
+				spin_unlock_irqrestore(&ac->buf_lock, flags);
+				return -EINVAL;
+			}
+			token = hdr->token;
+			port->buf[token].used = 1;
+			spin_unlock_irqrestore(&ac->buf_lock, flags);
+		}
+		break;
+	case ASM_DATA_EVENT_READ_DONE_V2:
+		port =  &ac->port[SNDRV_PCM_STREAM_CAPTURE];
+		client_event = ASM_CLIENT_EVENT_DATA_READ_DONE;
+
+		if (ac->io_mode & ASM_SYNC_IO_MODE) {
+			struct asm_data_cmd_read_v2_done *done = data->payload;
+			unsigned long flags;
+			phys_addr_t phys;
+
+			spin_lock_irqsave(&ac->buf_lock, flags);
+			if (!port->buf) {
+				spin_unlock_irqrestore(&ac->buf_lock, flags);
+				return 0;
+			}
+
+			phys = port->buf[hdr->token].phys;
+			token = hdr->token;
+			port->buf[token].used = 0;
+
+			if (upper_32_bits(phys) != done->buf_addr_msw ||
+			    lower_32_bits(phys) != done->buf_addr_lsw) {
+				dev_err(ac->dev, "Expected addr %pa %08x-%08x\n",
+					&port->buf[hdr->token].phys,
+					done->buf_addr_lsw,
+					done->buf_addr_msw);
+				spin_unlock_irqrestore(&ac->buf_lock, flags);
+				return -EINVAL;
+			}
+			spin_unlock_irqrestore(&ac->buf_lock, flags);
+		}
+
+		break;
+	}
+
+	if (ac->cb)
+		ac->cb(client_event, hdr->token, data->payload, ac->priv);
+
+	return 0;
+}
+
 static int q6asm_srvc_callback(struct apr_device *adev,
 			       struct apr_resp_pkt *data)
 {
@@ -399,6 +674,11 @@ static int q6asm_srvc_callback(struct apr_device *adev,
 	struct q6asm *a;
 	uint32_t sid = 0;
 	uint32_t dir = 0;
+	int session_id;
+
+	session_id = (hdr->dest_port >> 8) & 0xFF;
+	if (session_id)
+		return q6asm_stream_callback(adev, data, session_id);
 
 	result = data->payload;
 	sid = (hdr->token >> 8) & 0x0F;
@@ -506,6 +786,563 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev, q6asm_cb cb,
 }
 EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
 
+static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
+{
+	struct apr_hdr *hdr = &pkt->hdr;
+	int rc;
+
+	mutex_lock(&ac->lock);
+	ac->result.opcode = 0;
+	ac->result.status = 0;
+
+	rc = apr_send_pkt(ac->adev, pkt);
+	if (rc < 0)
+		goto err;
+
+	rc = wait_event_timeout(ac->cmd_wait,
+				(ac->result.opcode == hdr->opcode), 5 * HZ);
+	if (!rc) {
+		dev_err(ac->dev, "CMD timeout\n");
+		rc =  -ETIMEDOUT;
+		goto err;
+	}
+
+	if (ac->result.status > 0) {
+		dev_err(ac->dev, "DSP returned error[%x]\n",
+			ac->result.status);
+		rc = -EINVAL;
+	}
+
+
+err:
+	mutex_unlock(&ac->lock);
+	return rc;
+}
+
+/**
+ * q6asm_open_write() - Open audio client for writing
+ *
+ * @ac: audio client pointer
+ * @format: audio sample format
+ * @bits_per_sample: bits per sample
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_open_write(struct audio_client *ac, uint32_t format,
+		     uint16_t bits_per_sample)
+{
+	struct asm_stream_cmd_open_write_v3 *open;
+	struct apr_pkt *pkt;
+	void *p;
+	int rc, pkt_size;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*open);
+
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	open = p + APR_HDR_SIZE;
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, ac->stream_id);
+
+	pkt->hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
+	open->mode_flags = 0x00;
+	open->mode_flags |= ASM_LEGACY_STREAM_SESSION;
+
+	/* source endpoint : matrix */
+	open->sink_endpointype = ASM_END_POINT_DEVICE_MATRIX;
+	open->bits_per_sample = bits_per_sample;
+	open->postprocopo_id = ASM_NULL_POPP_TOPOLOGY;
+
+	switch (format) {
+	case FORMAT_LINEAR_PCM:
+		open->dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
+		break;
+	default:
+		dev_err(ac->dev, "Invalid format 0x%x\n", format);
+		rc = -EINVAL;
+		goto err;
+	}
+
+	rc = q6asm_ac_send_cmd_sync(ac, pkt);
+	if (rc < 0)
+		goto err;
+
+	ac->io_mode |= ASM_TUN_WRITE_IO_MODE;
+
+err:
+	kfree(pkt);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_open_write);
+
+static int __q6asm_run(struct audio_client *ac, uint32_t flags,
+	      uint32_t msw_ts, uint32_t lsw_ts, bool wait)
+{
+	struct asm_session_cmd_run_v2 *run;
+	struct apr_pkt *pkt;
+	int pkt_size, rc;
+	void *p;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*run);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	run = p + APR_HDR_SIZE;
+
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, ac->stream_id);
+
+	pkt->hdr.opcode = ASM_SESSION_CMD_RUN_V2;
+	run->flags = flags;
+	run->time_lsw = lsw_ts;
+	run->time_msw = msw_ts;
+	if (wait) {
+		rc = q6asm_ac_send_cmd_sync(ac, pkt);
+	} else {
+		rc = apr_send_pkt(ac->adev, pkt);
+		if (rc == pkt_size)
+			rc = 0;
+	}
+
+	kfree(pkt);
+	return rc;
+}
+
+/**
+ * q6asm_run() - start the audio client
+ *
+ * @ac: audio client pointer
+ * @flags: flags associated with write
+ * @msw_ts: timestamp msw
+ * @lsw_ts: timestamp lsw
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_run(struct audio_client *ac, uint32_t flags,
+	      uint32_t msw_ts, uint32_t lsw_ts)
+{
+	return __q6asm_run(ac, flags, msw_ts, lsw_ts, true);
+}
+EXPORT_SYMBOL_GPL(q6asm_run);
+
+/**
+ * q6asm_run_nowait() - start the audio client withou blocking
+ *
+ * @ac: audio client pointer
+ * @flags: flags associated with write
+ * @msw_ts: timestamp msw
+ * @lsw_ts: timestamp lsw
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_run_nowait(struct audio_client *ac, uint32_t flags,
+	      uint32_t msw_ts, uint32_t lsw_ts)
+{
+	return __q6asm_run(ac, flags, msw_ts, lsw_ts, false);
+}
+EXPORT_SYMBOL_GPL(q6asm_run_nowait);
+
+/**
+ * q6asm_media_format_block_multi_ch_pcm() - setup pcm configuration
+ *
+ * @ac: audio client pointer
+ * @rate: audio sample rate
+ * @channels: number of audio channels.
+ * @use_default_chmap: flag to use default ch map.
+ * @channel_map: channel map pointer
+ * @bits_per_sample: bits per sample
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_media_format_block_multi_ch_pcm(struct audio_client *ac,
+					  uint32_t rate, uint32_t channels,
+					  u8 channel_map[PCM_MAX_NUM_CHANNEL],
+					  uint16_t bits_per_sample)
+{
+	struct asm_multi_channel_pcm_fmt_blk_v2 *fmt;
+	struct apr_pkt *pkt;
+	u8 *channel_mapping;
+	void *p;
+	int rc, pkt_size;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	fmt = p + APR_HDR_SIZE;
+
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, ac->stream_id);
+
+	pkt->hdr.opcode = ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2;
+	fmt->fmt_blk.fmt_blk_size = sizeof(*fmt) - sizeof(fmt->fmt_blk);
+	fmt->num_channels = channels;
+	fmt->bits_per_sample = bits_per_sample;
+	fmt->sample_rate = rate;
+	fmt->is_signed = 1;
+
+	channel_mapping = fmt->channel_mapping;
+
+	if (channel_map) {
+		memcpy(channel_mapping, channel_map, PCM_MAX_NUM_CHANNEL);
+	} else {
+		if (q6dsp_map_channels(channel_mapping, channels)) {
+			dev_err(ac->dev, " map channels failed %d\n", channels);
+			rc = -EINVAL;
+			goto err;
+		}
+	}
+
+	rc = q6asm_ac_send_cmd_sync(ac, pkt);
+
+err:
+	kfree(pkt);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_media_format_block_multi_ch_pcm);
+
+/**
+ * q6asm_enc_cfg_blk_pcm_format_support() - setup pcm configuration for capture
+ *
+ * @ac: audio client pointer
+ * @rate: audio sample rate
+ * @channels: number of audio channels.
+ * @use_default_chmap: flag to use default ch map.
+ * @channel_map: channel map pointer
+ * @bits_per_sample: bits per sample
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_enc_cfg_blk_pcm_format_support(struct audio_client *ac,
+		uint32_t rate, uint32_t channels, uint16_t bits_per_sample)
+{
+	struct asm_multi_channel_pcm_enc_cfg_v2  *enc_cfg;
+	struct apr_pkt *pkt;
+	u8 *channel_mapping;
+	u32 frames_per_buf = 0;
+	int pkt_size, rc;
+	void *p;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*enc_cfg);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	enc_cfg = p + APR_HDR_SIZE;
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, ac->stream_id);
+
+	pkt->hdr.opcode = ASM_STREAM_CMD_SET_ENCDEC_PARAM;
+	enc_cfg->encdec.param_id = ASM_PARAM_ID_ENCDEC_ENC_CFG_BLK_V2;
+	enc_cfg->encdec.param_size = sizeof(*enc_cfg) - sizeof(enc_cfg->encdec);
+	enc_cfg->encblk.frames_per_buf = frames_per_buf;
+	enc_cfg->encblk.enc_cfg_blk_size  = enc_cfg->encdec.param_size -
+					sizeof(struct asm_enc_cfg_blk_param_v2);
+
+	enc_cfg->num_channels = channels;
+	enc_cfg->bits_per_sample = bits_per_sample;
+	enc_cfg->sample_rate = rate;
+	enc_cfg->is_signed = 1;
+	channel_mapping = enc_cfg->channel_mapping;
+
+	if (q6dsp_map_channels(channel_mapping, channels)) {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	rc = q6asm_ac_send_cmd_sync(ac, pkt);
+err:
+	kfree(pkt);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_enc_cfg_blk_pcm_format_support);
+
+/**
+ * q6asm_read() - read data of period size from audio client
+ *
+ * @ac: audio client pointer
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_read(struct audio_client *ac)
+{
+	struct asm_data_cmd_read_v2 *read;
+	struct audio_port_data *port;
+	struct audio_buffer *ab;
+	struct apr_pkt *pkt;
+	int pkt_size;
+	int rc = 0;
+	void *p;
+
+	if (!(ac->io_mode & ASM_SYNC_IO_MODE))
+		return 0;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*read);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	read = p + APR_HDR_SIZE;
+
+	port = &ac->port[SNDRV_PCM_STREAM_CAPTURE];
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, false, ac->stream_id);
+	ab = &port->buf[port->dsp_buf];
+	pkt->hdr.opcode = ASM_DATA_CMD_READ_V2;
+	read->buf_addr_lsw = lower_32_bits(ab->phys);
+	read->buf_addr_msw = upper_32_bits(ab->phys);
+	read->mem_map_handle = port->mem_map_handle;
+
+	read->buf_size = ab->size;
+	read->seq_id = port->dsp_buf;
+	pkt->hdr.token = port->dsp_buf;
+
+	port->dsp_buf++;
+
+	if (port->dsp_buf >= port->num_periods)
+		port->dsp_buf = 0;
+
+	rc = apr_send_pkt(ac->adev, pkt);
+	if (rc == pkt_size)
+		rc = 0;
+	else
+		pr_err("read op[0x%x]rc[%d]\n", pkt->hdr.opcode, rc);
+
+	kfree(pkt);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_read);
+
+static int __q6asm_open_read(struct audio_client *ac,
+		uint32_t format, uint16_t bits_per_sample)
+{
+	struct asm_stream_cmd_open_read_v3 *open;
+	struct apr_pkt *pkt;
+	int pkt_size, rc;
+	void *p;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*open);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	open = p + APR_HDR_SIZE;
+
+	q6asm_add_hdr(ac, &pkt->hdr,  pkt_size, true, ac->stream_id);
+	pkt->hdr.opcode = ASM_STREAM_CMD_OPEN_READ_V3;
+	/* Stream prio : High, provide meta info with encoded frames */
+	open->src_endpointype = ASM_END_POINT_DEVICE_MATRIX;
+
+	open->preprocopo_id = ASM_STREAM_POSTPROC_TOPO_ID_NONE;
+	open->bits_per_sample = bits_per_sample;
+	open->mode_flags = 0x0;
+
+	open->mode_flags |= ASM_LEGACY_STREAM_SESSION <<
+				ASM_SHIFT_STREAM_PERF_MODE_FLAG_IN_OPEN_READ;
+
+	switch (format) {
+	case FORMAT_LINEAR_PCM:
+		open->mode_flags |= 0x00;
+		open->enc_cfg_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
+		break;
+	default:
+		pr_err("Invalid format[%d]\n", format);
+	}
+
+	rc = q6asm_ac_send_cmd_sync(ac, pkt);
+
+	kfree(pkt);
+	return rc;
+}
+
+/**
+ * q6asm_open_read() - Open audio client for reading
+ *
+ * @ac: audio client pointer
+ * @format: audio sample format
+ * @bits_per_sample: bits per sample
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_open_read(struct audio_client *ac, uint32_t format,
+			uint16_t bits_per_sample)
+{
+	return __q6asm_open_read(ac, format, bits_per_sample);
+}
+EXPORT_SYMBOL_GPL(q6asm_open_read);
+
+/**
+ * q6asm_write_async() - non blocking write
+ *
+ * @ac: audio client pointer
+ * @len: lenght in bytes
+ * @msw_ts: timestamp msw
+ * @lsw_ts: timestamp lsw
+ * @flags: flags associated with write
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_write_async(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
+		       uint32_t lsw_ts, uint32_t flags)
+{
+	struct asm_data_cmd_write_v2 *write;
+	struct audio_port_data *port;
+	struct audio_buffer *ab;
+	struct apr_pkt *pkt;
+	int pkt_size;
+	int rc = 0;
+	void *p;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*write);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	write = p + APR_HDR_SIZE;
+
+	if (!(ac->io_mode & ASM_SYNC_IO_MODE))
+		return 0;
+
+	port = &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, false, ac->stream_id);
+
+	ab = &port->buf[port->dsp_buf];
+
+	pkt->hdr.token = port->dsp_buf;
+	pkt->hdr.opcode = ASM_DATA_CMD_WRITE_V2;
+	write->buf_addr_lsw = lower_32_bits(ab->phys);
+	write->buf_addr_msw = upper_32_bits(ab->phys);
+	write->buf_size = len;
+	write->seq_id = port->dsp_buf;
+	write->timestamp_lsw = lsw_ts;
+	write->timestamp_msw = msw_ts;
+	write->mem_map_handle =
+	    ac->port[SNDRV_PCM_STREAM_PLAYBACK].mem_map_handle;
+
+	if (flags == NO_TIMESTAMP)
+		write->flags = (flags & 0x800000FF);
+	else
+		write->flags = (0x80000000 | flags);
+
+	port->dsp_buf++;
+
+	if (port->dsp_buf >= port->num_periods)
+		port->dsp_buf = 0;
+
+	rc = apr_send_pkt(ac->adev, pkt);
+	if (rc == pkt_size)
+		rc = 0;
+
+	kfree(pkt);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_write_async);
+
+static void q6asm_reset_buf_state(struct audio_client *ac)
+{
+	struct audio_port_data *port = NULL;
+	unsigned long flags;
+	int loopcnt = 0;
+	int cnt = 0;
+	int used;
+
+	if (!(ac->io_mode & ASM_SYNC_IO_MODE))
+		return;
+
+	used = (ac->io_mode & ASM_TUN_WRITE_IO_MODE ? 1 : 0);
+	spin_lock_irqsave(&ac->buf_lock, flags);
+	for (loopcnt = 0; loopcnt <= SNDRV_PCM_STREAM_CAPTURE; loopcnt++) {
+		port = &ac->port[loopcnt];
+		cnt = port->num_periods - 1;
+		port->dsp_buf = 0;
+		while (cnt >= 0) {
+			if (!port->buf)
+				continue;
+			port->buf[cnt].used = used;
+			cnt--;
+		}
+	}
+	spin_unlock_irqrestore(&ac->buf_lock, flags);
+}
+
+static int __q6asm_cmd(struct audio_client *ac, int cmd, bool wait)
+{
+	int stream_id = ac->stream_id;
+	struct apr_pkt pkt;
+	int rc;
+
+	q6asm_add_hdr(ac, &pkt.hdr, APR_HDR_SIZE, true, stream_id);
+
+	switch (cmd) {
+	case CMD_PAUSE:
+		pkt.hdr.opcode = ASM_SESSION_CMD_PAUSE;
+		break;
+	case CMD_SUSPEND:
+		pkt.hdr.opcode = ASM_SESSION_CMD_SUSPEND;
+		break;
+	case CMD_FLUSH:
+		pkt.hdr.opcode = ASM_STREAM_CMD_FLUSH;
+		break;
+	case CMD_OUT_FLUSH:
+		pkt.hdr.opcode = ASM_STREAM_CMD_FLUSH_READBUFS;
+		break;
+	case CMD_EOS:
+		pkt.hdr.opcode = ASM_DATA_CMD_EOS;
+		break;
+	case CMD_CLOSE:
+		pkt.hdr.opcode = ASM_STREAM_CMD_CLOSE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (wait)
+		rc = q6asm_ac_send_cmd_sync(ac, &pkt);
+	else
+		return apr_send_pkt(ac->adev, &pkt);
+
+	if (rc < 0)
+		return rc;
+
+	if (cmd == CMD_FLUSH)
+		q6asm_reset_buf_state(ac);
+
+	return 0;
+}
+
+/**
+ * q6asm_cmd() - run cmd on audio client
+ *
+ * @ac: audio client pointer
+ * @cmd: command to run on audio client.
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_cmd(struct audio_client *ac, int cmd)
+{
+	return __q6asm_cmd(ac, cmd, true);
+}
+EXPORT_SYMBOL_GPL(q6asm_cmd);
+
+/**
+ * q6asm_cmd_nowait() - non blocking, run cmd on audio client
+ *
+ * @ac: audio client pointer
+ * @cmd: command to run on audio client.
+ *
+ * Return: Will be an negative value on error or zero on success
+ */
+int q6asm_cmd_nowait(struct audio_client *ac, int cmd)
+{
+	return __q6asm_cmd(ac, cmd, false);
+}
+EXPORT_SYMBOL_GPL(q6asm_cmd_nowait);
 
 static int q6asm_probe(struct apr_device *adev)
 {
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 93e86d922087..681083dc07f7 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -1,8 +1,36 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __Q6_ASM_H__
 #define __Q6_ASM_H__
+#include "q6dsp-common.h"
+#include <dt-bindings/sound/qcom,q6asm.h>
+
+/* ASM client callback events */
+#define CMD_PAUSE			0x0001
+#define ASM_CLIENT_EVENT_CMD_PAUSE_DONE		0x1001
+#define CMD_FLUSH				0x0002
+#define ASM_CLIENT_EVENT_CMD_FLUSH_DONE		0x1002
+#define CMD_EOS				0x0003
+#define ASM_CLIENT_EVENT_CMD_EOS_DONE		0x1003
+#define CMD_CLOSE				0x0004
+#define ASM_CLIENT_EVENT_CMD_CLOSE_DONE		0x1004
+#define CMD_OUT_FLUSH				0x0005
+#define ASM_CLIENT_EVENT_CMD_OUT_FLUSH_DONE	0x1005
+#define CMD_SUSPEND				0x0006
+#define ASM_CLIENT_EVENT_CMD_SUSPEND_DONE	0x1006
+#define ASM_CLIENT_EVENT_CMD_RUN_DONE		0x1008
+#define ASM_CLIENT_EVENT_DATA_WRITE_DONE	0x1009
+#define ASM_CLIENT_EVENT_DATA_READ_DONE		0x100a
+
+enum {
+	LEGACY_PCM_MODE = 0,
+	LOW_LATENCY_PCM_MODE,
+	ULTRA_LOW_LATENCY_PCM_MODE,
+	ULL_POST_PROCESSING_PCM_MODE,
+};
 
 #define MAX_SESSIONS	16
+#define NO_TIMESTAMP    0xFF00
+#define FORMAT_LINEAR_PCM   0x0000
 
 typedef void (*q6asm_cb) (uint32_t opcode, uint32_t token,
 			  void *payload, void *priv);
@@ -11,6 +39,27 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev,
 					      q6asm_cb cb, void *priv,
 					      int session_id, int perf_mode);
 void q6asm_audio_client_free(struct audio_client *ac);
+int q6asm_write_async(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
+		       uint32_t lsw_ts, uint32_t flags);
+int q6asm_open_write(struct audio_client *ac, uint32_t format,
+		     uint16_t bits_per_sample);
+
+int q6asm_open_read(struct audio_client *ac, uint32_t format,
+		     uint16_t bits_per_sample);
+int q6asm_enc_cfg_blk_pcm_format_support(struct audio_client *ac,
+		uint32_t rate, uint32_t channels, uint16_t bits_per_sample);
+int q6asm_read(struct audio_client *ac);
+
+int q6asm_media_format_block_multi_ch_pcm(struct audio_client *ac,
+					  uint32_t rate, uint32_t channels,
+					  u8 channel_map[PCM_MAX_NUM_CHANNEL],
+					  uint16_t bits_per_sample);
+int q6asm_run(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
+	      uint32_t lsw_ts);
+int q6asm_run_nowait(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
+		     uint32_t lsw_ts);
+int q6asm_cmd(struct audio_client *ac, int cmd);
+int q6asm_cmd_nowait(struct audio_client *ac, int cmd);
 int q6asm_get_session_id(struct audio_client *ac);
 int q6asm_map_memory_regions(unsigned int dir,
 			     struct audio_client *ac,
-- 
2.16.2
