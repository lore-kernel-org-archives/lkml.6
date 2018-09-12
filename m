Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A16C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8067820880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8067820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeILFLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:11:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:9561 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeILFLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:11:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 17:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72213105"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 17:10:04 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v8 1/6] iommu/vt-d: Relocate struct/function declarations to its header files
Date:   Tue, 11 Sep 2018 17:11:36 -0700
Message-Id: <20180912001141.64025-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912001141.64025-1-sohil.mehta@intel.com>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reuse the static functions and the struct declarations, move them to
corresponding header files and export the needed functions.

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---

v8: Remove pasid table related changes
    Add Interrupt remapping related changes
    Remove redundant extern type from functions

v7: Split patch 1/5 and 2/5 differently
    Update the commit message

v6: No change

v5: No change

v4: No change

v3: No change

v2: No change

 arch/x86/include/asm/irq_remapping.h |  2 ++
 drivers/iommu/intel-iommu.c          | 31 +++-------------------------
 drivers/iommu/intel_irq_remapping.c  |  2 +-
 include/linux/intel-iommu.h          | 30 +++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 5f26962eff42..67ed72f31cc2 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -45,6 +45,8 @@ struct vcpu_data {
 
 #ifdef CONFIG_IRQ_REMAP
 
+extern raw_spinlock_t irq_2_ir_lock;
+
 extern bool irq_remapping_cap(enum irq_remap_cap cap);
 extern void set_irq_remapping_broken(void);
 extern int irq_remapping_prepare(void);
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5f3f10cf9d9d..b5868c757995 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -185,16 +185,6 @@ static int rwbf_quirk;
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
@@ -220,21 +210,6 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
 
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
@@ -261,7 +236,7 @@ static inline bool __context_present(struct context_entry *context)
 	return (context->lo & 1);
 }
 
-static inline bool context_present(struct context_entry *context)
+bool context_present(struct context_entry *context)
 {
 	return context_pasid_enabled(context) ?
 	     __context_present(context) :
@@ -788,8 +763,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	domain->iommu_superpage = domain_update_iommu_superpage(NULL);
 }
 
-static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
-						       u8 bus, u8 devfn, int alloc)
+struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
+					 u8 devfn, int alloc)
 {
 	struct root_entry *root = &iommu->root_entry[bus];
 	struct context_entry *context;
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 967450bd421a..c2d6c11431de 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -76,7 +76,7 @@ static struct hpet_scope ir_hpet[MAX_HPET_TBS];
  * in single-threaded environment with interrupt disabled, so no need to tabke
  * the dmar_global_lock.
  */
-static DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
+DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
 static const struct irq_domain_ops intel_ir_domain_ops;
 
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 28004d74ae04..b7cf32e8ae1f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -389,6 +389,33 @@ struct pasid_entry;
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
 struct dmar_domain {
 	int	nid;			/* node id */
 
@@ -559,5 +586,8 @@ extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 #endif
 
 extern const struct attribute_group *intel_iommu_groups[];
+bool context_present(struct context_entry *context);
+struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
+					 u8 devfn, int alloc);
 
 #endif
-- 
2.18.0

