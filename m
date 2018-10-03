Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C543C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD4F20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T0sI1qmg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JLaW45UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD4F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJCSWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:22:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:22:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 911E8607BD; Wed,  3 Oct 2018 11:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566491;
        bh=tt+NgkqbOF6X7P7TEkE2mbojlOPdiDYXaQowH2j7qek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0sI1qmgm9rBBGWEhHw0g0T29SflWykOtuCc99uZwfxU4GYUh3sHRdK79qG8ElnS4
         FLgXj3bQFiM8B8YLgJ5Wq3KYTKswZWrBqJPcYz5IW2pHsfCZbkitj4BbHmYi5mgSOX
         oTuVgIVoqco4fZZlRQnj58BAvY+adJFwPKRRl9d8=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 745CD60275;
        Wed,  3 Oct 2018 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566490;
        bh=tt+NgkqbOF6X7P7TEkE2mbojlOPdiDYXaQowH2j7qek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLaW45UHb+L1M5PKRn67dpPTy8FbQvxAN3m14jH9hlkcNdiDZcjMVPm4EDDb6Mxhp
         cqhFt0Swaf8+UFrNBAvVU6/fb/6FLf1t2kyprrIjNMgcfvhyWfKBxucR4LJTQFfHU5
         xrMjv6AB7rJdL4Upji8G/PHOcj9q4quvY9a79qmM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 745CD60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH 1/5] rpmsg: glink: Add GLINK signal support for RPMSG
Date:   Wed,  3 Oct 2018 17:04:19 +0530
Message-Id: <1538566463-24627-2-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
References: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to handle SMD signals to RPMSG over GLINK. SMD signals
mimic serial protocol signals to notify of ports opening and closing.
This change affects the rpmsg core, rpmsg char and glink drivers.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 80 +++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_core.c        | 41 ++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  5 +++
 include/linux/rpmsg.h             | 25 ++++++++++++
 4 files changed, 151 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index f6988fd..ff8751b 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016-2017, Linaro Ltd
+ * Copyright (c) 2018, The Linux Foundation.
  */
 
 #include <linux/idr.h>
@@ -150,6 +151,8 @@ enum {
  * @intent_req_lock: Synchronises multiple intent requests
  * @intent_req_result: Result of intent request
  * @intent_req_comp: Completion for intent_req signalling
+ * @lsigs:	Local side signals
+ * @rsigs:	Remote side signals
  */
 struct glink_channel {
 	struct rpmsg_endpoint ept;
@@ -181,6 +184,9 @@ struct glink_channel {
 	struct mutex intent_req_lock;
 	bool intent_req_result;
 	struct completion intent_req_comp;
+
+	unsigned int lsigs;
+	unsigned int rsigs;
 };
 
 #define to_glink_channel(_ept) container_of(_ept, struct glink_channel, ept)
@@ -201,6 +207,7 @@ struct glink_channel {
 #define RPM_CMD_TX_DATA_CONT		12
 #define RPM_CMD_READ_NOTIF		13
 #define RPM_CMD_RX_DONE_W_REUSE		14
+#define RPM_CMD_SIGNALS			15
 
 #define GLINK_FEATURE_INTENTLESS	BIT(1)
 
@@ -954,6 +961,52 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
 	return 0;
 }
 
+/**
+ * qcom_glink_send_signals() - convert a signal  cmd to wire format and transmit
+ * @glink:	The transport to transmit on.
+ * @channel:	The glink channel
+ * @sigs:	The signals to encode.
+ *
+ * Return: 0 on success or standard Linux error code.
+ */
+static int qcom_glink_send_signals(struct qcom_glink *glink,
+				   struct glink_channel *channel,
+				   u32 sigs)
+{
+	struct glink_msg msg;
+
+	msg.cmd = cpu_to_le16(RPM_CMD_SIGNALS);
+	msg.param1 = cpu_to_le16(channel->lcid);
+	msg.param2 = cpu_to_le32(sigs);
+
+	return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
+}
+
+static int qcom_glink_handle_signals(struct qcom_glink *glink,
+				     unsigned int rcid, unsigned int signals)
+{
+	struct glink_channel *channel;
+	unsigned long flags;
+	u32 old;
+
+	spin_lock_irqsave(&glink->idr_lock, flags);
+	channel = idr_find(&glink->rcids, rcid);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
+	if (!channel) {
+		dev_err(glink->dev, "signal for non-existing channel\n");
+		return -EINVAL;
+	}
+
+	old = channel->rsigs;
+	channel->rsigs = signals;
+
+	if (channel->ept.sig_cb)
+		channel->ept.sig_cb(channel->ept.rpdev, channel->ept.priv,
+				    old, channel->rsigs);
+
+	return 0;
+}
+
 static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 {
 	struct qcom_glink *glink = data;
@@ -1015,6 +1068,10 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 			qcom_glink_handle_intent_req_ack(glink, param1, param2);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
+		case RPM_CMD_SIGNALS:
+			qcom_glink_handle_signals(glink, param1, param2);
+			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
+			break;
 		default:
 			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
 			ret = -EINVAL;
@@ -1312,6 +1369,27 @@ static int qcom_glink_trysend(struct rpmsg_endpoint *ept, void *data, int len)
 	return __qcom_glink_send(channel, data, len, false);
 }
 
+static int qcom_glink_get_sigs(struct rpmsg_endpoint *ept,
+			       u32 *lsigs, u32 *rsigs)
+{
+	struct glink_channel *channel = to_glink_channel(ept);
+
+	*lsigs = channel->lsigs;
+	*rsigs = channel->rsigs;
+
+	return 0;
+}
+
+static int qcom_glink_set_sigs(struct rpmsg_endpoint *ept, u32 sigs)
+{
+	struct glink_channel *channel = to_glink_channel(ept);
+	struct qcom_glink *glink = channel->glink;
+
+	channel->lsigs = sigs;
+
+	return qcom_glink_send_signals(glink, channel, sigs);
+}
+
 /*
  * Finds the device_node for the glink child interested in this channel.
  */
@@ -1345,6 +1423,8 @@ static struct device_node *qcom_glink_match_channel(struct device_node *node,
 	.destroy_ept = qcom_glink_destroy_ept,
 	.send = qcom_glink_send,
 	.trysend = qcom_glink_trysend,
+	.get_sigs = qcom_glink_get_sigs,
+	.set_sigs = qcom_glink_set_sigs,
 };
 
 static void qcom_glink_rpdev_release(struct device *dev)
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index c4585d6..5b39139 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
+ * Copyright (c) 2018 The Linux Foundation.
  *
  * Ohad Ben-Cohen <ohad@wizery.com>
  * Brian Swetland <swetland@google.com>
@@ -283,6 +284,42 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 }
 EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 
+/**
+ * rpmsg_get_sigs() - get the signals for this endpoint
+ * @ept: the rpmsg endpoint
+ * @sigs: serial signals bitmask
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_get_sigs(struct rpmsg_endpoint *ept, u32 *lsigs, u32 *rsigs)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->get_sigs)
+		return -ENXIO;
+
+	return ept->ops->get_sigs(ept, lsigs, rsigs);
+}
+EXPORT_SYMBOL(rpmsg_get_sigs);
+
+/**
+ * rpmsg_set_sigs() - set the remote signals for this endpoint
+ * @ept: the rpmsg endpoint
+ * @sigs: serial signals bitmask
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_set_sigs(struct rpmsg_endpoint *ept, u32 sigs)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->set_sigs)
+		return -ENXIO;
+
+	return ept->ops->set_sigs(ept, sigs);
+}
+EXPORT_SYMBOL(rpmsg_set_sigs);
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
index 0d791c3..034ac07 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
+ * Copyright (c) 2018 The Linux Foundation.
  *
  * Ohad Ben-Cohen <ohad@wizery.com>
  * Brian Swetland <swetland@google.com>
@@ -46,6 +47,8 @@ struct rpmsg_device_ops {
  * @trysend:		see @rpmsg_trysend(), required
  * @trysendto:		see @rpmsg_trysendto(), optional
  * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
+ * @get_sigs:		see @rpmsg_get_sigs(), optional
+ * @set_sigs:		see @rpmsg_set_sigs(), optional
  *
  * Indirection table for the operations that a rpmsg backend should implement.
  * In addition to @destroy_ept, the backend must at least implement @send and
@@ -65,6 +68,8 @@ struct rpmsg_endpoint_ops {
 			     void *data, int len);
 	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
 			     poll_table *wait);
+	int (*get_sigs)(struct rpmsg_endpoint *ept, u32 *lsigs, u32 *rsigs);
+	int (*set_sigs)(struct rpmsg_endpoint *ept, u32 sigs);
 };
 
 int rpmsg_register_device(struct rpmsg_device *rpdev);
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 9fe156d..580726d 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
+ * Copyright (c) 2018 The Linux Foundation.
  * All rights reserved.
  */
 
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
@@ -135,6 +141,8 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 			poll_table *wait);
 
+int rpmsg_get_sigs(struct rpmsg_endpoint *ept, u32 *lsigs, u32 *rsigs);
+int rpmsg_set_sigs(struct rpmsg_endpoint *ept, u32 sigs);
 #else
 
 static inline int register_rpmsg_device(struct rpmsg_device *dev)
@@ -242,6 +250,23 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
 	return 0;
 }
 
+static inline int rpmsg_get_sigs(struct rpmsg_endpoint *ept, u32 *lsigs,
+				 u32 *rsigs)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -ENXIO;
+}
+
+static inline int rpmsg_set_sigs(struct rpmsg_endpoint *ept, u32 sigs)
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

