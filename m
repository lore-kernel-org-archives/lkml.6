Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Sj8NDJZymcxd+vrBTMCiRwggwovcQfZg6VAEIqYbjmsns91w/20jI9sikDRBAjMHQGe6q
ARC-Seal: i=1; a=rsa-sha256; t=1519218567; cv=none;
        d=google.com; s=arc-20160816;
        b=BLZ3Y6Q1qGTJqPllIwIfBi046ipv/Pzwl7RAhBwf5B+PaRcyqrjYZEfEiz8xS6sZoh
         EsRXhCJ1jeDTY4b4GEWFmnVrPh6yvK7X1t0L3yGhq2ZIVmhy7T/3w7pUr9sPd9Adn8vD
         7wBJ+WvcNqj+5LzldWqJg57nQlH75xhzucm+jucXs/LWT3mn6msH300T/5FkKVRyG4Hv
         LMOcJPFwnn8tY6xC2IljOsKIzMF4fIUlGwsXM+hwPzjcLbhyvUL5p63sZ48DGCL+RX7o
         gYbD44Y/BOjk5T+aRHLwZugAr+SUBDAWjmFRPcQsAyeeRM8Caiea656Y9L2elH/q4LVk
         TPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DbSwcU1EDgrYraAKeULX0sFIJMCXUBAD2MNMfJXpu70=;
        b=oVTM9nwYrZeAwUtmu9fdEt91V0kWIaqKW0LYMGGIrsmL794aVBTd9CYJ6RgcQxwxgw
         YQkq2tbAc95jhUogGwI8Bf1iI9Q/rMa29IOdLRHBvPSHcmeBTrmm4hPW0IiTYrn+fmy2
         mKM3TLcc/mqGvnOEtAkbN5Jjk7AidrBCeG57c+QbIH3vT0MCj1+aV1nmJF7Cs+iWvnrk
         Y8GDU2zw6jDNHfRhqrcFoiQzHxtZvbHL5H7Ba48RrXDhrPh3tjhbHpkTY1a39U9YUWPm
         +7KQ3vbuV0BpJgKXXZ8Q/0QJUnpwVza754RbaRzq0M0Viv4C7gbB9Brl3YNAAHHMihdE
         4Uvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 058/163] x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface
Date: Wed, 21 Feb 2018 13:48:07 +0100
Message-Id: <20180221124533.671163678@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015548902748205?=
X-GMAIL-MSGID: =?utf-8?q?1593016128947257780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 3ac6d8c787b835b997eb23e43e09aa0895ef7d58 upstream.

Clear the 'extra' registers on entering the 64-bit kernel for exceptions
and interrupts. The common registers are not cleared since they are
likely clobbered well before they can be exploited in a speculative
execution attack.

Originally-From: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com
[ Made small improvements to the changelog and the code comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   19 +++++++++++++++++++
 arch/x86/entry/entry_64.S |    6 +++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -147,6 +147,25 @@ For 32-bit we have the following convent
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
+	/*
+	 * Sanitize registers of values that a speculation attack
+	 * might otherwise want to exploit. The lower registers are
+	 * likely clobbered well before they could be put to use in
+	 * a speculative execution gadget:
+	 */
+	.macro CLEAR_REGS_NOSPEC
+	xorl %ebp, %ebp
+	xorl %ebx, %ebx
+	xorq %r8, %r8
+	xorq %r9, %r9
+	xorq %r10, %r10
+	xorq %r11, %r11
+	xorq %r12, %r12
+	xorq %r13, %r13
+	xorq %r14, %r14
+	xorq %r15, %r15
+	.endm
+
 	.macro POP_EXTRA_REGS
 	popq %r15
 	popq %r14
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -575,6 +575,7 @@ END(irq_entries_start)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1133,6 +1134,7 @@ ENTRY(xen_failsafe_callback)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
@@ -1178,6 +1180,7 @@ ENTRY(paranoid_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1230,8 +1233,8 @@ ENTRY(error_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
-	xorl	%ebx, %ebx
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1428,6 +1431,7 @@ ENTRY(nmi)
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
 	UNWIND_HINT_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	/*
