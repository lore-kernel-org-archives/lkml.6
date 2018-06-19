Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE02C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D516020874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D516020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756012AbeFSF1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:27:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:14970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755956AbeFSF1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:27:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 22:27:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="50424338"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 22:27:30 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 8/9] iommu/vt-d: Apply per pci device pasid table in SVA
Date:   Tue, 19 Jun 2018 13:17:28 +0800
Message-Id: <1529385449-25649-9-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
References: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies the per pci device pasid table in the Shared
Virtual Address (SVA) implementation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 29 +++++++++--------------------
 drivers/iommu/intel-svm.c   | 22 ++++++++++------------
 2 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 43bf151..b0651a2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5163,22 +5163,16 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 #define MAX_NR_PASID_BITS (20)
-static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
+static inline unsigned long intel_iommu_get_pts(struct device *dev)
 {
-	/*
-	 * Convert ecap_pss to extend context entry pts encoding, also
-	 * respect the soft pasid_max value set by the iommu.
-	 * - number of PASID bits = ecap_pss + 1
-	 * - number of PASID table entries = 2^(pts + 5)
-	 * Therefore, pts = ecap_pss - 4
-	 * e.g. KBL ecap_pss = 0x13, PASID has 20 bits, pts = 15
-	 */
-	if (ecap_pss(iommu->ecap) < 5)
+	int pts, max_pasid;
+
+	max_pasid = intel_pasid_get_dev_max_id(dev);
+	pts = find_first_bit((unsigned long *)&max_pasid, MAX_NR_PASID_BITS);
+	if (pts < 5)
 		return 0;
 
-	/* pasid_max is encoded as actual number of entries not the bits */
-	return find_first_bit((unsigned long *)&iommu->pasid_max,
-			MAX_NR_PASID_BITS) - 5;
+	return pts - 5;
 }
 
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
@@ -5214,8 +5208,8 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
 		if (iommu->pasid_state_table)
 			context[1].hi = (u64)virt_to_phys(iommu->pasid_state_table);
-		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
-			intel_iommu_get_pts(iommu);
+		context[1].lo = (u64)virt_to_phys(info->pasid_table->table) |
+			intel_iommu_get_pts(sdev->dev);
 
 		wmb();
 		/* CONTEXT_TT_MULTI_LEVEL and CONTEXT_TT_DEV_IOTLB are both
@@ -5282,11 +5276,6 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 		return NULL;
 	}
 
-	if (!iommu->pasid_table) {
-		dev_err(dev, "PASID not enabled on IOMMU; cannot enable SVM\n");
-		return NULL;
-	}
-
 	return iommu;
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 9b5dc72..a253cde 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -274,11 +274,9 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * page) so that we end up taking a fault that the hardware really
 	 * *has* to handle gracefully without affecting other processes.
 	 */
-	svm->iommu->pasid_table[svm->pasid].val = 0;
-	wmb();
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
+		intel_pasid_clear_entry(sdev->dev, svm->pasid);
 		intel_flush_pasid_dev(svm, sdev, svm->pasid);
 		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 	}
@@ -299,6 +297,7 @@ static LIST_HEAD(global_svm_list);
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct pasid_entry *entry;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
 	struct mm_struct *mm = NULL;
@@ -306,7 +305,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	int pasid_max;
 	int ret;
 
-	if (!iommu || !iommu->pasid_table)
+	if (!iommu)
 		return -EINVAL;
 
 	if (dev_is_pci(dev)) {
@@ -384,8 +383,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		}
 		svm->iommu = iommu;
 
-		if (pasid_max > iommu->pasid_max)
-			pasid_max = iommu->pasid_max;
+		if (pasid_max > intel_pasid_max_id)
+			pasid_max = intel_pasid_max_id;
 
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
 		ret = intel_pasid_alloc_id(svm,
@@ -418,7 +417,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (cpu_feature_enabled(X86_FEATURE_LA57))
 			pasid_entry_val |= PASID_ENTRY_FLPM_5LP;
 
-		iommu->pasid_table[svm->pasid].val = pasid_entry_val;
+		entry = intel_pasid_get_entry(dev, svm->pasid);
+		entry->val = pasid_entry_val;
 
 		wmb();
 
@@ -453,7 +453,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 
 	mutex_lock(&pasid_mutex);
 	iommu = intel_svm_device_to_iommu(dev);
-	if (!iommu || !iommu->pasid_table)
+	if (!iommu)
 		goto out;
 
 	svm = intel_pasid_lookup_id(pasid);
@@ -476,11 +476,9 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 				intel_flush_pasid_dev(svm, sdev, svm->pasid);
 				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 				kfree_rcu(sdev, rcu);
+				intel_pasid_clear_entry(dev, svm->pasid);
 
 				if (list_empty(&svm->devs)) {
-					svm->iommu->pasid_table[svm->pasid].val = 0;
-					wmb();
-
 					intel_pasid_free_id(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
@@ -513,7 +511,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 
 	mutex_lock(&pasid_mutex);
 	iommu = intel_svm_device_to_iommu(dev);
-	if (!iommu || !iommu->pasid_table)
+	if (!iommu)
 		goto out;
 
 	svm = intel_pasid_lookup_id(pasid);
-- 
2.7.4

