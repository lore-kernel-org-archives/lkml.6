Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeCLMVF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:21:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48193 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeCLMVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:21:04 -0400
Date: Mon, 12 Mar 2018 05:20:21 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-194a9749c73d650c0b1dfdee04fb0bdf0a888ba8@git.kernel.org>
Cc: bp@alien8.de, hpa@zytor.com, peterz@infradead.org, gorcunov@openvz.org,
        kirill.shutemov@linux.intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org, jpoimboe@redhat.com, tglx@linutronix.de,
        luto@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
        willy@infradead.org, luto@amacapital.net, dvlasenk@redhat.com,
        brgerst@gmail.com
Reply-To: bp@alien8.de, gorcunov@openvz.org, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        tglx@linutronix.de, luto@kernel.org, bp@suse.de, luto@amacapital.net,
        dvlasenk@redhat.com, linux-kernel@vger.kernel.org, willy@infradead.org,
        brgerst@gmail.com
In-Reply-To: <20180312100246.89175-5-kirill.shutemov@linux.intel.com>
References: <20180312100246.89175-5-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Handle 5-level paging boot if
 kernel is above 4G
Git-Commit-ID: 194a9749c73d650c0b1dfdee04fb0bdf0a888ba8
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

Commit-ID:  194a9749c73d650c0b1dfdee04fb0bdf0a888ba8
Gitweb:     https://git.kernel.org/tip/194a9749c73d650c0b1dfdee04fb0bdf0a888ba8
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 12 Mar 2018 13:02:46 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 11:49:25 +0100

x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G

This patch addresses a shortcoming in current boot process on machines
that supports 5-level paging.

If a bootloader enables 64-bit mode with 4-level paging, we might need to
switch over to 5-level paging. The switching requires the disabling
paging. It works fine if kernel itself is loaded below 4G.

But if the bootloader put the kernel above 4G (not sure if anybody does
this), we would lose control as soon as paging is disabled, because the
code becomes unreachable to the CPU.

This patch implements a trampoline in lower memory to handle this
situation.

We only need the memory for a very short time, until the main kernel
image sets up own page tables.

We go through the trampoline even if we don't have to: if we're already
in 5-level paging mode or if we don't need to switch to it. This way the
trampoline gets tested on every boot.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180312100246.89175-5-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 69 +++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 959ca07a58d9..fca012baba19 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -307,11 +307,27 @@ ENTRY(startup_64)
 
 	/*
 	 * At this point we are in long mode with 4-level paging enabled,
-	 * but we want to enable 5-level paging.
+	 * but we might want to enable 5-level paging or vice versa.
 	 *
-	 * The problem is that we cannot do it directly. Setting LA57 in
-	 * long mode would trigger #GP. So we need to switch off long mode
-	 * first.
+	 * The problem is that we cannot do it directly. Setting or clearing
+	 * CR4.LA57 in long mode would trigger #GP. So we need to switch off
+	 * long mode and paging first.
+	 *
+	 * We also need a trampoline in lower memory to switch over from
+	 * 4- to 5-level paging for cases when the bootloader puts the kernel
+	 * above 4G, but didn't enable 5-level paging for us.
+	 *
+	 * The same trampoline can be used to switch from 5- to 4-level paging
+	 * mode, like when starting 4-level paging kernel via kexec() when
+	 * original kernel worked in 5-level paging mode.
+	 *
+	 * For the trampoline, we need the top page table to reside in lower
+	 * memory as we don't have a way to load 64-bit values into CR3 in
+	 * 32-bit mode.
+	 *
+	 * We go though the trampoline even if we don't have to: if we're
+	 * already in a desired paging mode. This way the trampoline code gets
+	 * tested on every boot.
 	 */
 
 	/* Make sure we have GDT with 32-bit code segment */
@@ -336,13 +352,18 @@ ENTRY(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
+	/*
+	 * Load the address of trampoline_return() into RDI.
+	 * It will be used by the trampoline to return to the main code.
+	 */
+	leaq	trampoline_return(%rip), %rdi
 
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
-	leaq	compatible_mode(%rip), %rax
+	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
 	pushq	%rax
 	lretq
-lvl5:
+trampoline_return:
 	/* Restore the stack, the 32-bit trampoline uses its own stack */
 	leaq	boot_stack_end(%rbx), %rsp
 
@@ -492,8 +513,14 @@ relocated:
 	jmp	*%rax
 
 	.code32
+/*
+ * This is the 32-bit trampoline that will be copied over to low memory.
+ *
+ * RDI contains the return address (might be above 4G).
+ * ECX contains the base address of the trampoline memory.
+ * Non zero RDX on return means we need to enable 5-level paging.
+ */
 ENTRY(trampoline_32bit_src)
-compatible_mode:
 	/* Set up data and stack segments */
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
@@ -534,24 +561,34 @@ compatible_mode:
 1:
 	movl	%eax, %cr4
 
-	/* Calculate address we are running at */
-	call	1f
-1:	popl	%edi
-	subl	$1b, %edi
+	/* Calculate address of paging_enabled() once we are executing in the trampoline */
+	leal	paging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
 
-	/* Prepare stack for far return to Long Mode */
+	/* Prepare the stack for far return to Long Mode */
 	pushl	$__KERNEL_CS
-	leal	lvl5(%edi), %eax
-	push	%eax
+	pushl	%eax
 
-	/* Enable paging back */
+	/* Enable paging again */
 	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 
 	lret
 
+	.code64
+paging_enabled:
+	/* Return from the trampoline */
+	jmp	*%rdi
+
+	/*
+         * The trampoline code has a size limit.
+         * Make sure we fail to compile if the trampoline code grows
+         * beyond TRAMPOLINE_32BIT_CODE_SIZE bytes.
+	 */
+	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
+
+	.code32
 no_longmode:
-	/* This isn't an x86-64 CPU so hang */
+	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
 	hlt
 	jmp     1b
