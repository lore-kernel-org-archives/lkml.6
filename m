Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeCLMVq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:21:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53161 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeCLMVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:21:44 -0400
Date: Mon, 12 Mar 2018 05:19:48 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-0a1756bd2897951c03c1cb671bdfd40729ac2177@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, bp@alien8.de,
        luto@amacapital.net, mingo@kernel.org, brgerst@gmail.com,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        willy@infradead.org, gorcunov@openvz.org,
        torvalds@linux-foundation.org, bp@suse.de, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, dvlasenk@redhat.com
Reply-To: bp@alien8.de, luto@amacapital.net, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, gorcunov@openvz.org,
        willy@infradead.org, torvalds@linux-foundation.org, bp@suse.de,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        dvlasenk@redhat.com, brgerst@gmail.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com
In-Reply-To: <20180312100246.89175-4-kirill.shutemov@linux.intel.com>
References: <20180312100246.89175-4-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Use page table in trampoline
 memory
Git-Commit-ID: 0a1756bd2897951c03c1cb671bdfd40729ac2177
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

Commit-ID:  0a1756bd2897951c03c1cb671bdfd40729ac2177
Gitweb:     https://git.kernel.org/tip/0a1756bd2897951c03c1cb671bdfd40729ac2177
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 12 Mar 2018 13:02:45 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 11:49:25 +0100

x86/boot/compressed/64: Use page table in trampoline memory

If a bootloader enables 64-bit mode with 4-level paging, we might need to
switch over to 5-level paging. The switching requires the disabling
paging. It works fine if kernel itself is loaded below 4G.

But if the bootloader put the kernel above 4G (i.e. in kexec() case),
we would lose control as soon as paging is disabled, because the code
becomes unreachable to the CPU.

To handle the situation, we need a trampoline in lower memory that would
take care of switching on 5-level paging.

Apart from the trampoline code itself we also need a place to store
top-level page table in lower memory as we don't have a way to load
64-bit values into CR3 in 32-bit mode. We only really need 8 bytes there
as we only use the very first entry of the page table. But we allocate a
whole page anyway.

This patch switches 32-bit code to use page table in trampoline memory.

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
Link: http://lkml.kernel.org/r/20180312100246.89175-4-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 47 +++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 12915511be61..959ca07a58d9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -336,23 +336,6 @@ ENTRY(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
-	/* Check if we need to enable 5-level paging */
-	cmpq	$0, %rdx
-	jz	lvl5
-
-	/* Clear additional page table */
-	leaq	lvl5_pgtable(%rbx), %rdi
-	xorq	%rax, %rax
-	movq	$(PAGE_SIZE/8), %rcx
-	rep	stosq
-
-	/*
-	 * Setup current CR3 as the first and only entry in a new top level
-	 * page table.
-	 */
-	movq	%cr3, %rdi
-	leaq	0x7 (%rdi), %rax
-	movq	%rax, lvl5_pgtable(%rbx)
 
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
@@ -524,13 +507,31 @@ compatible_mode:
 	btrl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 
-	/* Point CR3 to 5-level paging */
-	leal	lvl5_pgtable(%ebx), %eax
-	movl	%eax, %cr3
+	/* Check what paging mode we want to be in after the trampoline */
+	cmpl	$0, %edx
+	jz	1f
 
-	/* Enable PAE and LA57 mode */
+	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
 	movl	%cr4, %eax
-	orl	$(X86_CR4_PAE | X86_CR4_LA57), %eax
+	testl	$X86_CR4_LA57, %eax
+	jnz	3f
+	jmp	2f
+1:
+	/* We want 4-level paging: don't touch CR3 if it already points to 4-level page tables */
+	movl	%cr4, %eax
+	testl	$X86_CR4_LA57, %eax
+	jz	3f
+2:
+	/* Point CR3 to the trampoline's new top level page table */
+	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%ecx), %eax
+	movl	%eax, %cr3
+3:
+	/* Enable PAE and LA57 (if required) paging modes */
+	movl	$X86_CR4_PAE, %eax
+	cmpl	$0, %edx
+	jz	1f
+	orl	$X86_CR4_LA57, %eax
+1:
 	movl	%eax, %cr4
 
 	/* Calculate address we are running at */
@@ -611,5 +612,3 @@ boot_stack_end:
 	.balign 4096
 pgtable:
 	.fill BOOT_PGT_SIZE, 1, 0
-lvl5_pgtable:
-	.fill PAGE_SIZE, 1, 0
