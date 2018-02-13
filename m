Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965531AbeBMRBr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:01:47 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34412 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965452AbeBMRBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:31 -0500
X-Google-Smtp-Source: AH8x226/7xzqo1E+SLwVj3MzNxnSXQS96WetUqDX3bYALW8FKjgUhKdxWUYEnzZz0o5GhoGRwvLDzA==
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
Subject: [PATCH v3 11/25] ASoC: qcom: q6asm: add support to audio stream apis
Date: Tue, 13 Feb 2018 16:58:23 +0000
Message-Id: <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to open, write and media format commands
in the q6asm module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/dt-bindings/sound/qcom,q6asm.h |  22 ++
 sound/soc/qcom/qdsp6/q6asm.c           | 503 ++++++++++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.h           |  41 +++
 3 files changed, 564 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/sound/qcom,q6asm.h

diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
new file mode 100644
index 000000000000..4e85bf804cec
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6asm.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __DT_BINDINGS_Q6_ASM_H__
+#define __DT_BINDINGS_Q6_ASM_H__
+
+#define MSM_FRONTEND_DAI_MULTIMEDIA1	0
+#define MSM_FRONTEND_DAI_MULTIMEDIA2	1
+#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
+#define MSM_FRONTEND_DAI_MULTIMEDIA4	3
+#define MSM_FRONTEND_DAI_MULTIMEDIA5	4
+#define MSM_FRONTEND_DAI_MULTIMEDIA6	5
+#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
+#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
+#define	MSM_FRONTEND_DAI_MULTIMEDIA9	8
+#define	MSM_FRONTEND_DAI_MULTIMEDIA10	9
+#define	MSM_FRONTEND_DAI_MULTIMEDIA11	10
+#define	MSM_FRONTEND_DAI_MULTIMEDIA12	11
+#define	MSM_FRONTEND_DAI_MULTIMEDIA13	12
+#define	MSM_FRONTEND_DAI_MULTIMEDIA14	13
+#define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
+#define	MSM_FRONTEND_DAI_MULTIMEDIA16	15
+
+#endif /* __DT_BINDINGS_Q6_ASM_H__ */
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 412275edb15c..0ee1e30a8d8e 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -10,6 +10,7 @@
 #include <linux/soc/qcom/apr.h>
 #include <linux/device.h>
 #include <linux/of.h>
+#include <uapi/sound/asound.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -17,10 +18,26 @@
 #include "q6dsp-errno.h"
 #include "q6dsp-common.h"
 
+#define ASM_STREAM_CMD_CLOSE			0x00010BCD
+#define ASM_STREAM_CMD_FLUSH			0x00010BCE
+#define ASM_SESSION_CMD_PAUSE			0x00010BD3
+#define ASM_DATA_CMD_EOS			0x00010BDB
+#define ASM_DEFAULT_POPP_TOPOLOGY		0x00010BE4
+#define ASM_STREAM_CMD_FLUSH_READBUFS		0x00010C09
 #define ASM_CMD_SHARED_MEM_MAP_REGIONS		0x00010D92
 #define ASM_CMDRSP_SHARED_MEM_MAP_REGIONS	0x00010D93
 #define ASM_CMD_SHARED_MEM_UNMAP_REGIONS	0x00010D94
-
+#define ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2	0x00010D98
+#define ASM_DATA_EVENT_WRITE_DONE_V2		0x00010D99
+#define ASM_SESSION_CMD_RUN_V2			0x00010DAA
+#define ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2	0x00010DA5
+#define ASM_DATA_CMD_WRITE_V2			0x00010DAB
+#define ASM_SESSION_CMD_SUSPEND			0x00010DEC
+#define ASM_STREAM_CMD_OPEN_WRITE_V3		0x00010DB3
+
+#define ASM_LEGACY_STREAM_SESSION	0
+#define ASM_END_POINT_DEVICE_MATRIX	0
+#define ASM_DEFAULT_APP_TYPE		0
 #define ASM_SYNC_IO_MODE		0x0001
 #define ASM_ASYNC_IO_MODE		0x0002
 #define ASM_TUN_READ_IO_MODE		0x0004	/* tunnel read write mode */
@@ -46,6 +63,49 @@ struct avs_cmd_shared_mem_unmap_regions {
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
@@ -131,7 +191,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
 
 	rc = wait_event_timeout(a->mem_wait, (a->mem_state <= 0), 5 * HZ);
 	if (!rc) {
-		dev_err(a->dev, "CMD timeout \n");
+		dev_err(a->dev, "CMD timeout\n");
 		rc = -ETIMEDOUT;
 	} else if (a->mem_state < 0) {
 		rc =  q6dsp_errno(a->mem_state);
@@ -395,6 +455,108 @@ void *q6asm_get_dai_data(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(q6asm_get_dai_data);
 
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
+		case ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2:
+			if (result->status != 0) {
+				dev_err(ac->dev,
+					"cmd = 0x%x returned error = 0x%x\n",
+					result->opcode, result->status);
+				ac->cmd_state = -result->status;
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
+		if (ac->cmd_state) {
+			ac->cmd_state = 0;
+			wake_up(&ac->cmd_wait);
+		}
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
+			phys_addr_t phys = port->buf[data->token].phys;
+
+			if (lower_32_bits(phys) != result->opcode ||
+			    upper_32_bits(phys) != result->status) {
+				dev_err(ac->dev, "Expected addr %pa\n",
+					&port->buf[data->token].phys);
+				return -EINVAL;
+			}
+			token = data->token;
+			port->buf[token].used = 1;
+		}
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
@@ -404,6 +566,11 @@ static int q6asm_srvc_callback(struct apr_device *adev,
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
@@ -519,6 +686,338 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev, q6asm_cb cb,
 }
 EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
 
+static int q6asm_ac_send_cmd_sync(struct audio_client *ac, void *cmd)
+{
+	int rc;
+
+	mutex_lock(&ac->lock);
+	ac->cmd_state = 1;
+
+	rc = apr_send_pkt(ac->adev, cmd);
+	if (rc < 0)
+		goto err;
+
+	rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state <= 0), 5 * HZ);
+	if (!rc) {
+		dev_err(ac->dev, "CMD timeout\n");
+		rc =  -ETIMEDOUT;
+		goto err;
+	}
+
+	if (ac->cmd_state > 0)
+		rc = q6dsp_errno(ac->cmd_state);
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
+	int cnt = 0;
+	int loopcnt = 0;
+	int used;
+	struct audio_port_data *port = NULL;
+
+	if (!(ac->io_mode & ASM_SYNC_IO_MODE))
+		return;
+
+	used = (ac->io_mode & ASM_TUN_WRITE_IO_MODE ? 1 : 0);
+	mutex_lock(&ac->lock);
+	for (loopcnt = 0; loopcnt <= SNDRV_PCM_STREAM_CAPTURE;
+	     loopcnt++) {
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
+	mutex_unlock(&ac->lock);
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
index a4f9fe636b7e..b5ef90bb724b 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -1,8 +1,35 @@
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
 
 void q6asm_set_dai_data(struct device *dev, void *data);
 void *q6asm_get_dai_data(struct device *dev);
@@ -14,6 +41,20 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev,
 					      q6asm_cb cb, void *priv,
 					      int session_id);
 void q6asm_audio_client_free(struct audio_client *ac);
+int q6asm_write_async(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
+		       uint32_t lsw_ts, uint32_t flags);
+int q6asm_open_write(struct audio_client *ac, uint32_t format,
+		     uint16_t bits_per_sample);
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
