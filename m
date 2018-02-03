Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbeBCAtj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:49:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:17233 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752255AbeBCAtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:49:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,452,1511856000";
   d="scan'208";a="15086251"
From: Sohil Mehta <sohil.mehta@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v7 1/5] iommu/vt-d: Relocate struct/function declarations to its header files
Date: Fri,  2 Feb 2018 16:49:57 -0800
Message-Id: <1517619001-148586-2-git-send-email-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

To reuse the static functions and the struct declarations, move them to
corresponding header files and export the needed functions.

Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---

v7: Split patch 1/5 and 2/5 differently
    Update the commit message

v6: No change

v5: No change

v4: No change

v3: No change

v2: No change

 drivers/iommu/intel-iommu.c | 33 ++++-----------------------------
 include/linux/intel-iommu.h | 31 +++++++++++++++++++++++++++++++
 include/linux/intel-svm.h   |  2 +-
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4a2de34..f6241f6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -183,16 +183,6 @@ static int rwbf_quirk;
 static int force_on = 0;
 int intel_iommu_tboot_noforce;
 
-/*
- * 0: Present
- * 1-11: Reserved
- * 12-63: Context Ptr (12 - (haw-1))
- * 64-127: Reserved
- */
-struct root_entry {
-	u64	lo;
-	u64	hi;
-};
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
 
 /*
@@ -218,21 +208,6 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
 
 	return re->hi & VTD_PAGE_MASK;
 }
-/*
- * low 64 bits:
- * 0: present
- * 1: fault processing disable
- * 2-3: translation type
- * 12-63: address space root
- * high 64 bits:
- * 0-2: address width
- * 3-6: aval
- * 8-23: domain id
- */
-struct context_entry {
-	u64 lo;
-	u64 hi;
-};
 
 static inline void context_clear_pasid_enable(struct context_entry *context)
 {
@@ -259,7 +234,7 @@ static inline bool __context_present(struct context_entry *context)
 	return (context->lo & 1);
 }
 
-static inline bool context_present(struct context_entry *context)
+bool context_present(struct context_entry *context)
 {
 	return context_pasid_enabled(context) ?
 	     __context_present(context) :
@@ -819,8 +794,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	domain->iommu_superpage = domain_update_iommu_superpage(NULL);
 }
 
-static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
-						       u8 bus, u8 devfn, int alloc)
+struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
+					 u8 devfn, int alloc)
 {
 	struct root_entry *root = &iommu->root_entry[bus];
 	struct context_entry *context;
@@ -5208,7 +5183,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 #define MAX_NR_PASID_BITS (20)
-static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
+unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
 {
 	/*
 	 * Convert ecap_pss to extend context entry pts encoding, also
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index f3274d9..78ec85a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -383,6 +383,33 @@ struct pasid_entry;
 struct pasid_state_entry;
 struct page_req_dsc;
 
+/*
+ * 0: Present
+ * 1-11: Reserved
+ * 12-63: Context Ptr (12 - (haw-1))
+ * 64-127: Reserved
+ */
+struct root_entry {
+	u64     lo;
+	u64     hi;
+};
+
+/*
+ * low 64 bits:
+ * 0: present
+ * 1: fault processing disable
+ * 2-3: translation type
+ * 12-63: address space root
+ * high 64 bits:
+ * 0-2: address width
+ * 3-6: aval
+ * 8-23: domain id
+ */
+struct context_entry {
+	u64 lo;
+	u64 hi;
+};
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -488,8 +515,12 @@ struct intel_svm {
 
 extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev);
 extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
+extern unsigned long intel_iommu_get_pts(struct intel_iommu *iommu);
 #endif
 
 extern const struct attribute_group *intel_iommu_groups[];
+extern bool context_present(struct context_entry *context);
+extern struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
+						u8 bus, u8 devfn, int alloc);
 
 #endif
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 99bc5b3..733eaf9 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -130,7 +130,7 @@ static inline int intel_svm_unbind_mm(struct device *dev, int pasid)
 	BUG();
 }
 
-static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
+static inline int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 {
 	return -EINVAL;
 }
-- 
2.7.4
