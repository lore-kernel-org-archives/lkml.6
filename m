Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeEPKhP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:37:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39827 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeEPKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:37:14 -0400
Date: Wed, 16 May 2018 03:35:52 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-5c9b0b1c49881c680d4a56b9d9e03dfb3160fd4d@git.kernel.org>
Cc: hughd@google.com, eric.dumazet@gmail.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: hughd@google.com, hpa@zytor.com, eric.dumazet@gmail.com,
        mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180516080131.27913-2-kirill.shutemov@linux.intel.com>
References: <20180516080131.27913-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/compressed/64: Set up GOT for
 paging_prepare() and cleanup_trampoline()
Git-Commit-ID: 5c9b0b1c49881c680d4a56b9d9e03dfb3160fd4d
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

Commit-ID:  5c9b0b1c49881c680d4a56b9d9e03dfb3160fd4d
Gitweb:     https://git.kernel.org/tip/5c9b0b1c49881c680d4a56b9d9e03dfb3160fd4d
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 16 May 2018 11:01:28 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 16 May 2018 12:15:13 +0200

x86/boot/compressed/64: Set up GOT for paging_prepare() and cleanup_trampoline()

Eric and Hugh have reported instant reboot due to my recent changes in
decompression code.

The root cause is that I didn't realize that we need to adjust GOT to be
able to run C code that early.

The problem is only visible with an older toolchain. Binutils >= 2.24 is
able to eliminate GOT references by replacing them with RIP-relative
address loads:

  https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=80d873266dec

We need to adjust GOT two times:

 - before calling paging_prepare() using the initial load address
 - before calling C code from the relocated kernel

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 194a9749c73d ("x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G")
Link: http://lkml.kernel.org/r/20180516080131.27913-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 68 ++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fca012baba19..d17af6a4bfc9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -305,6 +305,25 @@ ENTRY(startup_64)
 	/* Set up the stack */
 	leaq	boot_stack_end(%rbx), %rsp
 
+	/*
+	 * paging_prepare() and cleanup_trampoline() below can have GOT
+	 * references. Adjust the table with address we are running at.
+	 *
+	 * Zero RAX for adjust_got: the GOT was not adjusted before;
+	 * there's no adjustment to undo.
+	 */
+	xorq	%rax, %rax
+
+	/*
+	 * Calculate the address the binary is loaded at and use it as
+	 * a GOT adjustment.
+	 */
+	call	1f
+1:	popq	%rdi
+	subq	$1b, %rdi
+
+	call	adjust_got
+
 	/*
 	 * At this point we are in long mode with 4-level paging enabled,
 	 * but we might want to enable 5-level paging or vice versa.
@@ -381,6 +400,21 @@ trampoline_return:
 	pushq	$0
 	popfq
 
+	/*
+	 * Previously we've adjusted the GOT with address the binary was
+	 * loaded at. Now we need to re-adjust for relocation address.
+	 *
+	 * Calculate the address the binary is loaded at, so that we can
+	 * undo the previous GOT adjustment.
+	 */
+	call	1f
+1:	popq	%rax
+	subq	$1b, %rax
+
+	/* The new adjustment is the relocation address */
+	movq	%rbx, %rdi
+	call	adjust_got
+
 /*
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
@@ -481,19 +515,6 @@ relocated:
 	shrq	$3, %rcx
 	rep	stosq
 
-/*
- * Adjust our own GOT
- */
-	leaq	_got(%rip), %rdx
-	leaq	_egot(%rip), %rcx
-1:
-	cmpq	%rcx, %rdx
-	jae	2f
-	addq	%rbx, (%rdx)
-	addq	$8, %rdx
-	jmp	1b
-2:
-	
 /*
  * Do the extraction, and jump to the new kernel..
  */
@@ -512,6 +533,27 @@ relocated:
  */
 	jmp	*%rax
 
+/*
+ * Adjust the global offset table
+ *
+ * RAX is the previous adjustment of the table to undo (use 0 if it's the
+ * first time we touch GOT).
+ * RDI is the new adjustment to apply.
+ */
+adjust_got:
+	/* Walk through the GOT adding the address to the entries */
+	leaq	_got(%rip), %rdx
+	leaq	_egot(%rip), %rcx
+1:
+	cmpq	%rcx, %rdx
+	jae	2f
+	subq	%rax, (%rdx)	/* Undo previous adjustment */
+	addq	%rdi, (%rdx)	/* Apply the new adjustment */
+	addq	$8, %rdx
+	jmp	1b
+2:
+	ret
+
 	.code32
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
