Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648880; cv=none;
        d=google.com; s=arc-20160816;
        b=rf0sJ8CVwXs4Em+SbfURa/t73CDPDeTQ8ZIE2Zb9c3fmLuuGb33c5EgvDze6ZuCtNh
         isQkBpgqlk1czFWtE9iYlSaSRFXyj/OHVtZiu8obaY5EmQ4bhfwPgeiNbM++j2Ge+eiI
         BMRfchuw1z5AqW5LIE2Yyjuuts7kmKTL/AnygEgP3xFVZ7xHt6rww/hDqWZAZY5pstJ2
         clJ4SPPyrwoX0z5i9Xr4UVaHG8oBD3UgC3VurAQ8fZy3bZM2b/sfXwy4qw2iU2C6BjgD
         P71LoW8WCUJAvdohlsXbifkLCl+OrEMHJUK9HoXu5YF+riIr4Q5p/XPOVbBC+kp1mPUH
         rklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=AD0IuZqrV6IcnUw35aXrYA/21Q1fwhQSpOgdkWo1Eug=;
        b=z9PQz2WkSox7la6E1qlEk5vsMJsqqUVk/eOPPViNjB60sU2IR/UuNFCcAUxjvkA9Lv
         4FZynUSvuhAFs2l5e7eS7rdjmnbQxDMGMCXXH+HCcsvrXvxUs+EEvT/2D8aewrA+qaWo
         ByRKnROM5z7IJmGj9T3x4h41q1rVHVApFLhR+Z4fPVQ3McJwEZoS42eimQDEm0XBAhu0
         aG8xH0W3n5Lsv3JKQuK1+SEdsuI7QF4W+CDWS9FKvRXP7gJubPLRdPfVf4qGvbJOCjmA
         JJpLlZUwsqCq/zBjfrA+CVqk05r3MutGIWw55CkwakuquuE8gdDGxdAp3E9QSE+7Dj4t
         Vjjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KXV1Cp/o;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KXV1Cp/o;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsx3xa9jpepjLQhbH4OrVvBp9JaZWe6croW6RgV1fIbodS+D2Iv8vGbKc1oEB5sj0+qBzgikg==
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
Subject: [PATCH v4 14/24] ASoC: qdsp6: q6asm: Add support to audio stream apis
Date: Sat, 10 Mar 2018 02:24:46 +0000
Message-Id: <20180310022456.26739-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515920555563949?=
X-GMAIL-MSGID: =?utf-8?q?1594515920555563949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to open, write and media format commands
in the q6asm module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 744 ++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.h |  49 +++
 2 files changed, 792 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 8a2ca2ff9ce8..ddbf526358bd 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -9,6 +9,8 @@
 #include <linux/device.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
+#include <uapi/sound/asound.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -17,10 +19,36 @@
 #include "q6dsp-errno.h"
 #include "q6dsp-common.h"
 
+#define ASM_STREAM_CMD_CLOSE			0x00010BCD
+#define ASM_STREAM_CMD_FLUSH			0x00010BCE
+#define ASM_SESSION_CMD_PAUSE			0x00010BD3
+#define ASM_DATA_CMD_EOS			0x00010BDB
+#define ASM_DEFAULT_POPP_TOPOLOGY		0x00010BE4
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
@@ -46,6 +74,96 @@ struct avs_cmd_shared_mem_unmap_regions {
 	u32 mem_map_handle;
 } __packed;
 
+struct asm_data_cmd_media_fmt_update_v2 {
+	u32 fmt_blk_size;
+} __packed;
+
+struct asm_multi_channel_pcm_fmt_blk_v2 {
+	struct apr_hdr hdr;
+	struct asm_data_cmd_media_fmt_update_v2 fmt_blk;
+	u16 num_channels;
+	u16 bits_per_sample;
+	u32 sample_rate;
+	u16 is_signed;
+	u16 reserved;
+	u8 channel_mapping[PCM_FORMAT_MAX_NUM_CHANNEL];
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
+	struct apr_hdr hdr;
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
+	struct apr_hdr       hdr;
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
+	struct apr_hdr hdr;
+	u32                    mode_flags;
+	u32                    src_endpointype;
+	u32                    preprocopo_id;
+	u32                    enc_cfg_id;
+	u16                    bits_per_sample;
+	u16                    reserved;
+} __packed;
+
+struct asm_data_cmd_write_v2 {
+	struct apr_hdr hdr;
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
+	struct apr_hdr hdr;
+	uint32_t mode_flags;
+	uint16_t sink_endpointype;
+	uint16_t bits_per_sample;
+	uint32_t postprocopo_id;
+	uint32_t dec_fmt_id;
+} __packed;
+
+struct asm_session_cmd_run_v2 {
+	struct apr_hdr hdr;
+	u32 flags;
+	u32 time_lsw;
+	u32 time_msw;
+} __packed;
+
 struct audio_buffer {
 	phys_addr_t phys;
 	uint32_t used;
@@ -394,6 +512,153 @@ static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
 	return a->session[session_id];
 }
 
+static int32_t q6asm_stream_callback(struct apr_device *adev,
+				     struct apr_client_message *data,
+				     int session_id)
+{
+	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+	struct aprv2_ibasic_rsp_result_t *result;
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
+	switch (data->opcode) {
+	case APR_BASIC_RSP_RESULT:
+		token = data->token;
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
+			ac->cb(client_event, data->token,
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
+			phys = port->buf[data->token].phys;
+
+			if (lower_32_bits(phys) != result->opcode ||
+			    upper_32_bits(phys) != result->status) {
+				dev_err(ac->dev, "Expected addr %pa\n",
+					&port->buf[data->token].phys);
+				spin_unlock_irqrestore(&ac->buf_lock, flags);
+				return -EINVAL;
+			}
+			token = data->token;
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
+			phys = port->buf[data->token].phys;
+			token = data->token;
+			port->buf[token].used = 0;
+
+			if (upper_32_bits(phys) != done->buf_addr_msw ||
+			    lower_32_bits(phys) != done->buf_addr_lsw) {
+				dev_err(ac->dev, "Expected addr %pa %08x-%08x\n",
+					&port->buf[data->token].phys,
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
+		ac->cb(client_event, data->token, data->payload, ac->priv);
+
+	return 0;
+}
+
 static int q6asm_srvc_callback(struct apr_device *adev,
 			       struct apr_client_message *data)
 {
@@ -403,6 +668,11 @@ static int q6asm_srvc_callback(struct apr_device *adev,
 	struct audio_port_data *port;
 	uint32_t dir = 0;
 	uint32_t sid = 0;
+	int session_id;
+
+	session_id = (data->dest_port >> 8) & 0xFF;
+	if (session_id)
+		return q6asm_stream_callback(adev, data, session_id);
 
 	result = data->payload;
 	sid = (data->token >> 8) & 0x0F;
@@ -510,6 +780,478 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev, q6asm_cb cb,
 }
 EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
 
+static int q6asm_ac_send_cmd_sync(struct audio_client *ac, void *cmd)
+{
+	struct apr_hdr *hdr = cmd;
+	int rc;
+
+	mutex_lock(&ac->lock);
+	ac->result.opcode = 0;
+	ac->result.status = 0;
+
+	rc = apr_send_pkt(ac->adev, cmd);
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
+	struct asm_stream_cmd_open_write_v3 open;
+	int rc;
+
+	q6asm_add_hdr(ac, &open.hdr, sizeof(open), true, ac->stream_id);
+
+	open.hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
+	open.mode_flags = 0x00;
+	open.mode_flags |= ASM_LEGACY_STREAM_SESSION;
+
+	/* source endpoint : matrix */
+	open.sink_endpointype = ASM_END_POINT_DEVICE_MATRIX;
+	open.bits_per_sample = bits_per_sample;
+	open.postprocopo_id = ASM_DEFAULT_POPP_TOPOLOGY;
+
+	switch (format) {
+	case FORMAT_LINEAR_PCM:
+		open.dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
+		break;
+	default:
+		dev_err(ac->dev, "Invalid format 0x%x\n", format);
+		return -EINVAL;
+	}
+
+	rc = q6asm_ac_send_cmd_sync(ac, &open);
+	if (rc < 0)
+		return rc;
+
+	ac->io_mode |= ASM_TUN_WRITE_IO_MODE;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6asm_open_write);
+
+static int __q6asm_run(struct audio_client *ac, uint32_t flags,
+	      uint32_t msw_ts, uint32_t lsw_ts, bool wait)
+{
+	struct asm_session_cmd_run_v2 run;
+
+	q6asm_add_hdr(ac, &run.hdr, sizeof(run), true, ac->stream_id);
+
+	run.hdr.opcode = ASM_SESSION_CMD_RUN_V2;
+	run.flags = flags;
+	run.time_lsw = lsw_ts;
+	run.time_msw = msw_ts;
+	if (wait)
+		return q6asm_ac_send_cmd_sync(ac, &run);
+	else
+		return  apr_send_pkt(ac->adev, &run);
+
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
+					  u8 channel_map[PCM_FORMAT_MAX_NUM_CHANNEL],
+					  uint16_t bits_per_sample)
+{
+	struct asm_multi_channel_pcm_fmt_blk_v2 fmt;
+	u8 *channel_mapping;
+	int rc;
+
+	q6asm_add_hdr(ac, &fmt.hdr, sizeof(fmt), true, ac->stream_id);
+
+	fmt.hdr.opcode = ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2;
+	fmt.fmt_blk.fmt_blk_size = sizeof(fmt) - sizeof(fmt.hdr) -
+	    sizeof(fmt.fmt_blk);
+	fmt.num_channels = channels;
+	fmt.bits_per_sample = bits_per_sample;
+	fmt.sample_rate = rate;
+	fmt.is_signed = 1;
+
+	channel_mapping = fmt.channel_mapping;
+
+	if (channel_map) {
+		memcpy(channel_mapping, channel_map,
+		       PCM_FORMAT_MAX_NUM_CHANNEL);
+	} else {
+		if (q6dsp_map_channels(channel_mapping, channels)) {
+			dev_err(ac->dev, " map channels failed %d\n", channels);
+			return -EINVAL;
+		}
+	}
+
+	rc = q6asm_ac_send_cmd_sync(ac, &fmt);
+	if (rc < 0)
+		goto fail_cmd;
+
+	return 0;
+fail_cmd:
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
+	struct asm_multi_channel_pcm_enc_cfg_v2  enc_cfg;
+	u8 *channel_mapping;
+	u32 frames_per_buf = 0;
+
+	q6asm_add_hdr(ac, &enc_cfg.hdr, sizeof(enc_cfg), true, ac->stream_id);
+	enc_cfg.hdr.opcode = ASM_STREAM_CMD_SET_ENCDEC_PARAM;
+	enc_cfg.encdec.param_id = ASM_PARAM_ID_ENCDEC_ENC_CFG_BLK_V2;
+	enc_cfg.encdec.param_size = sizeof(enc_cfg) - sizeof(enc_cfg.hdr) -
+				sizeof(enc_cfg.encdec);
+	enc_cfg.encblk.frames_per_buf = frames_per_buf;
+	enc_cfg.encblk.enc_cfg_blk_size  = enc_cfg.encdec.param_size -
+					sizeof(struct asm_enc_cfg_blk_param_v2);
+
+	enc_cfg.num_channels = channels;
+	enc_cfg.bits_per_sample = bits_per_sample;
+	enc_cfg.sample_rate = rate;
+	enc_cfg.is_signed = 1;
+	channel_mapping = enc_cfg.channel_mapping;
+
+	memset(channel_mapping, 0, PCM_FORMAT_MAX_NUM_CHANNEL);
+
+	if (q6dsp_map_channels(channel_mapping, channels))
+		return -EINVAL;
+
+
+	return q6asm_ac_send_cmd_sync(ac, &enc_cfg);
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
+	struct asm_data_cmd_read_v2 read;
+	struct audio_port_data *port;
+	struct audio_buffer *ab;
+	int rc;
+
+	if (!(ac->io_mode & ASM_SYNC_IO_MODE))
+		return 0;
+
+	port = &ac->port[SNDRV_PCM_STREAM_CAPTURE];
+	q6asm_add_hdr(ac, &read.hdr, sizeof(read), false, ac->stream_id);
+	ab = &port->buf[port->dsp_buf];
+	read.hdr.opcode = ASM_DATA_CMD_READ_V2;
+	read.buf_addr_lsw = lower_32_bits(ab->phys);
+	read.buf_addr_msw = upper_32_bits(ab->phys);
+	read.mem_map_handle = ac->port[SNDRV_PCM_STREAM_CAPTURE].mem_map_handle;
+
+	read.buf_size = ab->size;
+	read.seq_id = port->dsp_buf;
+	read.hdr.token = port->dsp_buf;
+
+	port->dsp_buf++;
+
+	if (port->dsp_buf >= port->num_periods)
+		port->dsp_buf = 0;
+
+	rc = apr_send_pkt(ac->adev, &read);
+	if (rc < 0) {
+		pr_err("read op[0x%x]rc[%d]\n", read.hdr.opcode, rc);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6asm_read);
+
+static int __q6asm_open_read(struct audio_client *ac,
+		uint32_t format, uint16_t bits_per_sample)
+{
+	struct asm_stream_cmd_open_read_v3 open;
+
+	q6asm_add_hdr(ac, &open.hdr, sizeof(open), true, ac->stream_id);
+	open.hdr.opcode = ASM_STREAM_CMD_OPEN_READ_V3;
+	/* Stream prio : High, provide meta info with encoded frames */
+	open.src_endpointype = ASM_END_POINT_DEVICE_MATRIX;
+
+	open.preprocopo_id = ASM_STREAM_POSTPROC_TOPO_ID_NONE;
+	open.bits_per_sample = bits_per_sample;
+	open.mode_flags = 0x0;
+
+	open.mode_flags |= ASM_LEGACY_STREAM_SESSION <<
+				ASM_SHIFT_STREAM_PERF_MODE_FLAG_IN_OPEN_READ;
+
+	switch (format) {
+	case FORMAT_LINEAR_PCM:
+		open.mode_flags |= 0x00;
+		open.enc_cfg_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
+		break;
+	default:
+		pr_err("Invalid format[%d]\n", format);
+	}
+
+	return q6asm_ac_send_cmd_sync(ac, &open);
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
+	struct asm_data_cmd_write_v2 write;
+	struct audio_port_data *port;
+	struct audio_buffer *ab;
+	int rc = 0;
+
+	if (!(ac->io_mode & ASM_SYNC_IO_MODE))
+		return 0;
+
+	port = &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
+	q6asm_add_hdr(ac, &write.hdr, sizeof(write), false,
+		      ac->stream_id);
+
+	ab = &port->buf[port->dsp_buf];
+
+	write.hdr.token = port->dsp_buf;
+	write.hdr.opcode = ASM_DATA_CMD_WRITE_V2;
+	write.buf_addr_lsw = lower_32_bits(ab->phys);
+	write.buf_addr_msw = upper_32_bits(ab->phys);
+	write.buf_size = len;
+	write.seq_id = port->dsp_buf;
+	write.timestamp_lsw = lsw_ts;
+	write.timestamp_msw = msw_ts;
+	write.mem_map_handle =
+	    ac->port[SNDRV_PCM_STREAM_PLAYBACK].mem_map_handle;
+
+	if (flags == NO_TIMESTAMP)
+		write.flags = (flags & 0x800000FF);
+	else
+		write.flags = (0x80000000 | flags);
+
+	port->dsp_buf++;
+
+	if (port->dsp_buf >= port->num_periods)
+		port->dsp_buf = 0;
+
+	rc = apr_send_pkt(ac->adev, &write);
+	if (rc < 0)
+		return rc;
+
+	return 0;
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
+	struct apr_hdr hdr;
+	int rc;
+
+	q6asm_add_hdr(ac, &hdr, sizeof(hdr), true, stream_id);
+
+	switch (cmd) {
+	case CMD_PAUSE:
+		hdr.opcode = ASM_SESSION_CMD_PAUSE;
+		break;
+	case CMD_SUSPEND:
+		hdr.opcode = ASM_SESSION_CMD_SUSPEND;
+		break;
+	case CMD_FLUSH:
+		hdr.opcode = ASM_STREAM_CMD_FLUSH;
+		break;
+	case CMD_OUT_FLUSH:
+		hdr.opcode = ASM_STREAM_CMD_FLUSH_READBUFS;
+		break;
+	case CMD_EOS:
+		hdr.opcode = ASM_DATA_CMD_EOS;
+		break;
+	case CMD_CLOSE:
+		hdr.opcode = ASM_STREAM_CMD_CLOSE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (wait)
+		rc = q6asm_ac_send_cmd_sync(ac, &hdr);
+	else
+		return apr_send_pkt(ac->adev, &hdr);
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
index faa49ca1cde6..9ed15e0edaf0 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -1,8 +1,36 @@
 // SPDX-License-Identifier: GPL-2.0
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
+					  u8 channel_map[PCM_FORMAT_MAX_NUM_CHANNEL],
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
2.15.1
