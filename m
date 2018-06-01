Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeFAMkD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:40:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeFAMkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:40:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C104760263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org
Cc: toshi.kani@hpe.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v12 5/5] arm64: Allow huge io mappings again
Date: Fri,  1 Jun 2018 18:09:18 +0530
Message-Id: <1527856758-27169-6-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge mappings have had stability issues due to stale
TLB entry and memory leak issues. Since, those are
addressed in this series of patches, it is now safe
to allow huge mappings.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6e7e16c..c65abc4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -934,15 +934,8 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
-	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), sect_prot);
-
-	/* Only allow permission changes for now */
-	if (!pgattr_change_is_safe(READ_ONCE(pud_val(*pudp)),
-				   pud_val(new_pud)))
-		return 0;
-
 	BUG_ON(phys & ~PUD_MASK);
-	set_pud(pudp, new_pud);
+	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 
@@ -950,15 +943,8 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
-	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), sect_prot);
-
-	/* Only allow permission changes for now */
-	if (!pgattr_change_is_safe(READ_ONCE(pmd_val(*pmdp)),
-				   pmd_val(new_pmd)))
-		return 0;
-
 	BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmdp, new_pmd);
+	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
