Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0080ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B5B208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B5B208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbeGPH0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:26:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:45301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeGPH0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:26:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 00:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="72647330"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 00:00:28 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 08/10] iommu/vt-d: Add first level page table interface
Date:   Mon, 16 Jul 2018 14:49:51 +0800
Message-Id: <1531723793-14607-9-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an interface to setup the structures for first
level page table translation type.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-pasid.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  4 +++
 drivers/iommu/intel-svm.c   |  1 -
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index da504576..1195c2a 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	"DMAR: " fmt
 
 #include <linux/bitops.h>
+#include <linux/cpufeature.h>
 #include <linux/dmar.h>
 #include <linux/intel-iommu.h>
 #include <linux/iommu.h>
@@ -377,6 +378,26 @@ static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
 	pasid_set_bits(&pe->val[1], 1 << 23, value);
 }
 
+/*
+ * Setup the First Level Page table Pointer field (Bit 140~191)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_flptr(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[2], VTD_PAGE_MASK, value);
+}
+
+/*
+ * Setup the First Level Paging Mode field (Bit 130~131) of a
+ * scalable mode PASID entry.
+ */
+static inline void
+pasid_set_flpm(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
+}
+
 static inline void
 flush_pasid_cache(struct intel_iommu *iommu, int did, int pasid)
 {
@@ -389,6 +410,50 @@ flush_pasid_cache(struct intel_iommu *iommu, int did, int pasid)
 }
 
 /*
+ * Set up the scalable mode pasid table entry for first only
+ * translation type.
+ */
+void intel_pasid_setup_first_level(struct intel_iommu *iommu,
+				   struct mm_struct *mm,
+				   struct device *dev,
+				   int pasid)
+{
+	struct pasid_entry *pte;
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte))
+		return;
+
+	pasid_clear_entry(pte);
+
+	/* Setup the first level page table pointer: */
+	if (mm) {
+		pasid_set_flptr(pte, (u64)__pa(mm->pgd));
+	} else {
+		pasid_set_sre(pte);
+		pasid_set_flptr(pte, (u64)__pa(init_mm.pgd));
+	}
+
+#ifdef CONFIG_X86
+	if (cpu_feature_enabled(X86_FEATURE_LA57))
+		pasid_set_flpm(pte, 1);
+#endif /* CONFIG_X86 */
+
+	pasid_set_address_width(pte, iommu->agaw);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+
+	/* Setup Present and PASID Granular Transfer Type: */
+	pasid_set_translation_type(pte, 1);
+	pasid_set_present(pte);
+
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
+	if (cap_caching_mode(iommu->cap))
+		flush_pasid_cache(iommu, 0, pasid);
+}
+
+/*
  * Set up the scalable mode pasid table entry for second only or
  * passthrough translation type.
  */
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 80d4667..518df72 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -45,6 +45,10 @@ struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_get_dev_max_id(struct device *dev);
 struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
 void intel_pasid_clear_entry(struct device *dev, int pasid);
+void intel_pasid_setup_first_level(struct intel_iommu *iommu,
+				   struct mm_struct *mm,
+				   struct device *dev,
+				   int pasid);
 void intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev, int pasid,
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 5d250cf..8d4a911 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -29,7 +29,6 @@
 #include "intel-pasid.h"
 
 #define PASID_ENTRY_P		BIT_ULL(0)
-#define PASID_ENTRY_FLPM_5LP	BIT_ULL(9)
 #define PASID_ENTRY_SRE		BIT_ULL(11)
 
 static irqreturn_t prq_event_thread(int irq, void *d);
-- 
2.7.4

