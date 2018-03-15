Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeCOCqx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:46:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:43990 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbeCOCq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:46:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,308,1517904000";
   d="scan'208";a="24171129"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 3/3] iommu/vt-d: Use global PASID for SVM usage
Date: Thu, 15 Mar 2018 10:38:21 +0800
Message-Id: <1521081501-30119-4-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521081501-30119-1-git-send-email-baolu.lu@linux.intel.com>
References: <1521081501-30119-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches PASID management for SVM from SVM specific
idr to the global idr.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel-svm.c   | 20 +++++++++-----------
 include/linux/intel-iommu.h |  1 -
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index f3b7394..1c45f75 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -85,8 +85,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 				iommu->name);
 	}
 
-	idr_init(&iommu->pasid_idr);
-
 	return 0;
 }
 
@@ -102,7 +100,7 @@ int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
 		free_pages((unsigned long)iommu->pasid_state_table, order);
 		iommu->pasid_state_table = NULL;
 	}
-	idr_destroy(&iommu->pasid_idr);
+
 	return 0;
 }
 
@@ -392,9 +390,9 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 			pasid_max = iommu->pasid_max;
 
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
-		ret = idr_alloc(&iommu->pasid_idr, svm,
-				!!cap_caching_mode(iommu->cap),
-				pasid_max - 1, GFP_KERNEL);
+		ret = intel_iommu_alloc_pasid(svm,
+					      !!cap_caching_mode(iommu->cap),
+					      pasid_max - 1, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
 			goto out;
@@ -409,7 +407,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+				intel_iommu_free_pasid(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -463,7 +461,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu || !iommu->pasid_table)
 		goto out;
 
-	svm = idr_find(&iommu->pasid_idr, pasid);
+	svm = intel_iommu_lookup_pasid(pasid);
 	if (!svm)
 		goto out;
 
@@ -488,7 +486,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 					svm->iommu->pasid_table[svm->pasid].val = 0;
 					wmb();
 
-					idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+					intel_iommu_free_pasid(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
@@ -523,7 +521,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 	if (!iommu || !iommu->pasid_table)
 		goto out;
 
-	svm = idr_find(&iommu->pasid_idr, pasid);
+	svm = intel_iommu_lookup_pasid(pasid);
 	if (!svm)
 		goto out;
 
@@ -621,7 +619,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
-			svm = idr_find(&iommu->pasid_idr, req->pasid);
+			svm = intel_iommu_lookup_pasid(req->pasid);
 			/* It *can't* go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a2013dd..e50bef8 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -418,7 +418,6 @@ struct intel_iommu {
 	struct pasid_state_entry *pasid_state_table;
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
-	struct idr pasid_idr;
 	u32 pasid_max;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.7.4
