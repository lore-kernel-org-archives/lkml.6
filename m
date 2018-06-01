Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeFAMj4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:39:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeFAMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:39:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 518D860263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org
Cc: toshi.kani@hpe.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>,
        Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <joro@8bytes.org>, <stable@vger.kernel.org>
Subject: [PATCH v12 1/5] ioremap: Update pgtable free interfaces with addr
Date: Fri,  1 Jun 2018 18:09:14 +0530
Message-Id: <1527856758-27169-2-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chintan Pandya <cpandya@codeaurora.org>

The following kernel panic was observed on ARM64 platform due to a stale
TLB entry.

 1. ioremap with 4K size, a valid pte page table is set.
 2. iounmap it, its pte entry is set to 0.
 3. ioremap the same address with 2M size, update its pmd entry with
    a new value.
 4. CPU may hit an exception because the old pmd entry is still in TLB,
    which leads to a kernel panic.

Commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
table") has addressed this panic by falling to pte mappings in the above
case on ARM64.

To support pmd mappings in all cases, TLB purge needs to be performed
in this case on ARM64.

Add a new arg, 'addr', to pud_free_pmd_page() and pmd_free_pte_page()
so that TLB purge can be added later in seprate patches.

[toshi@hpe.com: merge changes, rewrite patch description]
Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: <stable@vger.kernel.org>

---
 arch/arm64/mm/mmu.c           | 4 ++--
 arch/x86/mm/pgtable.c         | 8 +++++---
 include/asm-generic/pgtable.h | 8 ++++----
 lib/ioremap.c                 | 4 ++--
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 493ff75..8ae5d7a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -977,12 +977,12 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return pud_none(*pud);
 }
 
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return pmd_none(*pmd);
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ffc8c13..37e3cba 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -718,11 +718,12 @@ int pmd_clear_huge(pmd_t *pmd)
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
  * @pud: Pointer to a PUD.
+ * @addr: Virtual address associated with pud.
  *
  * Context: The pud range has been unmaped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	pmd_t *pmd;
 	int i;
@@ -733,7 +734,7 @@ int pud_free_pmd_page(pud_t *pud)
 	pmd = (pmd_t *)pud_page_vaddr(*pud);
 
 	for (i = 0; i < PTRS_PER_PMD; i++)
-		if (!pmd_free_pte_page(&pmd[i]))
+		if (!pmd_free_pte_page(&pmd[i], addr + (i * PMD_SIZE)))
 			return 0;
 
 	pud_clear(pud);
@@ -745,11 +746,12 @@ int pud_free_pmd_page(pud_t *pud)
 /**
  * pmd_free_pte_page - Clear pmd entry and free pte page.
  * @pmd: Pointer to a PMD.
+ * @addr: Virtual address associated with pmd.
  *
  * Context: The pmd range has been unmaped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	pte_t *pte;
 
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index f59639a..b081794 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1019,8 +1019,8 @@ static inline int p4d_clear_huge(p4d_t *p4d)
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
-int pud_free_pmd_page(pud_t *pud);
-int pmd_free_pte_page(pmd_t *pmd);
+int pud_free_pmd_page(pud_t *pud, unsigned long addr);
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 {
@@ -1046,11 +1046,11 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 {
 	return 0;
 }
-static inline int pud_free_pmd_page(pud_t *pud)
+static inline int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return 0;
 }
-static inline int pmd_free_pte_page(pmd_t *pmd)
+static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return 0;
 }
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 54e5bba..517f585 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -92,7 +92,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 		if (ioremap_pmd_enabled() &&
 		    ((next - addr) == PMD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
-		    pmd_free_pte_page(pmd)) {
+		    pmd_free_pte_page(pmd, addr)) {
 			if (pmd_set_huge(pmd, phys_addr + addr, prot))
 				continue;
 		}
@@ -119,7 +119,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 		if (ioremap_pud_enabled() &&
 		    ((next - addr) == PUD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
-		    pud_free_pmd_page(pud)) {
+		    pud_free_pmd_page(pud, addr)) {
 			if (pud_set_huge(pud, phys_addr + addr, prot))
 				continue;
 		}
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
