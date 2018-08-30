Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAD6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6879720647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6879720647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeH3Fgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:36:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:9350 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbeH3Fgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:36:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 18:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,305,1531810800"; 
   d="scan'208";a="79442310"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2018 18:36:55 -0700
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
Subject: [PATCH v2 09/12] iommu/vt-d: Setup context and enable RID2PASID support
Date:   Thu, 30 Aug 2018 09:35:21 +0800
Message-Id: <20180830013524.28743-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830013524.28743-1-baolu.lu@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the translation for requests without PASID in
the scalable mode by setting up the root and context entries.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 109 ++++++++++++++++++++++++++++++------
 drivers/iommu/intel-pasid.h |   1 +
 include/linux/intel-iommu.h |   1 +
 3 files changed, 95 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 33642dd3d6ba..d854b17033a4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1219,6 +1219,8 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 	unsigned long flag;
 
 	addr = virt_to_phys(iommu->root_entry);
+	if (sm_supported(iommu))
+		addr |= DMA_RTADDR_SMT;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	dmar_writeq(iommu->reg + DMAR_RTADDR_REG, addr);
@@ -1940,6 +1942,55 @@ static void domain_exit(struct dmar_domain *domain)
 	free_domain_mem(domain);
 }
 
+/*
+ * Get the PASID directory size for scalable mode context entry.
+ * Value of X in the PDTS field of a scalable mode context entry
+ * indicates PASID directory with 2^(X + 7) entries.
+ */
+static inline unsigned long context_get_sm_pds(struct pasid_table *table)
+{
+	int pds, max_pde;
+
+	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
+	pds = find_first_bit((unsigned long *)&max_pde, MAX_NR_PASID_BITS);
+	if (pds < 7)
+		return 0;
+
+	return pds - 7;
+}
+
+/*
+ * Set the RID_PASID field of a scalable mode context entry. The
+ * IOMMU hardware will use the PASID value set in this field for
+ * DMA translations of DMA requests without PASID.
+ */
+static inline void
+context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
+{
+	context->hi |= pasid & ((1 << 20) - 1);
+}
+
+/*
+ * Set the DTE(Device-TLB Enable) field of a scalable mode context
+ * entry.
+ */
+static inline void context_set_sm_dte(struct context_entry *context)
+{
+	context->lo |= (1 << 2);
+}
+
+/*
+ * Set the PRE(Page Request Enable) field of a scalable mode context
+ * entry.
+ */
+static inline void context_set_sm_pre(struct context_entry *context)
+{
+	context->lo |= (1 << 4);
+}
+
+/* Convert value to context PASID directory size field coding. */
+#define context_pdts(pds)	(((pds) & 0x7) << 9)
+
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
 				      struct pasid_table *table,
@@ -1998,9 +2049,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	}
 
 	pgd = domain->pgd;
-
 	context_clear_entry(context);
-	context_set_domain_id(context, did);
 
 	/*
 	 * Skip top levels of page tables for iommu which has less agaw
@@ -2013,25 +2062,54 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			if (!dma_pte_present(pgd))
 				goto out_unlock;
 		}
+	}
 
-		info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
-		if (info && info->ats_supported)
-			translation = CONTEXT_TT_DEV_IOTLB;
-		else
-			translation = CONTEXT_TT_MULTI_LEVEL;
+	if (sm_supported(iommu)) {
+		unsigned long pds;
+
+		WARN_ON(!table);
+
+		/* Setup the PASID DIR pointer: */
+		pds = context_get_sm_pds(table);
+		context->lo = (u64)virt_to_phys(table->table) |
+				context_pdts(pds);
+
+		/* Setup the RID_PASID field: */
+		context_set_sm_rid2pasid(context, PASID_RID2PASID);
 
-		context_set_address_root(context, virt_to_phys(pgd));
-		context_set_address_width(context, iommu->agaw);
-	} else {
 		/*
-		 * In pass through mode, AW must be programmed to
-		 * indicate the largest AGAW value supported by
-		 * hardware. And ASR is ignored by hardware.
+		 * Setup the Device-TLB enable bit and Page request
+		 * Enable bit:
 		 */
-		context_set_address_width(context, iommu->msagaw);
+		info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
+		if (info && info->ats_supported)
+			context_set_sm_dte(context);
+		if (info && info->pri_supported)
+			context_set_sm_pre(context);
+	} else {
+		context_set_domain_id(context, did);
+
+		if (translation != CONTEXT_TT_PASS_THROUGH) {
+			info = iommu_support_dev_iotlb(domain, iommu,
+						       bus, devfn);
+			if (info && info->ats_supported)
+				translation = CONTEXT_TT_DEV_IOTLB;
+			else
+				translation = CONTEXT_TT_MULTI_LEVEL;
+
+			context_set_address_root(context, virt_to_phys(pgd));
+			context_set_address_width(context, iommu->agaw);
+		} else {
+			/*
+			 * In pass through mode, AW must be programmed to
+			 * indicate the largest AGAW value supported by
+			 * hardware. And ASR is ignored by hardware.
+			 */
+			context_set_address_width(context, iommu->msagaw);
+		}
+		context_set_translation_type(context, translation);
 	}
 
-	context_set_translation_type(context, translation);
 	context_set_fault_enable(context);
 	context_set_present(context);
 	domain_flush_cache(domain, context, sizeof(*context));
@@ -5201,7 +5279,6 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 }
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-#define MAX_NR_PASID_BITS (20)
 static inline unsigned long intel_iommu_get_pts(struct device *dev)
 {
 	int pts, max_pasid;
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index dda578b8f18e..948cd3a25976 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -17,6 +17,7 @@
 #define PASID_PTE_PRESENT		1
 #define PDE_PFN_MASK			PAGE_MASK
 #define PASID_PDE_SHIFT			6
+#define MAX_NR_PASID_BITS		20
 
 /*
  * Domain ID reserved for pasid entries programmed for first-level
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d77d23dfd221..b28613b472d6 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -196,6 +196,7 @@
 
 /* DMA_RTADDR_REG */
 #define DMA_RTADDR_RTT (((u64)1) << 11)
+#define DMA_RTADDR_SMT (((u64)1) << 10)
 
 /* CCMD_REG */
 #define DMA_CCMD_ICC (((u64)1) << 63)
-- 
2.17.1

