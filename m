Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934040AbeCGRr7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:47:59 -0500
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:54233 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932905AbeCGRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:47:38 -0500
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bp@suse.de, catalin.marinas@arm.com
Cc: guohanjun@huawei.com, will.deacon@arm.com, wxf.wang@hisilicon.com,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 2/2] x86/mm: implement free pmd/pte page interfaces
Date: Wed,  7 Mar 2018 11:32:27 -0700
Message-Id: <20180307183227.17983-3-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180307183227.17983-1-toshi.kani@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
clear a given pud/pmd entry and free up lower level page table(s).
Address range associated with the pud/pmd entry must have been purged
by INVLPG.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
---
 arch/x86/mm/pgtable.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 942f4fa341f1..121c0114439e 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -710,7 +710,22 @@ int pmd_clear_huge(pmd_t *pmd)
  */
 int pud_free_pmd_page(pud_t *pud)
 {
-	return pud_none(*pud);
+	pmd_t *pmd;
+	int i;
+
+	if (pud_none(*pud))
+		return 1;
+
+	pmd = (pmd_t *)pud_page_vaddr(*pud);
+
+	for (i = 0; i < PTRS_PER_PMD; i++)
+		if (!pmd_free_pte_page(&pmd[i]))
+			return 0;
+
+	pud_clear(pud);
+	free_page((unsigned long)pmd);
+
+	return 1;
 }
 
 /**
@@ -720,6 +735,15 @@ int pud_free_pmd_page(pud_t *pud)
  */
 int pmd_free_pte_page(pmd_t *pmd)
 {
-	return pmd_none(*pmd);
+	pte_t *pte;
+
+	if (pmd_none(*pmd))
+		return 1;
+
+	pte = (pte_t *)pmd_page_vaddr(*pmd);
+	pmd_clear(pmd);
+	free_page((unsigned long)pte);
+
+	return 1;
 }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
