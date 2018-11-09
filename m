Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B441C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4432520827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4432520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeKIUr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:47:27 -0500
Received: from 8bytes.org ([81.169.241.247]:48926 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeKIUr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:47:27 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5089E22F; Fri,  9 Nov 2018 12:07:19 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: [PATCH 1/7] iommu/amd: Collect page-table pages in freelist
Date:   Fri,  9 Nov 2018 12:07:06 +0100
Message-Id: <20181109110712.12469-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Collect all pages that belong to a page-table in a list and
free them after the tree has been traversed. This allows to
implement safer page-table updates in subsequent patches.
Also move the functions for page-table freeing a bit upwards
in the file so that they are usable from the iommu_map() path.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 144 ++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..2655bd91af93 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1317,6 +1317,89 @@ static void domain_flush_devices(struct protection_domain *domain)
  *
  ****************************************************************************/
 
+static void free_page_list(struct page *freelist)
+{
+	while (freelist != NULL) {
+		unsigned long p = (unsigned long)page_address(freelist);
+		freelist = freelist->freelist;
+		free_page(p);
+	}
+}
+
+static struct page *free_pt_page(unsigned long pt, struct page *freelist)
+{
+	struct page *p = virt_to_page((void *)pt);
+
+	p->freelist = freelist;
+
+	return p;
+}
+
+#define DEFINE_FREE_PT_FN(LVL, FN)						\
+static struct page *free_pt_##LVL (unsigned long __pt, struct page *freelist)	\
+{										\
+	unsigned long p;							\
+	u64 *pt;								\
+	int i;									\
+										\
+	pt = (u64 *)__pt;							\
+										\
+	for (i = 0; i < 512; ++i) {						\
+		/* PTE present? */						\
+		if (!IOMMU_PTE_PRESENT(pt[i]))					\
+			continue;						\
+										\
+		/* Large PTE? */						\
+		if (PM_PTE_LEVEL(pt[i]) == 0 ||					\
+		    PM_PTE_LEVEL(pt[i]) == 7)					\
+			continue;						\
+										\
+		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);			\
+		freelist = FN(p, freelist);					\
+	}									\
+										\
+	return free_pt_page((unsigned long)pt, freelist);			\
+}
+
+DEFINE_FREE_PT_FN(l2, free_pt_page)
+DEFINE_FREE_PT_FN(l3, free_pt_l2)
+DEFINE_FREE_PT_FN(l4, free_pt_l3)
+DEFINE_FREE_PT_FN(l5, free_pt_l4)
+DEFINE_FREE_PT_FN(l6, free_pt_l5)
+
+static void free_pagetable(struct protection_domain *domain)
+{
+	unsigned long root = (unsigned long)domain->pt_root;
+	struct page *freelist = NULL;
+
+	switch (domain->mode) {
+	case PAGE_MODE_NONE:
+		break;
+	case PAGE_MODE_1_LEVEL:
+		freelist = free_pt_page(root, freelist);
+		break;
+	case PAGE_MODE_2_LEVEL:
+		freelist = free_pt_l2(root, freelist);
+		break;
+	case PAGE_MODE_3_LEVEL:
+		freelist = free_pt_l3(root, freelist);
+		break;
+	case PAGE_MODE_4_LEVEL:
+		freelist = free_pt_l4(root, freelist);
+		break;
+	case PAGE_MODE_5_LEVEL:
+		freelist = free_pt_l5(root, freelist);
+		break;
+	case PAGE_MODE_6_LEVEL:
+		freelist = free_pt_l6(root, freelist);
+		break;
+	default:
+		BUG();
+	}
+
+	free_page_list(freelist);
+}
+
 /*
  * This function is used to add another level to an IO page table. Adding
  * another level increases the size of the address space by 9 bits to a size up
@@ -1638,67 +1721,6 @@ static void domain_id_free(int id)
 	spin_unlock(&pd_bitmap_lock);
 }
 
-#define DEFINE_FREE_PT_FN(LVL, FN)				\
-static void free_pt_##LVL (unsigned long __pt)			\
-{								\
-	unsigned long p;					\
-	u64 *pt;						\
-	int i;							\
-								\
-	pt = (u64 *)__pt;					\
-								\
-	for (i = 0; i < 512; ++i) {				\
-		/* PTE present? */				\
-		if (!IOMMU_PTE_PRESENT(pt[i]))			\
-			continue;				\
-								\
-		/* Large PTE? */				\
-		if (PM_PTE_LEVEL(pt[i]) == 0 ||			\
-		    PM_PTE_LEVEL(pt[i]) == 7)			\
-			continue;				\
-								\
-		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);	\
-		FN(p);						\
-	}							\
-	free_page((unsigned long)pt);				\
-}
-
-DEFINE_FREE_PT_FN(l2, free_page)
-DEFINE_FREE_PT_FN(l3, free_pt_l2)
-DEFINE_FREE_PT_FN(l4, free_pt_l3)
-DEFINE_FREE_PT_FN(l5, free_pt_l4)
-DEFINE_FREE_PT_FN(l6, free_pt_l5)
-
-static void free_pagetable(struct protection_domain *domain)
-{
-	unsigned long root = (unsigned long)domain->pt_root;
-
-	switch (domain->mode) {
-	case PAGE_MODE_NONE:
-		break;
-	case PAGE_MODE_1_LEVEL:
-		free_page(root);
-		break;
-	case PAGE_MODE_2_LEVEL:
-		free_pt_l2(root);
-		break;
-	case PAGE_MODE_3_LEVEL:
-		free_pt_l3(root);
-		break;
-	case PAGE_MODE_4_LEVEL:
-		free_pt_l4(root);
-		break;
-	case PAGE_MODE_5_LEVEL:
-		free_pt_l5(root);
-		break;
-	case PAGE_MODE_6_LEVEL:
-		free_pt_l6(root);
-		break;
-	default:
-		BUG();
-	}
-}
-
 static void free_gcr3_tbl_level1(u64 *tbl)
 {
 	u64 *ptr;
-- 
2.17.1

