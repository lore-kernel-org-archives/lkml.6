Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeESLeh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:34:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42569 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeESLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:34:34 -0400
Date: Sat, 19 May 2018 04:34:14 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-ad3fe525b9507d8d750d60e8e5dd8e0c0836fb99@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, hughd@google.com, mingo@kernel.org
Reply-To: peterz@infradead.org, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, hughd@google.com, torvalds@linux-foundation.org,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180518103528.59260-3-kirill.shutemov@linux.intel.com>
References: <20180518103528.59260-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/mm: Unify pgtable_l5_enabled usage in early boot
 code
Git-Commit-ID: ad3fe525b9507d8d750d60e8e5dd8e0c0836fb99
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

Commit-ID:  ad3fe525b9507d8d750d60e8e5dd8e0c0836fb99
Gitweb:     https://git.kernel.org/tip/ad3fe525b9507d8d750d60e8e5dd8e0c0836fb99
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 18 May 2018 13:35:23 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 19 May 2018 11:56:57 +0200

x86/mm: Unify pgtable_l5_enabled usage in early boot code

Usually pgtable_l5_enabled is defined using cpu_feature_enabled().
cpu_feature_enabled() is not available in early boot code. We use
several different preprocessor tricks to get around it. It's messy.

Unify them all.

If cpu_feature_enabled() is not yet available, USE_EARLY_PGTABLE_L5 can
be defined before all includes. It makes pgtable_l5_enabled rely on
__pgtable_l5_enabled variable instead. This approach fits all early
users.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180518103528.59260-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c        |  4 ++--
 arch/x86/boot/compressed/misc.h         |  6 ++----
 arch/x86/include/asm/pgtable_64_types.h | 13 ++++++++++---
 arch/x86/kernel/head64.c                | 12 +++++-------
 arch/x86/mm/kasan_init_64.c             |  6 ++----
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index a0a50b91ecef..b87a7582853d 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -47,7 +47,7 @@
 #include <linux/decompress/mm.h>
 
 #ifdef CONFIG_X86_5LEVEL
-unsigned int pgtable_l5_enabled __ro_after_init;
+unsigned int __pgtable_l5_enabled;
 unsigned int pgdir_shift __ro_after_init = 39;
 unsigned int ptrs_per_p4d __ro_after_init = 1;
 #endif
@@ -734,7 +734,7 @@ void choose_random_location(unsigned long input,
 
 #ifdef CONFIG_X86_5LEVEL
 	if (__read_cr4() & X86_CR4_LA57) {
-		pgtable_l5_enabled = 1;
+		__pgtable_l5_enabled = 1;
 		pgdir_shift = 48;
 		ptrs_per_p4d = 512;
 	}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 9e11be4cae19..a423bdb42686 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -12,10 +12,8 @@
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
 
-#ifdef CONFIG_X86_5LEVEL
-/* cpu_feature_enabled() cannot be used that early */
-#define pgtable_l5_enabled __pgtable_l5_enabled
-#endif
+/* cpu_feature_enabled() cannot be used this early */
+#define USE_EARLY_PGTABLE_L5
 
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index adb47552e6bb..c14a4116a693 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -22,12 +22,19 @@ typedef struct { pteval_t pte; } pte_t;
 
 #ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled;
-#ifndef pgtable_l5_enabled
+
+#ifdef USE_EARLY_PGTABLE_L5
+/*
+ * cpu_feature_enabled() is not available in early boot code.
+ * Use variable instead.
+ */
+#define pgtable_l5_enabled __pgtable_l5_enabled
+#else
 #define pgtable_l5_enabled cpu_feature_enabled(X86_FEATURE_LA57)
-#endif
+#endif /* USE_EARLY_PGTABLE_L5 */
 #else
 #define pgtable_l5_enabled 0
-#endif
+#endif /* CONFIG_X86_5LEVEL */
 
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 2d29e47c056e..494fea1dbd6e 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -6,6 +6,10 @@
  */
 
 #define DISABLE_BRANCH_PROFILING
+
+/* cpu_feature_enabled() cannot be used this early */
+#define USE_EARLY_PGTABLE_L5
+
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/types.h>
@@ -32,11 +36,6 @@
 #include <asm/microcode.h>
 #include <asm/kasan.h>
 
-#ifdef CONFIG_X86_5LEVEL
-#undef pgtable_l5_enabled
-#define pgtable_l5_enabled __pgtable_l5_enabled
-#endif
-
 /*
  * Manage page tables very early on.
  */
@@ -46,7 +45,6 @@ pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled __ro_after_init;
-EXPORT_SYMBOL(__pgtable_l5_enabled);
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
@@ -88,7 +86,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 	if (!(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
 		return false;
 
-	*fixup_int(&pgtable_l5_enabled, physaddr) = 1;
+	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
 	*fixup_int(&pgdir_shift, physaddr) = 48;
 	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
 	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 980dbebd0ca7..340bb9b32e01 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -2,10 +2,8 @@
 #define DISABLE_BRANCH_PROFILING
 #define pr_fmt(fmt) "kasan: " fmt
 
-#ifdef CONFIG_X86_5LEVEL
-/* Too early to use cpu_feature_enabled() */
-#define pgtable_l5_enabled __pgtable_l5_enabled
-#endif
+/* cpu_feature_enabled() cannot be used this early */
+#define USE_EARLY_PGTABLE_L5
 
 #include <linux/bootmem.h>
 #include <linux/kasan.h>
