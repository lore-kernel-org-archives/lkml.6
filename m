Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392CA208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392CA208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeGPH0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:26:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:45301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeGPH0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:26:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 00:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="72647265"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 00:00:18 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 03/10] iommu/vt-d: Move page table helpers into header
Date:   Mon, 16 Jul 2018 14:49:46 +0800
Message-Id: <1531723793-14607-4-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that they could also be used in other source files.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 43 -------------------------------------------
 include/linux/intel-iommu.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f9036c8..a139a45 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -315,49 +315,6 @@ static inline void context_clear_entry(struct context_entry *context)
 }
 
 /*
- * 0: readable
- * 1: writable
- * 2-6: reserved
- * 7: super page
- * 8-10: available
- * 11: snoop behavior
- * 12-63: Host physcial address
- */
-struct dma_pte {
-	u64 val;
-};
-
-static inline void dma_clear_pte(struct dma_pte *pte)
-{
-	pte->val = 0;
-}
-
-static inline u64 dma_pte_addr(struct dma_pte *pte)
-{
-#ifdef CONFIG_64BIT
-	return pte->val & VTD_PAGE_MASK;
-#else
-	/* Must have a full atomic 64-bit read */
-	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
-#endif
-}
-
-static inline bool dma_pte_present(struct dma_pte *pte)
-{
-	return (pte->val & 3) != 0;
-}
-
-static inline bool dma_pte_superpage(struct dma_pte *pte)
-{
-	return (pte->val & DMA_PTE_LARGE_PAGE);
-}
-
-static inline int first_pte_in_page(struct dma_pte *pte)
-{
-	return !((unsigned long)pte & ~VTD_PAGE_MASK);
-}
-
-/*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
  * 	2. It maps to each iommu if successful.
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4124cd9..7818b1c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -501,6 +501,49 @@ static inline void __iommu_flush_cache(
 		clflush_cache_range(addr, size);
 }
 
+/*
+ * 0: readable
+ * 1: writable
+ * 2-6: reserved
+ * 7: super page
+ * 8-10: available
+ * 11: snoop behavior
+ * 12-63: Host physcial address
+ */
+struct dma_pte {
+	u64 val;
+};
+
+static inline void dma_clear_pte(struct dma_pte *pte)
+{
+	pte->val = 0;
+}
+
+static inline u64 dma_pte_addr(struct dma_pte *pte)
+{
+#ifdef CONFIG_64BIT
+	return pte->val & VTD_PAGE_MASK;
+#else
+	/* Must have a full atomic 64-bit read */
+	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
+#endif
+}
+
+static inline bool dma_pte_present(struct dma_pte *pte)
+{
+	return (pte->val & 3) != 0;
+}
+
+static inline bool dma_pte_superpage(struct dma_pte *pte)
+{
+	return (pte->val & DMA_PTE_LARGE_PAGE);
+}
+
+static inline int first_pte_in_page(struct dma_pte *pte)
+{
+	return !((unsigned long)pte & ~VTD_PAGE_MASK);
+}
+
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
 extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
 
-- 
2.7.4

