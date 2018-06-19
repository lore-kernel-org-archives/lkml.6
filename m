Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C096CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0CB20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0CB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756178AbeFSF2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:28:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:14970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755871AbeFSF1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:27:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 22:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="50424320"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 22:27:21 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 4/9] iommu/vt-d: Move device_domain_info to header
Date:   Tue, 19 Jun 2018 13:17:24 +0800
Message-Id: <1529385449-25649-5-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
References: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the per device iommu data and some helpers to be
used in other files.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 62 +++--------------------------------------
 include/linux/intel-iommu.h | 68 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3653ebc..d9a8222 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -381,60 +381,6 @@ static int hw_pass_through = 1;
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
 
-struct dmar_domain {
-	int	nid;			/* node id */
-
-	unsigned	iommu_refcnt[DMAR_UNITS_SUPPORTED];
-					/* Refcount of devices per iommu */
-
-
-	u16		iommu_did[DMAR_UNITS_SUPPORTED];
-					/* Domain ids per IOMMU. Use u16 since
-					 * domain ids are 16 bit wide according
-					 * to VT-d spec, section 9.3 */
-
-	bool has_iotlb_device;
-	struct list_head devices;	/* all devices' list */
-	struct iova_domain iovad;	/* iova's that belong to this domain */
-
-	struct dma_pte	*pgd;		/* virtual address */
-	int		gaw;		/* max guest address width */
-
-	/* adjusted guest address width, 0 is level 2 30-bit */
-	int		agaw;
-
-	int		flags;		/* flags to find out type of domain */
-
-	int		iommu_coherency;/* indicate coherency of iommu access */
-	int		iommu_snooping; /* indicate snooping control feature*/
-	int		iommu_count;	/* reference count of iommu */
-	int		iommu_superpage;/* Level of superpages supported:
-					   0 == 4KiB (no superpages), 1 == 2MiB,
-					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
-	u64		max_addr;	/* maximum mapped address */
-
-	struct iommu_domain domain;	/* generic domain data structure for
-					   iommu core */
-};
-
-/* PCI domain-device relationship */
-struct device_domain_info {
-	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
-	u8 bus;			/* PCI bus number */
-	u8 devfn;		/* PCI devfn number */
-	u8 pasid_supported:3;
-	u8 pasid_enabled:1;
-	u8 pri_supported:1;
-	u8 pri_enabled:1;
-	u8 ats_supported:1;
-	u8 ats_enabled:1;
-	u8 ats_qdep;
-	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
-	struct intel_iommu *iommu; /* IOMMU used by this device */
-	struct dmar_domain *domain; /* pointer to domain */
-};
-
 struct dmar_rmrr_unit {
 	struct list_head list;		/* list of rmrr units	*/
 	struct acpi_dmar_header *hdr;	/* ACPI header		*/
@@ -603,7 +549,7 @@ static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
 		domains[did & 0xff] = domain;
 }
 
-static inline void *alloc_pgtable_page(int node)
+void *alloc_pgtable_page(int node)
 {
 	struct page *page;
 	void *vaddr = NULL;
@@ -614,7 +560,7 @@ static inline void *alloc_pgtable_page(int node)
 	return vaddr;
 }
 
-static inline void free_pgtable_page(void *vaddr)
+void free_pgtable_page(void *vaddr)
 {
 	free_page((unsigned long)vaddr);
 }
@@ -697,7 +643,7 @@ int iommu_calculate_agaw(struct intel_iommu *iommu)
 }
 
 /* This functionin only returns single iommu in a domain */
-static struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
+struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 {
 	int iommu_id;
 
@@ -3512,7 +3458,7 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	return iova_pfn;
 }
 
-static struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
+struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 {
 	struct dmar_domain *domain, *tmp;
 	struct dmar_rmrr_unit *rmrr;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 0cfac9d..3598dc0f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -31,6 +31,7 @@
 #include <linux/list.h>
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/dmar.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -384,6 +385,50 @@ struct pasid_entry;
 struct pasid_state_entry;
 struct page_req_dsc;
 
+struct dmar_domain {
+	int	nid;			/* node id */
+
+	unsigned int	iommu_refcnt[DMAR_UNITS_SUPPORTED];
+					/* Refcount of devices per iommu */
+
+	u16		iommu_did[DMAR_UNITS_SUPPORTED];
+					/*
+					 * Domain ids per IOMMU. Use u16 since
+					 * domain ids are 16 bit wide according
+					 * to VT-d spec, section 9.3
+					 */
+
+	bool has_iotlb_device;
+	struct list_head devices;	/* all devices' list */
+	struct iova_domain iovad;	/* iova's that belong to this domain */
+
+	struct dma_pte	*pgd;		/* virtual address */
+	int		gaw;		/* max guest address width */
+
+	int		agaw;		/*
+					 * adjusted guest address width,
+					 * 0 is level 2 30-bit
+					 */
+
+	int		flags;		/* flags to find out type of domain */
+
+	int		iommu_coherency;/* indicate coherency of iommu access */
+	int		iommu_snooping; /* indicate snooping control feature*/
+	int		iommu_count;	/* reference count of iommu */
+	int		iommu_superpage;/*
+					 * Level of superpages supported:
+					 *  0 == 4KiB (no superpages),
+					 *  1 == 2MiB, 2 == 1GiB,
+					 *  3 == 512GiB, 4 == 1TiB
+					 */
+	u64		max_addr;	/* maximum mapped address */
+
+	struct iommu_domain domain;	/*
+					 * generic domain data structure for
+					 * iommu core
+					 */
+};
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -432,6 +477,24 @@ struct intel_iommu {
 	u32		flags;      /* Software defined flags */
 };
 
+/* PCI domain-device relationship */
+struct device_domain_info {
+	struct list_head link;	/* link to domain siblings */
+	struct list_head global; /* link to global list */
+	u8 bus;			/* PCI bus number */
+	u8 devfn;		/* PCI devfn number */
+	u8 pasid_supported:3;
+	u8 pasid_enabled:1;
+	u8 pri_supported:1;
+	u8 pri_enabled:1;
+	u8 ats_supported:1;
+	u8 ats_enabled:1;
+	u8 ats_qdep;
+	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
+	struct intel_iommu *iommu; /* IOMMU used by this device */
+	struct dmar_domain *domain; /* pointer to domain */
+};
+
 static inline void __iommu_flush_cache(
 	struct intel_iommu *iommu, void *addr, int size)
 {
@@ -458,6 +521,11 @@ extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
 
+struct dmar_domain *get_valid_domain_for_dev(struct device *dev);
+void *alloc_pgtable_page(int node);
+void free_pgtable_page(void *vaddr);
+struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
 extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
-- 
2.7.4

