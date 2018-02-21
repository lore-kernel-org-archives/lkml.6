Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225JB1HHW4EkyH7Upz9TZKx5HLfNvG4uyWcs7awnzpkgvjic9SX5kDH6iWX36UK/Z2hF/7sc
ARC-Seal: i=1; a=rsa-sha256; t=1519218596; cv=none;
        d=google.com; s=arc-20160816;
        b=rY1Rx9ZCsV+v/BdeamAF5/cAASfRDmtNYfRRzgyo/tYEiw3EMZ7QHKy+DyKecyG7hH
         B+TaDVOqLO9ZaANT3/vhNez9lkCPtJbMVWio4N+aRh+fcy0EMlt23vzqnajNCvWSzLdS
         iw8T62l5s8UiK8FJSen9MFWXWp/LcFs0kGugxdGwt212Ar1cz6gg+3AHuUxdd+MdoGK9
         8gAMxUqFSeESSx/SXfCK8v9M4SYeU0traH8y0QRgfNgp4cViwn63LN9Q/QzHR+C2v5xR
         foHqA72CvlStrO6Z/OYnpKIBb/2lTZq+DynL/GomV56yh/jqt3hObZUdTgeWOuryiXr9
         xEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nilGdLHVqRM1COoomapq2C6JPZRoaWSGqR4iIDSwcRM=;
        b=MwErns3EQl8GqpUELHM9mJFMDqEWmD6zb2enIz6SJ96e/qqRrY4VaGSXCKyEAufUKs
         n9wOhAaLfYXImQEa2Beq5SssasfDMglUEIjHclm4A2nUhQxJtrtxlWUAw9dS7Rerigx0
         1s7mUie52gQkI0HN4rzS0+XxGwkW8ucuTHjwkUnr8mtGBCx2KNpgTss4nZ9obvFTgOEr
         DDuF/La26As60o0pdPMolaVGORuOHH3LkOGsaY4l9DoF6VYNWwg91fF/isO4i0/oznCo
         WU98I0zaRjW/GIzhMzhqs2XkjDQnC62ZWFJF/OohoYeWj4qwL0qcC/VexKFTryzOwqUJ
         9Bcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	dan.j.williams@intel.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 061/163] x86/entry/64: Interleave XOR register clearing with PUSH instructions
Date: Wed, 21 Feb 2018 13:48:10 +0100
Message-Id: <20180221124533.825154281@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015557071139759?=
X-GMAIL-MSGID: =?utf-8?q?1593016158390041828?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit f7bafa2b05ef25eda1d9179fd930b0330cf2b7d1 upstream.

Same as is done for syscalls, interleave XOR with PUSH instructions
for exceptions/interrupts, in order to minimize the cost of the
additional instructions required for register clearing.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-4-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   40 +++++++++++++++++++---------------------
 arch/x86/entry/entry_64.S |   30 +++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 30 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -101,44 +101,42 @@ For 32-bit we have the following convent
 	addq	$-(15*8), %rsp
 	.endm
 
-	.macro SAVE_REGS offset=0
+	.macro SAVE_AND_CLEAR_REGS offset=0
+	/*
+	 * Save registers and sanitize registers of values that a
+	 * speculation attack might otherwise want to exploit. The
+	 * lower registers are likely clobbered well before they
+	 * could be put to use in a speculative execution gadget.
+	 * Interleave XOR with PUSH for better uop scheduling:
+	 */
 	movq %rdi, 14*8+\offset(%rsp)
 	movq %rsi, 13*8+\offset(%rsp)
 	movq %rdx, 12*8+\offset(%rsp)
 	movq %rcx, 11*8+\offset(%rsp)
 	movq %rax, 10*8+\offset(%rsp)
 	movq %r8,  9*8+\offset(%rsp)
+	xorq %r8, %r8				/* nospec r8 */
 	movq %r9,  8*8+\offset(%rsp)
+	xorq %r9, %r9				/* nospec r9 */
 	movq %r10, 7*8+\offset(%rsp)
+	xorq %r10, %r10				/* nospec r10 */
 	movq %r11, 6*8+\offset(%rsp)
+	xorq %r11, %r11				/* nospec r11 */
 	movq %rbx, 5*8+\offset(%rsp)
+	xorl %ebx, %ebx				/* nospec rbx */
 	movq %rbp, 4*8+\offset(%rsp)
+	xorl %ebp, %ebp				/* nospec rbp */
 	movq %r12, 3*8+\offset(%rsp)
+	xorq %r12, %r12				/* nospec r12 */
 	movq %r13, 2*8+\offset(%rsp)
+	xorq %r13, %r13				/* nospec r13 */
 	movq %r14, 1*8+\offset(%rsp)
+	xorq %r14, %r14				/* nospec r14 */
 	movq %r15, 0*8+\offset(%rsp)
+	xorq %r15, %r15				/* nospec r15 */
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
-	/*
-	 * Sanitize registers of values that a speculation attack
-	 * might otherwise want to exploit. The lower registers are
-	 * likely clobbered well before they could be put to use in
-	 * a speculative execution gadget:
-	 */
-	.macro CLEAR_REGS_NOSPEC
-	xorl %ebp, %ebp
-	xorl %ebx, %ebx
-	xorq %r8, %r8
-	xorq %r9, %r9
-	xorq %r10, %r10
-	xorq %r11, %r11
-	xorq %r12, %r12
-	xorq %r13, %r13
-	xorq %r14, %r14
-	xorq %r15, %r15
-	.endm
-
 	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
@@ -177,7 +175,7 @@ For 32-bit we have the following convent
  * is just setting the LSB, which makes it an invalid stack address and is also
  * a signal to the unwinder that it's a pt_regs pointer in disguise.
  *
- * NOTE: This macro must be used *after* SAVE_REGS because it corrupts
+ * NOTE: This macro must be used *after* SAVE_AND_CLEAR_REGS because it corrupts
  * the original rbp.
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -565,8 +565,7 @@ END(irq_entries_start)
 1:
 
 	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_REGS
-	CLEAR_REGS_NOSPEC
+	SAVE_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1114,8 +1113,7 @@ ENTRY(xen_failsafe_callback)
 	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
 	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_REGS
-	CLEAR_REGS_NOSPEC
+	SAVE_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
@@ -1159,8 +1157,7 @@ idtentry machine_check		do_mce			has_err
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_REGS 8
-	CLEAR_REGS_NOSPEC
+	SAVE_AND_CLEAR_REGS 8
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1211,8 +1208,7 @@ END(paranoid_exit)
 ENTRY(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_REGS 8
-	CLEAR_REGS_NOSPEC
+	SAVE_AND_CLEAR_REGS 8
 	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
@@ -1399,18 +1395,34 @@ ENTRY(nmi)
 	pushq   (%rdx)		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   %rax		/* pt_regs->ax */
+	/*
+	 * Sanitize registers of values that a speculation attack
+	 * might otherwise want to exploit. The lower registers are
+	 * likely clobbered well before they could be put to use in
+	 * a speculative execution gadget. Interleave XOR with PUSH
+	 * for better uop scheduling:
+	 */
 	pushq   %r8		/* pt_regs->r8 */
+	xorq    %r8, %r8	/* nospec   r8 */
 	pushq   %r9		/* pt_regs->r9 */
+	xorq    %r9, %r9	/* nospec   r9 */
 	pushq   %r10		/* pt_regs->r10 */
+	xorq    %r10, %r10	/* nospec   r10 */
 	pushq   %r11		/* pt_regs->r11 */
+	xorq    %r11, %r11	/* nospec   r11*/
 	pushq	%rbx		/* pt_regs->rbx */
+	xorl    %ebx, %ebx	/* nospec   rbx*/
 	pushq	%rbp		/* pt_regs->rbp */
+	xorl    %ebp, %ebp	/* nospec   rbp*/
 	pushq	%r12		/* pt_regs->r12 */
+	xorq    %r12, %r12	/* nospec   r12*/
 	pushq	%r13		/* pt_regs->r13 */
+	xorq    %r13, %r13	/* nospec   r13*/
 	pushq	%r14		/* pt_regs->r14 */
+	xorq    %r14, %r14	/* nospec   r14*/
 	pushq	%r15		/* pt_regs->r15 */
+	xorq    %r15, %r15	/* nospec   r15*/
 	UNWIND_HINT_REGS
-	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	/*
