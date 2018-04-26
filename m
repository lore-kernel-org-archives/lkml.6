Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524736190; cv=none;
        d=google.com; s=arc-20160816;
        b=hNQ7yrYNMqMaunDrzhKCjjSzNr/bQpH9E/6UHoVhvQefjwDcPVTr6rw4BOqnB5wA38
         DGIdBhkrt7gVVS2fmmaEWmIzK+ozWyNyf7zHkq2I3CbHt6dP2x+ncsGYX0J8nmCnAFjr
         qDB489xdGDzkO9BAQbpAUOaDhQ3UC3Z07ndLoiOymJvfZlEbDqyNm5x+L+rbqV7C6lWn
         JFCbP/2bvMtPzN+I+ESndfMHRKCuQdA2qgcc8vI4lHophJkf8qfn6FmnE3IkS0DPvzlp
         ST2N5g9d08vprGdQYoF7+TsIwcOuhOnzqm6rmQZ1d3hJJZwzOUJLN6/jUmMLiDhsW945
         Xuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ddwSFudWmMVh9pYVLjbpwHQjWGSMa4k48YhdmmCArBQ=;
        b=hjfmmciAduKOlRjiTsv6kBAQrxtU0pPFCMszFWBQ7uPGfZ62gaCyT707IiJeK7B11P
         gfQvuEJPwz6C+R2Ux32eMzv+Tn27wD3UMn3bkoVirwtRozqN81AOfqoNQ+AQBxNex7we
         9k2c8SulkiUwvg5RX8vTKd5IWcflD4PhIscXu45o3A+Z3a1Lmbg74ukxOnZfdByKgzHL
         vKxWN3llGfhkAVgR/pxWvMa4AGU7t/PUOU4PXt+HyIrO+aMH38NJglfJd62FG++aQj2f
         cu9jM5ukgaVuwHsnVWx0o57ocJBAf5y78J5kIhxa3wVo3FdrmsfBpO1kIj4tf0+Wuz/N
         tyBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=H+zu7+YH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=H+zu7+YH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/GoiNp5uHQNK8SU+3mcdEnLXsI13bzeiInnCj/Sy76tfwfWw2KApB/MR1H4KeBzQkh2uSpKw==
From: srinivas.kandagatla@linaro.org
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
Subject: [PATCH v6 15/24] ASoC: qdsp6: q6asm: Add support to memory map and unmap
Date: Thu, 26 Apr 2018 10:45:57 +0100
Message-Id: <20180426094606.4775-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801775596968968?=
X-GMAIL-MSGID: =?utf-8?q?1598801775596968968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to memory map and unmap regions commands in
q6asm module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 340 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h |   5 +
 2 files changed, 345 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 2d0f6a734e98..fc1b505dcca5 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -18,10 +18,47 @@
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
@@ -31,6 +68,8 @@ struct audio_client {
 	struct apr_device *adev;
 	struct mutex lock;
 	spinlock_t buf_lock;
+	/* idx:1 out port, 0: in port */
+	struct audio_port_data port[2];
 	wait_queue_head_t cmd_wait;
 	struct aprv2_ibasic_rsp_result_t result;
 	int perf_mode;
@@ -48,6 +87,268 @@ struct q6asm {
 	struct platform_device *pdev_dais;
 };
 
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
+				      void *data, uint32_t rsp_opcode)
+{
+	struct apr_hdr *hdr = data;
+	int rc;
+
+	mutex_lock(&ac->lock);
+	ac->result.opcode = 0;
+	ac->result.status = 0;
+	rc = apr_send_pkt(a->adev, data);
+	if (rc < 0)
+		goto err;
+
+	if (rsp_opcode)
+		rc = wait_event_timeout(a->mem_wait,
+					(ac->result.opcode == hdr->opcode) ||
+					(ac->result.opcode == rsp_opcode),
+					5 * HZ);
+	else
+		rc = wait_event_timeout(a->mem_wait,
+					(ac->result.opcode == hdr->opcode),
+					5 * HZ);
+
+	if (!rc) {
+		dev_err(a->dev, "CMD timeout\n");
+		rc = -ETIMEDOUT;
+	} else if (ac->result.status > 0) {
+		dev_err(a->dev, "DSP returned error[%x]\n",
+			ac->result.status);
+		rc = -EINVAL;
+	}
+
+err:
+	mutex_unlock(&ac->lock);
+	return rc;
+}
+
+static int __q6asm_memory_unmap(struct audio_client *ac,
+				phys_addr_t buf_add, int dir)
+{
+	struct avs_cmd_shared_mem_unmap_regions mem_unmap;
+	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
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
+	rc = q6asm_apr_send_session_pkt(a, ac, &mem_unmap, 0);
+	if (rc < 0)
+		return rc;
+
+	ac->port[dir].mem_map_handle = 0;
+
+	return 0;
+}
+
+
+static void q6asm_audio_client_free_buf(struct audio_client *ac,
+					struct audio_port_data *port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ac->buf_lock, flags);
+
+	port->num_periods = 0;
+	kfree(port->buf);
+	port->buf = NULL;
+
+	spin_unlock_irqrestore(&ac->buf_lock, flags);
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
+	port = &ac->port[dir];
+	if (!port->buf) {
+		rc = -EINVAL;
+		goto err;
+	}
+
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
+	q6asm_audio_client_free_buf(ac, port);
+
+err:
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
+	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
+	struct audio_port_data *port = NULL;
+	struct audio_buffer *ab = NULL;
+	void *mmap_region_cmd = NULL;
+	unsigned long flags;
+	uint32_t num_regions, buf_sz;
+	int rc, i, cmd_size;
+
+	if (is_contiguous) {
+		num_regions = 1;
+		buf_sz = period_sz * periods;
+	} else {
+		buf_sz = period_sz;
+		num_regions = periods;
+	}
+
+	/* DSP expects size should be aligned to 4K */
+	buf_sz = ALIGN(buf_sz, 4096);
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
+	spin_lock_irqsave(&ac->buf_lock, flags);
+	for (i = 0; i < num_regions; i++) {
+		ab = &port->buf[i];
+		mregions->shm_addr_lsw = lower_32_bits(ab->phys);
+		mregions->shm_addr_msw = upper_32_bits(ab->phys);
+		mregions->mem_size_bytes = buf_sz;
+		++mregions;
+	}
+	spin_unlock_irqrestore(&ac->buf_lock, flags);
+
+	rc = q6asm_apr_send_session_pkt(a, ac, mmap_region_cmd,
+					ASM_CMDRSP_SHARED_MEM_MAP_REGIONS);
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
+	unsigned long flags;
+	int cnt;
+	int rc;
+
+	spin_lock_irqsave(&ac->buf_lock, flags);
+	if (ac->port[dir].buf) {
+		dev_err(ac->dev, "Buffer already allocated\n");
+		spin_unlock_irqrestore(&ac->buf_lock, flags);
+		return 0;
+	}
+
+	buf = kzalloc(((sizeof(struct audio_buffer)) * periods), GFP_ATOMIC);
+	if (!buf) {
+		spin_unlock_irqrestore(&ac->buf_lock, flags);
+		return -ENOMEM;
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
+	spin_unlock_irqrestore(&ac->buf_lock, flags);
+
+	ac->port[dir].num_periods = periods;
+
+	rc = __q6asm_memory_map_regions(ac, dir, period_sz, periods, 1);
+	if (rc < 0) {
+		dev_err(ac->dev, "Memory_map_regions failed\n");
+		q6asm_audio_client_free_buf(ac, &ac->port[dir]);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_map_memory_regions);
+
 /**
  * q6asm_audio_client_free() - Freee allocated audio client
  *
@@ -83,8 +384,11 @@ static int q6asm_srvc_callback(struct apr_device *adev,
 {
 	struct aprv2_ibasic_rsp_result_t *result;
 	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+	struct audio_port_data *port;
 	struct audio_client *ac = NULL;
+	struct q6asm *a;
 	uint32_t sid = 0;
+	uint32_t dir = 0;
 
 	result = data->payload;
 	sid = (data->token >> 8) & 0x0F;
@@ -94,6 +398,42 @@ static int q6asm_srvc_callback(struct apr_device *adev,
 		return 0;
 	}
 
+	a = dev_get_drvdata(ac->dev->parent);
+	dir = (data->token & 0x0F);
+	port = &ac->port[dir];
+
+	switch (data->opcode)
+	case APR_BASIC_RSP_RESULT: {
+		switch (result->opcode) {
+		case ASM_CMD_SHARED_MEM_MAP_REGIONS:
+		case ASM_CMD_SHARED_MEM_UNMAP_REGIONS:
+			ac->result = *result;
+			wake_up(&a->mem_wait);
+			break;
+		default:
+			dev_err(&adev->dev, "command[0x%x] not expecting rsp\n",
+				 result->opcode);
+			break;
+		}
+		return 0;
+	case ASM_CMDRSP_SHARED_MEM_MAP_REGIONS:
+		ac->result.status = 0;
+		ac->result.opcode = data->opcode;
+		ac->port[dir].mem_map_handle = result->opcode;
+		wake_up(&a->mem_wait);
+		break;
+	case ASM_CMD_SHARED_MEM_UNMAP_REGIONS:
+		ac->result.opcode = data->opcode;
+		ac->result.status = 0;
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
index 92cc0efaa2c8..93e86d922087 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -12,4 +12,9 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev,
 					      int session_id, int perf_mode);
 void q6asm_audio_client_free(struct audio_client *ac);
 int q6asm_get_session_id(struct audio_client *ac);
+int q6asm_map_memory_regions(unsigned int dir,
+			     struct audio_client *ac,
+			     phys_addr_t phys,
+			     size_t bufsz, unsigned int bufcnt);
+int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac);
 #endif /* __Q6_ASM_H__ */
-- 
2.16.2
