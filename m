Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21802C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF432087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KuBnCn6F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jSNYHGXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF432087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJHNtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:49:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeJHNtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:49:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5ACBF60C4F; Mon,  8 Oct 2018 06:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538980767;
        bh=MIn5iSr9lAAU51qqDEhh9xt4Olc0awzQZErPrl9u4yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuBnCn6F9iRkrWqsQeCuki9JB3uNlkl4xKbXfr/3xaioUy3ma1pnXuflTsRZq6y1S
         HEXWBYZqNUccLo/lpL1DWuA27yBJ+b4SDHPT8UY0L1+tUyECfZ+RgT83BdZ+5wBPeA
         7LgzJVj8B6aiswXDsPYuYcI8vePGCMkhWNkNWIqc=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C78DD60B1E;
        Mon,  8 Oct 2018 06:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538980766;
        bh=MIn5iSr9lAAU51qqDEhh9xt4Olc0awzQZErPrl9u4yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSNYHGXcwfeysN9rXFeChDwaSomiOclXtdEc3CY4/KDz9yZvSwJN9IbYkZegW8CDr
         1R3ocaf0ldLL/L/KhxZuFyFVxnGWrdqUsVOAsrdlgi5nvrsWV1P/dMp4Cz9bWzKPkL
         o853tWMF4pxfi1zDjJuQsqOBKwF8xDWg7Dx9R+tc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C78DD60B1E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V4 1/4] rpmsg: core: Add signal API support
Date:   Mon,  8 Oct 2018 12:08:15 +0530
Message-Id: <1538980699-21516-2-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538980699-21516-1-git-send-email-aneela@codeaurora.org>
References: <1538980699-21516-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some transports like Glink support the state notifications between
clients using signals similar to serial protocol signals.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_core.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h |  5 +++++
 include/linux/rpmsg.h          | 26 ++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 8122807..3d7458a 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -2,6 +2,7 @@
 /*
  * remote processor messaging bus
  *
+ * Copyright (c) 2018, The Linux Foundation.
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
  *
@@ -283,6 +284,42 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 }
 EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 
+/**
+ * rpmsg_get_signals() - get the signals for this endpoint
+ * @ept:	the rpmsg endpoint
+ *
+ * Returns signal bits on success and an appropriate error value on failure.
+ */
+int rpmsg_get_signals(struct rpmsg_endpoint *ept)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->get_signals)
+		return -EOPNOTSUPP;
+
+	return ept->ops->get_signals(ept);
+}
+EXPORT_SYMBOL(rpmsg_get_signals);
+
+/**
+ * rpmsg_set_signals() - set the remote signals for this endpoint
+ * @ept:	the rpmsg endpoint
+ * @set:	set mask for signals
+ * @clear:	clear mask for signals
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_set_signals(struct rpmsg_endpoint *ept, u32 set, u32 clear)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->set_signals)
+		return -EOPNOTSUPP;
+
+	return ept->ops->set_signals(ept, set, clear);
+}
+EXPORT_SYMBOL(rpmsg_set_signals);
+
 /*
  * match an rpmsg channel with a channel info struct.
  * this is used to make sure we're not creating rpmsg devices for channels
@@ -468,6 +505,10 @@ static int rpmsg_dev_probe(struct device *dev)
 
 		rpdev->ept = ept;
 		rpdev->src = ept->addr;
+
+		if (rpdrv->signals)
+			ept->sig_cb = rpdrv->signals;
+
 	}
 
 	err = rpdrv->probe(rpdev);
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 0d791c3..033656d 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -2,6 +2,7 @@
 /*
  * remote processor messaging bus internals
  *
+ * Copyright (c) 2018, The Linux Foundation.
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
  *
@@ -46,6 +47,8 @@ struct rpmsg_device_ops {
  * @trysend:		see @rpmsg_trysend(), required
  * @trysendto:		see @rpmsg_trysendto(), optional
  * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
+ * @get_signals:	see @rpmsg_get_signals(), optional
+ * @set_signals:	see @rpmsg_set_signals(), optional
  *
  * Indirection table for the operations that a rpmsg backend should implement.
  * In addition to @destroy_ept, the backend must at least implement @send and
@@ -65,6 +68,8 @@ struct rpmsg_endpoint_ops {
 			     void *data, int len);
 	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
 			     poll_table *wait);
+	int (*get_signals)(struct rpmsg_endpoint *ept);
+	int (*set_signals)(struct rpmsg_endpoint *ept, u32 set, u32 clear);
 };
 
 int rpmsg_register_device(struct rpmsg_device *rpdev);
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 9fe156d..48c8ae3 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -2,6 +2,7 @@
 /*
  * Remote processor messaging
  *
+ * Copyright (c) 2018 The Linux Foundation.
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
  * All rights reserved.
@@ -60,6 +61,7 @@ struct rpmsg_device {
 };
 
 typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
+typedef int (*rpmsg_rx_sig_t)(struct rpmsg_device *, void *, u32, u32);
 
 /**
  * struct rpmsg_endpoint - binds a local rpmsg address to its user
@@ -67,6 +69,7 @@ struct rpmsg_device {
  * @refcount: when this drops to zero, the ept is deallocated
  * @cb: rx callback handler
  * @cb_lock: must be taken before accessing/changing @cb
+ * @sig_cb: rx serial signal handler
  * @addr: local rpmsg address
  * @priv: private data for the driver's use
  *
@@ -89,6 +92,7 @@ struct rpmsg_endpoint {
 	struct kref refcount;
 	rpmsg_rx_cb_t cb;
 	struct mutex cb_lock;
+	rpmsg_rx_sig_t sig_cb;
 	u32 addr;
 	void *priv;
 
@@ -102,6 +106,7 @@ struct rpmsg_endpoint {
  * @probe: invoked when a matching rpmsg channel (i.e. device) is found
  * @remove: invoked when the rpmsg channel is removed
  * @callback: invoked when an inbound message is received on the channel
+ * @signals: invoked when a serial signal change is received on the channel
  */
 struct rpmsg_driver {
 	struct device_driver drv;
@@ -109,6 +114,7 @@ struct rpmsg_driver {
 	int (*probe)(struct rpmsg_device *dev);
 	void (*remove)(struct rpmsg_device *dev);
 	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
+	int (*signals)(struct rpmsg_device *, void *, u32, u32);
 };
 
 #if IS_ENABLED(CONFIG_RPMSG)
@@ -135,6 +141,9 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 			poll_table *wait);
 
+int rpmsg_get_signals(struct rpmsg_endpoint *ept);
+int rpmsg_set_signals(struct rpmsg_endpoint *ept, u32 set, u32 clear);
+
 #else
 
 static inline int register_rpmsg_device(struct rpmsg_device *dev)
@@ -242,6 +251,23 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
 	return 0;
 }
 
+static inline int rpmsg_get_signals(struct rpmsg_endpoint *ept)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -ENXIO;
+}
+
+static inline int rpmsg_set_signals(struct rpmsg_endpoint *ept,
+				    u32 set, u32 clear)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -ENXIO;
+}
+
 #endif /* IS_ENABLED(CONFIG_RPMSG) */
 
 /* use a macro to avoid include chaining to get THIS_MODULE */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

