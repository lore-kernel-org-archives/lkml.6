Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeESLfh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:35:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752202AbeESLfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:35:32 -0400
Date: Sat, 19 May 2018 04:35:12 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-372fddf709041743a93e381556f4c41aad1e28f8@git.kernel.org>
Cc: kirill.shutemov@linux.intel.com, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, mingo@kernel.org, hughd@google.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: kirill.shutemov@linux.intel.com, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, mingo@kernel.org, hughd@google.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <20180518103528.59260-5-kirill.shutemov@linux.intel.com>
References: <20180518103528.59260-5-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/mm: Introduce the 'no5lvl' kernel parameter
Git-Commit-ID: 372fddf709041743a93e381556f4c41aad1e28f8
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

Commit-ID:  372fddf709041743a93e381556f4c41aad1e28f8
Gitweb:     https://git.kernel.org/tip/372fddf709041743a93e381556f4c41aad1e28f8
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 18 May 2018 13:35:25 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 19 May 2018 11:56:57 +0200

x86/mm: Introduce the 'no5lvl' kernel parameter

This kernel parameter allows to force kernel to use 4-level paging even
if hardware and kernel support 5-level paging.

The option may be useful to work around regressions related to 5-level
paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180518103528.59260-5-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/boot/compressed/cmdline.c              |  2 +-
 arch/x86/boot/compressed/head_64.S              |  1 +
 arch/x86/boot/compressed/pgtable_64.c           | 12 ++++++++++--
 arch/x86/kernel/cpu/common.c                    | 15 +++++++++++++++
 arch/x86/kernel/head64.c                        |  9 +++++----
 6 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28ecdb6d..364a33c1534d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2600,6 +2600,9 @@
 			emulation library even if a 387 maths coprocessor
 			is present.
 
+	no5lvl		[X86-64] Disable 5-level paging mode. Forces
+			kernel to use 4-level paging instead.
+
 	no_console_suspend
 			[HW] Never suspend the console
 			Disable suspending of consoles during suspend and
diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index 0cb325734cfb..af6cda0b7900 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 
-#if CONFIG_EARLY_PRINTK || CONFIG_RANDOMIZE_BASE
+#if CONFIG_EARLY_PRINTK || CONFIG_RANDOMIZE_BASE || CONFIG_X86_5LEVEL
 
 static unsigned long fs;
 static inline void set_fs(unsigned long seg)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8169e8b7a4dc..64037895b085 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -365,6 +365,7 @@ ENTRY(startup_64)
 	 * this function call.
 	 */
 	pushq	%rsi
+	movq	%rsi, %rdi		/* real mode address */
 	call	paging_prepare
 	popq	%rsi
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 23707e1da1ff..8c5107545251 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -31,16 +31,23 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
  */
 unsigned long *trampoline_32bit __section(.data);
 
-struct paging_config paging_prepare(void)
+extern struct boot_params *boot_params;
+int cmdline_find_option_bool(const char *option);
+
+struct paging_config paging_prepare(void *rmode)
 {
 	struct paging_config paging_config = {};
 	unsigned long bios_start, ebda_start;
 
+	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
+	boot_params = rmode;
+
 	/*
 	 * Check if LA57 is desired and supported.
 	 *
-	 * There are two parts to the check:
+	 * There are several parts to the check:
 	 *   - if the kernel supports 5-level paging: CONFIG_X86_5LEVEL=y
+	 *   - if user asked to disable 5-level paging: no5lvl in cmdline
 	 *   - if the machine supports 5-level paging:
 	 *     + CPUID leaf 7 is supported
 	 *     + the leaf has the feature bit set
@@ -48,6 +55,7 @@ struct paging_config paging_prepare(void)
 	 * That's substitute for boot_cpu_has() in early boot code.
 	 */
 	if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
+			!cmdline_find_option_bool("no5lvl") &&
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
 		paging_config.l5_required = 1;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 39ed2e6ff8a0..27f68d14c962 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1028,6 +1028,21 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	 */
 	setup_clear_cpu_cap(X86_FEATURE_PCID);
 #endif
+
+	/*
+	 * Later in the boot process pgtable_l5_enabled() relies on
+	 * cpu_feature_enabled(X86_FEATURE_LA57). If 5-level paging is not
+	 * enabled by this point we need to clear the feature bit to avoid
+	 * false-positives at the later stage.
+	 *
+	 * pgtable_l5_enabled() can be false here for several reasons:
+	 *  - 5-level paging is disabled compile-time;
+	 *  - it's 32-bit kernel;
+	 *  - machine doesn't support 5-level paging;
+	 *  - user specified 'no5lvl' in kernel command line.
+	 */
+	if (!pgtable_l5_enabled())
+		setup_clear_cpu_cap(X86_FEATURE_LA57);
 }
 
 void __init early_cpu_init(void)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8d372d1c266d..8047379e575a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -80,10 +80,11 @@ static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
 
 static bool __head check_la57_support(unsigned long physaddr)
 {
-	if (native_cpuid_eax(0) < 7)
-		return false;
-
-	if (!(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+	/*
+	 * 5-level paging is detected and enabled at kernel decomression
+	 * stage. Only check if it has been enabled there.
+	 */
+	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
 	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
