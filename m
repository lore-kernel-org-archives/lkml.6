Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225FzEUaeHxn7I8SCTXqIaivh3+ImzV+TRjEaLIynm7oTGblVuEio63BwR2EeKKSrqxT8OSf
ARC-Seal: i=1; a=rsa-sha256; t=1519218593; cv=none;
        d=google.com; s=arc-20160816;
        b=cZTBjxfoJKOTKHXxYREtfTHmLuNolJtRY0HXCUlU3i/peEwvVwKDhVdIV3TMF2L5Zx
         DunO/mknVOquZZFKxCCGPHyiQ3FAVNlmLqL2usGSwcG99P22RzEso/TAAoM7TxGY/PEh
         FzrtYGP+XVz+c5iRaVOSiFrx8BEw+yVL+V+8w5C6U4ZxkI02k5d8doBKAhrsNtCjV7KI
         /+YjFQ3whrAa6bIcDKCJ6bPI6JMfL+X4sGAkTAXZczdc5RfTSOEwHxLdIBnWdDn4kTii
         IaFgWCpDH1pb2BCnI/Wg3p5dGY4yMCPhqikyn3EtwMAJLd2IehoA3u8x9XBhMWag/Gce
         8mRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KZ/mRVTgra2LSqD3Sv6N9Rnst+w7rRJ68bCTJ0C1nbs=;
        b=a8rSJAGKDZ9jY4klksyODmb7gOLXQ6c0PZDczKy+ohJG2N5N7XMOyiRHR8vLdWW+8c
         Ewsn/ImGoXl+4oAoobvgZ3etamBs4ia1CX2nDtG/YSQXE/t+O5XqvLMBDO/SWVKs3Dje
         U5Gkb59Hk/+JlyRuW/2hAjg/5CJO9k8W9O9PDipgGbIm0x/uidLnO928lvgBQ4KCVmx+
         k0Ghh3Fvq+oUqeVc+dUYX+8A7bhxvbX7Nru3ktPgNFyDa5/x07QCHk845f96UI5wue0I
         6ekYl10GOFnxjAxlm7zq++jFib6sVuob1Ps/dFrOsWyV21YKOe+LkkVAgDW1kM9GmqMK
         fvag==
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
Subject: [PATCH 4.15 060/163] x86/entry/64: Merge the POP_C_REGS and POP_EXTRA_REGS macros into a single POP_REGS macro
Date: Wed, 21 Feb 2018 13:48:09 +0100
Message-Id: <20180221124533.779094705@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015554149942379?=
X-GMAIL-MSGID: =?utf-8?q?1593016156156208684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 502af0d70843c2a9405d7ba1f79b4b0305aaf5f5 upstream.

The two special, opencoded cases for POP_C_REGS can be handled by ASM
macros.

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
Link: http://lkml.kernel.org/r/20180211104949.12992-3-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   15 +++++++++++----
 arch/x86/entry/entry_64.S |   26 ++++----------------------
 2 files changed, 15 insertions(+), 26 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -139,25 +139,32 @@ For 32-bit we have the following convent
 	xorq %r15, %r15
 	.endm
 
-	.macro POP_EXTRA_REGS
+	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
 	popq %r13
 	popq %r12
 	popq %rbp
 	popq %rbx
-	.endm
-
-	.macro POP_C_REGS
+	.if \skip_r11rcx
+	popq %rsi
+	.else
 	popq %r11
+	.endif
 	popq %r10
 	popq %r9
 	popq %r8
 	popq %rax
+	.if \skip_r11rcx
+	popq %rsi
+	.else
 	popq %rcx
+	.endif
 	popq %rdx
 	popq %rsi
+	.if \pop_rdi
 	popq %rdi
+	.endif
 	.endm
 
 	.macro icebp
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -334,15 +334,7 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
 	UNWIND_HINT_EMPTY
-	POP_EXTRA_REGS
-	popq	%rsi	/* skip r11 */
-	popq	%r10
-	popq	%r9
-	popq	%r8
-	popq	%rax
-	popq	%rsi	/* skip rcx */
-	popq	%rdx
-	popq	%rsi
+	POP_REGS pop_rdi=0 skip_r11rcx=1
 
 	/*
 	 * Now all regs are restored except RSP and RDI.
@@ -635,15 +627,7 @@ GLOBAL(swapgs_restore_regs_and_return_to
 	ud2
 1:
 #endif
-	POP_EXTRA_REGS
-	popq	%r11
-	popq	%r10
-	popq	%r9
-	popq	%r8
-	popq	%rax
-	popq	%rcx
-	popq	%rdx
-	popq	%rsi
+	POP_REGS pop_rdi=0
 
 	/*
 	 * The stack is now user RDI, orig_ax, RIP, CS, EFLAGS, RSP, SS.
@@ -701,8 +685,7 @@ GLOBAL(restore_regs_and_return_to_kernel
 	ud2
 1:
 #endif
-	POP_EXTRA_REGS
-	POP_C_REGS
+	POP_REGS
 	addq	$8, %rsp	/* skip regs->orig_ax */
 	INTERRUPT_RETURN
 
@@ -1661,8 +1644,7 @@ end_repeat_nmi:
 nmi_swapgs:
 	SWAPGS_UNSAFE_STACK
 nmi_restore:
-	POP_EXTRA_REGS
-	POP_C_REGS
+	POP_REGS
 
 	/*
 	 * Skip orig_ax and the "outermost" frame to point RSP at the "iret"
