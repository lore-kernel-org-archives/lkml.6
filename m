Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67975ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D104204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D104204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbeKEOwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:52:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:13964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbeKEOwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:52:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 21:34:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="105289030"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2018 21:34:49 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 11/12] iommu/vt-d: Shared virtual address in scalable mode
Date:   Mon,  5 Nov 2018 13:31:50 +0800
Message-Id: <20181105053151.7173-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105053151.7173-1-baolu.lu@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the current SVA (Shared Virtual Address)
implementation to work in the scalable mode.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c   | 38 ------------------------
 drivers/iommu/intel-pasid.c   |  2 +-
 drivers/iommu/intel-pasid.h   |  1 -
 drivers/iommu/intel-svm.c     | 55 ++++++++++-------------------------
 include/linux/dma_remapping.h |  9 +-----
 5 files changed, 17 insertions(+), 88 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9c5e0d5530a2..3c3a882964a0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5253,18 +5253,6 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 }
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-static inline unsigned long intel_iommu_get_pts(struct device *dev)
-{
-	int pts, max_pasid;
-
-	max_pasid = intel_pasid_get_dev_max_id(dev);
-	pts = find_first_bit((unsigned long *)&max_pasid, MAX_NR_PASID_BITS);
-	if (pts < 5)
-		return 0;
-
-	return pts - 5;
-}
-
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
 {
 	struct device_domain_info *info;
@@ -5296,33 +5284,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
-		if (iommu->pasid_state_table)
-			context[1].hi = (u64)virt_to_phys(iommu->pasid_state_table);
-		context[1].lo = (u64)virt_to_phys(info->pasid_table->table) |
-			intel_iommu_get_pts(sdev->dev);
-
-		wmb();
-		/* CONTEXT_TT_MULTI_LEVEL and CONTEXT_TT_DEV_IOTLB are both
-		 * extended to permit requests-with-PASID if the PASIDE bit
-		 * is set. which makes sense. For CONTEXT_TT_PASS_THROUGH,
-		 * however, the PASIDE bit is ignored and requests-with-PASID
-		 * are unconditionally blocked. Which makes less sense.
-		 * So convert from CONTEXT_TT_PASS_THROUGH to one of the new
-		 * "guest mode" translation types depending on whether ATS
-		 * is available or not. Annoyingly, we can't use the new
-		 * modes *unless* PASIDE is set. */
-		if ((ctx_lo & CONTEXT_TT_MASK) == (CONTEXT_TT_PASS_THROUGH << 2)) {
-			ctx_lo &= ~CONTEXT_TT_MASK;
-			if (info->ats_supported)
-				ctx_lo |= CONTEXT_TT_PT_PASID_DEV_IOTLB << 2;
-			else
-				ctx_lo |= CONTEXT_TT_PT_PASID << 2;
-		}
 		ctx_lo |= CONTEXT_PASIDE;
-		if (iommu->pasid_state_table)
-			ctx_lo |= CONTEXT_DINVE;
-		if (info->pri_supported)
-			ctx_lo |= CONTEXT_PRS;
 		context[0].lo = ctx_lo;
 		wmb();
 		iommu->flush.flush_context(iommu, sdev->did, sdev->sid,
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index d8ca1e6a8e5e..839f83974aca 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -285,7 +285,7 @@ static inline void pasid_clear_entry(struct pasid_entry *pe)
 	WRITE_ONCE(pe->val[7], 0);
 }
 
-void intel_pasid_clear_entry(struct device *dev, int pasid)
+static void intel_pasid_clear_entry(struct device *dev, int pasid)
 {
 	struct pasid_entry *pe;
 
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 80db18441b1d..381545ff9fb7 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -58,7 +58,6 @@ void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_get_dev_max_id(struct device *dev);
 struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
-void intel_pasid_clear_entry(struct device *dev, int pasid);
 int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 				  struct device *dev, pgd_t *pgd,
 				  int pasid, int flags);
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 9b6771a89207..4187a91592c1 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -29,10 +29,6 @@
 
 #include "intel-pasid.h"
 
-#define PASID_ENTRY_P		BIT_ULL(0)
-#define PASID_ENTRY_FLPM_5LP	BIT_ULL(9)
-#define PASID_ENTRY_SRE		BIT_ULL(11)
-
 static irqreturn_t prq_event_thread(int irq, void *d);
 
 struct pasid_state_entry {
@@ -248,20 +244,6 @@ static void intel_invalidate_range(struct mmu_notifier *mn,
 			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0, 0);
 }
 
-
-static void intel_flush_pasid_dev(struct intel_svm *svm, struct intel_svm_dev *sdev, int pasid)
-{
-	struct qi_desc desc;
-
-	desc.qw0 = QI_PC_TYPE | QI_PC_DID(sdev->did) |
-			QI_PC_PASID_SEL | QI_PC_PASID(pasid);
-	desc.qw1 = 0;
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(&desc, svm->iommu);
-}
-
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
@@ -281,8 +263,7 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
-		intel_pasid_clear_entry(sdev->dev, svm->pasid);
-		intel_flush_pasid_dev(svm, sdev, svm->pasid);
+		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
 		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 	}
 	rcu_read_unlock();
@@ -301,11 +282,9 @@ static LIST_HEAD(global_svm_list);
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
-	struct pasid_entry *entry;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
 	struct mm_struct *mm = NULL;
-	u64 pasid_entry_val;
 	int pasid_max;
 	int ret;
 
@@ -414,22 +393,19 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 				kfree(sdev);
 				goto out;
 			}
-			pasid_entry_val = (u64)__pa(mm->pgd) | PASID_ENTRY_P;
-		} else
-			pasid_entry_val = (u64)__pa(init_mm.pgd) |
-					  PASID_ENTRY_P | PASID_ENTRY_SRE;
-		if (cpu_feature_enabled(X86_FEATURE_LA57))
-			pasid_entry_val |= PASID_ENTRY_FLPM_5LP;
-
-		entry = intel_pasid_get_entry(dev, svm->pasid);
-		WRITE_ONCE(entry->val[0], pasid_entry_val);
-
-		/*
-		 * Flush PASID cache when a PASID table entry becomes
-		 * present.
-		 */
-		if (cap_caching_mode(iommu->cap))
-			intel_flush_pasid_dev(svm, sdev, svm->pasid);
+		}
+
+		ret = intel_pasid_setup_first_level(iommu, dev,
+				mm ? mm->pgd : init_mm.pgd, svm->pasid,
+				mm ? 0 : PASID_FLAG_SUPERVISOR_MODE);
+		if (ret) {
+			if (mm)
+				mmu_notifier_unregister(&svm->notifier, mm);
+			intel_pasid_free_id(svm->pasid);
+			kfree(svm);
+			kfree(sdev);
+			goto out;
+		}
 
 		list_add_tail(&svm->list, &global_svm_list);
 	}
@@ -475,10 +451,9 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 				 * to use. We have a *shared* PASID table, because it's
 				 * large and has to be physically contiguous. So it's
 				 * hard to be as defensive as we might like. */
-				intel_flush_pasid_dev(svm, sdev, svm->pasid);
+				intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
 				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 				kfree_rcu(sdev, rcu);
-				intel_pasid_clear_entry(dev, svm->pasid);
 
 				if (list_empty(&svm->devs)) {
 					intel_pasid_free_id(svm->pasid);
diff --git a/include/linux/dma_remapping.h b/include/linux/dma_remapping.h
index 21b3e7d33d68..6f01e54702e5 100644
--- a/include/linux/dma_remapping.h
+++ b/include/linux/dma_remapping.h
@@ -21,14 +21,7 @@
 #define CONTEXT_TT_MULTI_LEVEL	0
 #define CONTEXT_TT_DEV_IOTLB	1
 #define CONTEXT_TT_PASS_THROUGH 2
-/* Extended context entry types */
-#define CONTEXT_TT_PT_PASID	4
-#define CONTEXT_TT_PT_PASID_DEV_IOTLB 5
-#define CONTEXT_TT_MASK (7ULL << 2)
-
-#define CONTEXT_DINVE		(1ULL << 8)
-#define CONTEXT_PRS		(1ULL << 9)
-#define CONTEXT_PASIDE		(1ULL << 11)
+#define CONTEXT_PASIDE		BIT_ULL(3)
 
 struct intel_iommu;
 struct dmar_domain;
-- 
2.17.1

