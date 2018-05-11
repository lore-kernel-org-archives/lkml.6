Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeEKMJI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:09:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:33124 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752219AbeEKMJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:09:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="227710306"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] x86/mm: Introduce 'no5lvl' kernel parameter
Date: Fri, 11 May 2018 15:08:59 +0300
Message-Id: <20180511120859.26375-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511120859.26375-1-kirill.shutemov@linux.intel.com>
References: <20180511120859.26375-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel parameter allows to force kernel to use 4-level paging even
if hardware and kernel support 5-level paging.

The option may be useful to workaround regressions related to 5-level
paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/boot/compressed/cmdline.c              |  2 +-
 arch/x86/boot/compressed/head_64.S              |  1 +
 arch/x86/boot/compressed/pgtable_64.c           | 12 ++++++++++--
 arch/x86/kernel/cpu/common.c                    |  6 ++++++
 arch/x86/kernel/head64.c                        | 10 ++++++----
 6 files changed, 27 insertions(+), 7 deletions(-)

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
index 1acf7b5d16cf..3ecd8399ad1f 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -361,6 +361,7 @@ ENTRY(startup_64)
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
index ce243f7d2d4e..1e91ec6293de 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1008,6 +1008,12 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	 */
 	setup_clear_cpu_cap(X86_FEATURE_PCID);
 #endif
+
+#ifdef CONFIG_X86_5LEVEL
+	/* Clear the 5-level paging feature if user asked for 'no5lvl' */
+	if (!__pgtable_l5_enabled)
+		setup_clear_cpu_cap(X86_FEATURE_LA57);
+#endif
 }
 
 void __init early_cpu_init(void)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c408f8c4ed4..8ca65d35b93a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -82,10 +82,12 @@ static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
 
 static bool __head check_la57_support(unsigned long physaddr)
 {
-	if (native_cpuid_eax(0) < 7)
-		return false;
-
-	if (!(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+	/*
+	 * 5-level paging is detected and enabled on kernel decomression
+	 * stage. Back off if 5-level paging mode has not yet enabled by
+	 * this point.
+	 */
+	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
 	*fixup_int(&pgtable_l5_enabled, physaddr) = 1;
-- 
2.17.0
