Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF3FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E420856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4E420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbeGWNru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:47:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbeGWNrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:49 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8E43CCB4;
        Mon, 23 Jul 2018 12:45:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denys Vlasenko <dvlasenk@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 029/107] x86/asm/entry/32: Simplify pushes of zeroed pt_regs->REGs
Date:   Mon, 23 Jul 2018 14:41:23 +0200
Message-Id: <20180723122414.287788276@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denys Vlasenko <dvlasenk@redhat.com>

commit 778843f934e362ed4ed734520f60a44a78a074b4 upstream

Use of a temporary R8 register here seems to be unnecessary.

"push %r8" is a two-byte insn (it needs REX prefix to specify R8),
"push $0" is two-byte too. It seems just using the latter would be
no worse.

Thus, code had an unnecessary "xorq %r8,%r8" insn.
It probably costs nothing in execution time here since we are probably
limited by store bandwidth at this point, but still.

Run-tested under QEMU: 32-bit calls still work:

 / # ./test_syscall_vdso32
 [RUN]	Executing 6-argument 32-bit syscall via VDSO
 [OK]	Arguments are preserved across syscall
 [NOTE]	R11 has changed:0000000000200ed7 - assuming clobbered by SYSRET insn
 [OK]	R8..R15 did not leak kernel data
 [RUN]	Executing 6-argument 32-bit syscall via INT 80
 [OK]	Arguments are preserved across syscall
 [OK]	R8..R15 did not leak kernel data
 [RUN]	Running tests under ptrace
 [RUN]	Executing 6-argument 32-bit syscall via VDSO
 [OK]	Arguments are preserved across syscall
 [NOTE]	R11 has changed:0000000000200ed7 - assuming clobbered by SYSRET insn
 [OK]	R8..R15 did not leak kernel data
 [RUN]	Executing 6-argument 32-bit syscall via INT 80
 [OK]	Arguments are preserved across syscall
 [OK]	R8..R15 did not leak kernel data

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/1462201010-16846-1-git-send-email-dvlasenk@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/entry/entry_64_compat.S |   45 ++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -79,24 +79,23 @@ ENTRY(entry_SYSENTER_compat)
 	ASM_CLAC			/* Clear AC after saving FLAGS */
 
 	pushq	$__USER32_CS		/* pt_regs->cs */
-	xorq    %r8,%r8
-	pushq	%r8			/* pt_regs->ip = 0 (placeholder) */
+	pushq	$0			/* pt_regs->ip = 0 (placeholder) */
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
 	pushq	%rdx			/* pt_regs->dx */
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   %r8                     /* pt_regs->r8  = 0 */
-	pushq   %r8                     /* pt_regs->r9  = 0 */
-	pushq   %r8                     /* pt_regs->r10 = 0 */
-	pushq   %r8                     /* pt_regs->r11 = 0 */
+	pushq   $0			/* pt_regs->r8  = 0 */
+	pushq   $0			/* pt_regs->r9  = 0 */
+	pushq   $0			/* pt_regs->r10 = 0 */
+	pushq   $0			/* pt_regs->r11 = 0 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
-	pushq   %r8                     /* pt_regs->r12 = 0 */
-	pushq   %r8                     /* pt_regs->r13 = 0 */
-	pushq   %r8                     /* pt_regs->r14 = 0 */
-	pushq   %r8                     /* pt_regs->r15 = 0 */
+	pushq   $0			/* pt_regs->r12 = 0 */
+	pushq   $0			/* pt_regs->r13 = 0 */
+	pushq   $0			/* pt_regs->r14 = 0 */
+	pushq   $0			/* pt_regs->r15 = 0 */
 	cld
 
 	/*
@@ -185,17 +184,16 @@ ENTRY(entry_SYSCALL_compat)
 	pushq	%rdx			/* pt_regs->dx */
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	xorq    %r8,%r8
-	pushq   %r8                     /* pt_regs->r8  = 0 */
-	pushq   %r8                     /* pt_regs->r9  = 0 */
-	pushq   %r8                     /* pt_regs->r10 = 0 */
-	pushq   %r8                     /* pt_regs->r11 = 0 */
+	pushq   $0			/* pt_regs->r8  = 0 */
+	pushq   $0			/* pt_regs->r9  = 0 */
+	pushq   $0			/* pt_regs->r10 = 0 */
+	pushq   $0			/* pt_regs->r11 = 0 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
-	pushq   %r8                     /* pt_regs->r12 = 0 */
-	pushq   %r8                     /* pt_regs->r13 = 0 */
-	pushq   %r8                     /* pt_regs->r14 = 0 */
-	pushq   %r8                     /* pt_regs->r15 = 0 */
+	pushq   $0			/* pt_regs->r12 = 0 */
+	pushq   $0			/* pt_regs->r13 = 0 */
+	pushq   $0			/* pt_regs->r14 = 0 */
+	pushq   $0			/* pt_regs->r15 = 0 */
 
 	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
@@ -292,11 +290,10 @@ ENTRY(entry_INT80_compat)
 	pushq	%rdx			/* pt_regs->dx */
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	xorq    %r8,%r8
-	pushq   %r8                     /* pt_regs->r8  = 0 */
-	pushq   %r8                     /* pt_regs->r9  = 0 */
-	pushq   %r8                     /* pt_regs->r10 = 0 */
-	pushq   %r8                     /* pt_regs->r11 = 0 */
+	pushq   $0			/* pt_regs->r8  = 0 */
+	pushq   $0			/* pt_regs->r9  = 0 */
+	pushq   $0			/* pt_regs->r10 = 0 */
+	pushq   $0			/* pt_regs->r11 = 0 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	pushq   %rbp                    /* pt_regs->rbp */
 	pushq   %r12                    /* pt_regs->r12 */


