Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09259C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CC52064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CC52064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLJCDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:03:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:8030 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeLJCDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 21:03:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2018 18:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,336,1539673200"; 
   d="scan'208";a="300767227"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2018 18:03:01 -0800
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
Subject: [PATCH v6 10/12] iommu/vt-d: Add first level page table interface
Date:   Mon, 10 Dec 2018 09:59:04 +0800
Message-Id: <20181210015906.27929-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210015906.27929-1-baolu.lu@linux.intel.com>
References: <20181210015906.27929-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an interface to setup the PASID entries for first
level page table translation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-pasid.c | 80 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 11 +++++
 include/linux/intel-iommu.h |  1 +
 3 files changed, 92 insertions(+)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 6d2b2e87e6fc..c3dcf4dc2496 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	"DMAR: " fmt
 
 #include <linux/bitops.h>
+#include <linux/cpufeature.h>
 #include <linux/dmar.h>
 #include <linux/intel-iommu.h>
 #include <linux/iommu.h>
@@ -389,6 +390,26 @@ static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
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
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 				    u16 did, int pasid)
@@ -459,6 +480,65 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
+/*
+ * Set up the scalable mode pasid table entry for first only
+ * translation type.
+ */
+int intel_pasid_setup_first_level(struct intel_iommu *iommu,
+				  struct device *dev, pgd_t *pgd,
+				  int pasid, u16 did, int flags)
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
+	pasid_set_flptr(pte, (u64)__pa(pgd));
+	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
+		if (!ecap_srs(iommu->ecap)) {
+			pr_err("No supervisor request support on %s\n",
+			       iommu->name);
+			return -EINVAL;
+		}
+		pasid_set_sre(pte);
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
+		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+		iotlb_invalidation_with_pasid(iommu, did, pasid);
+	} else {
+		iommu_flush_write_buffer(iommu);
+	}
+
+	return 0;
+}
+
 /*
  * Set up the scalable mode pasid entry for second only translation type.
  */
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 55bb8715329d..512c63ec8a22 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -25,6 +25,14 @@
  */
 #define FLPT_DEFAULT_DID		1
 
+/*
+ * The SUPERVISOR_MODE flag indicates a first level translation which
+ * can be used for access to kernel addresses. It is valid only for
+ * access to the kernel's static 1:1 mapping of physical memory — not
+ * to vmalloc or even module mappings.
+ */
+#define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
+
 struct pasid_dir_entry {
 	u64 val;
 };
@@ -51,6 +59,9 @@ struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_get_dev_max_id(struct device *dev);
 struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
 void intel_pasid_clear_entry(struct device *dev, int pasid);
+int intel_pasid_setup_first_level(struct intel_iommu *iommu,
+				  struct device *dev, pgd_t *pgd,
+				  int pasid, u16 did, int flags);
 int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, int pasid);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 5fdd33ed2cce..4ad62396e81e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -178,6 +178,7 @@
  */
 
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
+#define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
-- 
2.17.1

