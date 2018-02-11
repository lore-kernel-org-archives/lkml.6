Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932394AbeBLCJ2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 21:09:28 -0500
Received: from [198.137.202.136] ([198.137.202.136]:51617 "EHLO
        terminus.zytor.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbeBLCJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 21:09:26 -0500
Date: Sun, 11 Feb 2018 04:19:12 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-4440977be1347d43503f381716e4918413b5a6f0@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@suse.de,
        hpa@zytor.com, gorcunov@openvz.org, luto@amacapital.net,
        willy@infradead.org, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, bp@suse.de,
        tglx@linutronix.de, luto@amacapital.net, gorcunov@openvz.org,
        willy@infradead.org, mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com
In-Reply-To: <20180209142228.21231-3-kirill.shutemov@linux.intel.com>
References: <20180209142228.21231-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/compressed/64: Introduce paging_prepare()
Git-Commit-ID: 4440977be1347d43503f381716e4918413b5a6f0
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

Commit-ID:  4440977be1347d43503f381716e4918413b5a6f0
Gitweb:     https://git.kernel.org/tip/4440977be1347d43503f381716e4918413b5a6f0
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 9 Feb 2018 17:22:26 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 12:36:18 +0100

x86/boot/compressed/64: Introduce paging_prepare()

Rename l5_paging_required() to paging_prepare() and change the
interface of the function.

This is a preparation for the next patch, which would make the function
also allocate memory for the 32-bit trampoline.

The function now returns a 128-bit structure. RAX would return
trampoline memory address (zero for now) and RDX would indicate if we
need to enable 5-level paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[ Typo fixes and general clarification. ]
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180209142228.21231-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 41 ++++++++++++++++-------------------
 arch/x86/boot/compressed/pgtable_64.c | 25 ++++++++++-----------
 2 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fc313e2..d598d65 100644
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
+	 * paging_prepare() sets up the trampoline and checks if we need to
+	 * enable 5-level paging.
 	 *
-	 * NOTE: This is not going to work if bootloader put us above 4G
-	 * limit.
+	 * Address of the trampoline is returned in RAX.
+	 * Non zero RDX on return means we need to enable 5-level paging.
 	 *
-	 * The first step is go into compatibility mode.
+	 * RSI holds real mode data and needs to be preserved across
+	 * this function call.
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
index b4469a3..3f1697f 100644
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
