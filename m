Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A9AC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B595B2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B595B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeLJCCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:02:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:8030 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbeLJCCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 21:02:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2018 18:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,336,1539673200"; 
   d="scan'208";a="300767157"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2018 18:02:43 -0800
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
Subject: [PATCH v6 03/12] iommu/vt-d: Move page table helpers into header
Date:   Mon, 10 Dec 2018 09:58:57 +0800
Message-Id: <20181210015906.27929-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210015906.27929-1-baolu.lu@linux.intel.com>
References: <20181210015906.27929-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that they could also be used in other source files.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel-iommu.c | 43 -------------------------------------
 include/linux/intel-iommu.h | 43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 73d7c15bf737..52cdb0e077f2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -290,49 +290,6 @@ static inline void context_clear_entry(struct context_entry *context)
 	context->hi = 0;
 }
 
-/*
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
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8c9b6063d275..b4da61385ebf 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -590,6 +590,49 @@ static inline void __iommu_flush_cache(
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
2.17.1

