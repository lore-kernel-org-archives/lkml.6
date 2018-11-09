Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033C6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C897920827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C897920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeKIUro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:47:44 -0500
Received: from 8bytes.org ([81.169.241.247]:48988 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbeKIUr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:47:28 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1F032533; Fri,  9 Nov 2018 12:07:20 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: [PATCH 6/7] iommu/amd: Allow to upgrade page-size
Date:   Fri,  9 Nov 2018 12:07:11 +0100
Message-Id: <20181109110712.12469-7-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Before this patch the iommu_map_page() function failed when
it tried to map a huge-page where smaller mappings existed
before.

With this change the page-table pages of the old mappings
are teared down, so that the huge-page can be mapped.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c539b2a59019..71797b3d67e5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1557,6 +1557,25 @@ static u64 *fetch_pte(struct protection_domain *domain,
 	return pte;
 }
 
+static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
+{
+	unsigned long pt;
+	int mode;
+
+	while (cmpxchg64(pte, pteval, 0) != pteval) {
+		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
+		pteval = *pte;
+	}
+
+	if (!IOMMU_PTE_PRESENT(pteval))
+		return freelist;
+
+	pt   = (unsigned long)IOMMU_PTE_PAGE(pteval);
+	mode = IOMMU_PTE_MODE(pteval);
+
+	return free_sub_pt(pt, mode, freelist);
+}
+
 /*
  * Generic mapping functions. It maps a physical address into a DMA
  * address space. It allocates the page table pages if necessary.
@@ -1571,6 +1590,7 @@ static int iommu_map_page(struct protection_domain *dom,
 			  int prot,
 			  gfp_t gfp)
 {
+	struct page *freelist = NULL;
 	u64 __pte, *pte;
 	int i, count;
 
@@ -1587,8 +1607,10 @@ static int iommu_map_page(struct protection_domain *dom,
 		return -ENOMEM;
 
 	for (i = 0; i < count; ++i)
-		if (IOMMU_PTE_PRESENT(pte[i]))
-			return -EBUSY;
+		freelist = free_clear_pte(&pte[i], pte[i], freelist);
+
+	if (freelist != NULL)
+		dom->updated = true;
 
 	if (count > 1) {
 		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
@@ -1606,6 +1628,9 @@ static int iommu_map_page(struct protection_domain *dom,
 
 	update_domain(dom);
 
+	/* Everything flushed out, free pages now */
+	free_page_list(freelist);
+
 	return 0;
 }
 
-- 
2.17.1

