Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88839ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E854204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E854204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbeKEOwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:52:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:13964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbeKEOwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:52:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 21:34:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="105289023"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2018 21:34:47 -0800
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
Subject: [PATCH v4 10/12] iommu/vt-d: Add first level page table interface
Date:   Mon,  5 Nov 2018 13:31:49 +0800
Message-Id: <20181105053151.7173-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105053151.7173-1-baolu.lu@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
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
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-pasid.c | 81 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 11 +++++
 include/linux/intel-iommu.h |  1 +
 3 files changed, 93 insertions(+)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 69530317c323..d8ca1e6a8e5e 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	"DMAR: " fmt
 
 #include <linux/bitops.h>
+#include <linux/cpufeature.h>
 #include <linux/dmar.h>
 #include <linux/intel-iommu.h>
 #include <linux/iommu.h>
@@ -388,6 +389,26 @@ static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
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
@@ -458,6 +479,66 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
+/*
+ * Set up the scalable mode pasid table entry for first only
+ * translation type.
+ */
+int intel_pasid_setup_first_level(struct intel_iommu *iommu,
+				  struct device *dev, pgd_t *pgd,
+				  int pasid, int flags)
+{
+	u16 did = FLPT_DEFAULT_DID;
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
index 55bb8715329d..80db18441b1d 100644
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
+				  int pasid, int flags);
 int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, int pasid);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 0bff03309822..b3f7cabdf6d7 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -152,6 +152,7 @@
  */
 
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
+#define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
-- 
2.17.1

