Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x224UwJXTrR6kDC9aASABpnBWNIXCeHk4M+MYYlB5DCsLwLVHPx/YxH5ZW4U+61wcJDQzgBn9
ARC-Seal: i=1; a=rsa-sha256; t=1518461163; cv=none;
        d=google.com; s=arc-20160816;
        b=SIuYOdQ2QBk4mCB0UcqX3J1rGZEkYFK/ND8us6RQtHux8vgcpXk+bls1KRniIkElgo
         z0ogruELKJGCefdMf6uH0QZAqa4UZqQCV9CRcmm7cnW68ic5hCpqIKBQIXZ+hF+NFNyU
         o2R8vwycZA898nWhNl6g+6HR//+ESYnw0hqulNJq/J8XkdKA+TTl5onY9D7JSt1ItY9x
         1BRxpIju0IlQswLhK+4kKTMES4N0vzp0j5WPYU7zXU+WnjPyEoJLfH2898ZUCjxEYmJU
         CUtIl4Ry5ljdRflRa6sI9m5v7H5MDF+NnU9mHdtzjkC5xBWT6TrU6jQU38reYiLkb2QG
         AepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=O8UfY8C8VOKcc2DegWEvUAAaSiLW+hu2nKaCx9BxPk8=;
        b=gE3CbkVn/wQ4hC82QdV03q+PACZxAB53KT/XeHWiImAaXNCOwyow1XPFtAPMnMFqbf
         DnIfZ1DCGka4YAjyP4X+mE8xRGSyQBO9vkzXMlPBC+50QLYIWBGLesTWLUv4oYkVsoWE
         15FbwpSHYTyI5oqRxr1ivhG2AqSkO2tJ7U0OFEo4SZxvuY+18Sx8YRkHEctslu/K5ry7
         p3dLHuwxfkVtZuQnx22XtkIrO57lOeM8SNYByDw5cn0HlY6CEc2SRrLbdQP3NdNbimjc
         eVJdQ9z1SSWf1NS3UhH3MTLNSPe6A5OrprXNlTTZ0CPN9g+93CUnOPl0nCOB0sc9YntV
         Yc5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH v5 13/20] firmware: arm_scmi: refactor in preparation to support per-protocol channels
Date: Mon, 12 Feb 2018 18:45:17 +0000
Message-Id: <1518461124-17371-14-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221933513736089?=
X-GMAIL-MSGID: =?utf-8?q?1592221933513736089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to support per-protocol channels if available, we need to
factor out all the mailbox channel information(Tx/Rx payload and
channel handle) out of the main SCMI instance information structure.

This patch refactors the existing channel information into a separate
chan_info structure.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 86 ++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 32 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 0108bb39d0f6..5dd54f72b587 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -102,6 +102,22 @@ struct scmi_desc {
 };
 
 /**
+ * struct scmi_chan_info - Structure representing a SCMI channel informfation
+ *
+ * @cl: Mailbox Client
+ * @chan: Transmit/Receive mailbox channel
+ * @payload: Transmit/Receive mailbox channel payload area
+ * @dev: Reference to device in the SCMI hierarchy corresponding to this
+ *	 channel
+ */
+struct scmi_chan_info {
+	struct mbox_client cl;
+	struct mbox_chan *chan;
+	void __iomem *payload;
+	struct device *dev;
+};
+
+/**
  * struct scmi_info - Structure representing a  SCMI instance
  *
  * @dev: Device pointer
@@ -109,10 +125,8 @@ struct scmi_desc {
  * @handle: Instance of SCMI handle to send to clients
  * @version: SCMI revision information containing protocol version,
  *	implementation version and (sub-)vendor identification.
- * @cl: Mailbox Client
- * @tx_chan: Transmit mailbox channel
- * @tx_payload: Transmit mailbox channel payload area
  * @minfo: Message info
+ * @tx_cinfo: Reference to SCMI channel information
  * @protocols_imp: list of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: list head
@@ -123,16 +137,14 @@ struct scmi_info {
 	const struct scmi_desc *desc;
 	struct scmi_revision_info version;
 	struct scmi_handle handle;
-	struct mbox_client cl;
-	struct mbox_chan *tx_chan;
-	void __iomem *tx_payload;
 	struct scmi_xfers_info minfo;
+	struct scmi_chan_info *tx_cinfo;
 	u8 *protocols_imp;
 	struct list_head node;
 	int users;
 };
 
-#define client_to_scmi_info(c)	container_of(c, struct scmi_info, cl)
+#define client_to_scmi_chan_info(c) container_of(c, struct scmi_chan_info, cl)
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
 
 /*
@@ -215,10 +227,11 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 {
 	u16 xfer_id;
 	struct scmi_xfer *xfer;
-	struct scmi_info *info = client_to_scmi_info(cl);
+	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
+	struct device *dev = cinfo->dev;
+	struct scmi_info *info = dev_get_drvdata(dev);
 	struct scmi_xfers_info *minfo = &info->minfo;
-	struct device *dev = info->dev;
-	struct scmi_shared_mem __iomem *mem = info->tx_payload;
+	struct scmi_shared_mem __iomem *mem = cinfo->payload;
 
 	xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
 
@@ -269,8 +282,8 @@ static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
 static void scmi_tx_prepare(struct mbox_client *cl, void *m)
 {
 	struct scmi_xfer *t = m;
-	struct scmi_info *info = client_to_scmi_info(cl);
-	struct scmi_shared_mem __iomem *mem = info->tx_payload;
+	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
+	struct scmi_shared_mem __iomem *mem = cinfo->payload;
 
 	/* Mark channel busy + clear error */
 	iowrite32(0x0, &mem->channel_status);
@@ -349,15 +362,15 @@ void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 }
 
 static bool
-scmi_xfer_poll_done(const struct scmi_info *info, struct scmi_xfer *xfer)
+scmi_xfer_poll_done(const struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 {
-	struct scmi_shared_mem *mem = info->tx_payload;
-	u16 xfer_id = MSG_XTRACT_TOKEN(le32_to_cpu(mem->msg_header));
+	struct scmi_shared_mem __iomem *mem = cinfo->payload;
+	u16 xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
 
 	if (xfer->hdr.seq != xfer_id)
 		return false;
 
-	return le32_to_cpu(mem->channel_status) &
+	return ioread32(&mem->channel_status) &
 		(SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR |
 		SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 }
@@ -379,8 +392,9 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	int timeout;
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct device *dev = info->dev;
+	struct scmi_chan_info *cinfo = info->tx_cinfo;
 
-	ret = mbox_send_message(info->tx_chan, xfer);
+	ret = mbox_send_message(cinfo->chan, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "mbox send fail %d\n", ret);
 		return ret;
@@ -396,11 +410,11 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 		do {
 			udelay(5);
 			cur = ktime_get();
-		} while (!scmi_xfer_poll_done(info, xfer) &&
+		} while (!scmi_xfer_poll_done(cinfo, xfer) &&
 			 ktime_before(cur, stop));
 
 		if (ktime_before(cur, stop))
-			scmi_fetch_response(xfer, info->tx_payload);
+			scmi_fetch_response(xfer, cinfo->payload);
 		else
 			ret = -ETIMEDOUT;
 	} else {
@@ -420,7 +434,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	 * Unfortunately, we have to kick the mailbox framework after we have
 	 * received our message.
 	 */
-	mbox_client_txdone(info->tx_chan, ret);
+	mbox_client_txdone(cinfo->chan, ret);
 
 	return ret;
 }
@@ -648,11 +662,11 @@ static int scmi_mailbox_check(struct device_node *np)
 	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
 }
 
-static int scmi_mbox_free_channel(struct scmi_info *info)
+static int scmi_mbox_free_channel(struct scmi_chan_info *cinfo)
 {
-	if (!IS_ERR_OR_NULL(info->tx_chan)) {
-		mbox_free_channel(info->tx_chan);
-		info->tx_chan = NULL;
+	if (!IS_ERR_OR_NULL(cinfo->chan)) {
+		mbox_free_channel(cinfo->chan);
+		cinfo->chan = NULL;
 	}
 
 	return 0;
@@ -672,7 +686,7 @@ static int scmi_remove(struct platform_device *pdev)
 
 	if (!ret)
 		/* Safe to free channels since no more users */
-		return scmi_mbox_free_channel(info);
+		return scmi_mbox_free_channel(info->tx_cinfo);
 
 	return ret;
 }
@@ -684,9 +698,17 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 	resource_size_t size;
 	struct device *dev = info->dev;
 	struct device_node *shmem, *np = dev->of_node;
+	struct scmi_chan_info *cinfo;
 	struct mbox_client *cl;
 
-	cl = &info->cl;
+	cinfo = devm_kzalloc(info->dev, sizeof(*cinfo), GFP_KERNEL);
+	if (!cinfo)
+		return -ENOMEM;
+
+	info->tx_cinfo = cinfo;
+	cinfo->dev = dev;
+
+	cl = &cinfo->cl;
 	cl->dev = dev;
 	cl->rx_callback = scmi_rx_callback;
 	cl->tx_prepare = scmi_tx_prepare;
@@ -702,16 +724,16 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 	}
 
 	size = resource_size(&res);
-	info->tx_payload = devm_ioremap(dev, res.start, size);
-	if (!info->tx_payload) {
+	cinfo->payload = devm_ioremap(info->dev, res.start, size);
+	if (!cinfo->payload) {
 		dev_err(dev, "failed to ioremap SCMI Tx payload\n");
 		return -EADDRNOTAVAIL;
 	}
 
 	/* Transmit channel is first entry i.e. index 0 */
-	info->tx_chan = mbox_request_channel(cl, 0);
-	if (IS_ERR(info->tx_chan)) {
-		ret = PTR_ERR(info->tx_chan);
+	cinfo->chan = mbox_request_channel(cl, 0);
+	if (IS_ERR(cinfo->chan)) {
+		ret = PTR_ERR(cinfo->chan);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "failed to request SCMI Tx mailbox\n");
 		return ret;
@@ -779,7 +801,7 @@ static int scmi_probe(struct platform_device *pdev)
 	ret = scmi_base_protocol_init(handle);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
-		scmi_mbox_free_channel(info);
+		scmi_mbox_free_channel(info->tx_cinfo);
 		return ret;
 	}
 
-- 
2.7.4
