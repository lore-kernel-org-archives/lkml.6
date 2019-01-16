Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8D5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7D620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405764AbfAPQdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:33:13 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:42727 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405737AbfAPQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:33:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 1CE3C18545;
        Wed, 16 Jan 2019 17:33:06 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id G-dxQAzS-C0d; Wed, 16 Jan 2019 17:33:00 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 480211855B;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2922E1A058;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C3E61A07F;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 0EB342FB9;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 0CFAD80B47; Wed, 16 Jan 2019 17:32:58 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 8/8] vop: Add loopback
Date:   Wed, 16 Jan 2019 17:32:53 +0100
Message-Id: <20190116163253.23780-9-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a loopback driver to allow testing and evaluation of the VOP
framework without special hardware.  The host and the guest will run
under the same kernel.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/Kconfig            |  10 +
 drivers/misc/mic/vop/Makefile       |   2 +
 drivers/misc/mic/vop/vop_loopback.c | 390 ++++++++++++++++++++++++++++
 3 files changed, 402 insertions(+)
 create mode 100644 drivers/misc/mic/vop/vop_loopback.c

diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
index 319ee3c90a26..b181cf20d40f 100644
--- a/drivers/misc/mic/Kconfig
+++ b/drivers/misc/mic/Kconfig
@@ -149,6 +149,16 @@ config VOP
 	  OS and tools for MIC to use with this driver are available from
 	  <http://software.intel.com/en-us/mic-developer>.
 
+config VOP_LOOPBACK
+	tristate "VOP loopback driver"
+	depends on VOP
+	help
+	  This enables a loopback driver to test and evaluate the VOP
+	  infrastructure without actual PCIe hardware.  The host and the guest
+	  sides run under the same kernel.
+
+	  If unsure, say N.
+
 if VOP
 source "drivers/vhost/Kconfig.vringh"
 endif
diff --git a/drivers/misc/mic/vop/Makefile b/drivers/misc/mic/vop/Makefile
index 78819c8999f1..a6ead25c4418 100644
--- a/drivers/misc/mic/vop/Makefile
+++ b/drivers/misc/mic/vop/Makefile
@@ -7,3 +7,5 @@ obj-m := vop.o
 vop-objs += vop_main.o
 vop-objs += vop_debugfs.o
 vop-objs += vop_vringh.o
+
+obj-$(CONFIG_VOP_LOOPBACK) += vop_loopback.o
diff --git a/drivers/misc/mic/vop/vop_loopback.c b/drivers/misc/mic/vop/vop_loopback.c
new file mode 100644
index 000000000000..6e3d24f166cf
--- /dev/null
+++ b/drivers/misc/mic/vop/vop_loopback.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Axis Communications AB
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/mic_common.h>
+#include <linux/of_device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/io.h>
+
+#include "../bus/vop_bus.h"
+
+struct mic_irq {
+	struct list_head list;
+	int irq;
+	irqreturn_t (*func)(int irq, void *data);
+	void *data;
+};
+
+struct vop_loopback_end {
+	struct vop_loopback *loopback;
+	const char *name;
+	struct vop_device *vop;
+	struct list_head irqs;
+	struct mutex mutex;
+	struct work_struct work;
+};
+
+struct vop_loopback {
+	struct device *dev;
+	void *dp;
+	struct vop_loopback_end host;
+	struct vop_loopback_end guest;
+};
+
+static inline struct vop_loopback *vop_to_loopback(struct device *dev)
+{
+	return dev_get_drvdata(dev->parent);
+}
+
+static dma_addr_t
+vop_loopback_dma_map_page(struct device *dev, struct page *page,
+		  unsigned long offset, size_t size,
+		  enum dma_data_direction dir, unsigned long attrs)
+{
+	return page_to_phys(page) + offset;
+}
+
+static void vop_loopback_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
+				size_t size, enum dma_data_direction dir,
+				unsigned long attrs)
+{
+}
+
+static int vop_loopback_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 unsigned long attrs)
+{
+	return remap_pfn_range(vma, vma->vm_start,
+			       PHYS_PFN(dma_addr), size,
+			       vma->vm_page_prot);
+}
+
+static void *vop_loopback_dma_alloc(struct device *dev, size_t size,
+				    dma_addr_t *handle, gfp_t gfp,
+				    unsigned long attrs)
+{
+	void *p = (void *) __get_free_pages(gfp, get_order(size));
+
+	if (p)
+		*handle = virt_to_phys(p);
+
+	return p;
+}
+
+static void vop_loopback_dma_free(struct device *dev, size_t size,
+				  void *cpu_addr, dma_addr_t handle,
+				  unsigned long attrs)
+{
+	free_pages((unsigned long) (uintptr_t) cpu_addr, get_order(size));
+}
+
+static const struct dma_map_ops vop_loopback_dma_ops = {
+	.map_page = vop_loopback_dma_map_page,
+	.unmap_page = vop_loopback_dma_unmap_page,
+	.mmap = vop_loopback_dma_mmap,
+	.alloc = vop_loopback_dma_alloc,
+	.free = vop_loopback_dma_free,
+};
+
+
+static void vop_loopback_ack_interrupt(struct vop_device *vop, int num)
+{
+}
+
+static int vop_loopback_next_db(struct vop_device *vop)
+{
+	return 0;
+}
+
+static void *vop_loopback_get_dp(struct vop_device *vop)
+{
+	struct vop_loopback *loopback = vop_to_loopback(&vop->dev);
+
+	return loopback->dp;
+}
+
+static dma_addr_t vop_loopback_get_dp_dma(struct vop_device *vop)
+{
+	struct vop_loopback *loopback = vop_to_loopback(&vop->dev);
+
+	return virt_to_phys(loopback->dp);
+}
+
+static void __iomem *vop_loopback_get_remote_dp(struct vop_device *vop)
+{
+	struct vop_loopback *loopback = vop_to_loopback(&vop->dev);
+
+	return (void __iomem *) loopback->dp;
+}
+
+static struct mic_irq *
+vop_loopback_request_irq(struct vop_loopback_end *end,
+		  irqreturn_t (*func)(int irq, void *data),
+		  void *data, int intr_src)
+{
+	struct mic_irq *mic_irq;
+
+	mic_irq = kzalloc(sizeof(*mic_irq), GFP_KERNEL);
+	if (!mic_irq)
+		return ERR_PTR(-ENOMEM);
+
+	mic_irq->irq = intr_src;
+	mic_irq->func = func;
+	mic_irq->data = data;
+
+	mutex_lock(&end->mutex);
+	list_add(&mic_irq->list, &end->irqs);
+	mutex_unlock(&end->mutex);
+
+	return mic_irq;
+}
+
+static struct mic_irq *
+vop_loopback_request_irq_host(struct vop_device *vop,
+		       irqreturn_t (*func)(int irq, void *data),
+		       const char *name, void *data, int intr_src)
+{
+	struct vop_loopback *loopback = vop_to_loopback(&vop->dev);
+
+	return vop_loopback_request_irq(&loopback->host, func, data, intr_src);
+}
+
+static struct mic_irq *
+vop_loopback_request_irq_guest(struct vop_device *vop,
+		       irqreturn_t (*func)(int irq, void *data),
+		       const char *name, void *data, int intr_src)
+{
+	struct vop_loopback *loopback = vop_to_loopback(&vop->dev);
+
+	return vop_loopback_request_irq(&loopback->guest, func, data, intr_src);
+}
+
+static void vop_loopback_free_irq(struct vop_loopback_end *end,
+			   struct mic_irq *cookie)
+{
+	mutex_lock(&end->mutex);
+	list_del(&cookie->list);
+	mutex_unlock(&end->mutex);
+
+	kfree(cookie);
+}
+
+static void vop_loopback_free_irq_host(struct vop_device *vop,
+				struct mic_irq *cookie, void *data)
+{
+	struct vop_loopback *loopback = vop_to_loopback(&vop->dev);
+
+	vop_loopback_free_irq(&loopback->host, cookie);
+}
+
+static void vop_loopback_free_irq_guest(struct vop_device *vop,
+				struct mic_irq *cookie, void *data)
+{
+	struct vop_loopback *loopback = vop_to_loopback(&vop->dev);
+
+	vop_loopback_free_irq(&loopback->guest, cookie);
+}
+
+static void vop_loopback_send_intr_host(struct vop_device *vop, int db)
+{
+	struct vop_loopback *loopback = vop_to_loopback(&vop->dev);
+
+	schedule_work(&loopback->guest.work);
+}
+
+static void vop_loopback_send_intr_guest(struct vop_device *vop, int db)
+{
+	struct vop_loopback *loopback = vop_to_loopback(&vop->dev);
+
+	schedule_work(&loopback->host.work);
+}
+
+static void __iomem *vop_loopback_ioremap(struct vop_device *vop,
+				   dma_addr_t pa, size_t len)
+{
+	return (void __iomem *) memremap(pa, len, MEMREMAP_WB);
+}
+
+static void vop_loopback_iounmap(struct vop_device *vop, void __iomem *va)
+{
+	memunmap((void __force *) va);
+}
+
+static struct vop_hw_ops vop_loopback_host_ops = {
+	.request_irq = vop_loopback_request_irq_host,
+	.free_irq = vop_loopback_free_irq_host,
+	.ack_interrupt = vop_loopback_ack_interrupt,
+	.next_db = vop_loopback_next_db,
+	.get_dp = vop_loopback_get_dp,
+	.get_dp_dma = vop_loopback_get_dp_dma,
+	.get_remote_dp = vop_loopback_get_remote_dp,
+	.send_intr = vop_loopback_send_intr_host,
+	.ioremap = vop_loopback_ioremap,
+	.iounmap = vop_loopback_iounmap,
+};
+
+static struct vop_hw_ops vop_loopback_guest_ops = {
+	.request_irq = vop_loopback_request_irq_guest,
+	.free_irq = vop_loopback_free_irq_guest,
+	.ack_interrupt = vop_loopback_ack_interrupt,
+	.next_db = vop_loopback_next_db,
+	.get_dp = vop_loopback_get_dp,
+	.get_remote_dp = vop_loopback_get_remote_dp,
+	.send_intr = vop_loopback_send_intr_guest,
+	.ioremap = vop_loopback_ioremap,
+	.iounmap = vop_loopback_iounmap,
+};
+
+static void vop_loopback_irq(struct work_struct *work)
+{
+	struct vop_loopback_end *end = container_of(work, struct vop_loopback_end, work);
+	struct vop_loopback *loopback = end->loopback;
+	struct mic_irq *mic_irq;
+
+	dev_dbg(loopback->dev, "%s irq\n", end->name);
+
+	mutex_lock(&end->mutex);
+	list_for_each_entry(mic_irq, &end->irqs, list) {
+		irqreturn_t ret;
+
+		dev_dbg(loopback->dev, "calling %pS\n", mic_irq->func);
+		ret = mic_irq->func(mic_irq->irq, mic_irq->data);
+		dev_dbg(loopback->dev, "%pS ret %d\n", mic_irq->func, ret);
+	}
+	mutex_unlock(&end->mutex);
+}
+
+static void vop_loopback_bootparam_init(struct vop_loopback *loopback)
+{
+	struct mic_bootparam *bootparam = loopback->dp;
+
+	bootparam->magic = cpu_to_le32(MIC_MAGIC);
+	bootparam->h2c_config_db = -1;
+	bootparam->node_id = 1;
+	bootparam->scif_host_dma_addr = 0x0;
+	bootparam->scif_card_dma_addr = 0x0;
+	bootparam->c2h_scif_db = -1;
+	bootparam->h2c_scif_db = -1;
+}
+
+static void vop_loopback_end_init(struct vop_loopback *loopback,
+				  struct vop_loopback_end *end,
+				  const char *name)
+{
+	end->loopback = loopback;
+	end->name = name;
+
+	INIT_WORK(&end->work, vop_loopback_irq);
+
+	INIT_LIST_HEAD(&end->irqs);
+	mutex_init(&end->mutex);
+}
+
+static int vop_loopback_probe(struct platform_device *pdev)
+{
+	struct vop_loopback *loopback;
+	int ret;
+
+	loopback = devm_kzalloc(&pdev->dev, sizeof(*loopback), GFP_KERNEL);
+	if (!loopback)
+		return -ENOMEM;
+
+	loopback->dp = (void *) devm_get_free_pages(&pdev->dev,
+				GFP_KERNEL | __GFP_ZERO,
+				get_order(MIC_DP_SIZE));
+	if (!loopback->dp)
+		return -ENOMEM;
+
+	loopback->dev = &pdev->dev;
+
+	vop_loopback_end_init(loopback, &loopback->host, "host");
+	vop_loopback_end_init(loopback, &loopback->guest, "guest");
+	vop_loopback_bootparam_init(loopback);
+
+	platform_set_drvdata(pdev, loopback);
+
+	loopback->host.vop = vop_register_device(&pdev->dev, VOP_DEV_TRNSP,
+						 &vop_loopback_dma_ops,
+						 &vop_loopback_host_ops, 1,
+						 NULL, NULL);
+	if (IS_ERR(loopback->host.vop))
+		return PTR_ERR(loopback->host.vop);
+
+	loopback->guest.vop = vop_register_device(&pdev->dev, VOP_DEV_TRNSP,
+						  &vop_loopback_dma_ops,
+						  &vop_loopback_guest_ops,
+						  0, NULL, NULL);
+	if (IS_ERR(loopback->guest.vop)) {
+		ret = PTR_ERR(loopback->guest.vop);
+		goto err_unregister_host;
+	}
+
+	schedule_work(&loopback->guest.work);
+
+	return 0;
+
+err_unregister_host:
+	vop_unregister_device(loopback->host.vop);
+	return ret;
+}
+
+static int vop_loopback_remove(struct platform_device *pdev)
+{
+	struct vop_loopback *loopback = platform_get_drvdata(pdev);
+
+	vop_unregister_device(loopback->guest.vop);
+	vop_unregister_device(loopback->host.vop);
+
+	return 0;
+}
+
+static struct platform_driver vop_loopback = {
+	.probe = vop_loopback_probe,
+	.remove = vop_loopback_remove,
+	.driver = {
+		.name = "vop-loopback",
+	},
+};
+
+static struct platform_device *loopback_dev;
+
+static int __init vop_loopback_init(void)
+{
+	int ret;
+
+	loopback_dev = platform_device_register_simple("vop-loopback", 0,
+						       NULL, 0);
+	if (IS_ERR(loopback_dev))
+		return PTR_ERR(loopback_dev);
+
+	ret = platform_driver_register(&vop_loopback);
+	if (ret)
+		goto err_remove_dev;
+
+	return 0;
+
+err_remove_dev:
+	platform_device_unregister(loopback_dev);
+	return ret;
+}
+
+static void __exit vop_loopback_exit(void)
+{
+	platform_driver_unregister(&vop_loopback);
+	platform_device_unregister(loopback_dev);
+}
+
+module_init(vop_loopback_init);
+module_exit(vop_loopback_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
2.20.0

