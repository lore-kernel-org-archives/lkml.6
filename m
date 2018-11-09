Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D0EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82CA20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82CA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeKIUsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:48:12 -0500
Received: from 8bytes.org ([81.169.241.247]:48966 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbeKIUr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:47:27 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C80C14EB; Fri,  9 Nov 2018 12:07:19 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: [PATCH 4/7] iommu/amd: Allow downgrading page-sizes in alloc_pte()
Date:   Fri,  9 Nov 2018 12:07:09 +0100
Message-Id: <20181109110712.12469-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Before this patch it was not possible the downgrade a
mapping established with page-mode 7 to a mapping using
smaller page-sizes, because the pte_level != level check
prevented that.

Treat page-mode 7 like a non-present mapping and allow to
overwrite it in alloc_pte().

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 49b5d3115e56..6a88ba9321d1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1460,10 +1460,13 @@ static u64 *alloc_pte(struct protection_domain *domain,
 
 	while (level > end_lvl) {
 		u64 __pte, __npte;
+		int pte_level;
 
-		__pte = *pte;
+		__pte     = *pte;
+		pte_level = PM_PTE_LEVEL(__pte);
 
-		if (!IOMMU_PTE_PRESENT(__pte)) {
+		if (!IOMMU_PTE_PRESENT(__pte) ||
+		    pte_level == PAGE_MODE_7_LEVEL) {
 			page = (u64 *)get_zeroed_page(gfp);
 			if (!page)
 				return NULL;
@@ -1475,10 +1478,13 @@ static u64 *alloc_pte(struct protection_domain *domain,
 				free_page((unsigned long)page);
 				continue;
 			}
+
+			if (pte_level == PAGE_MODE_7_LEVEL)
+				domain->updated = true;
 		}
 
 		/* No level skipping support yet */
-		if (PM_PTE_LEVEL(*pte) != level)
+		if (pte_level != level)
 			return NULL;
 
 		level -= 1;
-- 
2.17.1

