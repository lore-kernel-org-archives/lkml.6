Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeDQN1X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:27:23 -0400
Received: from 8bytes.org ([81.169.241.247]:52192 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752779AbeDQN1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:27:22 -0400
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: hpa@zytor.com, x86@kernel.org, kirill.shutemov@linux.intel.com,
        jgross@suse.com, JBeulich@suse.com, aryabinin@virtuozzo.com,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/mm: Fix kernel oops in PTDUMP code with HIGHPTE=y
Date: Tue, 17 Apr 2018 15:27:16 +0200
Message-Id: <1523971636-4137-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The walk_pte_level() function just uses __va to get the
virtual address of the PTE page, but that breaks when
the PTE page is not in the direct mapping with HIGHPTE=y.

The result is an unhandled kernel paging request at some
random address when accessing the current_kernel or
current_user file.

Use the correct API to access PTE pages nd fix the oops.

Fixes: fe770bf0310d ('x86: clean up the page table dumper and add 32-bit support')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/dump_pagetables.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 956c886f5dff..db1d7a0e6335 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/highmem.h>
 
 #include <asm/pgtable.h>
 
@@ -344,16 +345,16 @@ static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
 			   pgprotval_t eff_in, unsigned long P)
 {
 	int i;
-	pte_t *start;
+	pte_t *pte;
 	pgprotval_t prot, eff;
 
-	start = (pte_t *)pmd_page_vaddr(addr);
 	for (i = 0; i < PTRS_PER_PTE; i++) {
-		prot = pte_flags(*start);
-		eff = effective_prot(eff_in, prot);
 		st->current_address = normalize_addr(P + i * PTE_LEVEL_MULT);
+		pte = pte_offset_map(&addr, st->current_address);
+		prot = pte_flags(*pte);
+		eff = effective_prot(eff_in, prot);
 		note_page(m, st, __pgprot(prot), eff, 5);
-		start++;
+		pte_unmap(pte);
 	}
 }
 #ifdef CONFIG_KASAN
-- 
2.13.6
