Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A26AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDF12089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UqHqJcTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfAHF0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:26:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44163 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfAHF0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:26:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so1323348pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 21:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4oaJitf9e3QzSlIMVK6poPt7p39OdyXKFn0n02R9W8=;
        b=UqHqJcTRu3rJY1Mz4NWH329mel38tzLy3ICF81whlwENJC1Fo8JACCewokZsDO39JF
         qfsDk+agbDTt7cqiWcOTjvxJw0iMJkvxEWCHXSfL8RAVy7V+Gjx3qPXdaxBiQXn2FLyo
         RXwkgCQRHc6nzQAf/sF1hzTjRuunzUaNKWEnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4oaJitf9e3QzSlIMVK6poPt7p39OdyXKFn0n02R9W8=;
        b=p03VcFTTOnMRYMt+aHNAhAf+4GtzRa66YQV/xSQrUZWKohh/hpbgXGQs5rt4qnF9HG
         CuaIbvURts6GN2YWvYAWFI673fxyVX9Wileg/BnMfI430zBTKHOQ+oAILuSs+i9fWHxB
         paSO1mr/LkwbPxkbd1U8UsQISzZQoghRnt5TozIZVTf+FpzKnE0dn8g/ZCGUMu3nnEvS
         JpxfUKAryrC/rt0h8GA34zcRirtdTLPmF06JW5v3pSV5BDMfBAJssnnM8H+d90Zhhyyk
         bnuM58gmkWr34D0EYU4uOFuRkWqAsQ1vSIf00rBWjQkDufx6qYSt/DS27P8KuUAeV6eI
         oX5w==
X-Gm-Message-State: AJcUukdVAmnkVb/sVXp4dTMCL6W4Ulo9yWXU79/CIiB3YmcrBLAx0amR
        bV179HY1BDMM3irJvF7jISEX3A==
X-Google-Smtp-Source: ALg8bN4/TaN9eyy1YA7qjhW6lZSLuKzVCQCk6AWN58tavy0p8vM91Ppkr6ftg4ccEe4M0HRzEb8Khw==
X-Received: by 2002:a62:15d5:: with SMTP id 204mr378701pfv.103.1546925196799;
        Mon, 07 Jan 2019 21:26:36 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 64sm88106874pff.101.2019.01.07.21.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:26:36 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Erin Lo <erin.lo@mediatek.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [RFC v2 4/6] rpmsg: add rpmsg support for mt8183 SCP.
Date:   Tue,  8 Jan 2019 13:26:04 +0800
Message-Id: <20190108052606.59426-5-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190108052606.59426-1-pihsun@chromium.org>
References: <20190108052606.59426-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple rpmsg support for mt8183 SCP, that use IPI / IPC directly.
Lots of TODO, and I'm not sure on all file / type / variable namings.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v1:
 - Do cleanup properly in mtk_rpmsg.c, which also removes the problem of
   short-lived work items.
 - Fix several issues checkpatch found.
---
 drivers/remoteproc/mtk_common.h       |   3 +
 drivers/remoteproc/mtk_scp.c          |  29 +-
 drivers/remoteproc/mtk_scp_ipi.c      |   2 +-
 drivers/rpmsg/Kconfig                 |   5 +
 drivers/rpmsg/Makefile                |   1 +
 drivers/rpmsg/mtk_rpmsg.c             | 382 ++++++++++++++++++++++++++
 include/linux/platform_data/mtk_scp.h |  12 +-
 include/linux/rpmsg/mtk_rpmsg.h       |  35 +++
 8 files changed, 464 insertions(+), 5 deletions(-)
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index e97287a4eb25cc..3e9688082edbdc 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -54,6 +54,9 @@ struct mtk_scp {
 	void __iomem *cpu_addr;
 	phys_addr_t phys_addr;
 	size_t dram_size;
+
+	struct platform_device *pdev;
+	struct rproc_subdev *rpmsg_subdev;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 3e84c696523436..7f4d9261504c30 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -12,6 +12,7 @@
 #include <linux/platform_data/mtk_scp.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
+#include <linux/rpmsg/mtk_rpmsg.h>
 
 #include "mtk_common.h"
 #include "remoteproc_internal.h"
@@ -296,6 +297,23 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 	return 0;
 }
 
+static void scp_add_rpmsg_subdev(struct mtk_scp *scp)
+{
+	scp->rpmsg_subdev =
+		mtk_rpmsg_create_rproc_subdev(scp->pdev, scp->rproc);
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
 static int mtk_scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -319,6 +337,7 @@ static int mtk_scp_probe(struct platform_device *pdev)
 	scp = (struct mtk_scp *)rproc->priv;
 	scp->rproc = rproc;
 	scp->dev = dev;
+	scp->pdev = pdev;
 	platform_set_drvdata(pdev, scp);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
@@ -390,13 +409,16 @@ static int mtk_scp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&scp->run.wq);
 	init_waitqueue_head(&scp->ack_wq);
 
+	scp_add_rpmsg_subdev(scp);
+
 	ret = rproc_add(rproc);
 	if (ret)
-		goto destroy_mutex;
+		goto remove_subdev;
 
-	return ret;
+	return 0;
 
-destroy_mutex:
+remove_subdev:
+	scp_remove_rpmsg_subdev(scp);
 	mutex_destroy(&scp->scp_mutex);
 free_rproc:
 	rproc_free(rproc);
@@ -408,6 +430,7 @@ static int mtk_scp_remove(struct platform_device *pdev)
 {
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
 
+	scp_remove_rpmsg_subdev(scp);
 	rproc_del(scp->rproc);
 	rproc_free(scp->rproc);
 
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index 3aa18a387056d3..e51d0b970e500f 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -49,7 +49,7 @@ int scp_ipi_send(struct platform_device *pdev,
 	unsigned long timeout;
 	int ret;
 
-	if (WARN(id <= SCP_IPI_INIT || id >= SCP_IPI_MAX ||
+	if (WARN(id <= SCP_IPI_NS_SERVICE || id >= SCP_IPI_MAX ||
 	    len > sizeof(send_obj->share_buf) || !buf,
 	    "failed to send ipi message\n"))
 		return -EINVAL;
diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b41eca54c..b8364a397bb606 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -55,4 +55,9 @@ config RPMSG_VIRTIO
 	select RPMSG
 	select VIRTIO
 
+config RPMSG_MTK_SCP
+	tristate "MediaTek SCP"
+	depends on MTK_SCP
+	select RPMSG
+
 endmenu
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index 9aa859502d2752..a0c1dcefa36ee4 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
 obj-$(CONFIG_RPMSG_QCOM_SMD)	+= qcom_smd.o
 obj-$(CONFIG_RPMSG_VIRTIO)	+= virtio_rpmsg_bus.o
+obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
new file mode 100644
index 00000000000000..d7330f5626d8b5
--- /dev/null
+++ b/drivers/rpmsg/mtk_rpmsg.c
@@ -0,0 +1,382 @@
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
+/*
+ * TODO: This is built on top of scp_ipi_register / scp_ipi_send in mtk_scp.h.
+ * It's probably better to move the implementation of register / send to here
+ * instead of in remoteproc/mtk_scp_ipi.c
+ */
+/*
+ * TODO: Do we need some sort of vring for performance? We may be able to get
+ * rid of this file if so, but that would require SCP firmware support too.
+ */
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
+/* TODO: Naming is hard... */
+struct mtk_rpmsg_rproc_subdev {
+	struct rproc *scp_rproc;
+	struct platform_device *scp_pdev;
+	struct rpmsg_endpoint *ns_ept;
+	struct rproc_subdev subdev;
+
+	struct work_struct register_work;
+	struct list_head rpmsg_channel_info_list;
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
+ * TODO: This is copied from virtio_rpmsg_bus.
+ * struct rpmsg_ns_msg - dynamic name service announcement message
+ * @name: name of remote service that is published
+ * @addr: address of remote service that is published
+ *
+ * This message is sent across to publish a new service, or announce
+ * about its removal. When we receive these messages, an appropriate
+ * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
+ * or ->remove() handler of the appropriate rpmsg driver will be invoked
+ * (if/as-soon-as one is registered).
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
+
+	/* TODO: What if the cb() returns error? */
+	(*ept->cb)(ept->rpdev, data, len, ept->priv, ept->addr);
+}
+
+static struct rpmsg_endpoint *
+__rpmsg_create_ept(struct platform_device *scp_pdev, struct rpmsg_device *rpdev,
+		   rpmsg_rx_cb_t cb, void *priv,
+		   u32 id, const char *name)
+{
+	struct mtk_rpmsg_endpoint *mept;
+	struct rpmsg_endpoint *ept;
+
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
+	ret = scp_ipi_register(scp_pdev, id, mtk_rpmsg_ipi_handler, name, mept);
+	if (ret) {
+		dev_err(&scp_pdev->dev, "ipi register failed, id = %d", id);
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
+	/* TODO: Is using src as IPI id "correct"? */
+	return __rpmsg_create_ept(scp_pdev, rpdev, cb, priv, chinfo.src,
+				  chinfo.name);
+}
+
+static const struct rpmsg_device_ops mtk_rpmsg_device_ops = {
+	.create_ept = mtk_rpmsg_create_ept,
+};
+
+static void mtk_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
+{
+	kref_put(&ept->refcount, __ept_release);
+}
+
+static int __mtk_rpmsg_send(struct mtk_rpmsg_endpoint *mept, void *data,
+			    int len, bool wait)
+{
+	/*
+	 * TODO: The "wait" is not same as what scp_ipi_send's "wait" means, so
+	 * this is not correct.
+	 * (first wait for there's space of tx buffer, second wait for the ack
+	 * from scp.)
+	 */
+	return scp_ipi_send(mept->scp_pdev, mept->ept.addr, data, len,
+			    wait ? 200 : 0);
+}
+
+static int mtk_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
+{
+	struct mtk_rpmsg_endpoint *mept = to_scp_endpoint(ept);
+
+	return __mtk_rpmsg_send(mept, data, len, true);
+}
+
+static int mtk_rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
+{
+	struct mtk_rpmsg_endpoint *mept = to_scp_endpoint(ept);
+
+	return __mtk_rpmsg_send(mept, data, len, false);
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
+	rpdev->dev.parent = &scp_pdev->dev;
+	rpdev->dev.release = mtk_rpmsg_release_device;
+
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void mtk_register_device_work_function(struct work_struct *register_work)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = container_of(
+		register_work, struct mtk_rpmsg_rproc_subdev, register_work);
+	struct platform_device *scp_pdev = mtk_subdev->scp_pdev;
+
+	int ret;
+
+	struct mtk_rpmsg_channel_info *info;
+
+	/* TODO: lock the list */
+	list_for_each_entry(info, &mtk_subdev->rpmsg_channel_info_list, list) {
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
+}
+
+static int mtk_rpmsg_create_device(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
+				   char *name, u32 addr)
+{
+	struct mtk_rpmsg_channel_info *info;
+
+	/* This is called in interrupt context from name service callback. */
+	info = kzalloc(sizeof(*info), GFP_ATOMIC);
+	if (!info)
+		return -ENOMEM;
+
+	strncpy(info->info.name, name, RPMSG_NAME_SIZE);
+	info->info.src = addr;
+	info->info.dst = RPMSG_ADDR_ANY;
+	/* TODO: lock the list. */
+	list_add(&info->list, &mtk_subdev->rpmsg_channel_info_list);
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
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev;
+	struct platform_device *scp_pdev;
+
+	mtk_subdev = to_mtk_subdev(subdev);
+	scp_pdev = mtk_subdev->scp_pdev;
+
+	/* a dedicated endpoint handles the name service msgs */
+	mtk_subdev->ns_ept =
+		__rpmsg_create_ept(scp_pdev, NULL, mtk_rpmsg_ns_cb, mtk_subdev,
+				   SCP_IPI_NS_SERVICE, "name-service");
+	if (!mtk_subdev->ns_ept) {
+		dev_err(&scp_pdev->dev,
+			"failed to create name service endpoint\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void mtk_rpmsg_unprepare(struct rproc_subdev *subdev)
+{
+	struct mtk_rpmsg_channel_info *info, *next;
+	struct device *dev;
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
+
+	dev = &mtk_subdev->scp_pdev->dev;
+
+	/* TODO: cancel pending work, lock the list */
+	list_for_each_entry(info, &mtk_subdev->rpmsg_channel_info_list, list) {
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
+				 &mtk_subdev->rpmsg_channel_info_list, list) {
+		list_del(&info->list);
+		kfree(info);
+	}
+
+	kref_put(&mtk_subdev->ns_ept->refcount, __ept_release);
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
+	mtk_subdev->subdev.unprepare = mtk_rpmsg_unprepare;
+	INIT_LIST_HEAD(&mtk_subdev->rpmsg_channel_info_list);
+	INIT_WORK(&mtk_subdev->register_work,
+		  mtk_register_device_work_function);
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
index 23df7453eeacd0..3694ba61863395 100644
--- a/include/linux/platform_data/mtk_scp.h
+++ b/include/linux/platform_data/mtk_scp.h
@@ -27,8 +27,18 @@ typedef void (*scp_ipi_handler_t) (void *data,
 
 enum scp_ipi_id {
 	SCP_IPI_INIT = 0,
-	SCP_IPI_CROS_HOST_CMD,
+	/*
+	 * TODO: Should this just be part of the response of IPI_SCP_INIT
+	 * instead? e.g. the initial IPI_SCP_INIT from SCP sends a list of
+	 * channels.
+	 */
+	SCP_IPI_NS_SERVICE,
 	SCP_IPI_MDP,
+	/*
+	 * TODO: Since we'll not be having all IPI numbers here after the name
+	 * service & rpmsg, this IPI_MAX need to be manually specified and sync
+	 * with the firmware.
+	 */
 	SCP_IPI_MAX,
 };
 
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
2.20.1.97.g81188d93c3-goog

