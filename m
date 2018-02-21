Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbeBULBj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:01:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38531 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeBULBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:01:37 -0500
Date: Wed, 21 Feb 2018 02:50:54 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-b9952ec78778aa7ae5b8df672668aece6fc93d2a@git.kernel.org>
Cc: arjan@linux.intel.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@suse.de, jpoimboe@redhat.com, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org, bp@alien8.de,
        kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, dwmw2@infradead.org, luto@amacapital.net,
        jgross@suse.com, torvalds@linux-foundation.org
Reply-To: luto@amacapital.net, dwmw2@infradead.org,
        torvalds@linux-foundation.org, jgross@suse.com,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com,
        jpoimboe@redhat.com, bp@suse.de, hpa@zytor.com, bp@alien8.de,
        kirill.shutemov@linux.intel.com, mingo@kernel.org,
        peterz@infradead.org, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de
In-Reply-To: <20180216114948.68868-2-kirill.shutemov@linux.intel.com>
References: <20180216114948.68868-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/xen: Allow XEN_PV and XEN_PVH to be enabled with
 X86_5LEVEL
Git-Commit-ID: b9952ec78778aa7ae5b8df672668aece6fc93d2a
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

Commit-ID:  b9952ec78778aa7ae5b8df672668aece6fc93d2a
Gitweb:     https://git.kernel.org/tip/b9952ec78778aa7ae5b8df672668aece6fc93d2a
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 16 Feb 2018 14:49:46 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 10:19:18 +0100

x86/xen: Allow XEN_PV and XEN_PVH to be enabled with X86_5LEVEL

With boot-time switching between paging modes, XEN_PV and XEN_PVH can be
boot into 4-level paging mode.

Tested-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180216114948.68868-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/head_64.S | 12 ++++++------
 arch/x86/xen/Kconfig      |  5 -----
 arch/x86/xen/mmu_pv.c     | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 145d7b9..3e9de0f 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -38,12 +38,12 @@
  *
  */
 
+#define l4_index(x)	(((x) >> 39) & 511)
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 
-#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
-PGD_PAGE_OFFSET = pgd_index(__PAGE_OFFSET_BASE_L4)
-PGD_START_KERNEL = pgd_index(__START_KERNEL_map)
-#endif
+L4_PAGE_OFFSET = l4_index(__PAGE_OFFSET_BASE_L4)
+L4_START_KERNEL = l4_index(__START_KERNEL_map)
+
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
 	.text
@@ -386,9 +386,9 @@ NEXT_PAGE(early_dynamic_pgts)
 #if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
 NEXT_PGD_PAGE(init_top_pgt)
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
-	.org    init_top_pgt + PGD_PAGE_OFFSET*8, 0
+	.org    init_top_pgt + L4_PAGE_OFFSET*8, 0
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
-	.org    init_top_pgt + PGD_START_KERNEL*8, 0
+	.org    init_top_pgt + L4_START_KERNEL*8, 0
 	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
 	.quad   level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	.fill	PTI_USER_PGD_FILL,8,0
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index f605825..c1f98f3 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -18,9 +18,6 @@ config XEN_PV
 	bool "Xen PV guest support"
 	default y
 	depends on XEN
-	# XEN_PV is not ready to work with 5-level paging.
-	# Changes to hypervisor are also required.
-	depends on !X86_5LEVEL
 	select XEN_HAVE_PVMMU
 	select XEN_HAVE_VPMU
 	help
@@ -79,6 +76,4 @@ config XEN_DEBUG_FS
 config XEN_PVH
 	bool "Support for running as a PVH guest"
 	depends on XEN && XEN_PVHVM && ACPI
-	# Pre-built page tables are not ready to handle 5-level paging.
-	depends on !X86_5LEVEL
 	def_bool n
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index d850762..3f4fec5 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -538,6 +538,22 @@ static void xen_set_p4d(p4d_t *ptr, p4d_t val)
 
 	xen_mc_issue(PARAVIRT_LAZY_MMU);
 }
+
+#if CONFIG_PGTABLE_LEVELS >= 5
+__visible p4dval_t xen_p4d_val(p4d_t p4d)
+{
+	return pte_mfn_to_pfn(p4d.p4d);
+}
+PV_CALLEE_SAVE_REGS_THUNK(xen_p4d_val);
+
+__visible p4d_t xen_make_p4d(p4dval_t p4d)
+{
+	p4d = pte_pfn_to_mfn(p4d);
+
+	return native_make_p4d(p4d);
+}
+PV_CALLEE_SAVE_REGS_THUNK(xen_make_p4d);
+#endif  /* CONFIG_PGTABLE_LEVELS >= 5 */
 #endif	/* CONFIG_X86_64 */
 
 static int xen_pmd_walk(struct mm_struct *mm, pmd_t *pmd,
@@ -2411,6 +2427,11 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 
 	.alloc_pud = xen_alloc_pmd_init,
 	.release_pud = xen_release_pmd_init,
+
+#if CONFIG_PGTABLE_LEVELS >= 5
+	.p4d_val = PV_CALLEE_SAVE(xen_p4d_val),
+	.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
+#endif
 #endif	/* CONFIG_X86_64 */
 
 	.activate_mm = xen_activate_mm,
