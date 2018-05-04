Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeEDBvP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:51:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:35622 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751502AbeEDBvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:51:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="37326292"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 9/9] iommu/vt-d: Clean up PASID talbe management for SVM
Date: Fri,  4 May 2018 09:41:24 +0800
Message-Id: <1525398084-28815-10-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous per iommu pasid table alloc/free interfaces
are no longer used. Clean up the driver by removing it.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c |  6 +++---
 drivers/iommu/intel-svm.c   | 17 ++---------------
 include/linux/intel-iommu.h |  5 ++---
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fa6052a..010871d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1736,7 +1736,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	if (pasid_enabled(iommu)) {
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
-		intel_svm_free_pasid_tables(iommu);
+		intel_svm_exit(iommu);
 	}
 #endif
 }
@@ -3297,7 +3297,7 @@ static int __init init_dmars(void)
 			hw_pass_through = 0;
 #ifdef CONFIG_INTEL_IOMMU_SVM
 		if (pasid_enabled(iommu))
-			intel_svm_alloc_pasid_tables(iommu);
+			intel_svm_init(iommu);
 #endif
 	}
 
@@ -4274,7 +4274,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	if (pasid_enabled(iommu))
-		intel_svm_alloc_pasid_tables(iommu);
+		intel_svm_init(iommu);
 #endif
 
 	if (dmaru->ignored) {
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3b14819..38cae65 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -34,7 +34,7 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
+int intel_svm_init(struct intel_iommu *iommu)
 {
 	struct page *pages;
 	int order;
@@ -59,15 +59,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 		iommu->pasid_max = 0x20000;
 
 	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
-	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!pages) {
-		pr_warn("IOMMU: %s: Failed to allocate PASID table\n",
-			iommu->name);
-		return -ENOMEM;
-	}
-	iommu->pasid_table = page_address(pages);
-	pr_info("%s: Allocated order %d PASID table.\n", iommu->name, order);
-
 	if (ecap_dis(iommu->ecap)) {
 		/* Just making it explicit... */
 		BUILD_BUG_ON(sizeof(struct pasid_entry) != sizeof(struct pasid_state_entry));
@@ -82,14 +73,10 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 	return 0;
 }
 
-int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
+int intel_svm_exit(struct intel_iommu *iommu)
 {
 	int order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
 
-	if (iommu->pasid_table) {
-		free_pages((unsigned long)iommu->pasid_table, order);
-		iommu->pasid_table = NULL;
-	}
 	if (iommu->pasid_state_table) {
 		free_pages((unsigned long)iommu->pasid_state_table, order);
 		iommu->pasid_state_table = NULL;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 08e5811..44c7613 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -470,7 +470,6 @@ struct intel_iommu {
 	 * devices away to userspace processes (e.g. for DPDK) and don't
 	 * want to trust that userspace will use *only* the PASID it was
 	 * told to. But while it's all driver-arbitrated, we're fine. */
-	struct pasid_entry *pasid_table;
 	struct pasid_state_entry *pasid_state_table;
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
@@ -539,8 +538,8 @@ void free_pgtable_page(void *vaddr);
 struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
-extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
+int intel_svm_init(struct intel_iommu *iommu);
+int intel_svm_exit(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 
-- 
2.7.4
