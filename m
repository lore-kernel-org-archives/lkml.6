Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeEPIB6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:01:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:55442 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbeEPIBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:01:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="56324660"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 1/2] x86/boot/compressed/64: Set up GOT for paging_prepare() and cleanup_trampoline()
Date: Wed, 16 May 2018 11:01:28 +0300
Message-Id: <20180516080131.27913-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516080131.27913-1-kirill.shutemov@linux.intel.com>
References: <20180516080131.27913-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric and Hugh have reported instant reboot due to my recent changes in
decompression code.

The root cause is that I didn't realize that we need to adjust GOT to be
able to run C code that early.

The problem is only visible with an older toolchain. Binutils >= 2.24 is
able to eliminate GOT references by replacing them with RIP-relative
address loads[1].

We need to adjust GOT two times:
 - before calling paging_prepare() using the initial load address
 - before calling C code from the relocated kernel

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=80d873266dec

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 194a9749c73d ("x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: Hugh Dickins <hughd@google.com>
---
 arch/x86/boot/compressed/head_64.S | 68 ++++++++++++++++++++++++------
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
-- 
2.17.0
