Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2676BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA36A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA36A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeGPH00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:26:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:45301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeGPH0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:26:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 00:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="72647344"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 00:00:30 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 09/10] iommu/vt-d: Shared virtual address in scalable mode
Date:   Mon, 16 Jul 2018 14:49:52 +0800
Message-Id: <1531723793-14607-10-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
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
 drivers/iommu/intel-iommu.c   | 38 --------------------------------------
 drivers/iommu/intel-svm.c     | 24 ++----------------------
 include/linux/dma_remapping.h |  9 +--------
 3 files changed, 3 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 13f3d17..88ec860 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5228,18 +5228,6 @@ static void intel_iommu_put_resv_regions(struct device *dev,
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
@@ -5271,33 +5259,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
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
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 8d4a911..a16a421 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -28,9 +28,6 @@
 
 #include "intel-pasid.h"
 
-#define PASID_ENTRY_P		BIT_ULL(0)
-#define PASID_ENTRY_SRE		BIT_ULL(11)
-
 static irqreturn_t prq_event_thread(int irq, void *d);
 
 struct pasid_state_entry {
@@ -280,11 +277,9 @@ static LIST_HEAD(global_svm_list);
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
 
@@ -393,23 +388,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
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
-
+		}
+		intel_pasid_setup_first_level(iommu, mm, dev, svm->pasid);
 		list_add_tail(&svm->list, &global_svm_list);
 	}
 	list_add_rcu(&sdev->list, &svm->devs);
diff --git a/include/linux/dma_remapping.h b/include/linux/dma_remapping.h
index 21b3e7d..6f01e54 100644
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
2.7.4

