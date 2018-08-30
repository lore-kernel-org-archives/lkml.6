Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB085C04ABC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A8320647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A8320647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeH3Fg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:36:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:9350 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeH3Fg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:36:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 18:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,305,1531810800"; 
   d="scan'208";a="79442273"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2018 18:36:47 -0700
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
Subject: [PATCH v2 06/12] iommu/vt-d: Add second level page table interface
Date:   Thu, 30 Aug 2018 09:35:18 +0800
Message-Id: <20180830013524.28743-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830013524.28743-1-baolu.lu@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the interfaces to setup or tear down the structures
for second level page table translations. This includes types
of second level only translation and pass through.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c |   2 +-
 drivers/iommu/intel-pasid.c | 246 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |   7 +
 include/linux/intel-iommu.h |   3 +
 4 files changed, 257 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 562da10bf93e..de6b909bb47a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1232,7 +1232,7 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-static void iommu_flush_write_buffer(struct intel_iommu *iommu)
+void iommu_flush_write_buffer(struct intel_iommu *iommu)
 {
 	u32 val;
 	unsigned long flag;
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index d6e90cd5b062..edcea1d8b9fc 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"DMAR: " fmt
 
+#include <linux/bitops.h>
 #include <linux/dmar.h>
 #include <linux/intel-iommu.h>
 #include <linux/iommu.h>
@@ -291,3 +292,248 @@ void intel_pasid_clear_entry(struct device *dev, int pasid)
 
 	pasid_clear_entry(pe);
 }
+
+static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
+{
+	u64 old;
+
+	old = READ_ONCE(*ptr);
+	WRITE_ONCE(*ptr, (old & ~mask) | bits);
+}
+
+/*
+ * Setup the DID(Domain Identifier) field (Bit 64~79) of scalable mode
+ * PASID entry.
+ */
+static inline void
+pasid_set_domain_id(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[1], GENMASK_ULL(15, 0), value);
+}
+
+/*
+ * Setup the SLPTPTR(Second Level Page Table Pointer) field (Bit 12~63)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_address_root(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[0], VTD_PAGE_MASK, value);
+}
+
+/*
+ * Setup the AW(Address Width) field (Bit 2~4) of a scalable mode PASID
+ * entry.
+ */
+static inline void
+pasid_set_address_width(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[0], GENMASK_ULL(4, 2), value << 2);
+}
+
+/*
+ * Setup the PGTT(PASID Granular Translation Type) field (Bit 6~8)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_translation_type(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[0], GENMASK_ULL(8, 6), value << 6);
+}
+
+/*
+ * Enable fault processing by clearing the FPD(Fault Processing
+ * Disable) field (Bit 1) of a scalable mode PASID entry.
+ */
+static inline void pasid_set_fault_enable(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[0], 1 << 1, 0);
+}
+
+/*
+ * Setup the SRE(Supervisor Request Enable) field (Bit 128) of a
+ * scalable mode PASID entry.
+ */
+static inline void pasid_set_sre(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 0, 1);
+}
+
+/*
+ * Setup the P(Present) field (Bit 0) of a scalable mode PASID
+ * entry.
+ */
+static inline void pasid_set_present(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[0], 1 << 0, 1);
+}
+
+/*
+ * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
+ * entry.
+ */
+static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
+{
+	pasid_set_bits(&pe->val[1], 1 << 23, value);
+}
+
+static void
+pasid_based_pasid_cache_invalidation(struct intel_iommu *iommu,
+				     int did, int pasid)
+{
+	struct qi_desc desc;
+
+	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
+	desc.qw1 = 0;
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	qi_submit_sync(&desc, iommu);
+}
+
+static void
+pasid_based_iotlb_cache_invalidation(struct intel_iommu *iommu,
+				     u16 did, u32 pasid)
+{
+	struct qi_desc desc;
+
+	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
+			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) | QI_EIOTLB_TYPE;
+	desc.qw1 = 0;
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	qi_submit_sync(&desc, iommu);
+}
+
+static void
+pasid_based_dev_iotlb_cache_invalidation(struct intel_iommu *iommu,
+					 struct device *dev, int pasid)
+{
+	struct device_domain_info *info;
+	u16 sid, qdep, pfsid;
+
+	info = dev->archdata.iommu;
+	if (!info || !info->ats_enabled)
+		return;
+
+	sid = info->bus << 8 | info->devfn;
+	qdep = info->ats_qdep;
+	pfsid = info->pfsid;
+
+	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+}
+
+static void tear_down_one_pasid_entry(struct intel_iommu *iommu,
+				      struct device *dev, u16 did,
+				      int pasid)
+{
+	struct pasid_entry *pte;
+
+	intel_pasid_clear_entry(dev, pasid);
+
+	if (!ecap_coherent(iommu->ecap)) {
+		pte = intel_pasid_get_entry(dev, pasid);
+		clflush_cache_range(pte, sizeof(*pte));
+	}
+
+	pasid_based_pasid_cache_invalidation(iommu, did, pasid);
+	pasid_based_iotlb_cache_invalidation(iommu, did, pasid);
+
+	/* Device IOTLB doesn't need to be flushed in caching mode. */
+	if (!cap_caching_mode(iommu->cap))
+		pasid_based_dev_iotlb_cache_invalidation(iommu, dev, pasid);
+}
+
+/*
+ * Set up the scalable mode pasid table entry for second only or
+ * passthrough translation type.
+ */
+int intel_pasid_setup_second_level(struct intel_iommu *iommu,
+				   struct dmar_domain *domain,
+				   struct device *dev, int pasid,
+				   bool pass_through)
+{
+	struct pasid_entry *pte;
+	struct dma_pte *pgd;
+	u64 pgd_val;
+	int agaw;
+	u16 did;
+
+	/*
+	 * If hardware advertises no support for second level translation,
+	 * we only allow pass through translation setup.
+	 */
+	if (!(ecap_slts(iommu->ecap) || pass_through)) {
+		pr_err("No first level translation support on %s, only pass-through mode allowed\n",
+		       iommu->name);
+		return -EINVAL;
+	}
+
+	/*
+	 * Skip top levels of page tables for iommu which has less agaw
+	 * than default. Unnecessary for PT mode.
+	 */
+	pgd = domain->pgd;
+	if (!pass_through) {
+		for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+			pgd = phys_to_virt(dma_pte_addr(pgd));
+			if (!dma_pte_present(pgd)) {
+				dev_err(dev, "Invalid domain page table\n");
+				return -EINVAL;
+			}
+		}
+	}
+	pgd_val = pass_through ? 0 : virt_to_phys(pgd);
+	did = pass_through ? FLPT_DEFAULT_DID :
+			domain->iommu_did[iommu->seq_id];
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		return -ENODEV;
+	}
+
+	pasid_clear_entry(pte);
+	pasid_set_domain_id(pte, did);
+
+	if (!pass_through)
+		pasid_set_address_root(pte, pgd_val);
+
+	pasid_set_address_width(pte, iommu->agaw);
+	pasid_set_translation_type(pte, pass_through ? 4 : 2);
+	pasid_set_fault_enable(pte);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+
+	/*
+	 * Since it is a second level only translation setup, we should
+	 * set SRE bit as well (addresses are expected to be GPAs).
+	 */
+	pasid_set_sre(pte);
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
+ * Tear down the scalable mode pasid table entry for second only or
+ * passthrough translation type.
+ */
+void intel_pasid_tear_down_second_level(struct intel_iommu *iommu,
+					struct dmar_domain *domain,
+					struct device *dev, int pasid)
+{
+	u16 did = domain->iommu_did[iommu->seq_id];
+
+	tear_down_one_pasid_entry(iommu, dev, did, pasid);
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 03c1612d173c..85b158a1826a 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -49,5 +49,12 @@ struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_get_dev_max_id(struct device *dev);
 struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
 void intel_pasid_clear_entry(struct device *dev, int pasid);
+int intel_pasid_setup_second_level(struct intel_iommu *iommu,
+				   struct dmar_domain *domain,
+				   struct device *dev, int pasid,
+				   bool pass_through);
+void intel_pasid_tear_down_second_level(struct intel_iommu *iommu,
+					struct dmar_domain *domain,
+					struct device *dev, int pasid);
 
 #endif /* __INTEL_PASID_H */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 72aff482b293..d77d23dfd221 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -115,6 +115,8 @@
  * Extended Capability Register
  */
 
+#define ecap_smpwc(e)		(((e) >> 48) & 0x1)
+#define ecap_slts(e)		(((e) >> 46) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
@@ -571,6 +573,7 @@ void free_pgtable_page(void *vaddr);
 struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
 int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 				     void *data), void *data);
+void iommu_flush_write_buffer(struct intel_iommu *iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
-- 
2.17.1

