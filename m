Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbeA3NxZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:53:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:5185 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752617AbeA3Nwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:52:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,435,1511856000";
   d="scan'208";a="30617082"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 2/4] x86/boot/compressed/64: Introduce paging_prepare()
Date: Tue, 30 Jan 2018 16:52:37 +0300
Message-Id: <20180130135239.72244-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180130135239.72244-1-kirill.shutemov@linux.intel.com>
References: <20180130135239.72244-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames l5_paging_required() into paging_prepare() and
changes the interface of the function.

This is a preparation for the next patch, which would make the function
also allocate memory for the 32-bit trampoline.

The function now returns a 128-bit structure. RAX would return
trampoline memory address (zero for now) and RDX would indicate if we
need to enabled 5-level paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/head_64.S    | 41 ++++++++++++++++-------------------
 arch/x86/boot/compressed/pgtable_64.c | 25 ++++++++++-----------
 2 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fc313e29fe2c..10b4df46de84 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -304,20 +304,6 @@ ENTRY(startup_64)
 	/* Set up the stack */
 	leaq	boot_stack_end(%rbx), %rsp
 
-#ifdef CONFIG_X86_5LEVEL
-	/*
-	 * Check if we need to enable 5-level paging.
-	 * RSI holds real mode data and need to be preserved across
-	 * a function call.
-	 */
-	pushq	%rsi
-	call	l5_paging_required
-	popq	%rsi
-
-	/* If l5_paging_required() returned zero, we're done here. */
-	cmpq	$0, %rax
-	je	lvl5
-
 	/*
 	 * At this point we are in long mode with 4-level paging enabled,
 	 * but we want to enable 5-level paging.
@@ -325,12 +311,28 @@ ENTRY(startup_64)
 	 * The problem is that we cannot do it directly. Setting LA57 in
 	 * long mode would trigger #GP. So we need to switch off long mode
 	 * first.
+	 */
+
+	/*
+	 * paging_prepare() would set up the trampoline and check if we need to
+	 * enable 5-level paging.
 	 *
-	 * NOTE: This is not going to work if bootloader put us above 4G
-	 * limit.
+	 * Address of the trampoline is returned in RAX.
+	 * Non zero RDX on return means we need to enable 5-level paging.
 	 *
-	 * The first step is go into compatibility mode.
+	 * RSI holds real mode data and need to be preserved across
+	 * a function call.
 	 */
+	pushq	%rsi
+	call	paging_prepare
+	popq	%rsi
+
+	/* Save the trampoline address in RCX */
+	movq	%rax, %rcx
+
+	/* Check if we need to enable 5-level paging */
+	cmpq	$0, %rdx
+	jz	lvl5
 
 	/* Clear additional page table */
 	leaq	lvl5_pgtable(%rbx), %rdi
@@ -352,7 +354,6 @@ ENTRY(startup_64)
 	pushq	%rax
 	lretq
 lvl5:
-#endif
 
 	/* Zero EFLAGS */
 	pushq	$0
@@ -490,7 +491,6 @@ relocated:
 	jmp	*%rax
 
 	.code32
-#ifdef CONFIG_X86_5LEVEL
 compatible_mode:
 	/* Setup data and stack segments */
 	movl	$__KERNEL_DS, %eax
@@ -526,7 +526,6 @@ compatible_mode:
 	movl	%eax, %cr0
 
 	lret
-#endif
 
 no_longmode:
 	/* This isn't an x86-64 CPU so hang */
@@ -585,7 +584,5 @@ boot_stack_end:
 	.balign 4096
 pgtable:
 	.fill BOOT_PGT_SIZE, 1, 0
-#ifdef CONFIG_X86_5LEVEL
 lvl5_pgtable:
 	.fill PAGE_SIZE, 1, 0
-#endif
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index b4469a37e9a1..3f1697fcc7a8 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -9,20 +9,19 @@
  */
 unsigned long __force_order;
 
-int l5_paging_required(void)
-{
-	/* Check if leaf 7 is supported. */
-
-	if (native_cpuid_eax(0) < 7)
-		return 0;
+struct paging_config {
+	unsigned long trampoline_start;
+	unsigned long l5_required;
+};
 
-	/* Check if la57 is supported. */
-	if (!(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
-		return 0;
+struct paging_config paging_prepare(void)
+{
+	struct paging_config paging_config = {};
 
-	/* Check if 5-level paging has already been enabled. */
-	if (native_read_cr4() & X86_CR4_LA57)
-		return 0;
+	/* Check if LA57 is desired and supported */
+	if (IS_ENABLED(CONFIG_X86_5LEVEL) && native_cpuid_eax(0) >= 7 &&
+			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+		paging_config.l5_required = 1;
 
-	return 1;
+	return paging_config;
 }
-- 
2.15.1
