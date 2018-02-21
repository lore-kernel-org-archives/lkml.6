Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2249HzsSm50g1+qFygkBX5c3I8wS2LpAjbcFGhguw+8IdSDsotuG3B46fvzo51bsPsqdsKw1
ARC-Seal: i=1; a=rsa-sha256; t=1519218599; cv=none;
        d=google.com; s=arc-20160816;
        b=ILO7p2ZuivH9VppLMRF1wUXitZWU8IH72fvZQXFdGPVTC2D6rFMeijlPWV1KXPmpI5
         uhmfatJxXi4Z7IbHCSpXHeRm4eSwARBnef321cAQryBdlhQ+6H7M/yN7s6AsJUzsC7Rf
         r05RElyhmeABzw2zC+7j13Wh40sZDPLDv5ehFehdPX8XKSFNdmI0tujpANSrXM5Azhye
         p6XZ42c3WDAeEq/u6pndpdO4iDZCEyPTWf6XS1KCjX/rJTlRX9EysdB1BjSglQZrQe8R
         ynUba2TNTwUKnrOifFnd8gVgZZrg/K4B1b39OkALXFO6y/2gC2e2gP0LkvEKhX0AHqwl
         TgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h+rh9CtVQJhNQgA4EZMv1G6FmaI1rCqNbJlzrISOHMY=;
        b=ibwIGZe9xftwcfXlSG83VoOamS1y+X1gDA9y8DFmVFaTptVbF6zujHdd+TqPmyisSS
         wbZ0bgVm6TVCu3uFEHeKXYDMztCN2JTvfhiY5eVQm57huewgkBEDiMxzC8+N0YdTpBp9
         S8wyyXwkNcoLdiTGlTz2tvg/jRcGFk4IQZspJ9EXnle/2lyj0GCK9BbVYpkBhTqTYgiu
         7zlsNLia7AXpx45HEqCqCxrbRGZJdEpWjbAJxF9b5dYGJ+4fC+FZJ/nG8eOBN3dtZRkz
         VCvucq0HHjUA0kDzxeUwjbgW2+d6SVsIgq+Lcw7p5NIWCPKDRUWe9ggtuEdkWJNxYSi1
         D+Lw==
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
Subject: [PATCH 4.15 062/163] x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
Date: Wed, 21 Feb 2018 13:48:11 +0100
Message-Id: <20180221124533.890417390@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015562439488858?=
X-GMAIL-MSGID: =?utf-8?q?1593016161935127665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 3f01daecd545e818098d84fd1ad43e19a508d705 upstream.

Those instances where ALLOC_PT_GPREGS_ON_STACK is called just before
SAVE_AND_CLEAR_REGS can trivially be replaced by PUSH_AND_CLEAN_REGS.
This macro uses PUSH instead of MOV and should therefore be faster, at
least on newer CPUs.

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
Link: http://lkml.kernel.org/r/20180211104949.12992-5-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   36 ++++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S |    6 ++----
 2 files changed, 38 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -137,6 +137,42 @@ For 32-bit we have the following convent
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
+	.macro PUSH_AND_CLEAR_REGS
+	/*
+	 * Push registers and sanitize registers of values that a
+	 * speculation attack might otherwise want to exploit. The
+	 * lower registers are likely clobbered well before they
+	 * could be put to use in a speculative execution gadget.
+	 * Interleave XOR with PUSH for better uop scheduling:
+	 */
+	pushq   %rdi		/* pt_regs->di */
+	pushq   %rsi		/* pt_regs->si */
+	pushq   %rdx		/* pt_regs->dx */
+	pushq   %rcx		/* pt_regs->cx */
+	pushq   %rax		/* pt_regs->ax */
+	pushq   %r8		/* pt_regs->r8 */
+	xorq    %r8, %r8	/* nospec   r8 */
+	pushq   %r9		/* pt_regs->r9 */
+	xorq    %r9, %r9	/* nospec   r9 */
+	pushq   %r10		/* pt_regs->r10 */
+	xorq    %r10, %r10	/* nospec   r10 */
+	pushq   %r11		/* pt_regs->r11 */
+	xorq    %r11, %r11	/* nospec   r11*/
+	pushq	%rbx		/* pt_regs->rbx */
+	xorl    %ebx, %ebx	/* nospec   rbx*/
+	pushq	%rbp		/* pt_regs->rbp */
+	xorl    %ebp, %ebp	/* nospec   rbp*/
+	pushq	%r12		/* pt_regs->r12 */
+	xorq    %r12, %r12	/* nospec   r12*/
+	pushq	%r13		/* pt_regs->r13 */
+	xorq    %r13, %r13	/* nospec   r13*/
+	pushq	%r14		/* pt_regs->r14 */
+	xorq    %r14, %r14	/* nospec   r14*/
+	pushq	%r15		/* pt_regs->r15 */
+	xorq    %r15, %r15	/* nospec   r15*/
+	UNWIND_HINT_REGS
+	.endm
+
 	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -564,8 +564,7 @@ END(irq_entries_start)
 	call	switch_to_thread_stack
 1:
 
-	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_AND_CLEAR_REGS
+	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1112,8 +1111,7 @@ ENTRY(xen_failsafe_callback)
 	addq	$0x30, %rsp
 	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
-	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_AND_CLEAR_REGS
+	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
