Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966639AbeCAIwE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:52:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965940AbeCAIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:52:00 -0500
Date: Thu, 1 Mar 2018 00:51:47 -0800
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-945fd17ab6bab8a4d05da6c3170519fbcfe62ddb@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        william.grant@canonical.com, linux-kernel@vger.kernel.org,
        terraluna977@gmail.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        william.grant@canonical.com, terraluna977@gmail.com, mingo@kernel.org
In-Reply-To: <alpine.DEB.2.21.1802282137290.1392@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1802282137290.1392@nanos.tec.linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/cpu_entry_area: Sync cpu_entry_area to
 initial_page_table
Git-Commit-ID: 945fd17ab6bab8a4d05da6c3170519fbcfe62ddb
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

Commit-ID:  945fd17ab6bab8a4d05da6c3170519fbcfe62ddb
Gitweb:     https://git.kernel.org/tip/945fd17ab6bab8a4d05da6c3170519fbcfe62ddb
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 28 Feb 2018 21:14:26 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Mar 2018 09:48:27 +0100

x86/cpu_entry_area: Sync cpu_entry_area to initial_page_table

The separation of the cpu_entry_area from the fixmap missed the fact that
on 32bit non-PAE kernels the cpu_entry_area mapping might not be covered in
initial_page_table by the previous synchronizations.

This results in suspend/resume failures because 32bit utilizes initial page
table for resume. The absence of the cpu_entry_area mapping results in a
triple fault, aka. insta reboot.

With PAE enabled this works by chance because the PGD entry which covers
the fixmap and other parts incindentally provides the cpu_entry_area
mapping as well.

Synchronize the initial page table after setting up the cpu entry
area. Instead of adding yet another copy of the same code, move it to a
function and invoke it from the various places.

It needs to be investigated if the existing calls in setup_arch() and
setup_per_cpu_areas() can be replaced by the later invocation from
setup_cpu_entry_areas(), but that's beyond the scope of this fix.

Fixes: 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the fixmap")
Reported-by: Woody Suwalski <terraluna977@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Woody Suwalski <terraluna977@gmail.com>
Cc: William Grant <william.grant@canonical.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1802282137290.1392@nanos.tec.linutronix.de

---
 arch/x86/include/asm/pgtable_32.h |  1 +
 arch/x86/include/asm/pgtable_64.h |  1 +
 arch/x86/kernel/setup.c           | 17 +++++------------
 arch/x86/kernel/setup_percpu.c    | 17 ++++-------------
 arch/x86/mm/cpu_entry_area.c      |  6 ++++++
 arch/x86/mm/init_32.c             | 15 +++++++++++++++
 6 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index e55466760ff8..b3ec519e3982 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -32,6 +32,7 @@ extern pmd_t initial_pg_pmd[];
 static inline void pgtable_cache_init(void) { }
 static inline void check_pgt_cache(void) { }
 void paging_init(void);
+void sync_initial_page_table(void);
 
 /*
  * Define this if things work differently on an i386 and an i486:
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 81462e9a34f6..1149d2112b2e 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -28,6 +28,7 @@ extern pgd_t init_top_pgt[];
 #define swapper_pg_dir init_top_pgt
 
 extern void paging_init(void);
+static inline void sync_initial_page_table(void) { }
 
 #define pte_ERROR(e)					\
 	pr_err("%s:%d: bad pte %p(%016lx)\n",		\
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1ae67e982af7..4c616be28506 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1204,20 +1204,13 @@ void __init setup_arch(char **cmdline_p)
 
 	kasan_init();
 
-#ifdef CONFIG_X86_32
-	/* sync back kernel address range */
-	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			KERNEL_PGD_PTRS);
-
 	/*
-	 * sync back low identity map too.  It is used for example
-	 * in the 32-bit EFI stub.
+	 * Sync back kernel address range.
+	 *
+	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
+	 * this call?
 	 */
-	clone_pgd_range(initial_page_table,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
-#endif
+	sync_initial_page_table();
 
 	tboot_probe();
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 497aa766fab3..ea554f812ee1 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -287,24 +287,15 @@ void __init setup_per_cpu_areas(void)
 	/* Setup cpu initialized, callin, callout masks */
 	setup_cpu_local_masks();
 
-#ifdef CONFIG_X86_32
 	/*
 	 * Sync back kernel address range again.  We already did this in
 	 * setup_arch(), but percpu data also needs to be available in
 	 * the smpboot asm.  We can't reliably pick up percpu mappings
 	 * using vmalloc_fault(), because exception dispatch needs
 	 * percpu data.
+	 *
+	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
+	 * this call?
 	 */
-	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			KERNEL_PGD_PTRS);
-
-	/*
-	 * sync back low identity map too.  It is used for example
-	 * in the 32-bit EFI stub.
-	 */
-	clone_pgd_range(initial_page_table,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
-#endif
+	sync_initial_page_table();
 }
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index b9283cc27622..476d810639a8 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -163,4 +163,10 @@ void __init setup_cpu_entry_areas(void)
 
 	for_each_possible_cpu(cpu)
 		setup_cpu_entry_area(cpu);
+
+	/*
+	 * This is the last essential update to swapper_pgdir which needs
+	 * to be synchronized to initial_page_table on 32bit.
+	 */
+	sync_initial_page_table();
 }
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 79cb066f40c0..396e1f0151ac 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -453,6 +453,21 @@ static inline void permanent_kmaps_init(pgd_t *pgd_base)
 }
 #endif /* CONFIG_HIGHMEM */
 
+void __init sync_initial_page_table(void)
+{
+	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			KERNEL_PGD_PTRS);
+
+	/*
+	 * sync back low identity map too.  It is used for example
+	 * in the 32-bit EFI stub.
+	 */
+	clone_pgd_range(initial_page_table,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
+}
+
 void __init native_pagetable_init(void)
 {
 	unsigned long pfn, va;
