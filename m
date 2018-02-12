Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x224JkxpEvsBHvNtx9AEyHHIsxXrhAlxDsTNLrAFaTBZAAmMriUpoVy0hwDsmrqtqcsNlnara
ARC-Seal: i=1; a=rsa-sha256; t=1518461165; cv=none;
        d=google.com; s=arc-20160816;
        b=EWFB3QIl77RlcJnUKfuyus+hU2+DsOBN+5JaH1NRiU8QJuDyQyGveecNaJ0yTA5Unn
         e4qKXnj/tjkplok7fTqmLkiohhJMORBfI7Zhp9OLln929lFG2Iur5O1NHFUPHdMRbBOM
         2ekv3znbiSvwzFlKUYQ7+eWFvsCTXxw/lU8oLjPUoQYeAJ6IgOifb1fQPdvafYDUzyE9
         Wi8B4e33Ez1hBnXVU81S5yzzOUjPPvQS3fA/zk4r7DKfMu+cQWv+ylo3Mppy1Whw+wY2
         AqDRfywGdJhmDsF7eTpdguj0jW5SPJi79LzdW11LjtkWOdvdqFUXdS3K8miiDFro+ks9
         s7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/LgpCOMuvhbXUC2vj8cEsKim6iMp0JjaA9lHM/V5D0Q=;
        b=ExWBJdl5Fk0wH918sUtaTI2L49HA5iMO7njNLFqK5eli5bnNw/vDkaQhRnY4+sfjOc
         EjMUba+kzqHPYRkatC3Cmnt69W7ZA3iZUjs0YR7Ug3YaHbRJGp8G2xItCRsWUDdQ4jXw
         TXVO0OUqZaYXlNa1wfm1S/U+dvObW7SGidUcSu1AoKLucB2vL7LJ3Ag3/rEbeNDJ3vY4
         ipmru9Rb16MERtVtgZYOl9cRuKWJloI8rDDjedLcyVGefAQfwy/mNYmgCk3IbtAkaq8N
         ETH+FLXjDYxr35GlyU+0njkWzIJwar3uMKAAc4fJqvzliPqOyiP22vulsfVG3h0q+U6Y
         t+3w==
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
Subject: [PATCH v5 14/20] firmware: arm_scmi: add per-protocol channels support using idr objects
Date: Mon, 12 Feb 2018 18:45:18 +0000
Message-Id: <1518461124-17371-15-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221934859702241?=
X-GMAIL-MSGID: =?utf-8?q?1592221934859702241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to maintain the channel information per protocol, we need
some sort of list or hashtable to hold all this information. IDR
provides sparse array mapping of small integer ID numbers onto arbitrary
pointers. In this case the arbitrary pointers can be pointers to the
channel information.

This patch adds support for per-protocol channels using those idr
objects.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 5dd54f72b587..b91188dc85a1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -115,6 +115,7 @@ struct scmi_chan_info {
 	struct mbox_chan *chan;
 	void __iomem *payload;
 	struct device *dev;
+	struct scmi_handle *handle;
 };
 
 /**
@@ -126,7 +127,7 @@ struct scmi_chan_info {
  * @version: SCMI revision information containing protocol version,
  *	implementation version and (sub-)vendor identification.
  * @minfo: Message info
- * @tx_cinfo: Reference to SCMI channel information
+ * @tx_idr: IDR object to map protocol id to channel info pointer
  * @protocols_imp: list of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: list head
@@ -138,7 +139,7 @@ struct scmi_info {
 	struct scmi_revision_info version;
 	struct scmi_handle handle;
 	struct scmi_xfers_info minfo;
-	struct scmi_chan_info *tx_cinfo;
+	struct idr tx_idr;
 	u8 *protocols_imp;
 	struct list_head node;
 	int users;
@@ -229,7 +230,7 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 	struct scmi_xfer *xfer;
 	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
 	struct device *dev = cinfo->dev;
-	struct scmi_info *info = dev_get_drvdata(dev);
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 	struct scmi_xfers_info *minfo = &info->minfo;
 	struct scmi_shared_mem __iomem *mem = cinfo->payload;
 
@@ -392,7 +393,11 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	int timeout;
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct device *dev = info->dev;
-	struct scmi_chan_info *cinfo = info->tx_cinfo;
+	struct scmi_chan_info *cinfo;
+
+	cinfo = idr_find(&info->tx_idr, xfer->hdr.protocol_id);
+	if (unlikely(!cinfo))
+		return -EINVAL;
 
 	ret = mbox_send_message(cinfo->chan, xfer);
 	if (ret < 0) {
@@ -662,13 +667,18 @@ static int scmi_mailbox_check(struct device_node *np)
 	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
 }
 
-static int scmi_mbox_free_channel(struct scmi_chan_info *cinfo)
+static int scmi_mbox_free_channel(int id, void *p, void *data)
 {
+	struct scmi_chan_info *cinfo = p;
+	struct idr *idr = data;
+
 	if (!IS_ERR_OR_NULL(cinfo->chan)) {
 		mbox_free_channel(cinfo->chan);
 		cinfo->chan = NULL;
 	}
 
+	idr_remove(idr, id);
+
 	return 0;
 }
 
@@ -676,6 +686,7 @@ static int scmi_remove(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct scmi_info *info = platform_get_drvdata(pdev);
+	struct idr *idr = &info->tx_idr;
 
 	mutex_lock(&scmi_list_mutex);
 	if (info->users)
@@ -684,28 +695,34 @@ static int scmi_remove(struct platform_device *pdev)
 		list_del(&info->node);
 	mutex_unlock(&scmi_list_mutex);
 
-	if (!ret)
+	if (!ret) {
 		/* Safe to free channels since no more users */
-		return scmi_mbox_free_channel(info->tx_cinfo);
+		ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
+		idr_destroy(&info->tx_idr);
+	}
 
 	return ret;
 }
 
-static inline int scmi_mbox_chan_setup(struct scmi_info *info)
+static inline int
+scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
 {
 	int ret;
 	struct resource res;
 	resource_size_t size;
-	struct device *dev = info->dev;
 	struct device_node *shmem, *np = dev->of_node;
 	struct scmi_chan_info *cinfo;
 	struct mbox_client *cl;
 
+	if (scmi_mailbox_check(np)) {
+		cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
+		goto idr_alloc;
+	}
+
 	cinfo = devm_kzalloc(info->dev, sizeof(*cinfo), GFP_KERNEL);
 	if (!cinfo)
 		return -ENOMEM;
 
-	info->tx_cinfo = cinfo;
 	cinfo->dev = dev;
 
 	cl = &cinfo->cl;
@@ -739,6 +756,14 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 		return ret;
 	}
 
+idr_alloc:
+	ret = idr_alloc(&info->tx_idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
+	if (ret != prot_id) {
+		dev_err(dev, "unable to allocate SCMI idr slot err %d\n", ret);
+		return ret;
+	}
+
+	cinfo->handle = &info->handle;
 	return 0;
 }
 
@@ -755,6 +780,11 @@ scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
 		return;
 	}
 
+	if (scmi_mbox_chan_setup(info, &sdev->dev, prot_id)) {
+		dev_err(&sdev->dev, "failed to setup transport\n");
+		scmi_device_destroy(sdev);
+	}
+
 	/* setup handle now as the transport is ready */
 	scmi_set_handle(sdev);
 }
@@ -789,19 +819,19 @@ static int scmi_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, info);
+	idr_init(&info->tx_idr);
 
 	handle = &info->handle;
 	handle->dev = info->dev;
 	handle->version = &info->version;
 
-	ret = scmi_mbox_chan_setup(info);
+	ret = scmi_mbox_chan_setup(info, dev, SCMI_PROTOCOL_BASE);
 	if (ret)
 		return ret;
 
 	ret = scmi_base_protocol_init(handle);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
-		scmi_mbox_free_channel(info->tx_cinfo);
 		return ret;
 	}
 
-- 
2.7.4
