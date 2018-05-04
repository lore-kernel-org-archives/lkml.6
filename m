Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeEDBvC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:51:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:35622 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEDBu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:50:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="37326275"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 8/9] iommu/vt-d: Use per-domain pasid table
Date: Fri,  4 May 2018 09:41:23 +0800
Message-Id: <1525398084-28815-9-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces current per iommu pasid table with
the new added per domain pasid table. Each svm-capable
PCI device will be configured with a pasid table which
shares with other svm-capable devices within its iommu
domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c |  6 +++---
 drivers/iommu/intel-svm.c   | 37 +++++++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5602ccd..fa6052a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5197,7 +5197,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
 		if (iommu->pasid_state_table)
 			context[1].hi = (u64)virt_to_phys(iommu->pasid_state_table);
-		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
+		context[1].lo = (u64)virt_to_phys(domain->pasid_table) |
 			intel_iommu_get_pts(domain);
 
 		wmb();
@@ -5265,8 +5265,8 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 		return NULL;
 	}
 
-	if (!iommu->pasid_table) {
-		dev_err(dev, "PASID not enabled on IOMMU; cannot enable SVM\n");
+	if (!intel_pasid_get_table(dev)) {
+		dev_err(dev, "No PASID table for device; cannot enable SVM\n");
 		return NULL;
 	}
 
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3abc94f..3b14819 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -256,6 +256,7 @@ static void intel_flush_pasid_dev(struct intel_svm *svm, struct intel_svm_dev *s
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
+	struct pasid_entry *pasid_table;
 	struct intel_svm_dev *sdev;
 
 	/* This might end up being called from exit_mmap(), *before* the page
@@ -270,11 +271,16 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * page) so that we end up taking a fault that the hardware really
 	 * *has* to handle gracefully without affecting other processes.
 	 */
-	svm->iommu->pasid_table[svm->pasid].val = 0;
-	wmb();
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
+		pasid_table = intel_pasid_get_table(sdev->dev);
+		if (!pasid_table)
+			continue;
+
+		pasid_table[svm->pasid].val = 0;
+		/* Make sure the entry update is visible before translation. */
+		wmb();
+
 		intel_flush_pasid_dev(svm, sdev, svm->pasid);
 		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 	}
@@ -295,6 +301,7 @@ static LIST_HEAD(global_svm_list);
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct pasid_entry *pasid_table;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
 	struct mm_struct *mm = NULL;
@@ -302,7 +309,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	int pasid_max;
 	int ret;
 
-	if (WARN_ON(!iommu || !iommu->pasid_table))
+	pasid_table = intel_pasid_get_table(dev);
+	if (WARN_ON(!iommu || !pasid_table))
 		return -EINVAL;
 
 	if (dev_is_pci(dev)) {
@@ -380,8 +388,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		}
 		svm->iommu = iommu;
 
-		if (pasid_max > iommu->pasid_max)
-			pasid_max = iommu->pasid_max;
+		if (pasid_max > intel_pasid_max_id)
+			pasid_max = intel_pasid_max_id;
 
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
 		ret = intel_pasid_alloc_id(svm,
@@ -414,7 +422,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (cpu_feature_enabled(X86_FEATURE_LA57))
 			pasid_entry_val |= PASID_ENTRY_FLPM_5LP;
 
-		iommu->pasid_table[svm->pasid].val = pasid_entry_val;
+		pasid_table[svm->pasid].val = pasid_entry_val;
 
 		wmb();
 
@@ -442,6 +450,7 @@ EXPORT_SYMBOL_GPL(intel_svm_bind_mm);
 
 int intel_svm_unbind_mm(struct device *dev, int pasid)
 {
+	struct pasid_entry *pasid_table;
 	struct intel_svm_dev *sdev;
 	struct intel_iommu *iommu;
 	struct intel_svm *svm;
@@ -449,7 +458,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 
 	mutex_lock(&pasid_mutex);
 	iommu = intel_svm_device_to_iommu(dev);
-	if (!iommu || !iommu->pasid_table)
+	pasid_table = intel_pasid_get_table(dev);
+	if (!iommu || !pasid_table)
 		goto out;
 
 	svm = intel_pasid_lookup_id(pasid);
@@ -472,11 +482,14 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 				intel_flush_pasid_dev(svm, sdev, svm->pasid);
 				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 				kfree_rcu(sdev, rcu);
+				pasid_table[svm->pasid].val = 0;
+				/*
+				 * Make sure the entry update is visible
+				 * before translation.
+				 */
+				wmb();
 
 				if (list_empty(&svm->devs)) {
-					svm->iommu->pasid_table[svm->pasid].val = 0;
-					wmb();
-
 					intel_pasid_free_id(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
@@ -509,7 +522,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 
 	mutex_lock(&pasid_mutex);
 	iommu = intel_svm_device_to_iommu(dev);
-	if (!iommu || !iommu->pasid_table)
+	if (!iommu)
 		goto out;
 
 	svm = intel_pasid_lookup_id(pasid);
-- 
2.7.4
