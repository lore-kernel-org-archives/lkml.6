Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeDQNq5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:46:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49615 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbeDQNqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:46:55 -0400
Date: Tue, 17 Apr 2018 06:46:45 -0700
From: tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-d6ef1f194b7569af8b8397876dc9ab07649d63cb@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, jroedel@suse.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: jroedel@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com
In-Reply-To: <1523971636-4137-1-git-send-email-joro@8bytes.org>
References: <1523971636-4137-1-git-send-email-joro@8bytes.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Prevent kernel Oops in PTDUMP code with
 HIGHPTE=y
Git-Commit-ID: d6ef1f194b7569af8b8397876dc9ab07649d63cb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d6ef1f194b7569af8b8397876dc9ab07649d63cb
Gitweb:     https://git.kernel.org/tip/d6ef1f194b7569af8b8397876dc9ab07649d63cb
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Tue, 17 Apr 2018 15:27:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Apr 2018 15:43:01 +0200

x86/mm: Prevent kernel Oops in PTDUMP code with HIGHPTE=y

The walk_pte_level() function just uses __va to get the virtual address of
the PTE page, but that breaks when the PTE page is not in the direct
mapping with HIGHPTE=y.

The result is an unhandled kernel paging request at some random address
when accessing the current_kernel or current_user file.

Use the correct API to access PTE pages.

Fixes: fe770bf0310d ('x86: clean up the page table dumper and add 32-bit support')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: jgross@suse.com
Cc: JBeulich@suse.com
Cc: hpa@zytor.com
Cc: aryabinin@virtuozzo.com
Cc: kirill.shutemov@linux.intel.com
Link: https://lkml.kernel.org/r/1523971636-4137-1-git-send-email-joro@8bytes.org

---
 arch/x86/mm/dump_pagetables.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 62a7e9f65dec..cc7ff5957194 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/highmem.h>
 
 #include <asm/pgtable.h>
 
@@ -334,16 +335,16 @@ static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
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
