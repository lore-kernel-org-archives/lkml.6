Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EE720827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EE720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeKIUre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:47:34 -0500
Received: from 8bytes.org ([81.169.241.247]:48986 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbeKIUr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:47:29 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id ECF27527; Fri,  9 Nov 2018 12:07:19 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: [PATCH 5/7] iommu/amd: Restart loop if cmpxchg64 succeeded in alloc_pte()
Date:   Fri,  9 Nov 2018 12:07:10 +0100
Message-Id: <20181109110712.12469-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This makes sure that __pte always contains the correct value
when the pointer to the next page-table level is derived.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6a88ba9321d1..c539b2a59019 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1474,13 +1474,12 @@ static u64 *alloc_pte(struct protection_domain *domain,
 			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
 
 			/* pte could have been changed somewhere. */
-			if (cmpxchg64(pte, __pte, __npte) != __pte) {
+			if (cmpxchg64(pte, __pte, __npte) != __pte)
 				free_page((unsigned long)page);
-				continue;
-			}
-
-			if (pte_level == PAGE_MODE_7_LEVEL)
+			else if (pte_level == PAGE_MODE_7_LEVEL)
 				domain->updated = true;
+
+			continue;
 		}
 
 		/* No level skipping support yet */
@@ -1489,7 +1488,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 
 		level -= 1;
 
-		pte = IOMMU_PTE_PAGE(*pte);
+		pte = IOMMU_PTE_PAGE(__pte);
 
 		if (pte_page && level == end_lvl)
 			*pte_page = pte;
-- 
2.17.1

