Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525870860; cv=none;
        d=google.com; s=arc-20160816;
        b=1KFeIMNlw2tjMvy14DWtU8D8MLEtWqNDy6bSHoel3S9dxeWKx6g/hngWrZVQRbIQpf
         5pWn3Lzg4sziTFKKNTYAI/vHmjL7iM59BAUugdvt/bkqQXgYDKVxJnrKcC0RFVWu8Mc+
         7antM1cRgbsgg4Mvw5GvXZyhR05BJ4xmKV75MIhTCIkbwmVyksQYaBkwxj85N+LtzBQQ
         kH7FM7g5VW0qMjhZRWhOqyIuCvpAh8iFMzUxe+Z218VdsxvNd65sZbhBJ52ZkFnNU5FO
         kNFbpVFdqbxu39O7h3y5lpFr2tR5h6X45nSNNeP0lVtD1jjOxVUnvxE7BFoobAuUpiC/
         0N0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=xVTXSpmPdX9ogkG9touImOUR9iW9380jppVZiH8Oc/Y=;
        b=sLqONrVua0FrIHZ0DbCTUZ5n9lliT/+Ya3//xn+1IJiCAtmlU+QY3vHI96QIn4X+tD
         NKMChIbjiTyPbEv/EYaKkIl11QKS6/OvfVP/JIL32Oj4BFfnlRc86itS1gQqmIDCWhaY
         0zEnIoEj7N0mCl0NlgkY8nR6azundleHed/zwXzWdwy4S0Blv3bKHWI7CNNdBpqHN1nv
         roH7+G5vGMhYa/GPDB001POB+S4fFxoISstc7UNGwDNcPMdK8nn7kB8iXhCyOkITC4bH
         jIbfgF1++ZAJ3941GGM8HTTcfx534AyoYJ8dfaVu6MdeyF63b7/5fNs/N0AvfdKAgSE4
         JzFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YZDiGewB;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YZDiGewB;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpBzpPazhEJt4sudQzwTg3hwfATOwL9BibTOuVxNoYN/Tr4In95cjInjF+cF0trCRnEjJaV8A==
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
Subject: [PATCH v8 15/24] ASoC: qdsp6: q6asm: Add support to memory map and unmap
Date: Wed,  9 May 2018 13:56:26 +0100
Message-Id: <20180509125635.5653-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991563226769508?=
X-GMAIL-MSGID: =?utf-8?q?1599991563226769508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to memory map and unmap regions commands in
q6asm module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 351 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h |   5 +
 2 files changed, 356 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 09f62e90ab00..044ad57d15a0 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -18,10 +18,45 @@
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
@@ -31,6 +66,8 @@ struct audio_client {
 	struct apr_device *adev;
 	struct mutex lock;
 	spinlock_t buf_lock;
+	/* idx:1 out port, 0: in port */
+	struct audio_port_data port[2];
 	wait_queue_head_t cmd_wait;
 	struct aprv2_ibasic_rsp_result_t result;
 	int perf_mode;
@@ -48,6 +85,279 @@ struct q6asm {
 	struct platform_device *pdev_dais;
 };
 
+static inline void q6asm_add_hdr(struct audio_client *ac, struct apr_hdr *hdr,
+				 uint32_t pkt_size, bool cmd_flg,
+				 uint32_t stream_id)
+{
+	hdr->hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	hdr->src_port = ((ac->session << 8) & 0xFF00) | (stream_id);
+	hdr->dest_port = ((ac->session << 8) & 0xFF00) | (stream_id);
+	hdr->pkt_size = pkt_size;
+	if (cmd_flg)
+		hdr->token = ac->session;
+}
+
+static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
+				      struct apr_pkt *pkt, uint32_t rsp_opcode)
+{
+	struct apr_hdr *hdr = &pkt->hdr;
+	int rc;
+
+	mutex_lock(&ac->lock);
+	ac->result.opcode = 0;
+	ac->result.status = 0;
+	rc = apr_send_pkt(a->adev, pkt);
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
+	struct avs_cmd_shared_mem_unmap_regions *mem_unmap;
+	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
+	struct apr_pkt *pkt;
+	int rc, pkt_size;
+	void *p;
+
+	if (ac->port[dir].mem_map_handle == 0) {
+		dev_err(ac->dev, "invalid mem handle\n");
+		return -EINVAL;
+	}
+	pkt_size = APR_HDR_SIZE + sizeof(*mem_unmap);
+
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	mem_unmap = p + APR_HDR_SIZE;
+
+	pkt->hdr.hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	pkt->hdr.src_port = 0;
+	pkt->hdr.dest_port = 0;
+	pkt->hdr.pkt_size = pkt_size;
+	pkt->hdr.token = ((ac->session << 8) | dir);
+
+	pkt->hdr.opcode = ASM_CMD_SHARED_MEM_UNMAP_REGIONS;
+	mem_unmap->mem_map_handle = ac->port[dir].mem_map_handle;
+
+	rc = q6asm_apr_send_session_pkt(a, ac, pkt, 0);
+	if (rc < 0) {
+		kfree(pkt);
+		return rc;
+	}
+
+	ac->port[dir].mem_map_handle = 0;
+
+	kfree(pkt);
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
+	struct apr_pkt *pkt;
+	void *p;
+	unsigned long flags;
+	uint32_t num_regions, buf_sz;
+	int rc, i, pkt_size;
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
+	pkt_size = APR_HDR_SIZE + sizeof(*cmd) +
+		   (sizeof(*mregions) * num_regions);
+
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	cmd = p + APR_HDR_SIZE;
+	mregions = p + APR_HDR_SIZE +  sizeof(*cmd);
+
+	pkt->hdr.hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	pkt->hdr.src_port = 0;
+	pkt->hdr.dest_port = 0;
+	pkt->hdr.pkt_size = pkt_size;
+	pkt->hdr.token = ((ac->session << 8) | dir);
+	pkt->hdr.opcode = ASM_CMD_SHARED_MEM_MAP_REGIONS;
+
+	cmd->mem_pool_id = ADSP_MEMORY_MAP_SHMEM8_4K_POOL;
+	cmd->num_regions = num_regions;
+	cmd->property_flag = 0x00;
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
+	rc = q6asm_apr_send_session_pkt(a, ac, pkt,
+					ASM_CMDRSP_SHARED_MEM_MAP_REGIONS);
+
+	kfree(pkt);
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
@@ -82,9 +392,13 @@ static int q6asm_srvc_callback(struct apr_device *adev,
 			       struct apr_resp_pkt *data)
 {
 	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+	struct aprv2_ibasic_rsp_result_t *result;
+	struct audio_port_data *port;
 	struct audio_client *ac = NULL;
 	struct apr_hdr *hdr = &data->hdr;
+	struct q6asm *a;
 	uint32_t sid = 0;
+	uint32_t dir = 0;
 
 	sid = (hdr->token >> 8) & 0x0F;
 	ac = q6asm_get_audio_client(q6asm, sid);
@@ -93,6 +407,43 @@ static int q6asm_srvc_callback(struct apr_device *adev,
 		return 0;
 	}
 
+	a = dev_get_drvdata(ac->dev->parent);
+	dir = (hdr->token & 0x0F);
+	port = &ac->port[dir];
+	result = data->payload;
+
+	switch (hdr->opcode) {
+	case APR_BASIC_RSP_RESULT:
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
+		ac->result.opcode = hdr->opcode;
+		port->mem_map_handle = result->opcode;
+		wake_up(&a->mem_wait);
+		break;
+	case ASM_CMD_SHARED_MEM_UNMAP_REGIONS:
+		ac->result.opcode = hdr->opcode;
+		ac->result.status = 0;
+		port->mem_map_handle = 0;
+		wake_up(&a->mem_wait);
+		break;
+	default:
+		dev_dbg(&adev->dev, "command[0x%x]success [0x%x]\n",
+			result->opcode, result->status);
+		break;
+	}
+
 	if (ac->cb)
 		ac->cb(hdr->opcode, hdr->token, data->payload, ac->priv);
 
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index b7816e6384e7..8c317b7b63c3 100644
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
