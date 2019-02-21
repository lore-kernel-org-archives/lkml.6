Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC88214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QPMe/uy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfBUItA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:49:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40119 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfBUIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:48:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id u9so9919497pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 00:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGFCr26C7QVPB0iavp5n1bK4xiDL/I1sEfncjGgfqAU=;
        b=QPMe/uy7esQMtvdGCGQwk2hRTw4r1i0ROsr4i3hDuGndx8dLy5kwbYLuIRJs4Q4YfB
         q8mVZI5SeVytYXwGm2TtdkE1fukUe5pI6GB3LdHVI/DabRm5vmSnAkw0vC3LwLq4ciER
         BAeQE9Sv7kAOw90dAZfetPdqrhxb72h1N9YUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGFCr26C7QVPB0iavp5n1bK4xiDL/I1sEfncjGgfqAU=;
        b=Sj4LYK2Vmrw1mI1YFWwKSLNayLCyu2QRDJOUXPFA0Al1IO8dicPACgEntQoJdxlHjH
         aqLqUBBGIwVPGH+OTpi/pX2Wmx/wJTPz5lovakRkuTfQ5GW5I0phpHsap7M7Bgc6ofMs
         lPk2vyNWKtnMyzoFsDJ8kqu9fE8b9EVousO8o7NFAa+mDTzpx0D2lmBkXF4hc1WVDAfX
         Ket1fCVSvJ4xtxAGv2R3Yr0MPOurtpZDTyaYnKVpiHmodmPqoHrScjUmS5gi0sYM7TfX
         YfkXT7qsmZJdCKhOGdz9hLTw+4XFyODfKYBrF4T6Wnz9OZ+cUSS28hSFv3kJivC7ZWdm
         Dyxg==
X-Gm-Message-State: AHQUAuZTF2oNxJy67xL5G9DEb92OM/yWpVaLTrzD6/AfJJIyVtpgOrVt
        HJO5D7GIpB3DZfUVej6QUxiYsA==
X-Google-Smtp-Source: AHgI3IboYmQUuN0UT45I14XNGJRWVk/Qu/t9HKqtON17IMhW/p5rFwEGo7jauzCBi7IBth+w3bUbYw==
X-Received: by 2002:a63:1a5d:: with SMTP id a29mr31215105pgm.369.1550738938129;
        Thu, 21 Feb 2019 00:48:58 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id b4sm23154027pgq.57.2019.02.21.00.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 00:48:57 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v5 4/6] rpmsg: add rpmsg support for mt8183 SCP.
Date:   Thu, 21 Feb 2019 16:47:27 +0800
Message-Id: <20190221084729.101784-5-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221084729.101784-1-pihsun@chromium.org>
References: <20190221084729.101784-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple rpmsg support for mt8183 SCP, that use IPI / IPC directly.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v4:
 - Match and fill the device tree node to the created rpmsg subdevice,
   so the rpmsg subdevice can utilize the properties and subnodes on
   device tree (This is similar to what drivers/rpmsg/qcom_smd.c does).

Changes from v3:
 - Change from unprepare to stop, to stop the rpmsg driver before the
   rproc is stopped, avoiding problem that some rpmsg would fail after
   rproc is stopped.
 - Add missing spin_lock_init, and use destroy_ept instead of kref_put.

Changes from v2:
 - Unregiser IPI handler on unprepare.
 - Lock the channel list on operations.
 - Move SCP_IPI_NS_SERVICE to 0xFF.

Changes from v1:
 - Do cleanup properly in mtk_rpmsg.c, which also removes the problem of
   short-lived work items.
 - Fix several issues checkpatch found.
---
 drivers/remoteproc/mtk_common.h       |   2 +
 drivers/remoteproc/mtk_scp.c          |  30 +-
 drivers/remoteproc/mtk_scp_ipi.c      |   1 +
 drivers/rpmsg/Kconfig                 |   9 +
 drivers/rpmsg/Makefile                |   1 +
 drivers/rpmsg/mtk_rpmsg.c             | 385 ++++++++++++++++++++++++++
 include/linux/platform_data/mtk_scp.h |   4 +-
 include/linux/rpmsg/mtk_rpmsg.h       |  35 +++
 8 files changed, 462 insertions(+), 5 deletions(-)
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 7504ae1bc0efe2..19a90781027125 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -54,6 +54,8 @@ struct mtk_scp {
 	void __iomem *cpu_addr;
 	phys_addr_t phys_addr;
 	size_t dram_size;
+
+	struct rproc_subdev *rpmsg_subdev;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index c689a8cc41f092..7680edb7ca5f58 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -13,6 +13,7 @@
 #include <linux/platform_data/mtk_scp.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
+#include <linux/rpmsg/mtk_rpmsg.h>
 
 #include "mtk_common.h"
 #include "remoteproc_internal.h"
@@ -471,6 +472,23 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 	return 0;
 }
 
+static void scp_add_rpmsg_subdev(struct mtk_scp *scp)
+{
+	scp->rpmsg_subdev = mtk_rpmsg_create_rproc_subdev(
+		to_platform_device(scp->dev), scp->rproc);
+	if (scp->rpmsg_subdev)
+		rproc_add_subdev(scp->rproc, scp->rpmsg_subdev);
+}
+
+static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
+{
+	if (scp->rpmsg_subdev) {
+		rproc_remove_subdev(scp->rproc, scp->rpmsg_subdev);
+		mtk_rpmsg_destroy_rproc_subdev(scp->rpmsg_subdev);
+		scp->rpmsg_subdev = NULL;
+	}
+}
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -552,22 +570,25 @@ static int scp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&scp->run.wq);
 	init_waitqueue_head(&scp->ack_wq);
 
+	scp_add_rpmsg_subdev(scp);
+
 	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0), NULL,
 					scp_irq_handler, IRQF_ONESHOT,
 					pdev->name, scp);
 
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		goto destroy_mutex;
+		goto remove_subdev;
 	}
 
 	ret = rproc_add(rproc);
 	if (ret)
-		goto destroy_mutex;
+		goto remove_subdev;
 
-	return ret;
+	return 0;
 
-destroy_mutex:
+remove_subdev:
+	scp_remove_rpmsg_subdev(scp);
 	mutex_destroy(&scp->lock);
 free_rproc:
 	rproc_free(rproc);
@@ -579,6 +600,7 @@ static int scp_remove(struct platform_device *pdev)
 {
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
 
+	scp_remove_rpmsg_subdev(scp);
 	rproc_del(scp->rproc);
 	rproc_free(scp->rproc);
 
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index f5d271c0f6239b..10b0cbda7aee38 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -99,6 +99,7 @@ int scp_ipi_send(struct platform_device *pdev,
 	int ret;
 
 	if (WARN_ON(id <= SCP_IPI_INIT) || WARN_ON(id >= SCP_IPI_MAX) ||
+	    WARN_ON(id == SCP_IPI_NS_SERVICE) ||
 	    WARN_ON(len > sizeof(send_obj->share_buf)) || WARN_ON(!buf))
 		return -EINVAL;
 
diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b41eca54c..85e3cc075cb473 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -15,6 +15,15 @@ config RPMSG_CHAR
 	  in /dev. They make it possible for user-space programs to send and
 	  receive rpmsg packets.
 
+config RPMSG_MTK_SCP
+	tristate "MediaTek SCP"
+	depends on MTK_SCP
+	select RPMSG
+	help
+	  Say y here to enable support providing communication channels to
+	  remote processors in MediaTek platforms.
+	  This use IPI and IPC to communicate with remote processors.
+
 config RPMSG_QCOM_GLINK_NATIVE
 	tristate
 	select RPMSG
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index 9aa859502d2752..ae92a7fb08f623 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
+obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
new file mode 100644
index 00000000000000..fab1413a0a650c
--- /dev/null
+++ b/drivers/rpmsg/mtk_rpmsg.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2018 Google LLC.
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/mtk_scp.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+#include <linux/rpmsg/mtk_rpmsg.h>
+#include <linux/workqueue.h>
+
+#include "rpmsg_internal.h"
+
+struct mtk_rpmsg_device {
+	struct rpmsg_device rpdev;
+	struct platform_device *scp_pdev;
+};
+
+struct mtk_rpmsg_endpoint {
+	struct rpmsg_endpoint ept;
+	struct platform_device *scp_pdev;
+};
+
+struct mtk_rpmsg_rproc_subdev {
+	struct rproc *scp_rproc;
+	struct platform_device *scp_pdev;
+	struct rpmsg_endpoint *ns_ept;
+	struct rproc_subdev subdev;
+
+	struct work_struct register_work;
+	struct list_head channels;
+	struct mutex channels_lock;
+};
+
+#define to_mtk_subdev(d) container_of(d, struct mtk_rpmsg_rproc_subdev, subdev)
+
+struct mtk_rpmsg_channel_info {
+	struct rpmsg_channel_info info;
+	bool registered;
+	struct list_head list;
+};
+
+/**
+ * struct rpmsg_ns_msg - dynamic name service announcement message
+ * @name: name of remote service that is published
+ * @addr: address of remote service that is published
+ *
+ * This message is sent across to publish a new service. When we receive these
+ * messages, an appropriate rpmsg channel (i.e device) is created. In turn, the
+ * ->probe() handler of the appropriate rpmsg driver will be invoked
+ *  (if/as-soon-as one is registered).
+ */
+struct rpmsg_ns_msg {
+	char name[RPMSG_NAME_SIZE];
+	u32 addr;
+} __packed;
+
+#define to_scp_device(r)	container_of(r, struct mtk_rpmsg_device, rpdev)
+#define to_scp_endpoint(r)	container_of(r, struct mtk_rpmsg_endpoint, ept)
+
+static const struct rpmsg_endpoint_ops mtk_rpmsg_endpoint_ops;
+
+static void __ept_release(struct kref *kref)
+{
+	struct rpmsg_endpoint *ept = container_of(kref, struct rpmsg_endpoint,
+						  refcount);
+	kfree(to_scp_endpoint(ept));
+}
+
+static void mtk_rpmsg_ipi_handler(void *data, unsigned int len, void *priv)
+{
+	struct mtk_rpmsg_endpoint *mept = priv;
+	struct rpmsg_endpoint *ept = &mept->ept;
+	int ret;
+
+	ret = (*ept->cb)(ept->rpdev, data, len, ept->priv, ept->addr);
+	if (ret)
+		dev_warn(&ept->rpdev->dev, "rpmsg handler return error = %d",
+			 ret);
+}
+
+static struct rpmsg_endpoint *
+__rpmsg_create_ept(struct platform_device *scp_pdev, struct rpmsg_device *rpdev,
+		   rpmsg_rx_cb_t cb, void *priv,
+		   u32 id)
+{
+	struct mtk_rpmsg_endpoint *mept;
+	struct rpmsg_endpoint *ept;
+	int ret;
+
+	mept = kzalloc(sizeof(*mept), GFP_KERNEL);
+	if (!mept)
+		return NULL;
+	mept->scp_pdev = scp_pdev;
+
+	ept = &mept->ept;
+	kref_init(&ept->refcount);
+
+	ept->rpdev = rpdev;
+	ept->cb = cb;
+	ept->priv = priv;
+	ept->ops = &mtk_rpmsg_endpoint_ops;
+	ept->addr = id;
+
+	ret = scp_ipi_register(scp_pdev, id, mtk_rpmsg_ipi_handler, mept);
+	if (ret) {
+		dev_err(&scp_pdev->dev, "IPI register failed, id = %d", id);
+		kref_put(&ept->refcount, __ept_release);
+		return NULL;
+	}
+
+	return ept;
+}
+
+static struct rpmsg_endpoint *
+mtk_rpmsg_create_ept(struct rpmsg_device *rpdev, rpmsg_rx_cb_t cb, void *priv,
+		     struct rpmsg_channel_info chinfo)
+{
+	struct platform_device *scp_pdev = to_scp_device(rpdev)->scp_pdev;
+
+	return __rpmsg_create_ept(scp_pdev, rpdev, cb, priv, chinfo.src);
+}
+
+static void mtk_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
+{
+	struct mtk_rpmsg_endpoint *mept = to_scp_endpoint(ept);
+
+	scp_ipi_unregister(mept->scp_pdev, ept->addr);
+	kref_put(&ept->refcount, __ept_release);
+}
+
+static int mtk_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
+{
+	struct mtk_rpmsg_endpoint *mept = to_scp_endpoint(ept);
+
+	return scp_ipi_send(mept->scp_pdev, mept->ept.addr, data, len, 0);
+}
+
+static int mtk_rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
+{
+	struct mtk_rpmsg_endpoint *mept = to_scp_endpoint(ept);
+
+	/*
+	 * TODO: This currently is same as mtk_rpmsg_send, and wait until SCP
+	 * received the last command.
+	 */
+	return scp_ipi_send(mept->scp_pdev, mept->ept.addr, data, len, 0);
+}
+
+static const struct rpmsg_endpoint_ops mtk_rpmsg_endpoint_ops = {
+	.destroy_ept = mtk_rpmsg_destroy_ept,
+	.send = mtk_rpmsg_send,
+	.trysend = mtk_rpmsg_trysend,
+};
+
+static void mtk_rpmsg_release_device(struct device *dev)
+{
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
+	struct mtk_rpmsg_device *mdev = to_scp_device(rpdev);
+
+	kfree(mdev);
+}
+
+static const struct rpmsg_device_ops mtk_rpmsg_device_ops = {
+	.create_ept = mtk_rpmsg_create_ept,
+};
+
+static struct device_node *
+mtk_rpmsg_match_device_subnode(struct device_node *node, const char *channel)
+{
+	struct device_node *child;
+	const char *name;
+	int ret;
+
+	for_each_available_child_of_node(node, child) {
+		ret = of_property_read_string(child, "mtk,rpmsg-name", &name);
+		if (ret)
+			continue;
+
+		if (strcmp(name, channel) == 0)
+			return child;
+	}
+
+	return NULL;
+}
+
+static int mtk_rpmsg_register_device(struct platform_device *scp_pdev,
+				     struct rpmsg_channel_info *info)
+{
+	struct rpmsg_device *rpdev;
+	struct mtk_rpmsg_device *mdev;
+	int ret;
+
+	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
+	if (!mdev)
+		return -ENOMEM;
+
+	mdev->scp_pdev = scp_pdev;
+
+	rpdev = &mdev->rpdev;
+	rpdev->ops = &mtk_rpmsg_device_ops;
+	rpdev->src = info->src;
+	rpdev->dst = info->dst;
+	strncpy(rpdev->id.name, info->name, RPMSG_NAME_SIZE);
+
+	rpdev->dev.of_node = mtk_rpmsg_match_device_subnode(
+		scp_pdev->dev.of_node, info->name);
+	rpdev->dev.parent = &scp_pdev->dev;
+	rpdev->dev.release = mtk_rpmsg_release_device;
+
+	ret = rpmsg_register_device(rpdev);
+	if (ret) {
+		kfree(mdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mtk_register_device_work_function(struct work_struct *register_work)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = container_of(
+		register_work, struct mtk_rpmsg_rproc_subdev, register_work);
+	struct platform_device *scp_pdev = mtk_subdev->scp_pdev;
+	struct mtk_rpmsg_channel_info *info;
+	int ret;
+
+	mutex_lock(&mtk_subdev->channels_lock);
+	list_for_each_entry(info, &mtk_subdev->channels, list) {
+		if (info->registered)
+			continue;
+
+		ret = mtk_rpmsg_register_device(scp_pdev, &info->info);
+		if (ret) {
+			dev_err(&scp_pdev->dev, "Can't create rpmsg_device\n");
+			continue;
+		}
+
+		info->registered = true;
+	}
+	mutex_unlock(&mtk_subdev->channels_lock);
+}
+
+static int mtk_rpmsg_create_device(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
+				   char *name, u32 addr)
+{
+	struct mtk_rpmsg_channel_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	strncpy(info->info.name, name, RPMSG_NAME_SIZE);
+	info->info.src = addr;
+	info->info.dst = RPMSG_ADDR_ANY;
+	mutex_lock(&mtk_subdev->channels_lock);
+	list_add(&info->list, &mtk_subdev->channels);
+	mutex_unlock(&mtk_subdev->channels_lock);
+
+	schedule_work(&mtk_subdev->register_work);
+	return 0;
+}
+
+static int mtk_rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
+			   void *priv, u32 src)
+{
+	struct rpmsg_ns_msg *msg = data;
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = priv;
+	struct device *dev = &mtk_subdev->scp_pdev->dev;
+
+	int ret;
+
+	if (len != sizeof(*msg)) {
+		dev_err(dev, "malformed ns msg (%d)\n", len);
+		return -EINVAL;
+	}
+
+	/*
+	 * the name service ept does _not_ belong to a real rpmsg channel,
+	 * and is handled by the rpmsg bus itself.
+	 * for sanity reasons, make sure a valid rpdev has _not_ sneaked
+	 * in somehow.
+	 */
+	if (rpdev) {
+		dev_err(dev, "anomaly: ns ept has an rpdev handle\n");
+		return -EINVAL;
+	}
+
+	/* don't trust the remote processor for null terminating the name */
+	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
+
+	dev_info(dev, "creating channel %s addr 0x%x\n", msg->name, msg->addr);
+
+	ret = mtk_rpmsg_create_device(mtk_subdev, msg->name, msg->addr);
+	if (ret) {
+		dev_err(dev, "create rpmsg device failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int mtk_rpmsg_prepare(struct rproc_subdev *subdev)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
+	struct platform_device *scp_pdev = mtk_subdev->scp_pdev;
+
+	/* a dedicated endpoint handles the name service msgs */
+	mtk_subdev->ns_ept =
+		__rpmsg_create_ept(scp_pdev, NULL, mtk_rpmsg_ns_cb, mtk_subdev,
+				   SCP_IPI_NS_SERVICE);
+	if (!mtk_subdev->ns_ept) {
+		dev_err(&scp_pdev->dev,
+			"failed to create name service endpoint\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void mtk_rpmsg_stop(struct rproc_subdev *subdev, bool crashed)
+{
+	struct mtk_rpmsg_channel_info *info, *next;
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
+	struct device *dev = &mtk_subdev->scp_pdev->dev;
+
+	mtk_rpmsg_destroy_ept(mtk_subdev->ns_ept);
+	cancel_work_sync(&mtk_subdev->register_work);
+
+	mutex_lock(&mtk_subdev->channels_lock);
+	list_for_each_entry(info, &mtk_subdev->channels, list) {
+		if (!info->registered)
+			continue;
+		if (rpmsg_unregister_device(dev, &info->info)) {
+			dev_warn(
+				dev,
+				"rpmsg_unregister_device failed for %s.%d.%d\n",
+				info->info.name, info->info.src,
+				info->info.dst);
+		}
+	}
+
+	list_for_each_entry_safe(info, next,
+				 &mtk_subdev->channels, list) {
+		list_del(&info->list);
+		kfree(info);
+	}
+	mutex_unlock(&mtk_subdev->channels_lock);
+}
+
+struct rproc_subdev *
+mtk_rpmsg_create_rproc_subdev(struct platform_device *scp_pdev,
+			      struct rproc *scp_rproc)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev;
+
+	mtk_subdev = kzalloc(sizeof(*mtk_subdev), GFP_KERNEL);
+	if (!mtk_subdev)
+		return NULL;
+
+	mtk_subdev->scp_pdev = scp_pdev;
+	mtk_subdev->scp_rproc = scp_rproc;
+	mtk_subdev->subdev.prepare = mtk_rpmsg_prepare;
+	mtk_subdev->subdev.stop = mtk_rpmsg_stop;
+	INIT_LIST_HEAD(&mtk_subdev->channels);
+	INIT_WORK(&mtk_subdev->register_work,
+		  mtk_register_device_work_function);
+	mutex_init(&mtk_subdev->channels_lock);
+
+	return &mtk_subdev->subdev;
+}
+EXPORT_SYMBOL_GPL(mtk_rpmsg_create_rproc_subdev);
+
+void mtk_rpmsg_destroy_rproc_subdev(struct rproc_subdev *subdev)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
+
+	kfree(mtk_subdev);
+}
+EXPORT_SYMBOL_GPL(mtk_rpmsg_destroy_rproc_subdev);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MediaTek scp rpmsg driver");
diff --git a/include/linux/platform_data/mtk_scp.h b/include/linux/platform_data/mtk_scp.h
index 7625eede2e5832..e26e5f6146e68e 100644
--- a/include/linux/platform_data/mtk_scp.h
+++ b/include/linux/platform_data/mtk_scp.h
@@ -34,9 +34,11 @@ enum scp_ipi_id {
 	SCP_IPI_VENC_VP8,
 	SCP_IPI_MDP,
 	SCP_IPI_CROS_HOST_CMD,
-	SCP_IPI_MAX,
+	SCP_IPI_NS_SERVICE = 0xFF,
+	SCP_IPI_MAX = 0x100,
 };
 
+
 /**
  * scp_ipi_register - register an ipi function
  *
diff --git a/include/linux/rpmsg/mtk_rpmsg.h b/include/linux/rpmsg/mtk_rpmsg.h
new file mode 100644
index 00000000000000..8d21cd3d35b012
--- /dev/null
+++ b/include/linux/rpmsg/mtk_rpmsg.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018 Google LLC.
+ */
+
+#ifndef __LINUX_RPMSG_MTK_RPMSG_H
+#define __LINUX_RPMSG_MTK_RPMSG_H
+
+#include <linux/device.h>
+#include <linux/remoteproc.h>
+
+#if IS_ENABLED(CONFIG_RPMSG_MTK_SCP)
+
+struct rproc_subdev *
+mtk_rpmsg_create_rproc_subdev(struct platform_device *scp_pdev,
+			      struct rproc *scp_rproc);
+
+void mtk_rpmsg_destroy_rproc_subdev(struct rproc_subdev *subdev);
+
+#else
+
+static inline struct rproc_subdev *
+mtk_rpmsg_create_rproc_subdev(struct platform_device *scp_pdev,
+			      struct rproc *scp_rproc)
+{
+	return NULL;
+}
+
+static inline void mtk_rpmsg_destroy_rproc_subdev(struct rproc_subdev *subdev)
+{
+}
+
+#endif
+
+#endif
-- 
2.21.0.rc0.258.g878e2cd30e-goog

