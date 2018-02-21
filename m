Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753758AbeBULDg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:03:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeBULDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:03:34 -0500
Date: Wed, 21 Feb 2018 02:51:47 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-39b9552281abfcdfc54162897018890dafe7ffef@git.kernel.org>
Cc: dan.j.williams@intel.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        dwmw2@infradead.org, arjan@linux.intel.com,
        torvalds@linux-foundation.org, luto@kernel.org, mingo@kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org, luto@amacapital.net,
        linux-kernel@vger.kernel.org, bp@suse.de, bp@alien8.de,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com
Reply-To: tglx@linutronix.de, kirill.shutemov@linux.intel.com, bp@suse.de,
        bp@alien8.de, luto@amacapital.net, linux-kernel@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com, luto@kernel.org,
        mingo@kernel.org, hpa@zytor.com, arjan@linux.intel.com,
        torvalds@linux-foundation.org, dwmw2@infradead.org,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com
In-Reply-To: <20180216114948.68868-4-kirill.shutemov@linux.intel.com>
References: <20180216114948.68868-4-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Optimize boot-time paging mode switching cost
Git-Commit-ID: 39b9552281abfcdfc54162897018890dafe7ffef
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

Commit-ID:  39b9552281abfcdfc54162897018890dafe7ffef
Gitweb:     https://git.kernel.org/tip/39b9552281abfcdfc54162897018890dafe7ffef
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 16 Feb 2018 14:49:48 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 10:19:18 +0100

x86/mm: Optimize boot-time paging mode switching cost

By this point we have functioning boot-time switching between 4- and
5-level paging mode. But naive approach comes with cost.

Numbers below are for kernel build, allmodconfig, 5 times.

CONFIG_X86_5LEVEL=n:

 Performance counter stats for 'sh -c make -j100 -B -k >/dev/null' (5 runs):

   17308719.892691      task-clock:u (msec)       #   26.772 CPUs utilized            ( +-  0.11% )
                 0      context-switches:u        #    0.000 K/sec
                 0      cpu-migrations:u          #    0.000 K/sec
       331,993,164      page-faults:u             #    0.019 M/sec                    ( +-  0.01% )
43,614,978,867,455      cycles:u                  #    2.520 GHz                      ( +-  0.01% )
39,371,534,575,126      stalled-cycles-frontend:u #   90.27% frontend cycles idle     ( +-  0.09% )
28,363,350,152,428      instructions:u            #    0.65  insn per cycle
                                                  #    1.39  stalled cycles per insn  ( +-  0.00% )
 6,316,784,066,413      branches:u                #  364.948 M/sec                    ( +-  0.00% )
   250,808,144,781      branch-misses:u           #    3.97% of all branches          ( +-  0.01% )

     646.531974142 seconds time elapsed                                          ( +-  1.15% )

CONFIG_X86_5LEVEL=y:

 Performance counter stats for 'sh -c make -j100 -B -k >/dev/null' (5 runs):

   17411536.780625      task-clock:u (msec)       #   26.426 CPUs utilized            ( +-  0.10% )
                 0      context-switches:u        #    0.000 K/sec
                 0      cpu-migrations:u          #    0.000 K/sec
       331,868,663      page-faults:u             #    0.019 M/sec                    ( +-  0.01% )
43,865,909,056,301      cycles:u                  #    2.519 GHz                      ( +-  0.01% )
39,740,130,365,581      stalled-cycles-frontend:u #   90.59% frontend cycles idle     ( +-  0.05% )
28,363,358,997,959      instructions:u            #    0.65  insn per cycle
                                                  #    1.40  stalled cycles per insn  ( +-  0.00% )
 6,316,784,937,460      branches:u                #  362.793 M/sec                    ( +-  0.00% )
   251,531,919,485      branch-misses:u           #    3.98% of all branches          ( +-  0.00% )

     658.886307752 seconds time elapsed                                          ( +-  0.92% )

The patch tries to fix the performance regression by using
cpu_feature_enabled(X86_FEATURE_LA57) instead of pgtable_l5_enabled in
all hot code paths. These will statically patch the target code for
additional performance.

CONFIG_X86_5LEVEL=y + the patch:

 Performance counter stats for 'sh -c make -j100 -B -k >/dev/null' (5 runs):

   17381990.268506      task-clock:u (msec)       #   26.907 CPUs utilized            ( +-  0.19% )
                 0      context-switches:u        #    0.000 K/sec
                 0      cpu-migrations:u          #    0.000 K/sec
       331,862,625      page-faults:u             #    0.019 M/sec                    ( +-  0.01% )
43,697,726,320,051      cycles:u                  #    2.514 GHz                      ( +-  0.03% )
39,480,408,690,401      stalled-cycles-frontend:u #   90.35% frontend cycles idle     ( +-  0.05% )
28,363,394,221,388      instructions:u            #    0.65  insn per cycle
                                                  #    1.39  stalled cycles per insn  ( +-  0.00% )
 6,316,794,985,573      branches:u                #  363.410 M/sec                    ( +-  0.00% )
   251,013,232,547      branch-misses:u           #    3.97% of all branches          ( +-  0.01% )

     645.991174661 seconds time elapsed                                          ( +-  1.19% )

Unfortunately, this approach doesn't help with text size:

  vmlinux.before .text size:	8190319
  vmlinux.after .text size:	8200623

The .text section is increased by about 4k. Not sure if we can do anything
about this.

Signed-off-by: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
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
Link: http://lkml.kernel.org/r/20180216114948.68868-4-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/misc.h         |  5 +++++
 arch/x86/entry/entry_64.S               | 11 ++---------
 arch/x86/include/asm/pgtable_64_types.h |  5 ++++-
 arch/x86/kernel/head64.c                |  9 +++++++--
 arch/x86/kernel/head_64.S               |  2 +-
 arch/x86/mm/kasan_init_64.c             |  6 ++++++
 6 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 9d323dc..4d369c3 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -12,6 +12,11 @@
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
 
+#ifdef CONFIG_X86_5LEVEL
+/* cpu_feature_enabled() cannot be used that early */
+#define pgtable_l5_enabled __pgtable_l5_enabled
+#endif
+
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
 #include <linux/elf.h>
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 2c06348..b18acdf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -275,15 +275,8 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	 * depending on paging mode) in the address.
 	 */
 #ifdef CONFIG_X86_5LEVEL
-	testl	$1, pgtable_l5_enabled(%rip)
-	jz	1f
-	shl	$(64 - 57), %rcx
-	sar	$(64 - 57), %rcx
-	jmp	2f
-1:
-	shl	$(64 - 48), %rcx
-	sar	$(64 - 48), %rcx
-2:
+	ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
+		"shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATURE_LA57
 #else
 	shl	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
 	sar	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 68909a6..d5c21a3 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -21,7 +21,10 @@ typedef unsigned long	pgprotval_t;
 typedef struct { pteval_t pte; } pte_t;
 
 #ifdef CONFIG_X86_5LEVEL
-extern unsigned int pgtable_l5_enabled;
+extern unsigned int __pgtable_l5_enabled;
+#ifndef pgtable_l5_enabled
+#define pgtable_l5_enabled cpu_feature_enabled(X86_FEATURE_LA57)
+#endif
 #else
 #define pgtable_l5_enabled 0
 #endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8161e71..0c855de 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -32,6 +32,11 @@
 #include <asm/microcode.h>
 #include <asm/kasan.h>
 
+#ifdef CONFIG_X86_5LEVEL
+#undef pgtable_l5_enabled
+#define pgtable_l5_enabled __pgtable_l5_enabled
+#endif
+
 /*
  * Manage page tables very early on.
  */
@@ -40,8 +45,8 @@ static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
-unsigned int pgtable_l5_enabled __ro_after_init;
-EXPORT_SYMBOL(pgtable_l5_enabled);
+unsigned int __pgtable_l5_enabled __ro_after_init;
+EXPORT_SYMBOL(__pgtable_l5_enabled);
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3e9de0f..326c631 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -124,7 +124,7 @@ ENTRY(secondary_startup_64)
 	/* Enable PAE mode, PGE and LA57 */
 	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
-	testl	$1, pgtable_l5_enabled(%rip)
+	testl	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
 	orl	$X86_CR4_LA57, %ecx
 1:
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0df0dd1..d8ff013 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -1,6 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #define DISABLE_BRANCH_PROFILING
 #define pr_fmt(fmt) "kasan: " fmt
+
+#ifdef CONFIG_X86_5LEVEL
+/* Too early to use cpu_feature_enabled() */
+#define pgtable_l5_enabled __pgtable_l5_enabled
+#endif
+
 #include <linux/bootmem.h>
 #include <linux/kasan.h>
 #include <linux/kdebug.h>
