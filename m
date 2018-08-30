Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DE6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F9520647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F9520647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeH3Fgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:36:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:9350 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbeH3Fgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:36:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 18:37:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,305,1531810800"; 
   d="scan'208";a="79442322"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2018 18:36:58 -0700
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
Subject: [PATCH v2 10/12] iommu/vt-d: Add first level page table interface
Date:   Thu, 30 Aug 2018 09:35:22 +0800
Message-Id: <20180830013524.28743-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830013524.28743-1-baolu.lu@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the interfaces to setup or tear down the structures
for first level page table translation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-pasid.c | 89 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  7 +++
 include/linux/intel-iommu.h |  1 +
 3 files changed, 97 insertions(+)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index edcea1d8b9fc..c921426d7b64 100644
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
 static void
 pasid_based_pasid_cache_invalidation(struct intel_iommu *iommu,
 				     int did, int pasid)
@@ -445,6 +466,74 @@ static void tear_down_one_pasid_entry(struct intel_iommu *iommu,
 		pasid_based_dev_iotlb_cache_invalidation(iommu, dev, pasid);
 }
 
+/*
+ * Set up the scalable mode pasid table entry for first only
+ * translation type.
+ */
+int intel_pasid_setup_first_level(struct intel_iommu *iommu,
+				  struct mm_struct *mm,
+				  struct device *dev,
+				  u16 did, int pasid)
+{
+	struct pasid_entry *pte;
+
+	if (!ecap_flts(iommu->ecap)) {
+		pr_err("No first level translation support on %s\n",
+		       iommu->name);
+		return -EINVAL;
+	}
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte))
+		return -EINVAL;
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
+	pasid_set_domain_id(pte, did);
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
+	if (cap_caching_mode(iommu->cap)) {
+		pasid_based_pasid_cache_invalidation(iommu, did, pasid);
+		pasid_based_iotlb_cache_invalidation(iommu, did, pasid);
+	} else {
+		iommu_flush_write_buffer(iommu);
+	}
+
+	return 0;
+}
+
+/*
+ * Tear down the scalable mode pasid table entry for first only
+ * translation type.
+ */
+void intel_pasid_tear_down_first_level(struct intel_iommu *iommu,
+				       struct device *dev,
+				       u16 did, int pasid)
+{
+	tear_down_one_pasid_entry(iommu, dev, did, pasid);
+}
+
 /*
  * Set up the scalable mode pasid table entry for second only or
  * passthrough translation type.
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 948cd3a25976..ee5ac3d2ac22 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -51,6 +51,13 @@ struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_get_dev_max_id(struct device *dev);
 struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
 void intel_pasid_clear_entry(struct device *dev, int pasid);
+int intel_pasid_setup_first_level(struct intel_iommu *iommu,
+				  struct mm_struct *mm,
+				  struct device *dev,
+				  u16 did, int pasid);
+void intel_pasid_tear_down_first_level(struct intel_iommu *iommu,
+				       struct device *dev,
+				       u16 did, int pasid);
 int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, int pasid,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b28613b472d6..30e2bbfbbd50 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -116,6 +116,7 @@
  */
 
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
+#define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
-- 
2.17.1

