Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0496EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B529B20873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B529B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeK1O6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:58:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:51653 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeK1O6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:58:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 19:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,289,1539673200"; 
   d="scan'208";a="113554386"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga002.fm.intel.com with ESMTP; 27 Nov 2018 19:58:01 -0800
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
Subject: [PATCH v5 06/12] iommu/vt-d: Add second level page table interface
Date:   Wed, 28 Nov 2018 11:54:43 +0800
Message-Id: <20181128035449.10226-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128035449.10226-1-baolu.lu@linux.intel.com>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
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
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c |   2 +-
 drivers/iommu/intel-pasid.c | 280 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |   8 ++
 include/linux/intel-iommu.h |   3 +
 4 files changed, 292 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b521d648db9d..373fda89aaa4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1207,7 +1207,7 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-static void iommu_flush_write_buffer(struct intel_iommu *iommu)
+void iommu_flush_write_buffer(struct intel_iommu *iommu)
 {
 	u32 val;
 	unsigned long flag;
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index aeae209ec1b7..e5f585162a67 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"DMAR: " fmt
 
+#include <linux/bitops.h>
 #include <linux/dmar.h>
 #include <linux/intel-iommu.h>
 #include <linux/iommu.h>
@@ -293,3 +294,282 @@ void intel_pasid_clear_entry(struct device *dev, int pasid)
 
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
+ * Get domain ID value of a scalable mode PASID entry.
+ */
+static inline u16
+pasid_get_domain_id(struct pasid_entry *pe)
+{
+	return (u16)(READ_ONCE(pe->val[1]) & GENMASK_ULL(15, 0));
+}
+
+/*
+ * Setup the SLPTPTR(Second Level Page Table Pointer) field (Bit 12~63)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_slptr(struct pasid_entry *pe, u64 value)
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
+pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
+				    u16 did, int pasid)
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
+iotlb_invalidation_with_pasid(struct intel_iommu *iommu, u16 did, u32 pasid)
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
+devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
+			       struct device *dev, int pasid)
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
+void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
+				 struct device *dev, int pasid)
+{
+	struct pasid_entry *pte;
+	u16 did;
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte))
+		return;
+
+	intel_pasid_clear_entry(dev, pasid);
+	did = pasid_get_domain_id(pte);
+
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
+	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+	iotlb_invalidation_with_pasid(iommu, did, pasid);
+
+	/* Device IOTLB doesn't need to be flushed in caching mode. */
+	if (!cap_caching_mode(iommu->cap))
+		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+}
+
+/*
+ * Set up the scalable mode pasid entry for second only translation type.
+ */
+int intel_pasid_setup_second_level(struct intel_iommu *iommu,
+				   struct dmar_domain *domain,
+				   struct device *dev, int pasid)
+{
+	struct pasid_entry *pte;
+	struct dma_pte *pgd;
+	u64 pgd_val;
+	int agaw;
+	u16 did;
+
+	/*
+	 * If hardware advertises no support for second level
+	 * translation, return directly.
+	 */
+	if (!ecap_slts(iommu->ecap)) {
+		pr_err("No second level translation support on %s\n",
+		       iommu->name);
+		return -EINVAL;
+	}
+
+	/*
+	 * Skip top levels of page tables for iommu which has less agaw
+	 * than default. Unnecessary for PT mode.
+	 */
+	pgd = domain->pgd;
+	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
+		pgd = phys_to_virt(dma_pte_addr(pgd));
+		if (!dma_pte_present(pgd)) {
+			dev_err(dev, "Invalid domain page table\n");
+			return -EINVAL;
+		}
+	}
+
+	pgd_val = virt_to_phys(pgd);
+	did = domain->iommu_did[iommu->seq_id];
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		return -ENODEV;
+	}
+
+	pasid_clear_entry(pte);
+	pasid_set_domain_id(pte, did);
+	pasid_set_slptr(pte, pgd_val);
+	pasid_set_address_width(pte, agaw);
+	pasid_set_translation_type(pte, 2);
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
+		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+		iotlb_invalidation_with_pasid(iommu, did, pasid);
+	} else {
+		iommu_flush_write_buffer(iommu);
+	}
+
+	return 0;
+}
+
+/*
+ * Set up the scalable mode pasid entry for passthrough translation type.
+ */
+int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
+				   struct dmar_domain *domain,
+				   struct device *dev, int pasid)
+{
+	u16 did = FLPT_DEFAULT_DID;
+	struct pasid_entry *pte;
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		return -ENODEV;
+	}
+
+	pasid_clear_entry(pte);
+	pasid_set_domain_id(pte, did);
+	pasid_set_address_width(pte, iommu->agaw);
+	pasid_set_translation_type(pte, 4);
+	pasid_set_fault_enable(pte);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+
+	/*
+	 * We should set SRE bit as well since the addresses are expected
+	 * to be GPAs.
+	 */
+	pasid_set_sre(pte);
+	pasid_set_present(pte);
+
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
+	if (cap_caching_mode(iommu->cap)) {
+		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+		iotlb_invalidation_with_pasid(iommu, did, pasid);
+	} else {
+		iommu_flush_write_buffer(iommu);
+	}
+
+	return 0;
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 03c1612d173c..3c70522091d3 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -49,5 +49,13 @@ struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_get_dev_max_id(struct device *dev);
 struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
 void intel_pasid_clear_entry(struct device *dev, int pasid);
+int intel_pasid_setup_second_level(struct intel_iommu *iommu,
+				   struct dmar_domain *domain,
+				   struct device *dev, int pasid);
+int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
+				   struct dmar_domain *domain,
+				   struct device *dev, int pasid);
+void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
+				 struct device *dev, int pasid);
 
 #endif /* __INTEL_PASID_H */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 08ff588a4df7..cb3ebda47fa7 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -177,6 +177,8 @@
  * Extended Capability Register
  */
 
+#define ecap_smpwc(e)		(((e) >> 48) & 0x1)
+#define ecap_slts(e)		(((e) >> 46) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
@@ -662,6 +664,7 @@ void free_pgtable_page(void *vaddr);
 struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
 int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 				     void *data), void *data);
+void iommu_flush_write_buffer(struct intel_iommu *iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
-- 
2.17.1

