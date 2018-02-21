Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227YaJwRGmHeUxnzwin+AwK4J6aBuAX9sugPpg89lbINmZLi1LNZj1wxoniORSQTcnmaSVKw
ARC-Seal: i=1; a=rsa-sha256; t=1519218590; cv=none;
        d=google.com; s=arc-20160816;
        b=PLR03Vz93b+UkHejAoTBs2YbX+kDFstqC6EgHfkkZ4bnMwtk/6mjCmNQwi5XPJ6JCn
         3P75NgXHfQ9vpbu2S66hAzl+9Uy8gnatS5vEbl+nvNXwAAHYYuEu8I+Eqr04vucw3FqP
         RoTSM3WY91o4jup/fwP8GaeSxmNx/e/vevXPOcm+oMds5LSu4tmkXcDhfF7Mfd4IBckV
         4lZSIb6dztuAbuA0dLNI438zpv6l4vtiJ2Id9byT6USON5RDQX+ZJpUoreMAIw8ZA+bW
         29pdXVcYcWoaPaCyk6d/8HpG3zw5hhiBvr2ZoOCsOa1Lk4BC1J8zSFxTt/hO5JvWFl0y
         DzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I0zv8DpuofqvXDixSaiBIyXNHwAbgSuY5UMwPRrwxbg=;
        b=c7wOt0Sc2NOJ0EZ+PyIOCsFzhVB91jKn40QLNRY4Z+Yi8u+OfqBBzKMHyg+a9ypZsk
         ggbEEU8o8KVchWP3sbOQKYQyqzYYpFRCK4sQBxyjbfGuzkD3KiyMpVFlg6/PzbtfEEfO
         FqPLAEgr9vaQISEWuHOSSYmTY+NxXYbv2L8LlVv9kBm27NfqNDUeAtid0WIRswMZPj7e
         xFMsQVWhVrOsMV8d6jHnBqaiZbuhKaAzEHAYZ8rBfPPAsoV3zesWZRqjp1N48f5O3GSx
         0D5vm3hKZlRiuX3QbXiv0yHW7UBGhzX/s8GJYsRxjtquFG2BEkQ+2UHbpH7mXcyYw0Wz
         Md0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	dan.j.williams@intel.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 059/163] x86/entry/64: Merge SAVE_C_REGS and SAVE_EXTRA_REGS, remove unused extensions
Date: Wed, 21 Feb 2018 13:48:08 +0100
Message-Id: <20180221124533.725188829@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015551426490024?=
X-GMAIL-MSGID: =?utf-8?q?1593016153205345113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 2e3f0098bc45f710a2f4cbcc94b80a1fae7a99a1 upstream.

All current code paths call SAVE_C_REGS and then immediately
SAVE_EXTRA_REGS. Therefore, merge these two macros and order the MOV
sequeneces properly.

While at it, remove the macros to save all except specific registers,
as these macros have been unused for a long time.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-2-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   57 ++++++++++++----------------------------------
 arch/x86/entry/entry_64.S |   12 +++------
 2 files changed, 19 insertions(+), 50 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -101,49 +101,22 @@ For 32-bit we have the following convent
 	addq	$-(15*8), %rsp
 	.endm
 
-	.macro SAVE_C_REGS_HELPER offset=0 rax=1 rcx=1 r8910=1 r11=1
-	.if \r11
-	movq %r11, 6*8+\offset(%rsp)
-	.endif
-	.if \r8910
-	movq %r10, 7*8+\offset(%rsp)
-	movq %r9,  8*8+\offset(%rsp)
-	movq %r8,  9*8+\offset(%rsp)
-	.endif
-	.if \rax
-	movq %rax, 10*8+\offset(%rsp)
-	.endif
-	.if \rcx
-	movq %rcx, 11*8+\offset(%rsp)
-	.endif
-	movq %rdx, 12*8+\offset(%rsp)
-	movq %rsi, 13*8+\offset(%rsp)
+	.macro SAVE_REGS offset=0
 	movq %rdi, 14*8+\offset(%rsp)
-	UNWIND_HINT_REGS offset=\offset extra=0
-	.endm
-	.macro SAVE_C_REGS offset=0
-	SAVE_C_REGS_HELPER \offset, 1, 1, 1, 1
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RAX_RCX offset=0
-	SAVE_C_REGS_HELPER \offset, 0, 0, 1, 1
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_R891011
-	SAVE_C_REGS_HELPER 0, 1, 1, 0, 0
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RCX_R891011
-	SAVE_C_REGS_HELPER 0, 1, 0, 0, 0
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RAX_RCX_R11
-	SAVE_C_REGS_HELPER 0, 0, 0, 1, 0
-	.endm
-
-	.macro SAVE_EXTRA_REGS offset=0
-	movq %r15, 0*8+\offset(%rsp)
-	movq %r14, 1*8+\offset(%rsp)
-	movq %r13, 2*8+\offset(%rsp)
-	movq %r12, 3*8+\offset(%rsp)
-	movq %rbp, 4*8+\offset(%rsp)
+	movq %rsi, 13*8+\offset(%rsp)
+	movq %rdx, 12*8+\offset(%rsp)
+	movq %rcx, 11*8+\offset(%rsp)
+	movq %rax, 10*8+\offset(%rsp)
+	movq %r8,  9*8+\offset(%rsp)
+	movq %r9,  8*8+\offset(%rsp)
+	movq %r10, 7*8+\offset(%rsp)
+	movq %r11, 6*8+\offset(%rsp)
 	movq %rbx, 5*8+\offset(%rsp)
+	movq %rbp, 4*8+\offset(%rsp)
+	movq %r12, 3*8+\offset(%rsp)
+	movq %r13, 2*8+\offset(%rsp)
+	movq %r14, 1*8+\offset(%rsp)
+	movq %r15, 0*8+\offset(%rsp)
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
@@ -197,7 +170,7 @@ For 32-bit we have the following convent
  * is just setting the LSB, which makes it an invalid stack address and is also
  * a signal to the unwinder that it's a pt_regs pointer in disguise.
  *
- * NOTE: This macro must be used *after* SAVE_EXTRA_REGS because it corrupts
+ * NOTE: This macro must be used *after* SAVE_REGS because it corrupts
  * the original rbp.
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -573,8 +573,7 @@ END(irq_entries_start)
 1:
 
 	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_C_REGS
-	SAVE_EXTRA_REGS
+	SAVE_REGS
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
@@ -1132,8 +1131,7 @@ ENTRY(xen_failsafe_callback)
 	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
 	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_C_REGS
-	SAVE_EXTRA_REGS
+	SAVE_REGS
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
@@ -1178,8 +1176,7 @@ idtentry machine_check		do_mce			has_err
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_C_REGS 8
-	SAVE_EXTRA_REGS 8
+	SAVE_REGS 8
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
@@ -1231,8 +1228,7 @@ END(paranoid_exit)
 ENTRY(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_C_REGS 8
-	SAVE_EXTRA_REGS 8
+	SAVE_REGS 8
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
