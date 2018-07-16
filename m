Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D945AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9195320864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9195320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeGPH0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:26:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:45301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeGPH0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:26:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 00:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="72647274"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 00:00:20 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 04/10] iommu/vt-d: Add second level page table interface
Date:   Mon, 16 Jul 2018 14:49:47 +0800
Message-Id: <1531723793-14607-5-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an interface to setup the structures for second
level page table translation type. This includes the types
of second level translation only and pass through.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-pasid.c | 158 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |   4 ++
 include/linux/intel-iommu.h |   1 +
 3 files changed, 163 insertions(+)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index d6e90cd..da504576 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"DMAR: " fmt
 
+#include <linux/bitops.h>
 #include <linux/dmar.h>
 #include <linux/intel-iommu.h>
 #include <linux/iommu.h>
@@ -291,3 +292,160 @@ void intel_pasid_clear_entry(struct device *dev, int pasid)
 
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
+static inline void
+flush_pasid_cache(struct intel_iommu *iommu, int did, int pasid)
+{
+	struct qi_desc desc;
+
+	desc.high = 0;
+	desc.low = QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
+
+	qi_submit_sync(&desc, iommu);
+}
+
+/*
+ * Set up the scalable mode pasid table entry for second only or
+ * passthrough translation type.
+ */
+void intel_pasid_setup_second_level(struct intel_iommu *iommu,
+				    struct dmar_domain *domain,
+				    struct device *dev, int pasid,
+				    bool pass_through)
+{
+	u16 did = domain->iommu_did[iommu->seq_id];
+	struct pasid_entry *pte;
+	struct dma_pte *pgd;
+	u64 pgd_val;
+	int agaw;
+
+	/*
+	 * Skip top levels of page tables for iommu which has less agaw
+	 * than default.  Unnecessary for PT mode.
+	 */
+	pgd = domain->pgd;
+	if (!pass_through) {
+		for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+			pgd = phys_to_virt(dma_pte_addr(pgd));
+			if (!dma_pte_present(pgd)) {
+				dev_err(dev, "Invalid domain page table\n");
+				return;
+			}
+		}
+	}
+	pgd_val = pass_through ? 0 : virt_to_phys(pgd);
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		return;
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
+	if (cap_caching_mode(iommu->cap))
+		flush_pasid_cache(iommu, did, pasid);
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 12f480c..2fe40ff 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -43,5 +43,9 @@ struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_get_dev_max_id(struct device *dev);
 struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
 void intel_pasid_clear_entry(struct device *dev, int pasid);
+void intel_pasid_setup_second_level(struct intel_iommu *iommu,
+				    struct dmar_domain *domain,
+				    struct device *dev, int pasid,
+				    bool pass_through);
 
 #endif /* __INTEL_PASID_H */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 7818b1c..a20ebca 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -115,6 +115,7 @@
  * Extended Capability Register
  */
 
+#define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
-- 
2.7.4

