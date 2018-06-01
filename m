Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeFAMkA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:40:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeFAMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:39:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A22E2606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org
Cc: toshi.kani@hpe.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v12 4/5] arm64: Implement page table free interfaces
Date: Fri,  1 Jun 2018 18:09:17 +0530
Message-Id: <1527856758-27169-5-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement pud_free_pmd_page() and pmd_free_pte_page().

Implementation requires,
 1) Clearing off the current pud/pmd entry
 2) Invalidate TLB which could have previously
    valid but not stale entry
 3) Freeing of the un-used next level page tables

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8ae5d7a..6e7e16c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -45,6 +45,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/tlbflush.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -977,12 +978,41 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
-int pud_free_pmd_page(pud_t *pud, unsigned long addr)
+int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 {
-	return pud_none(*pud);
+	pte_t *table;
+	pmd_t pmd;
+
+	pmd = READ_ONCE(*pmdp);
+	if (pmd_present(pmd)) {
+		table = pmd_page_vaddr(pmd);
+		pmd_clear(pmdp);
+		__flush_tlb_kernel_pgtable(addr);
+		pte_free_kernel(NULL, table);
+	}
+	return 1;
 }
 
-int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
+int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 {
-	return pmd_none(*pmd);
+	pmd_t *table;
+	pmd_t *entry;
+	pud_t pud;
+	unsigned long next, end;
+
+	pud = READ_ONCE(*pudp);
+	if (pud_present(pud)) {
+		table = pud_page_vaddr(pud);
+		entry = table;
+		next = addr;
+		end = addr + PUD_SIZE;
+		do {
+			pmd_free_pte_page(entry, next);
+		} while (entry++, next += PMD_SIZE, next != end);
+
+		pud_clear(pudp);
+		__flush_tlb_kernel_pgtable(addr);
+		pmd_free(NULL, table);
+	}
+	return 1;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
