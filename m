Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B22C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE1920663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE1920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394570AbeKVVu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:50:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:39305 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394543AbeKVVuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:50:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 03:11:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="91290783"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2018 03:11:57 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 4/7] mei: dma ring: implement rx circular buffer logic
Date:   Thu, 22 Nov 2018 13:11:39 +0200
Message-Id: <20181122111142.18653-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181122111142.18653-1-tomas.winkler@intel.com>
References: <20181122111142.18653-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement circular buffer protocol over receive dma
buffer. Add extension to the mei message header that holds
length of the buffer on the dma buffer.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/client.c    |  2 +-
 drivers/misc/mei/dma-ring.c  | 61 ++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/hw.h        |  4 +++
 drivers/misc/mei/init.c      |  2 +-
 drivers/misc/mei/interrupt.c | 41 +++++++++++++++++-------
 drivers/misc/mei/mei_dev.h   |  3 +-
 6 files changed, 98 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 1fe9426ce48b..5d15501af313 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -461,7 +461,7 @@ struct mei_cl_cb *mei_cl_alloc_cb(struct mei_cl *cl, size_t length,
 	if (length == 0)
 		return cb;
 
-	cb->buf.data = kmalloc(length, GFP_KERNEL);
+	cb->buf.data = kmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
 	if (!cb->buf.data) {
 		mei_io_cb_free(cb);
 		return NULL;
diff --git a/drivers/misc/mei/dma-ring.c b/drivers/misc/mei/dma-ring.c
index b73d5ab54070..a0c40925049a 100644
--- a/drivers/misc/mei/dma-ring.c
+++ b/drivers/misc/mei/dma-ring.c
@@ -117,3 +117,64 @@ void mei_dma_ring_reset(struct mei_device *dev)
 
 	memset(ctrl, 0, sizeof(*ctrl));
 }
+
+/**
+ * mei_dma_copy_from() - copy from dma ring into buffer
+ * @dev: mei device
+ * @buf: data buffer
+ * @offset: offset in slots.
+ * @n: number of slots to copy.
+ */
+static size_t mei_dma_copy_from(struct mei_device *dev, unsigned char *buf,
+				u32 offset, u32 n)
+{
+	unsigned char *dbuf = dev->dr_dscr[DMA_DSCR_DEVICE].vaddr;
+
+	size_t b_offset = offset << 2;
+	size_t b_n = n << 2;
+
+	memcpy(buf, dbuf + b_offset, b_n);
+
+	return b_n;
+}
+
+/**
+ * mei_dma_ring_read() - read data from the ring
+ * @dev: mei device
+ * @buf: buffer to read into: may be NULL in case of droping the data.
+ * @len: length to read.
+ */
+void mei_dma_ring_read(struct mei_device *dev, unsigned char *buf, u32 len)
+{
+	struct hbm_dma_ring_ctrl *ctrl = mei_dma_ring_ctrl(dev);
+	u32 dbuf_depth;
+	u32 rd_idx, rem, slots;
+
+	if (WARN_ON(!ctrl))
+		return;
+
+	dev_dbg(dev->dev, "reading from dma %u bytes\n", len);
+
+	if (!len)
+		return;
+
+	dbuf_depth = dev->dr_dscr[DMA_DSCR_DEVICE].size >> 2;
+	rd_idx = READ_ONCE(ctrl->dbuf_rd_idx) & (dbuf_depth - 1);
+	slots = mei_data2slots(len);
+
+	/* if buf is NULL we drop the packet by advancing the pointer.*/
+	if (!buf)
+		goto out;
+
+	if (rd_idx + slots > dbuf_depth) {
+		buf += mei_dma_copy_from(dev, buf, rd_idx, dbuf_depth - rd_idx);
+		rem = slots - (dbuf_depth - rd_idx);
+		rd_idx = 0;
+	} else {
+		rem = slots;
+	}
+
+	mei_dma_copy_from(dev, buf, rd_idx, rem);
+out:
+	WRITE_ONCE(ctrl->dbuf_rd_idx, ctrl->dbuf_rd_idx + slots);
+}
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 4f09bbcdbc2a..acbccb8dba34 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -206,6 +206,7 @@ enum  mei_cl_disconnect_status {
  * @dma_ring: message is on dma ring
  * @internal: message is internal
  * @msg_complete: last packet of the message
+ * @extension: extension of the header
  */
 struct mei_msg_hdr {
 	u32 me_addr:8;
@@ -215,8 +216,11 @@ struct mei_msg_hdr {
 	u32 dma_ring:1;
 	u32 internal:1;
 	u32 msg_complete:1;
+	u32 extension[0];
 } __packed;
 
+#define MEI_MSG_HDR_MAX 2
+
 struct mei_bus_message {
 	u8 hbm_cmd;
 	u8 data[0];
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 4888ebc076b7..eb026e2a0537 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -151,7 +151,7 @@ int mei_reset(struct mei_device *dev)
 
 	mei_hbm_reset(dev);
 
-	dev->rd_msg_hdr = 0;
+	memset(dev->rd_msg_hdr, 0, sizeof(dev->rd_msg_hdr));
 
 	if (ret) {
 		dev_err(dev->dev, "hw_reset failed ret = %d\n", ret);
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 5a661cbdf2ae..055c2d89b310 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -75,6 +75,8 @@ static inline int mei_cl_hbm_equal(struct mei_cl *cl,
  */
 static void mei_irq_discard_msg(struct mei_device *dev, struct mei_msg_hdr *hdr)
 {
+	if (hdr->dma_ring)
+		mei_dma_ring_read(dev, NULL, hdr->extension[0]);
 	/*
 	 * no need to check for size as it is guarantied
 	 * that length fits into rd_msg_buf
@@ -100,6 +102,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 	struct mei_device *dev = cl->dev;
 	struct mei_cl_cb *cb;
 	size_t buf_sz;
+	u32 length;
 
 	cb = list_first_entry_or_null(&cl->rd_pending, struct mei_cl_cb, list);
 	if (!cb) {
@@ -119,25 +122,31 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		goto discard;
 	}
 
-	buf_sz = mei_hdr->length + cb->buf_idx;
+	length = mei_hdr->dma_ring ? mei_hdr->extension[0] : mei_hdr->length;
+
+	buf_sz = length + cb->buf_idx;
 	/* catch for integer overflow */
 	if (buf_sz < cb->buf_idx) {
 		cl_err(dev, cl, "message is too big len %d idx %zu\n",
-		       mei_hdr->length, cb->buf_idx);
+		       length, cb->buf_idx);
 		cb->status = -EMSGSIZE;
 		goto discard;
 	}
 
 	if (cb->buf.size < buf_sz) {
 		cl_dbg(dev, cl, "message overflow. size %zu len %d idx %zu\n",
-			cb->buf.size, mei_hdr->length, cb->buf_idx);
+			cb->buf.size, length, cb->buf_idx);
 		cb->status = -EMSGSIZE;
 		goto discard;
 	}
 
+	if (mei_hdr->dma_ring)
+		mei_dma_ring_read(dev, cb->buf.data + cb->buf_idx, length);
+
+	/*  for DMA read 0 length to generate an interrupt to the device */
 	mei_read_slots(dev, cb->buf.data + cb->buf_idx, mei_hdr->length);
 
-	cb->buf_idx += mei_hdr->length;
+	cb->buf_idx += length;
 
 	if (mei_hdr->msg_complete) {
 		cl_dbg(dev, cl, "completed read length = %zu\n", cb->buf_idx);
@@ -247,6 +256,9 @@ static inline int hdr_is_valid(u32 msg_hdr)
 	if (!msg_hdr || mei_hdr->reserved)
 		return -EBADMSG;
 
+	if (mei_hdr->dma_ring && mei_hdr->length != MEI_SLOT_SIZE)
+		return -EBADMSG;
+
 	return 0;
 }
 
@@ -267,20 +279,20 @@ int mei_irq_read_handler(struct mei_device *dev,
 	struct mei_cl *cl;
 	int ret;
 
-	if (!dev->rd_msg_hdr) {
-		dev->rd_msg_hdr = mei_read_hdr(dev);
+	if (!dev->rd_msg_hdr[0]) {
+		dev->rd_msg_hdr[0] = mei_read_hdr(dev);
 		(*slots)--;
 		dev_dbg(dev->dev, "slots =%08x.\n", *slots);
 
-		ret = hdr_is_valid(dev->rd_msg_hdr);
+		ret = hdr_is_valid(dev->rd_msg_hdr[0]);
 		if (ret) {
 			dev_err(dev->dev, "corrupted message header 0x%08X\n",
-				dev->rd_msg_hdr);
+				dev->rd_msg_hdr[0]);
 			goto end;
 		}
 	}
 
-	mei_hdr = (struct mei_msg_hdr *)&dev->rd_msg_hdr;
+	mei_hdr = (struct mei_msg_hdr *)dev->rd_msg_hdr;
 	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM(mei_hdr));
 
 	if (mei_slots2data(*slots) < mei_hdr->length) {
@@ -291,6 +303,12 @@ int mei_irq_read_handler(struct mei_device *dev,
 		goto end;
 	}
 
+	if (mei_hdr->dma_ring) {
+		dev->rd_msg_hdr[1] = mei_read_hdr(dev);
+		(*slots)--;
+		mei_hdr->length = 0;
+	}
+
 	/*  HBM message */
 	if (hdr_is_hbm(mei_hdr)) {
 		ret = mei_hbm_dispatch(dev, mei_hdr);
@@ -324,7 +342,7 @@ int mei_irq_read_handler(struct mei_device *dev,
 			goto reset_slots;
 		}
 		dev_err(dev->dev, "no destination client found 0x%08X\n",
-				dev->rd_msg_hdr);
+				dev->rd_msg_hdr[0]);
 		ret = -EBADMSG;
 		goto end;
 	}
@@ -334,9 +352,8 @@ int mei_irq_read_handler(struct mei_device *dev,
 
 reset_slots:
 	/* reset the number of slots and header */
+	memset(dev->rd_msg_hdr, 0, sizeof(dev->rd_msg_hdr));
 	*slots = mei_count_full_read_slots(dev);
-	dev->rd_msg_hdr = 0;
-
 	if (*slots == -EOVERFLOW) {
 		/* overflow - reset */
 		dev_err(dev->dev, "resetting due to slots overflow.\n");
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 033b5eff8e59..bfd181fbd90c 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -497,7 +497,7 @@ struct mei_device {
 #endif /* CONFIG_PM */
 
 	unsigned char rd_msg_buf[MEI_RD_MSG_BUF_SIZE];
-	u32 rd_msg_hdr;
+	u32 rd_msg_hdr[MEI_MSG_HDR_MAX];
 
 	/* write buffer */
 	bool hbuf_is_ready;
@@ -598,6 +598,7 @@ int mei_dmam_ring_alloc(struct mei_device *dev);
 void mei_dmam_ring_free(struct mei_device *dev);
 bool mei_dma_ring_is_allocated(struct mei_device *dev);
 void mei_dma_ring_reset(struct mei_device *dev);
+void mei_dma_ring_read(struct mei_device *dev, unsigned char *buf, u32 len);
 
 /*
  *  MEI interrupt functions prototype
-- 
2.17.2

