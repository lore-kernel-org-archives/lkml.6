Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeEDBwY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:52:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:35622 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbeEDBuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:50:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="37326235"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 2/9] iommu/vt-d: Decouple idr bond pointer from svm
Date: Fri,  4 May 2018 09:41:17 +0800
Message-Id: <1525398084-28815-3-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we move the PASID idr out of SVM code and make it serving
as a global PASID name space, the consumer can specify a ptr
to bind it with a PASID. We shouldn't assume that each PASID
will be bond with a ptr of struct intel_svm anymore.

This patch cleans up a idr_for_each_entry() usage in the SVM
code. It's required to replace the SVM-specific idr with the
global PASID idr.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-svm.c   | 14 ++++++++++----
 include/linux/intel-iommu.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index e8cd984..983af0c 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -298,6 +298,7 @@ static const struct mmu_notifier_ops intel_mmuops = {
 };
 
 static DEFINE_MUTEX(pasid_mutex);
+static LIST_HEAD(global_svm_list);
 
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
@@ -329,13 +330,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 
 	mutex_lock(&pasid_mutex);
 	if (pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
-		int i;
+		struct intel_svm *t;
 
-		idr_for_each_entry(&iommu->pasid_idr, svm, i) {
-			if (svm->mm != mm ||
-			    (svm->flags & SVM_FLAG_PRIVATE_PASID))
+		list_for_each_entry(t, &global_svm_list, list) {
+			if (t->mm != mm || (t->flags & SVM_FLAG_PRIVATE_PASID))
 				continue;
 
+			svm = t;
 			if (svm->pasid >= pasid_max) {
 				dev_warn(dev,
 					 "Limited PASID width. Cannot use existing PASID %d\n",
@@ -404,6 +405,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		svm->mm = mm;
 		svm->flags = flags;
 		INIT_LIST_HEAD_RCU(&svm->devs);
+		INIT_LIST_HEAD(&svm->list);
 		ret = -ENOMEM;
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
@@ -430,6 +432,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		 */
 		if (cap_caching_mode(iommu->cap))
 			intel_flush_pasid_dev(svm, sdev, svm->pasid);
+
+		list_add_tail(&svm->list, &global_svm_list);
 	}
 	list_add_rcu(&sdev->list, &svm->devs);
 
@@ -485,6 +489,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
+					list_del(&svm->list);
+
 					/* We mandate that no page faults may be outstanding
 					 * for the PASID when intel_svm_unbind_mm() is called.
 					 * If that is not obeyed, subtle errors will happen.
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ef169d6..795717e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -486,6 +486,7 @@ struct intel_svm {
 	int flags;
 	int pasid;
 	struct list_head devs;
+	struct list_head list;
 };
 
 extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev);
-- 
2.7.4
