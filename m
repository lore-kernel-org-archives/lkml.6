Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A32C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2131B217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YBSkpL6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbeLZHyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 02:54:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38659 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeLZHyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 02:54:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so7278837plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VFE5Q/expx9u5OAcUoGYir738UVsOttn1xCRe3b7ESk=;
        b=YBSkpL6ELxysiEDR1WlP0Jt/OWkV8QHrPo7e1QRsjZcA/yXiqhBE5uU0ePmN6uMMH/
         7yaZsKV9VWLlx8S1ADViAYPe6/H1hHPvdtz7FU7KbTjeFw3dN4lZaAR7F316cMOqaYqR
         eTGBw8j2i7V4/G+xCGXIMIlODu2P0XBYYjq1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VFE5Q/expx9u5OAcUoGYir738UVsOttn1xCRe3b7ESk=;
        b=JRIwcg6d4SCxmM4WcjlrhpWiVappRMApioii3zplWXurUSfkllbBUDm0XLo37iWWNE
         eC9YG6gZ/Uau08HBRUbpya7lVvpsb1rtC1aNmvSUEjqlLnTsm7FBpzEqhY0YAu83CUn4
         1jCLkoG3NYWoAp5Blt/n3d3W4J9ZBcFBIzUmOf87azCFarMcl3N81OWKqT1JcQ86UTr5
         WQR7OU1jFe1i52wnAjKjmQrkBNvFSgjDEsixWc4uxn7OmBB/rm/27eZIJZeCAH+Yv9Tz
         Dfy9Eep7WlEhxABli3POW8EKNcyd+FBLoS3qpYO1QhG2mwxKWzkTYRSMiMGE9m0+kLou
         +xtw==
X-Gm-Message-State: AJcUukfKkMcbg+AiahEFuSXSSMM/GWh6QmlSag1mnmQX4az0JrcwjS3c
        vHdBCBNU0BHUCFNna+ixG65L0A==
X-Google-Smtp-Source: ALg8bN54MM/dDBhCsTLRoHdoOmRtFl0m6Y30ZyOKKPjc3nFyFdj70pxkjvEAKApaXOt7DhSsOjvojg==
X-Received: by 2002:a17:902:9a8b:: with SMTP id w11mr18448017plp.121.1545810856986;
        Tue, 25 Dec 2018 23:54:16 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 84sm107392395pfa.115.2018.12.25.23.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 23:54:16 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [RFC,4/5] rpmsg: add rpmsg support for mt8183 SCP.
Date:   Wed, 26 Dec 2018 15:53:12 +0800
Message-Id: <20181226075330.82462-5-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181226075330.82462-1-pihsun@chromium.org>
References: <20181226075330.82462-1-pihsun@chromium.org>
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
There are lots of TODO comments on things that are not done yet / I have
doubt on whether it's the best way to do it.

 drivers/remoteproc/mtk_common.h       |   3 +
 drivers/remoteproc/mtk_scp.c          |  30 ++-
 drivers/remoteproc/mtk_scp_ipi.c      |   2 +-
 drivers/rpmsg/Kconfig                 |   5 +
 drivers/rpmsg/Makefile                |   1 +
 drivers/rpmsg/mtk_rpmsg.c             | 341 ++++++++++++++++++++++++++
 include/linux/platform_data/mtk_scp.h |   7 +
 include/linux/rpmsg/mtk_rpmsg.h       |  34 +++
 8 files changed, 419 insertions(+), 4 deletions(-)
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index ae55fca2ce2d7..cdd4919a402a8 100644
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
index aaebe96bcfd66..0ed7904809dce 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -12,6 +12,7 @@
 #include <linux/platform_data/mtk_scp.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
+#include <linux/rpmsg/mtk_rpmsg.h>
 
 #include "remoteproc_internal.h"
 #include "mtk_common.h"
@@ -278,6 +279,24 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 	return 0;
 }
 
+static void scp_add_rpmsg_subdev(struct mtk_scp *scp)
+{
+	scp->rpmsg_subdev =
+		mtk_rpmsg_create_rproc_subdev(scp->pdev, scp->rproc);
+	if (scp->rpmsg_subdev) {
+		rproc_add_subdev(scp->rproc, scp->rpmsg_subdev);
+	}
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
@@ -301,6 +320,7 @@ static int mtk_scp_probe(struct platform_device *pdev)
 	scp = (struct mtk_scp *)rproc->priv;
 	scp->rproc = rproc;
 	scp->dev = dev;
+	scp->pdev = pdev;
 	platform_set_drvdata(pdev, scp);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
@@ -372,13 +392,16 @@ static int mtk_scp_probe(struct platform_device *pdev)
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
@@ -390,6 +413,7 @@ static int mtk_scp_remove(struct platform_device *pdev)
 {
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
 
+	scp_remove_rpmsg_subdev(scp);
 	rproc_del(scp->rproc);
 	rproc_free(scp->rproc);
 
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index 6923066869874..1b72c5cc72d36 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -50,7 +50,7 @@ int scp_ipi_send(struct platform_device *pdev,
 	unsigned long timeout;
 	int ret;
 
-	if (WARN(id <= IPI_SCP_INIT || id >= IPI_MAX ||
+	if (WARN(id <= IPI_NS_SERVICE || id >= IPI_MAX ||
 	    len > sizeof(send_obj->share_buf) || !buf,
 	    "failed to send ipi message\n"))
 		return -EINVAL;
diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b41eca54..b8364a397bb60 100644
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
index 9aa859502d275..a0c1dcefa36ee 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
 obj-$(CONFIG_RPMSG_QCOM_SMD)	+= qcom_smd.o
 obj-$(CONFIG_RPMSG_VIRTIO)	+= virtio_rpmsg_bus.o
+obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
new file mode 100644
index 0000000000000..66b39eaae51f2
--- /dev/null
+++ b/drivers/rpmsg/mtk_rpmsg.c
@@ -0,0 +1,341 @@
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
+// TODO: This is built on top of scp_ipi_register / scp_ipi_send in mtk_scp.h.
+// It's probably better to move the implementation of register / send to here
+// instead of in remoteproc/mtk_scp_ipi.c
+// TODO: Do we need some sort of vring for performance? We may be able to get
+// rid of this file if so, but that would require SCP firmware support too.
+
+struct mtk_rpmsg_device {
+	struct rpmsg_device rpdev;
+
+	struct platform_device *scp_pdev;
+};
+
+struct mtk_rpmsg_endpoint {
+	struct rpmsg_endpoint ept;
+	u32 ipi_id;
+	struct platform_device *scp_pdev;
+};
+
+// TODO: Naming is hard...
+struct mtk_rpmsg_rproc_subdev {
+	struct rproc *scp_rproc;
+	struct platform_device *scp_pdev;
+	struct rpmsg_endpoint *ns_ept;
+	struct rproc_subdev subdev;
+};
+
+#define to_mtk_subdev(d) container_of(d, struct mtk_rpmsg_rproc_subdev, subdev);
+
+struct mtk_register_device_work {
+	struct work_struct register_work;
+	struct platform_device *scp_pdev;
+	char name[RPMSG_NAME_SIZE];
+	u32 addr;
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
+	// TODO: What if the cb() returns error?
+	(*ept->cb)(ept->rpdev, data, len, ept->priv, mept->ipi_id);
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
+	mept->ipi_id = id;
+	mept->scp_pdev = scp_pdev;
+
+	ept = &mept->ept;
+	kref_init(&ept->refcount);
+
+	ept->rpdev = rpdev;
+	ept->cb = cb;
+	ept->priv = priv;
+	ept->ops = &mtk_rpmsg_endpoint_ops;
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
+	// TODO: Is using src as IPI id "correct"?
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
+	// TODO: The "wait" is not same as what scp_ipi_send's "wait" means, so
+	// this is not correct.
+	// (first wait for there's space of tx buffer, second wait for the ack
+	// from scp.)
+	return scp_ipi_send(mept->scp_pdev, mept->ipi_id, data, len,
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
+static void mtk_register_device_work_function(struct work_struct *register_work)
+{
+	struct mtk_rpmsg_device *mdev;
+	struct rpmsg_device *rpdev;
+
+	struct mtk_register_device_work *work = container_of(
+		register_work, struct mtk_register_device_work, register_work);
+	struct platform_device *scp_pdev = work->scp_pdev;
+
+	int ret;
+
+	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
+	if (!mdev) {
+		goto free_work;
+	}
+
+	mdev->scp_pdev = scp_pdev;
+
+	rpdev = &mdev->rpdev;
+	rpdev->ops = &mtk_rpmsg_device_ops;
+	rpdev->src = work->addr;
+	rpdev->dst = RPMSG_ADDR_ANY;
+	strncpy(rpdev->id.name, work->name, RPMSG_NAME_SIZE);
+
+	rpdev->dev.parent = &scp_pdev->dev;
+	rpdev->dev.release = mtk_rpmsg_release_device;
+
+	ret = rpmsg_register_device(rpdev);
+
+	if (ret) {
+		dev_err(&scp_pdev->dev, "rpmsg register device failed\n");
+		goto free_work;
+	}
+	return;
+
+free_work:
+	// TODO: Is it reasonable to free the work itself in the handler?
+	kfree(register_work);
+}
+
+static int mtk_rpmsg_create_device(struct platform_device *scp_pdev,
+				    char *name, u32 addr)
+{
+	struct mtk_register_device_work *work;
+
+	// This is called in interrupt context from name service callback.
+	work = kzalloc(sizeof(*work), GFP_ATOMIC);
+	if (!work)
+		return -ENOMEM;
+
+	INIT_WORK(&work->register_work, mtk_register_device_work_function);
+	work->scp_pdev = scp_pdev;
+	strncpy(work->name, name, RPMSG_NAME_SIZE);
+	work->addr = addr;
+	// rpmsg_register_device can't be called in interrupt context, so need
+	// to schedule a work for it.
+	// TODO: Or should we change mtk_scp to call the callback in
+	// non-interrupt context?
+	schedule_work(&work->register_work);
+	return 0;
+}
+
+static int mtk_rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
+			   void *priv, u32 src)
+{
+	struct rpmsg_ns_msg *msg = data;
+	struct platform_device *scp_pdev = priv;
+	struct device *dev = &scp_pdev->dev;
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
+	ret = mtk_rpmsg_create_device(scp_pdev, msg->name, msg->addr);
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
+		__rpmsg_create_ept(scp_pdev, NULL, mtk_rpmsg_ns_cb, scp_pdev,
+				   IPI_NS_SERVICE, "name-service");
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
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
+
+	kref_put(&mtk_subdev->ns_ept->refcount, __ept_release);
+	// TODO: unregister all rpmsg devices created by name service here.
+}
+
+struct rproc_subdev *
+mtk_rpmsg_create_rproc_subdev(struct platform_device *scp_pdev,
+			      struct rproc *scp_rproc)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev;
+	struct device *dev = &scp_pdev->dev;
+
+	mtk_subdev = kzalloc(sizeof(*mtk_subdev), GFP_KERNEL);
+	if (!mtk_subdev) {
+		dev_err(dev, "allocate rproc subdevice failed.\n");
+		return NULL;
+	}
+	mtk_subdev->scp_pdev = scp_pdev;
+	mtk_subdev->scp_rproc = scp_rproc;
+	mtk_subdev->subdev.prepare = mtk_rpmsg_prepare;
+	mtk_subdev->subdev.unprepare = mtk_rpmsg_unprepare;
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
index 118838c91564f..4b3cf4f63fbe9 100644
--- a/include/linux/platform_data/mtk_scp.h
+++ b/include/linux/platform_data/mtk_scp.h
@@ -27,7 +27,14 @@ typedef void (*ipi_handler_t) (void *data,
 
 enum ipi_id {
 	IPI_SCP_INIT = 0,
+	// TODO: Should this just be part of the response of IPI_SCP_INIT
+	// instead? e.g. the initial IPI_SCP_INIT from SCP sends a list of
+	// channels.
+	IPI_NS_SERVICE,
 	IPI_MDP,
+	// TODO: Since we'll not be having all IPI numbers here after the name
+	// service & rpmsg, this IPI_MAX need to be manually specified and sync
+	// with the firmware.
 	IPI_MAX,
 };
 
diff --git a/include/linux/rpmsg/mtk_rpmsg.h b/include/linux/rpmsg/mtk_rpmsg.h
new file mode 100644
index 0000000000000..c55dbd658dde1
--- /dev/null
+++ b/include/linux/rpmsg/mtk_rpmsg.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2018 Google LLC.
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
2.20.1.415.g653613c723-goog

