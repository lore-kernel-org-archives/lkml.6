Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965441AbeBMRHs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:07:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51383 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965444AbeBMRB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:29 -0500
X-Google-Smtp-Source: AH8x224auDIVXg+5OwP6xH7N6K7iFmmkUBuQxI2uePk980/IlUGsEKNIkD8cvd8DEklPRl9rGSaMUg==
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
Subject: [PATCH v3 10/25] ASoC: qcom: q6asm: Add support to memory map and unmap
Date: Tue, 13 Feb 2018 16:58:22 +0000
Message-Id: <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to memory map and unmap regions commands in
q6asm module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 312 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h |   5 +
 2 files changed, 317 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 768d9b446da9..412275edb15c 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -17,10 +17,47 @@
 #include "q6dsp-errno.h"
 #include "q6dsp-common.h"
 
+#define ASM_CMD_SHARED_MEM_MAP_REGIONS		0x00010D92
+#define ASM_CMDRSP_SHARED_MEM_MAP_REGIONS	0x00010D93
+#define ASM_CMD_SHARED_MEM_UNMAP_REGIONS	0x00010D94
+
 #define ASM_SYNC_IO_MODE		0x0001
 #define ASM_ASYNC_IO_MODE		0x0002
 #define ASM_TUN_READ_IO_MODE		0x0004	/* tunnel read write mode */
 #define ASM_TUN_WRITE_IO_MODE		0x0008	/* tunnel read write mode */
+#define ASM_SHIFT_GAPLESS_MODE_FLAG	31
+#define ADSP_MEMORY_MAP_SHMEM8_4K_POOL	3
+
+struct avs_cmd_shared_mem_map_regions {
+	struct apr_hdr hdr;
+	u16 mem_pool_id;
+	u16 num_regions;
+	u32 property_flag;
+} __packed;
+
+struct avs_shared_map_region_payload {
+	u32 shm_addr_lsw;
+	u32 shm_addr_msw;
+	u32 mem_size_bytes;
+} __packed;
+
+struct avs_cmd_shared_mem_unmap_regions {
+	struct apr_hdr hdr;
+	u32 mem_map_handle;
+} __packed;
+
+struct audio_buffer {
+	phys_addr_t phys;
+	uint32_t used;
+	uint32_t size;		/* size of buffer */
+};
+
+struct audio_port_data {
+	struct audio_buffer *buf;
+	uint32_t num_periods;
+	uint32_t dsp_buf;
+	uint32_t mem_map_handle;
+};
 
 struct audio_client {
 	int session;
@@ -30,6 +67,8 @@ struct audio_client {
 	uint32_t io_mode;
 	struct apr_device *adev;
 	struct mutex lock;
+	/* idx:1 out port, 0: in port */
+	struct audio_port_data port[2];
 	wait_queue_head_t cmd_wait;
 	int perf_mode;
 	int stream_id;
@@ -63,6 +102,237 @@ static bool q6asm_is_valid_audio_client(struct audio_client *ac)
 	return false;
 }
 
+static inline void q6asm_add_hdr(struct audio_client *ac, struct apr_hdr *hdr,
+				 uint32_t pkt_size, bool cmd_flg,
+				 uint32_t stream_id)
+{
+	hdr->hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	hdr->src_svc = ac->adev->svc_id;
+	hdr->src_domain = APR_DOMAIN_APPS;
+	hdr->dest_svc = APR_SVC_ASM;
+	hdr->dest_domain = APR_DOMAIN_ADSP;
+	hdr->src_port = ((ac->session << 8) & 0xFF00) | (stream_id);
+	hdr->dest_port = ((ac->session << 8) & 0xFF00) | (stream_id);
+	hdr->pkt_size = pkt_size;
+	if (cmd_flg)
+		hdr->token = ac->session;
+}
+
+static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
+				      void *data)
+{
+	int rc;
+
+	mutex_lock(&a->session_lock);
+	a->mem_state = 1;
+	rc = apr_send_pkt(a->adev, data);
+	if (rc < 0)
+		goto err;
+
+	rc = wait_event_timeout(a->mem_wait, (a->mem_state <= 0), 5 * HZ);
+	if (!rc) {
+		dev_err(a->dev, "CMD timeout \n");
+		rc = -ETIMEDOUT;
+	} else if (a->mem_state < 0) {
+		rc =  q6dsp_errno(a->mem_state);
+	}
+
+err:
+	mutex_unlock(&a->session_lock);
+	return rc;
+}
+
+static int __q6asm_memory_unmap(struct audio_client *ac,
+				phys_addr_t buf_add, int dir)
+{
+	struct avs_cmd_shared_mem_unmap_regions mem_unmap;
+	struct q6asm *a = dev_get_drvdata(ac->dev);
+	int rc;
+
+	if (ac->port[dir].mem_map_handle == 0) {
+		dev_err(ac->dev, "invalid mem handle\n");
+		return -EINVAL;
+	}
+
+	mem_unmap.hdr.hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	mem_unmap.hdr.src_port = 0;
+	mem_unmap.hdr.dest_port = 0;
+	mem_unmap.hdr.pkt_size = sizeof(mem_unmap);
+	mem_unmap.hdr.token = ((ac->session << 8) | dir);
+
+	mem_unmap.hdr.opcode = ASM_CMD_SHARED_MEM_UNMAP_REGIONS;
+	mem_unmap.mem_map_handle = ac->port[dir].mem_map_handle;
+
+	rc = q6asm_apr_send_session_pkt(a, ac, &mem_unmap);
+	if (rc < 0)
+		return rc;
+
+	ac->port[dir].mem_map_handle = 0;
+
+	return 0;
+}
+
+/**
+ * q6asm_unmap_memory_regions() - unmap memory regions in the dsp.
+ *
+ * @dir: direction of audio stream
+ * @ac: audio client instanace
+ *
+ * Return: Will be an negative value on failure or zero on success
+ */
+int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac)
+{
+	struct audio_port_data *port;
+	int cnt = 0;
+	int rc = 0;
+
+	mutex_lock(&ac->lock);
+	port = &ac->port[dir];
+	if (!port->buf) {
+		rc = -EINVAL;
+		goto err;
+	}
+	cnt = port->num_periods - 1;
+	if (cnt >= 0) {
+		rc = __q6asm_memory_unmap(ac, port->buf[dir].phys, dir);
+		if (rc < 0) {
+			dev_err(ac->dev, "%s: Memory_unmap_regions failed %d\n",
+				__func__, rc);
+			goto err;
+		}
+	}
+
+	port->num_periods = 0;
+	kfree(port->buf);
+	port->buf = NULL;
+
+err:
+	mutex_unlock(&ac->lock);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_unmap_memory_regions);
+
+static int __q6asm_memory_map_regions(struct audio_client *ac, int dir,
+				      size_t period_sz, unsigned int periods,
+				      bool is_contiguous)
+{
+	struct avs_cmd_shared_mem_map_regions *cmd = NULL;
+	struct avs_shared_map_region_payload *mregions = NULL;
+	struct q6asm *a = dev_get_drvdata(ac->dev);
+	struct audio_port_data *port = NULL;
+	struct audio_buffer *ab = NULL;
+	void *mmap_region_cmd = NULL;
+	uint32_t num_regions, buf_sz;
+	int rc, i, cmd_size;
+
+	num_regions = is_contiguous ? 1 : periods;
+	buf_sz = is_contiguous ? (period_sz * periods) : period_sz;
+	buf_sz = PAGE_ALIGN(buf_sz);
+
+	cmd_size = sizeof(*cmd) + (sizeof(*mregions) * num_regions);
+	mmap_region_cmd = kzalloc(cmd_size, GFP_KERNEL);
+	if (!mmap_region_cmd)
+		return -ENOMEM;
+
+	cmd = mmap_region_cmd;
+
+	cmd->hdr.hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	cmd->hdr.src_port = 0;
+	cmd->hdr.dest_port = 0;
+	cmd->hdr.pkt_size = cmd_size;
+	cmd->hdr.token = ((ac->session << 8) | dir);
+
+
+	cmd->hdr.opcode = ASM_CMD_SHARED_MEM_MAP_REGIONS;
+	cmd->mem_pool_id = ADSP_MEMORY_MAP_SHMEM8_4K_POOL;
+	cmd->num_regions = num_regions;
+	cmd->property_flag = 0x00;
+
+	mregions = mmap_region_cmd +  sizeof(*cmd);
+
+	port = &ac->port[dir];
+
+	for (i = 0; i < num_regions; i++) {
+		ab = &port->buf[i];
+		mregions->shm_addr_lsw = lower_32_bits(ab->phys);
+		mregions->shm_addr_msw = upper_32_bits(ab->phys);
+		mregions->mem_size_bytes = buf_sz;
+		++mregions;
+	}
+
+	rc = q6asm_apr_send_session_pkt(a, ac, mmap_region_cmd);
+
+	kfree(mmap_region_cmd);
+
+	return rc;
+}
+
+/**
+ * q6asm_map_memory_regions() - map memory regions in the dsp.
+ *
+ * @dir: direction of audio stream
+ * @ac: audio client instanace
+ * @phys: physcial address that needs mapping.
+ * @period_sz: audio period size
+ * @periods: number of periods
+ *
+ * Return: Will be an negative value on failure or zero on success
+ */
+int q6asm_map_memory_regions(unsigned int dir, struct audio_client *ac,
+			     phys_addr_t phys,
+			     size_t period_sz, unsigned int periods)
+{
+	struct audio_buffer *buf;
+	int cnt;
+	int rc;
+
+	mutex_lock(&ac->lock);
+
+	if (ac->port[dir].buf) {
+		dev_err(ac->dev, "Buffer already allocated\n");
+		rc = 0;
+		goto err;
+	}
+
+
+	buf = kzalloc(((sizeof(struct audio_buffer)) * periods), GFP_KERNEL);
+	if (!buf) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+
+	ac->port[dir].buf = buf;
+
+	buf[0].phys = phys;
+	buf[0].used = !!dir;
+	buf[0].size = period_sz;
+
+	for (cnt = 1; cnt < periods; cnt++) {
+		if (period_sz > 0) {
+			buf[cnt].phys = buf[0].phys + (cnt * period_sz);
+			buf[cnt].used = dir ^ 1;
+			buf[cnt].size = period_sz;
+		}
+	}
+
+	ac->port[dir].num_periods = periods;
+
+	rc = __q6asm_memory_map_regions(ac, dir, period_sz, periods, 1);
+	if (rc < 0) {
+		dev_err(ac->dev, "Memory_map_regions failed\n");
+		ac->port[dir].num_periods = 0;
+		kfree(buf);
+		ac->port[dir].buf = NULL;
+		goto err;
+	}
+
+err:
+	mutex_unlock(&ac->lock);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_map_memory_regions);
+
 /**
  * q6asm_audio_client_free() - Freee allocated audio client
  *
@@ -143,6 +413,48 @@ static int q6asm_srvc_callback(struct apr_device *adev,
 		return 0;
 	}
 
+	a = dev_get_drvdata(ac->dev);
+	dir = (data->token & 0x0F);
+	port = &ac->port[dir];
+
+	switch (data->opcode)
+	case APR_BASIC_RSP_RESULT: {
+		switch (result->opcode) {
+		case ASM_CMD_SHARED_MEM_MAP_REGIONS:
+		case ASM_CMD_SHARED_MEM_UNMAP_REGIONS:
+			if (result->status != 0) {
+				dev_err(ac->dev,
+					"cmd = 0x%x retur err= 0x%x sid:%d\n",
+					result->opcode, result->status, sid);
+				a->mem_state = -result->status;
+			} else {
+				a->mem_state = 0;
+			}
+
+			wake_up(&a->mem_wait);
+			break;
+		default:
+			dev_err(&adev->dev, "command[0x%x] not expecting rsp\n",
+				 result->opcode);
+			break;
+		}
+		return 0;
+	case ASM_CMDRSP_SHARED_MEM_MAP_REGIONS:
+		a->mem_state = 0;
+		ac->port[dir].mem_map_handle = result->opcode;
+		wake_up(&a->mem_wait);
+		break;
+	case ASM_CMD_SHARED_MEM_UNMAP_REGIONS:
+		a->mem_state = 0;
+		ac->port[dir].mem_map_handle = 0;
+		wake_up(&a->mem_wait);
+		break;
+	default:
+		dev_dbg(&adev->dev, "command[0x%x]success [0x%x]\n",
+			result->opcode, result->status);
+		break;
+	}
+
 	if (ac->cb)
 		ac->cb(data->opcode, data->token, data->payload, ac->priv);
 
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index b13fe0d2ea61..a4f9fe636b7e 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -15,4 +15,9 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev,
 					      int session_id);
 void q6asm_audio_client_free(struct audio_client *ac);
 int q6asm_get_session_id(struct audio_client *ac);
+int q6asm_map_memory_regions(unsigned int dir,
+			     struct audio_client *ac,
+			     phys_addr_t phys,
+			     size_t bufsz, unsigned int bufcnt);
+int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac);
 #endif /* __Q6_ASM_H__ */
-- 
2.15.1
