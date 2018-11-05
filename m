Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BBDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03C6204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03C6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeKEOwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:52:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:13964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeKEOwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:52:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 21:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="105289016"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2018 21:34:44 -0800
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
Subject: [PATCH v4 09/12] iommu/vt-d: Setup context and enable RID2PASID support
Date:   Mon,  5 Nov 2018 13:31:48 +0800
Message-Id: <20181105053151.7173-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105053151.7173-1-baolu.lu@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
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
index a761c0aa3438..9c5e0d5530a2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1194,6 +1194,8 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 	unsigned long flag;
 
 	addr = virt_to_phys(iommu->root_entry);
+	if (sm_supported(iommu))
+		addr |= DMA_RTADDR_SMT;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	dmar_writeq(iommu->reg + DMAR_RTADDR_REG, addr);
@@ -1915,6 +1917,55 @@ static void domain_exit(struct dmar_domain *domain)
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
@@ -1973,9 +2024,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	}
 
 	pgd = domain->pgd;
-
 	context_clear_entry(context);
-	context_set_domain_id(context, did);
 
 	/*
 	 * Skip top levels of page tables for iommu which has less agaw
@@ -1988,25 +2037,54 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
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
@@ -5175,7 +5253,6 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 }
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-#define MAX_NR_PASID_BITS (20)
 static inline unsigned long intel_iommu_get_pts(struct device *dev)
 {
 	int pts, max_pasid;
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index d6f4fead4491..55bb8715329d 100644
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
index d83908420a83..0bff03309822 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -232,6 +232,7 @@
 
 /* DMA_RTADDR_REG */
 #define DMA_RTADDR_RTT (((u64)1) << 11)
+#define DMA_RTADDR_SMT (((u64)1) << 10)
 
 /* CCMD_REG */
 #define DMA_CCMD_ICC (((u64)1) << 63)
-- 
2.17.1

