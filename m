Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsk0imgKw2d8GbvY8T0p531LnQoFbqYpjZconWLL9npaI7y27z8o7HXv1PdutRdyQX7APH1
ARC-Seal: i=1; a=rsa-sha256; t=1519676585; cv=none;
        d=google.com; s=arc-20160816;
        b=vmxpxuwSVmt9gonYGL3GCZENS7F+nMoQmFfAGpVvsXdFIZxgHbW6T/NKTOI3tugB/T
         DOrkAR4kb4OCx8QN/cHP+DlG3Rajpa5U+p8gCl4wnXVac1NQId+rH4dn4cfbJgClOQaF
         KTGC6yVLRSvxZEZV/gDIXAgL41pjXglx3+MxjXu/jrFRBkVsNRX0nL16n33Wg0lpo5wd
         VbaGPZ+plp8pu7YbsVHyqLb6davdrrmGcZuohxsDKnUBLThec+5MPFS9Q/O2TgjREbXS
         s/vWgQfCZQxFwVcYKlDlpp5ehsHgjJTCbXGhh4V5Ombxa0WpcdOpzWtsqRDEiI8vGQbN
         urlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hQtXKlz0k3jmicATKetmzwOxwdXUIomHybqNSgX1B7I=;
        b=lzM9/cOsnx45Y/7ULrn7Licj38Ip+WGC5+ikDJ+AbVEehi17E+VTGmlbGe7tJgXZwF
         AhJcey5TlAmvT9ETHMiwHGIlXIHyp6HwlBXXpd7Y83qIOfs8c7J3y0cP650KgBP9YHkO
         oDgeuDO/MI88jWDGvJjQpysRL3yisve5wKj+zauez4HD3RMUdmhd6OqYm+ooWq6J1MyT
         HGF1zSB0pltDdagnR/QrgI9BIrHeL82JPXejcwL+Pba0SLVU2FNJB/8YmcSjC5be9/ah
         BvAzUJWjm0qVCfQTUwgTAEIkE95PsHF9f1mOEU+bexr6DZqg+rdASFRNj/TgfWbCFiQf
         CWDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 39/39] x86/entry/64: Clear extra registers beyond syscall arguments, to reduce speculation attack surface
Date: Mon, 26 Feb 2018 21:21:00 +0100
Message-Id: <20180226201645.379416320@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496395138590553?=
X-GMAIL-MSGID: =?utf-8?q?1593496395138590553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 8e1eb3fa009aa7c0b944b3c8b26b07de0efb3200 upstream.

At entry userspace may have (maliciously) populated the extra registers
outside the syscall calling convention with arbitrary values that could
be useful in a speculative execution (Spectre style) attack.

Clear these registers to minimize the kernel's attack surface.

Note, this only clears the extra registers and not the unused
registers for syscalls less than 6 arguments, since those registers are
likely to be clobbered well before their values could be put to use
under speculation.

Note, Linus found that the XOR instructions can be executed with
minimized cost if interleaved with the PUSH instructions, and Ingo's
analysis found that R10 and R11 should be included in the register
clearing beyond the typical 'extra' syscall calling convention
registers.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151787988577.7847.16733592218894189003.stgit@dwillia2-desk3.amr.corp.intel.com
[ Made small improvements to the changelog and the code comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/entry_64.S |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -176,13 +176,26 @@ GLOBAL(entry_SYSCALL_64_after_swapgs)
 	pushq	%r8				/* pt_regs->r8 */
 	pushq	%r9				/* pt_regs->r9 */
 	pushq	%r10				/* pt_regs->r10 */
+	/*
+	 * Clear extra registers that a speculation attack might
+	 * otherwise want to exploit. Interleave XOR with PUSH
+	 * for better uop scheduling:
+	 */
+	xorq	%r10, %r10			/* nospec   r10 */
 	pushq	%r11				/* pt_regs->r11 */
+	xorq	%r11, %r11			/* nospec   r11 */
 	pushq	%rbx				/* pt_regs->rbx */
+	xorl	%ebx, %ebx			/* nospec   rbx */
 	pushq	%rbp				/* pt_regs->rbp */
+	xorl	%ebp, %ebp			/* nospec   rbp */
 	pushq	%r12				/* pt_regs->r12 */
+	xorq	%r12, %r12			/* nospec   r12 */
 	pushq	%r13				/* pt_regs->r13 */
+	xorq	%r13, %r13			/* nospec   r13 */
 	pushq	%r14				/* pt_regs->r14 */
+	xorq	%r14, %r14			/* nospec   r14 */
 	pushq	%r15				/* pt_regs->r15 */
+	xorq	%r15, %r15			/* nospec   r15 */
 
 	/* IRQs are off. */
 	movq	%rsp, %rdi
