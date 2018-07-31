Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718E5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2202A208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2202A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbeGaIQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:16:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:59929 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeGaIQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:16:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 23:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="61154228"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2018 23:37:38 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 10/12] mei: dma ring: implement transmit flow
Date:   Tue, 31 Jul 2018 09:35:42 +0300
Message-Id: <20180731063544.25540-11-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180731063544.25540-1-tomas.winkler@intel.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a circular buffer on allocated system memory. Read and write
indices are stored on the control block which is also shared between the
device and the host.
Two new functions are exported from the DMA module: mei_dma_ring_write,
and mei_dma_ring_empty_slots. The former simply copy a packet on the TX
DMA circular buffer and later, returns the number of empty slots on the
TX DMA circular buffer.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/client.c   | 56 ++++++++++++++++++++++------
 drivers/misc/mei/dma-ring.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/mei_dev.h  |  2 +
 3 files changed, 138 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 859a5e1469c9..9dbf2ac1ca4b 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1573,10 +1573,13 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	struct mei_msg_hdr mei_hdr;
 	size_t hdr_len = sizeof(mei_hdr);
 	size_t len;
-	size_t hbuf_len;
+	size_t hbuf_len, dr_len;
 	int hbuf_slots;
+	u32 dr_slots;
+	u32 dma_len;
 	int rets;
 	bool first_chunk;
+	const void *data;
 
 	if (WARN_ON(!cl || !cl->dev))
 		return -ENODEV;
@@ -1597,6 +1600,7 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	}
 
 	len = buf->size - cb->buf_idx;
+	data = buf->data + cb->buf_idx;
 	hbuf_slots = mei_hbuf_empty_slots(dev);
 	if (hbuf_slots < 0) {
 		rets = -EOVERFLOW;
@@ -1604,6 +1608,8 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	}
 
 	hbuf_len = mei_slots2data(hbuf_slots);
+	dr_slots = mei_dma_ring_empty_slots(dev);
+	dr_len = mei_slots2data(dr_slots);
 
 	mei_msg_hdr_init(&mei_hdr, cb);
 
@@ -1614,23 +1620,32 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	if (len + hdr_len <= hbuf_len) {
 		mei_hdr.length = len;
 		mei_hdr.msg_complete = 1;
+	} else if (dr_slots && hbuf_len >= hdr_len + sizeof(dma_len)) {
+		mei_hdr.dma_ring = 1;
+		if (len > dr_len)
+			len = dr_len;
+		else
+			mei_hdr.msg_complete = 1;
+
+		mei_hdr.length = sizeof(dma_len);
+		dma_len = len;
+		data = &dma_len;
 	} else if ((u32)hbuf_slots == mei_hbuf_depth(dev)) {
 		mei_hdr.length = hbuf_len - hdr_len;
 	} else {
 		return 0;
 	}
 
-	cl_dbg(dev, cl, "buf: size = %zu idx = %zu\n",
-			cb->buf.size, cb->buf_idx);
+	if (mei_hdr.dma_ring)
+		mei_dma_ring_write(dev, buf->data + cb->buf_idx, len);
 
-	rets = mei_write_message(dev, &mei_hdr, hdr_len,
-				 buf->data + cb->buf_idx, mei_hdr.length);
+	rets = mei_write_message(dev, &mei_hdr, hdr_len, data, mei_hdr.length);
 	if (rets)
 		goto err;
 
 	cl->status = 0;
 	cl->writing_state = MEI_WRITING;
-	cb->buf_idx += mei_hdr.length;
+	cb->buf_idx += len;
 
 	if (first_chunk) {
 		if (mei_cl_tx_flow_ctrl_creds_reduce(cl)) {
@@ -1665,11 +1680,13 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 	struct mei_msg_data *buf;
 	struct mei_msg_hdr mei_hdr;
 	size_t hdr_len = sizeof(mei_hdr);
-	size_t len;
-	size_t hbuf_len;
+	size_t len, hbuf_len, dr_len;
 	int hbuf_slots;
+	u32 dr_slots;
+	u32 dma_len;
 	ssize_t rets;
 	bool blocking;
+	const void *data;
 
 	if (WARN_ON(!cl || !cl->dev))
 		return -ENODEV;
@@ -1681,10 +1698,12 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	buf = &cb->buf;
 	len = buf->size;
-	blocking = cb->blocking;
 
 	cl_dbg(dev, cl, "len=%zd\n", len);
 
+	blocking = cb->blocking;
+	data = buf->data;
+
 	rets = pm_runtime_get(dev->dev);
 	if (rets < 0 && rets != -EINPROGRESS) {
 		pm_runtime_put_noidle(dev->dev);
@@ -1721,16 +1740,31 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 	}
 
 	hbuf_len = mei_slots2data(hbuf_slots);
+	dr_slots = mei_dma_ring_empty_slots(dev);
+	dr_len =  mei_slots2data(dr_slots);
 
 	if (len + hdr_len <= hbuf_len) {
 		mei_hdr.length = len;
 		mei_hdr.msg_complete = 1;
+	} else if (dr_slots && hbuf_len >= hdr_len + sizeof(dma_len)) {
+		mei_hdr.dma_ring = 1;
+		if (len > dr_len)
+			len = dr_len;
+		else
+			mei_hdr.msg_complete = 1;
+
+		mei_hdr.length = sizeof(dma_len);
+		dma_len = len;
+		data = &dma_len;
 	} else {
 		mei_hdr.length = hbuf_len - hdr_len;
 	}
 
+	if (mei_hdr.dma_ring)
+		mei_dma_ring_write(dev, buf->data, len);
+
 	rets = mei_write_message(dev, &mei_hdr, hdr_len,
-				 buf->data, mei_hdr.length);
+				 data, mei_hdr.length);
 	if (rets)
 		goto err;
 
@@ -1739,7 +1773,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 		goto err;
 
 	cl->writing_state = MEI_WRITING;
-	cb->buf_idx = mei_hdr.length;
+	cb->buf_idx = len;
 
 out:
 	if (mei_hdr.msg_complete)
diff --git a/drivers/misc/mei/dma-ring.c b/drivers/misc/mei/dma-ring.c
index 2d2ce6f4ef3b..f809db5c0129 100644
--- a/drivers/misc/mei/dma-ring.c
+++ b/drivers/misc/mei/dma-ring.c
@@ -144,6 +144,27 @@ static size_t mei_dma_copy_from(struct mei_device *dev, unsigned char *buf,
 	return b_n;
 }
 
+/**
+ * mei_dma_copy_to - copy to a buffer to the dma ring
+ *
+ * @dev: mei device
+ * @buf: data buffer
+ * @offset: offset in slots.
+ * @n: number of slots to copy.
+ */
+static size_t mei_dma_copy_to(struct mei_device *dev, unsigned char *buf,
+			      u32 offset, u32 n)
+{
+	unsigned char *hbuf = dev->dr_dscr[DMA_DSCR_HOST].vaddr;
+
+	size_t b_offset = offset << 2;
+	size_t b_n = n << 2;
+
+	memcpy(hbuf + b_offset, buf, b_n);
+
+	return b_n;
+}
+
 /**
  * mei_dma_ring_read - read data from the ring
  *
@@ -185,3 +206,73 @@ void mei_dma_ring_read(struct mei_device *dev, unsigned char *buf, u32 len)
 out:
 	WRITE_ONCE(ctrl->dbuf_rd_idx, ctrl->dbuf_rd_idx + slots);
 }
+
+static inline u32 mei_dma_ring_hbuf_depth(struct mei_device *dev)
+{
+	return dev->dr_dscr[DMA_DSCR_HOST].size >> 2;
+}
+
+/**
+ * mei_dma_ring_empty_slots - calaculate number of empty slots in dma ring
+ *
+ * @dev: mei_device
+ *
+ * Return: number of empty slots
+ */
+u32 mei_dma_ring_empty_slots(struct mei_device *dev)
+{
+	struct hbm_dma_ring_ctrl *ctrl = mei_dma_ring_ctrl(dev);
+	u32 wr_idx, rd_idx, hbuf_depth, empty;
+
+	if (!mei_dma_ring_is_allocated(dev))
+		return 0;
+
+	if (WARN_ON(!ctrl))
+		return 0;
+
+	/* easier to work in slots */
+	hbuf_depth = mei_dma_ring_hbuf_depth(dev);
+	rd_idx = READ_ONCE(ctrl->hbuf_rd_idx);
+	wr_idx = READ_ONCE(ctrl->hbuf_wr_idx);
+
+	if (rd_idx > wr_idx)
+		empty = rd_idx - wr_idx;
+	else
+		empty = hbuf_depth - (wr_idx - rd_idx);
+
+	return empty;
+}
+
+/**
+ * mei_dma_ring_write - write data to dma ring host buffer
+ *
+ * @dev: mei_device
+ * @buf: data will be written
+ * @len: data length
+ */
+void mei_dma_ring_write(struct mei_device *dev, unsigned char *buf, u32 len)
+{
+	struct hbm_dma_ring_ctrl *ctrl = mei_dma_ring_ctrl(dev);
+	u32 hbuf_depth;
+	u32 wr_idx, rem, slots;
+
+	if (WARN_ON(!ctrl))
+		return;
+
+	dev_dbg(dev->dev, "writing to dma %u bytes\n", len);
+	hbuf_depth = mei_dma_ring_hbuf_depth(dev);
+	wr_idx = READ_ONCE(ctrl->hbuf_wr_idx) & (hbuf_depth - 1);
+	slots = mei_data2slots(len);
+
+	if (wr_idx + slots > hbuf_depth) {
+		buf += mei_dma_copy_to(dev, buf, wr_idx, hbuf_depth - wr_idx);
+		rem = slots - (hbuf_depth - wr_idx);
+		wr_idx = 0;
+	} else {
+		rem = slots;
+	}
+
+	mei_dma_copy_to(dev, buf, wr_idx, rem);
+
+	WRITE_ONCE(ctrl->hbuf_wr_idx, ctrl->hbuf_wr_idx + slots);
+}
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index bfd181fbd90c..685b78ce30a5 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -599,6 +599,8 @@ void mei_dmam_ring_free(struct mei_device *dev);
 bool mei_dma_ring_is_allocated(struct mei_device *dev);
 void mei_dma_ring_reset(struct mei_device *dev);
 void mei_dma_ring_read(struct mei_device *dev, unsigned char *buf, u32 len);
+void mei_dma_ring_write(struct mei_device *dev, unsigned char *buf, u32 len);
+u32 mei_dma_ring_empty_slots(struct mei_device *dev);
 
 /*
  *  MEI interrupt functions prototype
-- 
2.14.4

