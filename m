Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D499520846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D499520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbeGWLXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:23:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:16833 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387906AbeGWLXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:23:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 03:23:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="248063996"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2018 03:23:13 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/3] mei: move hbuf_depth from the mei device to the hw modules
Date:   Mon, 23 Jul 2018 13:21:23 +0300
Message-Id: <20180723102124.27788-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723102124.27788-1-tomas.winkler@intel.com>
References: <20180723102124.27788-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host buffer depth is hardware specific so it's better to
handle it inside the me and txe hw modules. In me the depth
is read from register in txe it's a constant number.
The value is now retrieved via mei_hbuf_depth accessor,
while it replaces mei_hbuf_max_len.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c  | 53 +++++++++++++++++++++++++++-------------------
 drivers/misc/mei/hw-me.c   | 19 ++++++++++-------
 drivers/misc/mei/hw-me.h   |  2 ++
 drivers/misc/mei/hw-txe.c  | 22 +++++++++----------
 drivers/misc/mei/mei_dev.h | 11 ++++------
 5 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 79e200d71652..ca917b84ca5e 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1556,8 +1556,8 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	struct mei_msg_data *buf;
 	struct mei_msg_hdr mei_hdr;
 	size_t len;
-	u32 msg_slots;
-	int slots;
+	size_t hbuf_len;
+	int hbuf_slots;
 	int rets;
 	bool first_chunk;
 
@@ -1579,29 +1579,30 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 		return 0;
 	}
 
-	slots = mei_hbuf_empty_slots(dev);
-	if (slots < 0)
-		return -EOVERFLOW;
-
-	len = buf->size - cb->buf_idx;
-	msg_slots = mei_data2slots(len);
-
 	mei_hdr.host_addr = mei_cl_host_addr(cl);
 	mei_hdr.me_addr = mei_cl_me_id(cl);
 	mei_hdr.reserved = 0;
+	mei_hdr.msg_complete = 0;
 	mei_hdr.internal = cb->internal;
 
-	if ((u32)slots >= msg_slots) {
+	len = buf->size - cb->buf_idx;
+	hbuf_slots = mei_hbuf_empty_slots(dev);
+	if (hbuf_slots < 0) {
+		rets = -EOVERFLOW;
+		goto err;
+	}
+	hbuf_len = mei_slots2data(hbuf_slots) - sizeof(struct mei_msg_hdr);
+
+	/**
+	 * Split the message only if we can write the whole host buffer
+	 * otherwise wait for next time the host buffer is empty.
+	 */
+	if (hbuf_len >= len) {
 		mei_hdr.length = len;
 		mei_hdr.msg_complete = 1;
-	/* Split the message only if we can write the whole host buffer */
-	} else if ((u32)slots == dev->hbuf_depth) {
-		msg_slots = slots;
-		len = mei_slots2data(slots) - sizeof(struct mei_msg_hdr);
-		mei_hdr.length = len;
-		mei_hdr.msg_complete = 0;
+	} else if ((u32)hbuf_slots == mei_hbuf_depth(dev)) {
+		mei_hdr.length = hbuf_len;
 	} else {
-		/* wait for next time the host buffer is empty */
 		return 0;
 	}
 
@@ -1650,6 +1651,8 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 	struct mei_msg_data *buf;
 	struct mei_msg_hdr mei_hdr;
 	size_t len;
+	size_t hbuf_len;
+	int hbuf_slots;
 	ssize_t rets;
 	bool blocking;
 
@@ -1692,19 +1695,25 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 		rets = len;
 		goto out;
 	}
+
 	if (!mei_hbuf_acquire(dev)) {
 		cl_dbg(dev, cl, "Cannot acquire the host buffer: not sending.\n");
 		rets = len;
 		goto out;
 	}
 
-	/* Check for a maximum length */
-	if (len > mei_hbuf_max_len(dev)) {
-		mei_hdr.length = mei_hbuf_max_len(dev);
-		mei_hdr.msg_complete = 0;
-	} else {
+	hbuf_slots = mei_hbuf_empty_slots(dev);
+	if (hbuf_slots < 0) {
+		rets = -EOVERFLOW;
+		goto out;
+	}
+
+	hbuf_len = mei_slots2data(hbuf_slots) - sizeof(struct mei_msg_hdr);
+	if (hbuf_len >= len) {
 		mei_hdr.length = len;
 		mei_hdr.msg_complete = 1;
+	} else {
+		mei_hdr.length = hbuf_len;
 	}
 
 	rets = mei_write_message(dev, &mei_hdr, buf->data);
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 016b7c956f18..c50671cf47eb 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -228,7 +228,7 @@ static void mei_me_hw_config(struct mei_device *dev)
 
 	/* Doesn't change in runtime */
 	hcsr = mei_hcsr_read(dev);
-	dev->hbuf_depth = (hcsr & H_CBD) >> 24;
+	hw->hbuf_depth = (hcsr & H_CBD) >> 24;
 
 	reg = 0;
 	pci_read_config_dword(pdev, PCI_CFG_HFS_1, &reg);
@@ -490,28 +490,31 @@ static bool mei_me_hbuf_is_empty(struct mei_device *dev)
  */
 static int mei_me_hbuf_empty_slots(struct mei_device *dev)
 {
+	struct mei_me_hw *hw = to_me_hw(dev);
 	unsigned char filled_slots, empty_slots;
 
 	filled_slots = mei_hbuf_filled_slots(dev);
-	empty_slots = dev->hbuf_depth - filled_slots;
+	empty_slots = hw->hbuf_depth - filled_slots;
 
 	/* check for overflow */
-	if (filled_slots > dev->hbuf_depth)
+	if (filled_slots > hw->hbuf_depth)
 		return -EOVERFLOW;
 
 	return empty_slots;
 }
 
 /**
- * mei_me_hbuf_max_len - returns size of hw buffer.
+ * mei_me_hbuf_depth - returns depth of the hw buffer.
  *
  * @dev: the device structure
  *
- * Return: size of hw buffer in bytes
+ * Return: size of hw buffer in slots
  */
-static size_t mei_me_hbuf_max_len(const struct mei_device *dev)
+static u32 mei_me_hbuf_depth(const struct mei_device *dev)
 {
-	return mei_slots2data(dev->hbuf_depth) - sizeof(struct mei_msg_hdr);
+	struct mei_me_hw *hw = to_me_hw(dev);
+
+	return hw->hbuf_depth;
 }
 
 
@@ -1317,7 +1320,7 @@ static const struct mei_hw_ops mei_me_hw_ops = {
 
 	.hbuf_free_slots = mei_me_hbuf_empty_slots,
 	.hbuf_is_ready = mei_me_hbuf_is_empty,
-	.hbuf_max_len = mei_me_hbuf_max_len,
+	.hbuf_depth = mei_me_hbuf_depth,
 
 	.write = mei_me_hbuf_write,
 
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index 67892533576e..0c6fe71d1212 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -52,12 +52,14 @@ struct mei_cfg {
  * @mem_addr: io memory address
  * @pg_state: power gating state
  * @d0i3_supported: di03 support
+ * @hbuf_depth: depth of hardware host/write buffer in slots
  */
 struct mei_me_hw {
 	const struct mei_cfg *cfg;
 	void __iomem *mem_addr;
 	enum mei_pg_state pg_state;
 	bool d0i3_supported;
+	u8 hbuf_depth;
 };
 
 #define to_me_hw(dev) (struct mei_me_hw *)((dev)->hw)
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index 0facd823634e..7e2026894e9f 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -31,6 +31,7 @@
 
 #include "mei-trace.h"
 
+#define TXE_HBUF_DEPTH (PAYLOAD_SIZE / MEI_SLOT_SIZE)
 
 /**
  * mei_txe_reg_read - Reads 32bit data from the txe device
@@ -681,9 +682,6 @@ static void mei_txe_hw_config(struct mei_device *dev)
 
 	struct mei_txe_hw *hw = to_txe_hw(dev);
 
-	/* Doesn't change in runtime */
-	dev->hbuf_depth = PAYLOAD_SIZE / MEI_SLOT_SIZE;
-
 	hw->aliveness = mei_txe_aliveness_get(dev);
 	hw->readiness = mei_txe_readiness_get(dev);
 
@@ -710,7 +708,7 @@ static int mei_txe_write(struct mei_device *dev,
 	unsigned long rem;
 	unsigned long length;
 	unsigned long i;
-	u32 slots = dev->hbuf_depth;
+	u32 slots = TXE_HBUF_DEPTH;
 	u32 *reg_buf = (u32 *)buf;
 	u32 dw_cnt;
 
@@ -762,15 +760,15 @@ static int mei_txe_write(struct mei_device *dev,
 }
 
 /**
- * mei_txe_hbuf_max_len - mimics the me hbuf circular buffer
+ * mei_txe_hbuf_depth - mimics the me hbuf circular buffer
  *
  * @dev: the device structure
  *
- * Return: the PAYLOAD_SIZE - header size
+ * Return: the TXE_HBUF_DEPTH
  */
-static size_t mei_txe_hbuf_max_len(const struct mei_device *dev)
+static u32 mei_txe_hbuf_depth(const struct mei_device *dev)
 {
-	return PAYLOAD_SIZE - sizeof(struct mei_msg_hdr);
+	return TXE_HBUF_DEPTH;
 }
 
 /**
@@ -778,7 +776,7 @@ static size_t mei_txe_hbuf_max_len(const struct mei_device *dev)
  *
  * @dev: the device structure
  *
- * Return: always hbuf_depth
+ * Return: always TXE_HBUF_DEPTH
  */
 static int mei_txe_hbuf_empty_slots(struct mei_device *dev)
 {
@@ -797,7 +795,7 @@ static int mei_txe_hbuf_empty_slots(struct mei_device *dev)
 static int mei_txe_count_full_read_slots(struct mei_device *dev)
 {
 	/* read buffers has static size */
-	return  PAYLOAD_SIZE / MEI_SLOT_SIZE;
+	return TXE_HBUF_DEPTH;
 }
 
 /**
@@ -1140,7 +1138,7 @@ irqreturn_t mei_txe_irq_thread_handler(int irq, void *dev_id)
 	/* Input Ready: Detection if host can write to SeC */
 	if (test_and_clear_bit(TXE_INTR_IN_READY_BIT, &hw->intr_cause)) {
 		dev->hbuf_is_ready = true;
-		hw->slots = dev->hbuf_depth;
+		hw->slots = TXE_HBUF_DEPTH;
 	}
 
 	if (hw->aliveness && dev->hbuf_is_ready) {
@@ -1186,7 +1184,7 @@ static const struct mei_hw_ops mei_txe_hw_ops = {
 
 	.hbuf_free_slots = mei_txe_hbuf_empty_slots,
 	.hbuf_is_ready = mei_txe_is_input_ready,
-	.hbuf_max_len = mei_txe_hbuf_max_len,
+	.hbuf_depth = mei_txe_hbuf_depth,
 
 	.write = mei_txe_write,
 
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 897126dca5d0..fa543dcfc111 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -29,7 +29,6 @@
 #define MEI_SLOT_SIZE             sizeof(u32)
 #define MEI_RD_MSG_BUF_SIZE       (128 * MEI_SLOT_SIZE)
 
-
 /*
  * Number of Maximum MEI Clients
  */
@@ -271,7 +270,7 @@ struct mei_cl {
  *
  * @hbuf_free_slots  : query for write buffer empty slots
  * @hbuf_is_ready    : query if write buffer is empty
- * @hbuf_max_len     : query for write buffer max len
+ * @hbuf_depth       : query for write buffer depth
  *
  * @write            : write a message to FW
  *
@@ -301,7 +300,7 @@ struct mei_hw_ops {
 
 	int (*hbuf_free_slots)(struct mei_device *dev);
 	bool (*hbuf_is_ready)(struct mei_device *dev);
-	size_t (*hbuf_max_len)(const struct mei_device *dev);
+	u32 (*hbuf_depth)(const struct mei_device *dev);
 	int (*write)(struct mei_device *dev,
 		     struct mei_msg_hdr *hdr,
 		     const unsigned char *buf);
@@ -411,7 +410,6 @@ struct mei_fw_version {
  * @rd_msg_buf  : control messages buffer
  * @rd_msg_hdr  : read message header storage
  *
- * @hbuf_depth  : depth of hardware host/write buffer is slots
  * @hbuf_is_ready : query if the host host/write buffer is ready
  *
  * @version     : HBM protocol version in use
@@ -489,7 +487,6 @@ struct mei_device {
 	u32 rd_msg_hdr;
 
 	/* write buffer */
-	u8 hbuf_depth;
 	bool hbuf_is_ready;
 
 	struct hbm_version version;
@@ -655,9 +652,9 @@ static inline int mei_hbuf_empty_slots(struct mei_device *dev)
 	return dev->ops->hbuf_free_slots(dev);
 }
 
-static inline size_t mei_hbuf_max_len(const struct mei_device *dev)
+static inline u32 mei_hbuf_depth(const struct mei_device *dev)
 {
-	return dev->ops->hbuf_max_len(dev);
+	return dev->ops->hbuf_depth(dev);
 }
 
 static inline int mei_write_message(struct mei_device *dev,
-- 
2.14.4

