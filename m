Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C56C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FF7208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FF7208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeGaIQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:16:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:59929 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeGaIQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:16:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 23:37:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="61154161"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2018 23:37:21 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 01/12] mei: add support for variable length mei headers.
Date:   Tue, 31 Jul 2018 09:35:33 +0300
Message-Id: <20180731063544.25540-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180731063544.25540-1-tomas.winkler@intel.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove header size knowledge from me and txe hw layers,
this requires to change the write handler to accept
header and its length as well as data and its length.

HBM messages are fixed to use basic header, hence we add mei_hbm2slots()
that converts HBM message length and mei message header,
while mei_data2slots() converts data length directly to the slots.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c    | 31 ++++++++++++++++++-------------
 drivers/misc/mei/hbm.c       | 30 ++++++++++++++++++++++--------
 drivers/misc/mei/hw-me.c     | 34 ++++++++++++++++++++--------------
 drivers/misc/mei/hw-txe.c    | 42 +++++++++++++++++++++---------------------
 drivers/misc/mei/interrupt.c |  4 ++--
 drivers/misc/mei/mei_dev.h   | 25 +++++++++++++++++++------
 6 files changed, 102 insertions(+), 64 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 207d2f5d5702..0a9173827461 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -863,7 +863,7 @@ int mei_cl_irq_disconnect(struct mei_cl *cl, struct mei_cl_cb *cb,
 	int slots;
 	int ret;
 
-	msg_slots = mei_data2slots(sizeof(struct hbm_client_connect_request));
+	msg_slots = mei_hbm2slots(sizeof(struct hbm_client_connect_request));
 	slots = mei_hbuf_empty_slots(dev);
 	if (slots < 0)
 		return -EOVERFLOW;
@@ -1055,11 +1055,10 @@ int mei_cl_irq_connect(struct mei_cl *cl, struct mei_cl_cb *cb,
 	int slots;
 	int rets;
 
-	msg_slots = mei_data2slots(sizeof(struct hbm_client_connect_request));
-
 	if (mei_cl_is_other_connecting(cl))
 		return 0;
 
+	msg_slots = mei_hbm2slots(sizeof(struct hbm_client_connect_request));
 	slots = mei_hbuf_empty_slots(dev);
 	if (slots < 0)
 		return -EOVERFLOW;
@@ -1299,7 +1298,7 @@ int mei_cl_irq_notify(struct mei_cl *cl, struct mei_cl_cb *cb,
 	int ret;
 	bool request;
 
-	msg_slots = mei_data2slots(sizeof(struct hbm_client_connect_request));
+	msg_slots = mei_hbm2slots(sizeof(struct hbm_client_connect_request));
 	slots = mei_hbuf_empty_slots(dev);
 	if (slots < 0)
 		return -EOVERFLOW;
@@ -1571,6 +1570,7 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	struct mei_device *dev;
 	struct mei_msg_data *buf;
 	struct mei_msg_hdr mei_hdr;
+	size_t hdr_len = sizeof(mei_hdr);
 	size_t len;
 	size_t hbuf_len;
 	int hbuf_slots;
@@ -1601,7 +1601,8 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 		rets = -EOVERFLOW;
 		goto err;
 	}
-	hbuf_len = mei_slots2data(hbuf_slots) - sizeof(struct mei_msg_hdr);
+
+	hbuf_len = mei_slots2data(hbuf_slots);
 
 	mei_msg_hdr_init(&mei_hdr, cb);
 
@@ -1609,11 +1610,11 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	 * Split the message only if we can write the whole host buffer
 	 * otherwise wait for next time the host buffer is empty.
 	 */
-	if (hbuf_len >= len) {
+	if (len + hdr_len <= hbuf_len) {
 		mei_hdr.length = len;
 		mei_hdr.msg_complete = 1;
 	} else if ((u32)hbuf_slots == mei_hbuf_depth(dev)) {
-		mei_hdr.length = hbuf_len;
+		mei_hdr.length = hbuf_len - hdr_len;
 	} else {
 		return 0;
 	}
@@ -1621,7 +1622,8 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	cl_dbg(dev, cl, "buf: size = %zu idx = %zu\n",
 			cb->buf.size, cb->buf_idx);
 
-	rets = mei_write_message(dev, &mei_hdr, buf->data + cb->buf_idx);
+	rets = mei_write_message(dev, &mei_hdr, hdr_len,
+				 buf->data + cb->buf_idx, mei_hdr.length);
 	if (rets)
 		goto err;
 
@@ -1661,6 +1663,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 	struct mei_device *dev;
 	struct mei_msg_data *buf;
 	struct mei_msg_hdr mei_hdr;
+	size_t hdr_len = sizeof(mei_hdr);
 	size_t len;
 	size_t hbuf_len;
 	int hbuf_slots;
@@ -1716,15 +1719,17 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 		goto out;
 	}
 
-	hbuf_len = mei_slots2data(hbuf_slots) - sizeof(struct mei_msg_hdr);
-	if (hbuf_len >= len) {
+	hbuf_len = mei_slots2data(hbuf_slots);
+
+	if (len + hdr_len <= hbuf_len) {
 		mei_hdr.length = len;
 		mei_hdr.msg_complete = 1;
 	} else {
-		mei_hdr.length = hbuf_len;
+		mei_hdr.length = hbuf_len - hdr_len;
 	}
 
-	rets = mei_write_message(dev, &mei_hdr, buf->data);
+	rets = mei_write_message(dev, &mei_hdr, hdr_len,
+				 buf->data, mei_hdr.length);
 	if (rets)
 		goto err;
 
@@ -1761,7 +1766,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 		}
 	}
 
-	rets = len;
+	rets = buf->size;
 err:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index fe6595fe94f1..8b3fd9ff6566 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -95,6 +95,20 @@ static int mei_cl_conn_status_to_errno(enum mei_cl_connect_status status)
 	}
 }
 
+/**
+ * mei_hbm_write_message - wrapper for sending hbm messages.
+ *
+ * @dev: mei device
+ * @hdr: mei header
+ * @data: payload
+ */
+static inline int mei_hbm_write_message(struct mei_device *dev,
+					struct mei_msg_hdr *hdr,
+					const void *data)
+{
+	return mei_write_message(dev, hdr, sizeof(*hdr), data, hdr->length);
+}
+
 /**
  * mei_hbm_idle - set hbm to idle state
  *
@@ -174,7 +188,7 @@ static inline int mei_hbm_cl_write(struct mei_device *dev, struct mei_cl *cl,
 	mei_hbm_hdr(&mei_hdr, len);
 	mei_hbm_cl_hdr(cl, hbm_cmd, buf, len);
 
-	return mei_write_message(dev, &mei_hdr, buf);
+	return mei_hbm_write_message(dev, &mei_hdr, buf);
 }
 
 /**
@@ -267,7 +281,7 @@ int mei_hbm_start_req(struct mei_device *dev)
 	start_req.host_version.minor_version = HBM_MINOR_VERSION;
 
 	dev->hbm_state = MEI_HBM_IDLE;
-	ret = mei_write_message(dev, &mei_hdr, &start_req);
+	ret = mei_hbm_write_message(dev, &mei_hdr, &start_req);
 	if (ret) {
 		dev_err(dev->dev, "version message write failed: ret = %d\n",
 			ret);
@@ -304,7 +318,7 @@ static int mei_hbm_enum_clients_req(struct mei_device *dev)
 	enum_req.flags |= dev->hbm_f_ie_supported ?
 			  MEI_HBM_ENUM_F_IMMEDIATE_ENUM : 0;
 
-	ret = mei_write_message(dev, &mei_hdr, &enum_req);
+	ret = mei_hbm_write_message(dev, &mei_hdr, &enum_req);
 	if (ret) {
 		dev_err(dev->dev, "enumeration request write failed: ret = %d.\n",
 			ret);
@@ -373,7 +387,7 @@ static int mei_hbm_add_cl_resp(struct mei_device *dev, u8 addr, u8 status)
 	resp.me_addr = addr;
 	resp.status  = status;
 
-	ret = mei_write_message(dev, &mei_hdr, &resp);
+	ret = mei_hbm_write_message(dev, &mei_hdr, &resp);
 	if (ret)
 		dev_err(dev->dev, "add client response write failed: ret = %d\n",
 			ret);
@@ -430,7 +444,7 @@ int mei_hbm_cl_notify_req(struct mei_device *dev,
 
 	req.start = start;
 
-	ret = mei_write_message(dev, &mei_hdr, &req);
+	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret)
 		dev_err(dev->dev, "notify request failed: ret = %d\n", ret);
 
@@ -555,7 +569,7 @@ static int mei_hbm_prop_req(struct mei_device *dev, unsigned long start_idx)
 	prop_req.hbm_cmd = HOST_CLIENT_PROPERTIES_REQ_CMD;
 	prop_req.me_addr = addr;
 
-	ret = mei_write_message(dev, &mei_hdr, &prop_req);
+	ret = mei_hbm_write_message(dev, &mei_hdr, &prop_req);
 	if (ret) {
 		dev_err(dev->dev, "properties request write failed: ret = %d\n",
 			ret);
@@ -592,7 +606,7 @@ int mei_hbm_pg(struct mei_device *dev, u8 pg_cmd)
 	memset(&req, 0, len);
 	req.hbm_cmd = pg_cmd;
 
-	ret = mei_write_message(dev, &mei_hdr, &req);
+	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret)
 		dev_err(dev->dev, "power gate command write failed.\n");
 	return ret;
@@ -618,7 +632,7 @@ static int mei_hbm_stop_req(struct mei_device *dev)
 	req.hbm_cmd = HOST_STOP_REQ_CMD;
 	req.reason = DRIVER_STOP_REQUEST;
 
-	return mei_write_message(dev, &mei_hdr, &req);
+	return mei_hbm_write_message(dev, &mei_hdr, &req);
 }
 
 /**
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index c50671cf47eb..0e3c31595dda 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -517,28 +517,31 @@ static u32 mei_me_hbuf_depth(const struct mei_device *dev)
 	return hw->hbuf_depth;
 }
 
-
 /**
  * mei_me_hbuf_write - writes a message to host hw buffer.
  *
  * @dev: the device structure
- * @header: mei HECI header of message
- * @buf: message payload will be written
+ * @hdr: header of message
+ * @hdr_len: header length in bytes: must be multiplication of a slot (4bytes)
+ * @data: payload
+ * @data_len: payload length in bytes
  *
- * Return: -EIO if write has failed
+ * Return: 0 if success, < 0 - otherwise.
  */
 static int mei_me_hbuf_write(struct mei_device *dev,
-			     struct mei_msg_hdr *header,
-			     const unsigned char *buf)
+			     const void *hdr, size_t hdr_len,
+			     const void *data, size_t data_len)
 {
 	unsigned long rem;
-	unsigned long length = header->length;
 	unsigned long i;
-	u32 *reg_buf = (u32 *)buf;
+	const u32 *reg_buf;
 	u32 dw_cnt;
 	int empty_slots;
 
-	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM(header));
+	if (WARN_ON(!hdr || !data || hdr_len & 0x3))
+		return -EINVAL;
+
+	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM((struct mei_msg_hdr *)hdr));
 
 	empty_slots = mei_hbuf_empty_slots(dev);
 	dev_dbg(dev->dev, "empty slots = %hu.\n", empty_slots);
@@ -546,20 +549,23 @@ static int mei_me_hbuf_write(struct mei_device *dev,
 	if (empty_slots < 0)
 		return -EOVERFLOW;
 
-	dw_cnt = mei_data2slots(length);
+	dw_cnt = mei_data2slots(hdr_len + data_len);
 	if (dw_cnt > (u32)empty_slots)
 		return -EMSGSIZE;
 
-	mei_me_hcbww_write(dev, *((u32 *) header));
+	reg_buf = hdr;
+	for (i = 0; i < hdr_len / MEI_SLOT_SIZE; i++)
+		mei_me_hcbww_write(dev, reg_buf[i]);
 
-	for (i = 0; i < length / MEI_SLOT_SIZE; i++)
+	reg_buf = data;
+	for (i = 0; i < data_len / MEI_SLOT_SIZE; i++)
 		mei_me_hcbww_write(dev, reg_buf[i]);
 
-	rem = length & 0x3;
+	rem = data_len & 0x3;
 	if (rem > 0) {
 		u32 reg = 0;
 
-		memcpy(&reg, &buf[length - rem], rem);
+		memcpy(&reg, (const u8 *)data + data_len - rem, rem);
 		mei_me_hcbww_write(dev, reg);
 	}
 
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index 7e2026894e9f..8449fe0367ff 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -689,37 +689,34 @@ static void mei_txe_hw_config(struct mei_device *dev)
 		hw->aliveness, hw->readiness);
 }
 
-
 /**
  * mei_txe_write - writes a message to device.
  *
  * @dev: the device structure
- * @header: header of message
- * @buf: message buffer will be written
+ * @hdr: header of message
+ * @hdr_len: header length in bytes - must multiplication of a slot (4bytes)
+ * @data: payload
+ * @data_len: paylead length in bytes
  *
- * Return: 0 if success, <0 - otherwise.
+ * Return: 0 if success, < 0 - otherwise.
  */
-
 static int mei_txe_write(struct mei_device *dev,
-			 struct mei_msg_hdr *header,
-			 const unsigned char *buf)
+			 const void *hdr, size_t hdr_len,
+			 const void *data, size_t data_len)
 {
 	struct mei_txe_hw *hw = to_txe_hw(dev);
 	unsigned long rem;
-	unsigned long length;
-	unsigned long i;
+	const u32 *reg_buf;
 	u32 slots = TXE_HBUF_DEPTH;
-	u32 *reg_buf = (u32 *)buf;
 	u32 dw_cnt;
+	unsigned long i, j;
 
-	if (WARN_ON(!header || !buf))
+	if (WARN_ON(!hdr || !data || hdr_len & 0x3))
 		return -EINVAL;
 
-	length = header->length;
-
-	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM(header));
+	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM((struct mei_msg_hdr *)hdr));
 
-	dw_cnt = mei_data2slots(length);
+	dw_cnt = mei_data2slots(hdr_len + data_len);
 	if (dw_cnt > slots)
 		return -EMSGSIZE;
 
@@ -737,17 +734,20 @@ static int mei_txe_write(struct mei_device *dev,
 		return -EAGAIN;
 	}
 
-	mei_txe_input_payload_write(dev, 0, *((u32 *)header));
+	reg_buf = hdr;
+	for (i = 0; i < hdr_len / MEI_SLOT_SIZE; i++)
+		mei_txe_input_payload_write(dev, i, reg_buf[i]);
 
-	for (i = 0; i < length / 4; i++)
-		mei_txe_input_payload_write(dev, i + 1, reg_buf[i]);
+	reg_buf = data;
+	for (j = 0; j < data_len / MEI_SLOT_SIZE; j++)
+		mei_txe_input_payload_write(dev, i + j, reg_buf[j]);
 
-	rem = length & 0x3;
+	rem = data_len & 0x3;
 	if (rem > 0) {
 		u32 reg = 0;
 
-		memcpy(&reg, &buf[length - rem], rem);
-		mei_txe_input_payload_write(dev, i + 1, reg);
+		memcpy(&reg, (const u8 *)data + data_len - rem, rem);
+		mei_txe_input_payload_write(dev, i + j, reg);
 	}
 
 	/* after each write the whole buffer is consumed */
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 6217cebcad3d..5a661cbdf2ae 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -173,7 +173,7 @@ static int mei_cl_irq_disconnect_rsp(struct mei_cl *cl, struct mei_cl_cb *cb,
 	int slots;
 	int ret;
 
-	msg_slots = mei_data2slots(sizeof(struct hbm_client_connect_response));
+	msg_slots = mei_hbm2slots(sizeof(struct hbm_client_connect_response));
 	slots = mei_hbuf_empty_slots(dev);
 	if (slots < 0)
 		return -EOVERFLOW;
@@ -208,7 +208,7 @@ static int mei_cl_irq_read(struct mei_cl *cl, struct mei_cl_cb *cb,
 	if (!list_empty(&cl->rd_pending))
 		return 0;
 
-	msg_slots = mei_data2slots(sizeof(struct hbm_flow_control));
+	msg_slots = mei_hbm2slots(sizeof(struct hbm_flow_control));
 	slots = mei_hbuf_empty_slots(dev);
 	if (slots < 0)
 		return -EOVERFLOW;
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index e9f37085a628..06fb5fc67fe9 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -300,8 +300,8 @@ struct mei_hw_ops {
 	bool (*hbuf_is_ready)(struct mei_device *dev);
 	u32 (*hbuf_depth)(const struct mei_device *dev);
 	int (*write)(struct mei_device *dev,
-		     struct mei_msg_hdr *hdr,
-		     const unsigned char *buf);
+		     const void *hdr, size_t hdr_len,
+		     const void *data, size_t data_len);
 
 	int (*rdbuf_full_slots)(struct mei_device *dev);
 
@@ -528,14 +528,26 @@ static inline unsigned long mei_secs_to_jiffies(unsigned long sec)
 }
 
 /**
- * mei_data2slots - get slots - number of (dwords) from a message length
- *	+ size of the mei header
+ * mei_data2slots - get slots number from a message length
  *
  * @length: size of the messages in bytes
  *
  * Return: number of slots
  */
 static inline u32 mei_data2slots(size_t length)
+{
+	return DIV_ROUND_UP(length, MEI_SLOT_SIZE);
+}
+
+/**
+ * mei_hbm2slots - get slots number from a hbm message length
+ *                 length + size of the mei message header
+ *
+ * @length: size of the messages in bytes
+ *
+ * Return: number of slots
+ */
+static inline u32 mei_hbm2slots(size_t length)
 {
 	return DIV_ROUND_UP(sizeof(struct mei_msg_hdr) + length, MEI_SLOT_SIZE);
 }
@@ -656,9 +668,10 @@ static inline u32 mei_hbuf_depth(const struct mei_device *dev)
 }
 
 static inline int mei_write_message(struct mei_device *dev,
-				    struct mei_msg_hdr *hdr, const void *buf)
+				    const void *hdr, size_t hdr_len,
+				    const void *data, size_t data_len)
 {
-	return dev->ops->write(dev, hdr, buf);
+	return dev->ops->write(dev, hdr, hdr_len, data, data_len);
 }
 
 static inline u32 mei_read_hdr(const struct mei_device *dev)
-- 
2.14.4

