Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935037AbeBPLE7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:04:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57269 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935010AbeBPLE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:04:57 -0500
Date: Fri, 16 Feb 2018 02:54:33 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-6f9dd329717f696f578347c0781a0247db957596@git.kernel.org>
Cc: bp@suse.de, hpa@zytor.com, tglx@linutronix.de, jpoimboe@redhat.com,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        dwmw2@infradead.org, arjan@linux.intel.com, dan.j.williams@intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org, luto@kernel.org
Reply-To: arjan@linux.intel.com, torvalds@linux-foundation.org,
        dan.j.williams@intel.com, dwmw2@infradead.org, luto@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, jpoimboe@redhat.com,
        peterz@infradead.org, bp@suse.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com
In-Reply-To: <20180214182542.69302-7-kirill.shutemov@linux.intel.com>
References: <20180214182542.69302-7-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Support boot-time switching of paging modes in
 the early boot code
Git-Commit-ID: 6f9dd329717f696f578347c0781a0247db957596
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

Commit-ID:  6f9dd329717f696f578347c0781a0247db957596
Gitweb:     https://git.kernel.org/tip/6f9dd329717f696f578347c0781a0247db957596
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 21:25:39 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:48:48 +0100

x86/mm: Support boot-time switching of paging modes in the early boot code

Early boot code should be able to initialize page tables for both 4- and
5-level paging modes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214182542.69302-7-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/head64.c  | 33 ++++++++++++++++++++++-----------
 arch/x86/kernel/head_64.S | 10 ++++------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 795e762..8161e71 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -75,13 +75,13 @@ static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
 	return fixup_pointer(ptr, physaddr);
 }
 
-static void __head check_la57_support(unsigned long physaddr)
+static bool __head check_la57_support(unsigned long physaddr)
 {
 	if (native_cpuid_eax(0) < 7)
-		return;
+		return false;
 
 	if (!(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
-		return;
+		return false;
 
 	*fixup_int(&pgtable_l5_enabled, physaddr) = 1;
 	*fixup_int(&pgdir_shift, physaddr) = 48;
@@ -89,24 +89,30 @@ static void __head check_la57_support(unsigned long physaddr)
 	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
 	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
 	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
+
+	return true;
 }
 #else
-static void __head check_la57_support(unsigned long physaddr) {}
+static bool __head check_la57_support(unsigned long physaddr)
+{
+	return false;
+}
 #endif
 
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
-	unsigned long load_delta;
+	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
+	bool la57;
 	int i;
 	unsigned int *next_pgt_ptr;
 
-	check_la57_support(physaddr);
+	la57 = check_la57_support(physaddr);
 
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
@@ -131,9 +137,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Fixup the physical addresses in the page table */
 
 	pgd = fixup_pointer(&early_top_pgt, physaddr);
-	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
-
-	if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
+	p = pgd + pgd_index(__START_KERNEL_map);
+	if (la57)
+		*p = (unsigned long)level4_kernel_pgt;
+	else
+		*p = (unsigned long)level3_kernel_pgt;
+	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
+
+	if (la57) {
 		p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
 		p4d[511] += load_delta;
 	}
@@ -158,7 +169,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
-	if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
+	if (la57) {
 		p4d = fixup_pointer(early_dynamic_pgts[next_early_pgt++], physaddr);
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
@@ -255,7 +266,7 @@ again:
 	 * critical -- __PAGE_OFFSET would point us back into the dynamic
 	 * range and we might end up looping forever...
 	 */
-	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
+	if (!pgtable_l5_enabled)
 		p4d_p = pgd_p;
 	else if (pgd)
 		p4d_p = (p4dval_t *)((pgd & PTE_PFN_MASK) + __START_KERNEL_map - phys_base);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d3f8b43..145d7b9 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -124,7 +124,10 @@ ENTRY(secondary_startup_64)
 	/* Enable PAE mode, PGE and LA57 */
 	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
+	testl	$1, pgtable_l5_enabled(%rip)
+	jz	1f
 	orl	$X86_CR4_LA57, %ecx
+1:
 #endif
 	movq	%rcx, %cr4
 
@@ -372,12 +375,7 @@ GLOBAL(name)
 
 	__INITDATA
 NEXT_PGD_PAGE(early_top_pgt)
-	.fill	511,8,0
-#ifdef CONFIG_X86_5LEVEL
-	.quad	level4_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
-#else
-	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
-#endif
+	.fill	512,8,0
 	.fill	PTI_USER_PGD_FILL,8,0
 
 NEXT_PAGE(early_dynamic_pgts)
