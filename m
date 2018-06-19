Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E420C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE72320661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE72320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756091AbeFSF1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:27:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:14970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755984AbeFSF1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:27:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 22:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="50424343"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 22:27:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 9/9] iommu/vt-d: Remove the obsolete per iommu pasid tables
Date:   Tue, 19 Jun 2018 13:17:29 +0800
Message-Id: <1529385449-25649-10-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
References: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The obsolete per iommu pasid tables are no longer used. Hence,
clean up them.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c |  6 +++---
 drivers/iommu/intel-svm.c   | 17 ++---------------
 include/linux/intel-iommu.h |  5 ++---
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b0651a2..0703ca3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1741,7 +1741,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	if (pasid_enabled(iommu)) {
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
-		intel_svm_free_pasid_tables(iommu);
+		intel_svm_exit(iommu);
 	}
 #endif
 }
@@ -3322,7 +3322,7 @@ static int __init init_dmars(void)
 			hw_pass_through = 0;
 #ifdef CONFIG_INTEL_IOMMU_SVM
 		if (pasid_enabled(iommu))
-			intel_svm_alloc_pasid_tables(iommu);
+			intel_svm_init(iommu);
 #endif
 	}
 
@@ -4285,7 +4285,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	if (pasid_enabled(iommu))
-		intel_svm_alloc_pasid_tables(iommu);
+		intel_svm_init(iommu);
 #endif
 
 	if (dmaru->ignored) {
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a253cde..eb30836 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -38,7 +38,7 @@ struct pasid_state_entry {
 	u64 val;
 };
 
-int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
+int intel_svm_init(struct intel_iommu *iommu)
 {
 	struct page *pages;
 	int order;
@@ -63,15 +63,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 		iommu->pasid_max = 0x20000;
 
 	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
-	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!pages) {
-		pr_warn("IOMMU: %s: Failed to allocate PASID table\n",
-			iommu->name);
-		return -ENOMEM;
-	}
-	iommu->pasid_table = page_address(pages);
-	pr_info("%s: Allocated order %d PASID table.\n", iommu->name, order);
-
 	if (ecap_dis(iommu->ecap)) {
 		/* Just making it explicit... */
 		BUILD_BUG_ON(sizeof(struct pasid_entry) != sizeof(struct pasid_state_entry));
@@ -86,14 +77,10 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 	return 0;
 }
 
-int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
+int intel_svm_exit(struct intel_iommu *iommu)
 {
 	int order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
 
-	if (iommu->pasid_table) {
-		free_pages((unsigned long)iommu->pasid_table, order);
-		iommu->pasid_table = NULL;
-	}
 	if (iommu->pasid_state_table) {
 		free_pages((unsigned long)iommu->pasid_state_table, order);
 		iommu->pasid_state_table = NULL;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8ec22b3..8051bc5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -458,7 +458,6 @@ struct intel_iommu {
 	 * devices away to userspace processes (e.g. for DPDK) and don't
 	 * want to trust that userspace will use *only* the PASID it was
 	 * told to. But while it's all driver-arbitrated, we're fine. */
-	struct pasid_entry *pasid_table;
 	struct pasid_state_entry *pasid_state_table;
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
@@ -531,8 +530,8 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 				     void *data), void *data);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
-extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
+int intel_svm_init(struct intel_iommu *iommu);
+int intel_svm_exit(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 
-- 
2.7.4

