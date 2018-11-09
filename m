Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A8DC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE9E20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE9E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeKIUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:47:29 -0500
Received: from 8bytes.org ([81.169.241.247]:48990 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbeKIUr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:47:28 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 46B98547; Fri,  9 Nov 2018 12:07:20 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: [PATCH 7/7] vfio/type1: Remove map_try_harder() code path
Date:   Fri,  9 Nov 2018 12:07:12 +0100
Message-Id: <20181109110712.12469-8-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The AMD IOMMU driver can now map a huge-page where smaller
mappings existed before, so this code-path is no longer
triggered.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/vfio/vfio_iommu_type1.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d9fd3188615d..7651cfb14836 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -978,32 +978,6 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 	return ret;
 }
 
-/*
- * Turns out AMD IOMMU has a page table bug where it won't map large pages
- * to a region that previously mapped smaller pages.  This should be fixed
- * soon, so this is just a temporary workaround to break mappings down into
- * PAGE_SIZE.  Better to map smaller pages than nothing.
- */
-static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
-			  unsigned long pfn, long npage, int prot)
-{
-	long i;
-	int ret = 0;
-
-	for (i = 0; i < npage; i++, pfn++, iova += PAGE_SIZE) {
-		ret = iommu_map(domain->domain, iova,
-				(phys_addr_t)pfn << PAGE_SHIFT,
-				PAGE_SIZE, prot | domain->prot);
-		if (ret)
-			break;
-	}
-
-	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
-		iommu_unmap(domain->domain, iova, PAGE_SIZE);
-
-	return ret;
-}
-
 static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 			  unsigned long pfn, long npage, int prot)
 {
@@ -1013,11 +987,8 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
 				npage << PAGE_SHIFT, prot | d->prot);
-		if (ret) {
-			if (ret != -EBUSY ||
-			    map_try_harder(d, iova, pfn, npage, prot))
-				goto unwind;
-		}
+		if (ret)
+			goto unwind;
 
 		cond_resched();
 	}
-- 
2.17.1

