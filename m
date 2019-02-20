Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82198C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516CA2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBTOae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:30:34 -0500
Received: from foss.arm.com ([217.140.101.70]:58792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfBTOac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:30:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DA8B1682;
        Wed, 20 Feb 2019 06:30:32 -0800 (PST)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 64D763F690;
        Wed, 20 Feb 2019 06:30:30 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, alex.williamson@redhat.com
Subject: [PATCH 1/1] iommu: Bind process address spaces to devices
Date:   Wed, 20 Feb 2019 14:27:59 +0000
Message-Id: <20190220142759.33308-2-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bind() and unbind() operations to the IOMMU API. Bind() returns a
PASID to the device driver (by convention, a 20-bit system-wide ID
representing the address space). When programming DMA addresses, device
drivers include this PASID in a device-specific manner, to let the device
access the given address space. Since the process memory may be paged out,
device and IOMMU must support I/O page faults (e.g. PCI PRI).

Device drivers pass an mm_exit() callback to bind(), that is called by the
IOMMU driver if the process exits before the device driver called
unbind(). In mm_exit(), device driver should disable DMA from the given
context, so that the core IOMMU can reallocate the PASID.

To use these functions, device driver must first enable the
IOMMU_DEV_FEAT_SVA device feature with iommu_dev_enable_feature().

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  24 ++++++++++
 2 files changed, 128 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1629354255c3..5feba98566b2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2351,3 +2351,107 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
+
+/**
+ * iommu_sva_bind_device() - Bind a process address space to a device
+ * @dev: the device
+ * @mm: the mm to bind, caller must hold a reference to it
+ * @pasid: valid address where the PASID will be stored
+ * @mm_exit: notifier function to call when the mm exits
+ * @drvdata: private data passed to the mm exit handler
+ *
+ * Create a bond between device and task, allowing the device to access the mm
+ * using the returned PASID. If unbind() isn't called first, a subsequent bind()
+ * for the same device and mm fails with -EEXIST.
+ *
+ * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
+ * initialize the required SVA features.
+ *
+ * @mm_exit is called when the mm is about to be torn down by exit_mmap. After
+ * @mm_exit returns, the device must not issue any more transaction with the
+ * PASID given as argument.
+ *
+ * The @mm_exit handler is allowed to sleep. Be careful about the locks taken in
+ * @mm_exit, because they might lead to deadlocks if they are also held when
+ * dropping references to the mm. Consider the following call chain:
+ *   mutex_lock(A); mmput(mm) -> exit_mm() -> @mm_exit() -> mutex_lock(A)
+ * Using mmput_async() prevents this scenario.
+ *
+ * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
+ * is returned.
+ */
+int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
+			  iommu_mm_exit_handler_t mm_exit, void *drvdata)
+{
+	int ret = -EINVAL;
+	struct iommu_group *group;
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (!pasid)
+		return -EINVAL;
+
+	if (!ops || !ops->bind_mm)
+		return -ENODEV;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	/* Ensure device count and domain don't change while we're binding */
+	mutex_lock(&group->mutex);
+
+	/*
+	 * To keep things simple, SVA currently doesn't support IOMMU groups
+	 * with more than one device. Existing SVA-capable systems are not
+	 * affected by the problems that required IOMMU groups (lack of ACS
+	 * isolation, device ID aliasing and other hardware issues).
+	 */
+	if (iommu_group_device_count(group) != 1)
+		goto out_unlock;
+
+	ret = ops->bind_mm(dev, mm, pasid, mm_exit, drvdata);
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
+
+/**
+ * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
+ * @dev: the device
+ * @pasid: the pasid returned by bind()
+ *
+ * Remove bond between device and address space identified by @pasid. Users
+ * should not call unbind() if the corresponding mm exited (as the PASID might
+ * have been reallocated for another process).
+ *
+ * The device must not be issuing any more transaction for this PASID. All
+ * outstanding page requests for this PASID must have been flushed to the IOMMU.
+ *
+ * Returns 0 on success, or an error value
+ */
+int iommu_sva_unbind_device(struct device *dev, int pasid)
+{
+	int ret = -EINVAL;
+	struct iommu_group *group;
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (!ops || !ops->unbind_mm)
+		return -ENODEV;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	ret = ops->unbind_mm(dev, pasid);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bdd68778ceb5..a69aeea58818 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -55,6 +55,7 @@ struct iommu_fault_event;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
+typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -159,6 +160,7 @@ struct iommu_resv_region {
 /* Per device IOMMU features */
 enum iommu_dev_features {
 	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
+	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
 };
 
 #ifdef CONFIG_IOMMU_API
@@ -228,6 +230,8 @@ struct page_response_msg {
  * @dev_feat_enabled: check enabled feature
  * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
  * @aux_get_pasid: get the pasid given an aux-domain
+ * @bind_mm: Bind process address space to device
+ * @unbind_mm: Unbind process address space from device
  * @page_response: handle page request response
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
@@ -283,6 +287,9 @@ struct iommu_ops {
 	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
 
+	int (*bind_mm)(struct device *dev, struct mm_struct *mm, int *pasid,
+			iommu_mm_exit_handler_t mm_exit, void *drvdata);
+	int (*unbind_mm)(struct device *dev, int pasid);
 	int (*page_response)(struct device *dev, struct page_response_msg *msg);
 
 	unsigned long pgsize_bitmap;
@@ -541,6 +548,11 @@ int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev);
 void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
 int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
+extern int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
+				 int *pasid, iommu_mm_exit_handler_t mm_exit,
+				 void *drvdata);
+extern int iommu_sva_unbind_device(struct device *dev, int pasid);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -889,6 +901,18 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 	return -ENODEV;
 }
 
+static inline int
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
+		      iommu_mm_exit_handler_t mm_exit, void *drvdata)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_sva_unbind_device(struct device *dev, int pasid)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
2.20.1

