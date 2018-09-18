Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B3CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822632146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822632146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbeIRT7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbeIRT7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:59:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E30383F42;
        Tue, 18 Sep 2018 14:26:56 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAFA37B017;
        Tue, 18 Sep 2018 14:26:45 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     tianyu.lan@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v2 17/20] vfio: VFIO_IOMMU_SET_FAULT_EVENTFD
Date:   Tue, 18 Sep 2018 16:24:54 +0200
Message-Id: <20180918142457.3325-18-eric.auger@redhat.com>
In-Reply-To: <20180918142457.3325-1-eric.auger@redhat.com>
References: <20180918142457.3325-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 18 Sep 2018 14:26:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VFIO_IOMMU_SET_FAULT_EVENTFD Allows to associate a fault
event handler to a container. This is useful when the
guest owns the first translation stage and the host uses
the second stage. As the guest translation is fully handled
by the physical IOMMU, if any fault happens, this latter needs
to be propagated to the guest.

The userspace passes an eventfd and a queue size. Each time
a fault occurs on physical IOMMU side, the fault is pushed to
a kfifo and the eventfd is signalled. The userspace handler,
awaken on eventfd signalling then reads the populated fifo
and can inject the faults to the virtual IOMMU.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

original API proposed by Lan in
[RFC PATCH 0/3] VFIO: Report IOMMU fault event to userspace
(https://www.spinics.net/lists/kvm/msg145280.html)

A current issue with the current implementation of
iommu_register_device_fault_handler() is that is expects
responses to void the list of pending faults. This looks
overkill for unrecoverable as responses are not mandated.
---
 drivers/vfio/vfio_iommu_type1.c | 150 ++++++++++++++++++++++++++++++--
 include/uapi/linux/vfio.h       |  16 ++++
 2 files changed, 157 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2ffd46c26dc3..e52cbeb479c3 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -41,6 +41,8 @@
 #include <linux/notifier.h>
 #include <linux/dma-iommu.h>
 #include <linux/irqdomain.h>
+#include <linux/eventfd.h>
+#include <linux/kfifo.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -66,6 +68,9 @@ struct vfio_iommu {
 	struct blocking_notifier_head notifier;
 	bool			v2;
 	bool			nesting;
+	struct eventfd_ctx	*fault_ctx;
+	DECLARE_KFIFO_PTR(fault_fifo, struct iommu_fault);
+	struct mutex            fault_lock;
 };
 
 struct vfio_domain {
@@ -114,6 +119,7 @@ struct vfio_regions {
 					(!list_empty(&iommu->domain_list))
 
 static int put_pfn(unsigned long pfn, int prot);
+static int vfio_iommu_teardown_fault_eventfd(struct vfio_iommu *iommu);
 
 /*
  * This code handles mapping and unmapping of user data buffers
@@ -1527,15 +1533,26 @@ static void vfio_sanity_check_pfn_list(struct vfio_iommu *iommu)
 	WARN_ON(iommu->notifier.head);
 }
 
+static inline int
+vfio_unregister_fault_handler_fn(struct device *dev, void *data)
+{
+	return iommu_unregister_device_fault_handler(dev);
+}
+
 static void vfio_iommu_type1_detach_group(void *iommu_data,
 					  struct iommu_group *iommu_group)
 {
 	struct vfio_iommu *iommu = iommu_data;
 	struct vfio_domain *domain;
 	struct vfio_group *group;
+	int ret;
 
 	mutex_lock(&iommu->lock);
 
+	ret = iommu_group_for_each_dev(iommu_group, NULL,
+				       vfio_unregister_fault_handler_fn);
+	WARN_ON(ret);
+
 	if (iommu->external_domain) {
 		group = find_iommu_group(iommu->external_domain, iommu_group);
 		if (group) {
@@ -1613,6 +1630,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	INIT_LIST_HEAD(&iommu->domain_list);
 	iommu->dma_list = RB_ROOT;
 	mutex_init(&iommu->lock);
+	mutex_init(&iommu->fault_lock);
 	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
 
 	return iommu;
@@ -1682,25 +1700,22 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
 	return iommu_cache_invalidate(d, dev, &ustruct->info);
 }
 
-static int
-vfio_cache_invalidate(struct vfio_iommu *iommu,
-		      struct vfio_iommu_type1_cache_invalidate *ustruct)
+/* iommu->lock must be held */
+static int vfio_iommu_for_each_dev(struct vfio_iommu *iommu, void *data,
+				   int (*fn)(struct device *, void *))
 {
 	struct vfio_domain *d;
 	struct vfio_group *g;
 	int ret = 0;
 
-	mutex_lock(&iommu->lock);
-
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		list_for_each_entry(g, &d->group_list, next) {
-			ret = iommu_group_for_each_dev(g->iommu_group, ustruct,
-						       vfio_cache_inv_fn);
+			ret = iommu_group_for_each_dev(g->iommu_group,
+						       data, fn);
 			if (ret)
 				break;
 		}
 	}
-	mutex_unlock(&iommu->lock);
 	return ret;
 }
 
@@ -1740,6 +1755,102 @@ vfio_bind_pasid_table(struct vfio_iommu *iommu,
 	return ret;
 }
 
+static int
+vfio_iommu_fault_handler(struct iommu_fault_event *event, void *data)
+{
+	struct vfio_iommu *iommu = (struct vfio_iommu *)data;
+	int ret;
+
+	mutex_lock(&iommu->fault_lock);
+	if (!iommu->fault_ctx)
+		goto out;
+	ret = kfifo_put(&iommu->fault_fifo, event->fault);
+	if (ret)
+		eventfd_signal(iommu->fault_ctx, 1);
+out:
+	mutex_unlock(&iommu->fault_lock);
+	return 0;
+}
+
+static inline int
+vfio_register_fault_handler_fn(struct device *dev, void *data)
+{
+	return iommu_register_device_fault_handler(dev,
+						   vfio_iommu_fault_handler,
+						   data);
+}
+
+static int vfio_iommu_teardown_fault_eventfd(struct vfio_iommu *iommu)
+{
+	int ret = -EINVAL;
+
+	mutex_lock(&iommu->fault_lock);
+
+	if (!iommu->fault_ctx)
+		goto out;
+
+	ret = vfio_iommu_for_each_dev(iommu, NULL,
+				      vfio_unregister_fault_handler_fn);
+	WARN_ON(ret);
+
+	eventfd_ctx_put(iommu->fault_ctx);
+	iommu->fault_ctx = NULL;
+	kfifo_free(&iommu->fault_fifo);
+out:
+	mutex_unlock(&iommu->fault_lock);
+	return ret;
+}
+
+static int
+vfio_iommu_set_fault_eventfd(struct vfio_iommu *iommu,
+			     struct vfio_iommu_type1_set_fault_eventfd *ustruct)
+{
+	struct eventfd_ctx *ctx;
+	int eventfd = ustruct->eventfd;
+	int qs = ustruct->config.qs;
+	int ret;
+
+	if (eventfd == -1)
+		return vfio_iommu_teardown_fault_eventfd(iommu);
+
+	if (qs <= 0)
+		return -EINVAL;
+
+	ctx = eventfd_ctx_fdget(eventfd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	mutex_lock(&iommu->fault_lock);
+	if (iommu->fault_ctx) {
+		eventfd_ctx_put(ctx);
+		return -EEXIST;
+	}
+
+	ret = kfifo_alloc(&iommu->fault_fifo,
+			  (1 << qs) * sizeof(struct iommu_fault),
+			  GFP_KERNEL);
+	if (ret)
+		goto out;
+
+	iommu->fault_ctx = ctx;
+	ret = vfio_iommu_for_each_dev(iommu, iommu,
+				      vfio_register_fault_handler_fn);
+	if (ret)
+		goto unregister;
+
+	mutex_unlock(&iommu->fault_lock);
+	return 0;
+unregister:
+	vfio_iommu_for_each_dev(iommu, NULL,
+				vfio_unregister_fault_handler_fn);
+	iommu->fault_ctx = NULL;
+	kfifo_free(&iommu->fault_fifo);
+out:
+	eventfd_ctx_put(ctx);
+	mutex_unlock(&iommu->fault_lock);
+	return ret;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -1825,6 +1936,7 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		return vfio_bind_pasid_table(iommu, &ustruct);
 	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
 		struct vfio_iommu_type1_cache_invalidate ustruct;
+		int ret;
 
 		minsz = offsetofend(struct vfio_iommu_type1_cache_invalidate,
 				    info);
@@ -1835,7 +1947,11 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		if (ustruct.argsz < minsz || ustruct.flags)
 			return -EINVAL;
 
-		return vfio_cache_invalidate(iommu, &ustruct);
+		mutex_lock(&iommu->lock);
+		ret = vfio_iommu_for_each_dev(iommu,
+					      &ustruct, vfio_cache_inv_fn);
+		mutex_unlock(&iommu->lock);
+		return ret;
 	} else if (cmd == VFIO_IOMMU_BIND_MSI) {
 		struct vfio_iommu_type1_bind_guest_msi ustruct;
 
@@ -1849,6 +1965,22 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 			return -EINVAL;
 
 		return vfio_iommu_bind_guest_msi(iommu, &ustruct);
+	} else if (cmd == VFIO_IOMMU_SET_FAULT_EVENTFD) {
+		struct vfio_iommu_type1_set_fault_eventfd ustruct;
+
+		minsz = offsetofend(struct vfio_iommu_type1_set_fault_eventfd,
+				    config);
+
+		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ustruct.argsz < minsz || ustruct.flags)
+			return -EINVAL;
+
+		if (ustruct.eventfd < 1)
+			return -EINVAL;
+
+		return vfio_iommu_set_fault_eventfd(iommu, &ustruct);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 6fb5e944e73c..0d62598c818a 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -687,6 +687,22 @@ struct vfio_iommu_type1_bind_guest_msi {
 };
 #define VFIO_IOMMU_BIND_MSI      _IO(VFIO_TYPE, VFIO_BASE + 24)
 
+struct vfio_iommu_type1_guest_fault_config {
+#define VFIO_IOMMU_FAULT_UNRECOVERABLE	(1 << 0)
+	__u32	flags;
+	union {
+		__u8	qs; /* queue size, log2(entries) */
+	};
+};
+
+struct vfio_iommu_type1_set_fault_eventfd {
+	__u32   argsz;
+	__u32   flags;
+	__u32   eventfd;
+	struct vfio_iommu_type1_guest_fault_config config;
+};
+#define VFIO_IOMMU_SET_FAULT_EVENTFD      _IO(VFIO_TYPE, VFIO_BASE + 25)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.17.1

