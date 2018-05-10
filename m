Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966803AbeEJRik (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:38:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:9615 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966774AbeEJRi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:38:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,386,1520924400";
   d="scan'208";a="223230906"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] x86/boot/compressed/64: Set up GOT for paging_prepare() and cleanup_trampoline()
Date: Thu, 10 May 2018 20:38:05 +0300
Message-Id: <20180510173806.4332-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510173806.4332-1-kirill.shutemov@linux.intel.com>
References: <20180510173806.4332-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric and Hugh have reported instant reboot due to my recent changes in
decompression code.

The root cause is that I didn't realize that we need to adjust GOT to be
able to run C code that early.

The problem is only visible with old toolchain. Binutils >= 2.24 is able
to eliminate GOT references by replacing them with RIP-relative address
loads[1].

We need to adjust GOT two times:
 - before calling paging_prepare() with address the binary was loaded by bootloader
 - before relocating the kernel to the new place with relocation address

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=80d873266dec

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 194a9749c73d ("x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: Hugh Dickins <hughd@google.com>
---
 arch/x86/boot/compressed/head_64.S | 66 ++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fca012baba19..6cbb2d64c91e 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -305,6 +305,21 @@ ENTRY(startup_64)
 	/* Set up the stack */
 	leaq	boot_stack_end(%rbx), %rsp
 
+	/*
+	 * paging_prepare() and cleanup_trampoline() below can have GOT
+	 * references. Adjust the table with address we are running at.
+	 */
+
+	/* The GOP was not adjusted before */
+	xorq	%rax, %rax
+
+	/* Calculate the address the binary is loaded at. */
+	call	1f
+1:	popq	%rdi
+	subq	$1b, %rdi
+
+	call	adjust_gop
+
 	/*
 	 * At this point we are in long mode with 4-level paging enabled,
 	 * but we might want to enable 5-level paging or vice versa.
@@ -381,6 +396,24 @@ trampoline_return:
 	pushq	$0
 	popfq
 
+	/*
+	 * Previously we've adjusted the GOT with address the binary was
+	 * loaded at. Now we need to re-adjust for relocation address.
+	 */
+
+	/*
+	 * Calculate the address the binary is loaded at.
+	 * This address was used to adjust the table before and we need to
+	 * undo the change.
+	 */
+	call	1f
+1:	popq	%rax
+	subq	$1b, %rax
+
+	/* The new adjustment is relocation address */
+	movq	%rbx, %rdi
+	call	adjust_gop
+
 /*
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
@@ -481,19 +514,6 @@ relocated:
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
@@ -512,6 +532,26 @@ relocated:
  */
 	jmp	*%rax
 
+/*
+ * Adjust global offest table
+ *
+ * RAX is previous adjustment of the table to undo (0 if it's the first time we touch GOP).
+ * RDI is the new adjustment to apply.
+ */
+adjust_gop:
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
