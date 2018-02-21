Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227oAiP/6SaCReRL7on3gCYp9aw0vusFZ++dNlJvQk4UNypNnVN0WSX/9RRTUTK5CifrvLAo
ARC-Seal: i=1; a=rsa-sha256; t=1519218030; cv=none;
        d=google.com; s=arc-20160816;
        b=frvWE71INvDLMqVlf+hYwdRLG60yUimbT/AuDekXDCK6Z2tlbfcXOAc+F6qC9jNmpa
         QIlRNEA27erulsI3F4KB+b9Xn4JTs6RxBD9+JO2bZjyC38UhI/hvK6ZPEu6gy13HXrNa
         tDnHhHglbUpgppdZQWlhaLDjpkIfI0uHbJ6ilwtWgmNbIzhfvp8m8fhPOHPXeYwd40he
         mAFZCbUbgTgJ/MDY8e9lAzjnkQu80ck7G4+n7aEr8umVrFEiiG68cBQpt+kuuaSzf3Sl
         Z+Me4MdPA+1c7Pn3gBdccTA4i9H0dgg90vFXKaHqvxHO9x3oAI2Y+IKX8SOZFuoulE7N
         5gUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FDoFqTiw9p4SAYkr1nAfEG26vGSq63pDiJQa/kNL8G0=;
        b=VcQQob/Ys/Rv6xi5ct/yveDccUHfHroZDNtQx+PglloSPXPTLXkvO+1GlIDk7ab6LS
         mDLsSbq85YtmT+a9VRzAVYWPFE0Lfj78t4yoGi3kzyjHB5yqwmRl/k41KkCd5vR9DERv
         eF6AzEeFEIAnchpUuCN3jjFtxNUxZuXo5WiZ2HAtmeJQfodz4xI4J3GxWMhG1nScaoUS
         uh4i3WY83gtHV21p8p17He15tgwldG2/s5H/QDHIiowJEXuZAufHem4zeeAwONfwPSUm
         J1ftuSUpC2Um83P+2DQaldluX3wzqXZsB8TUp/6AywKp/kL2NZfNBQLoZ/nFhnkWSLw1
         sFQQ==
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
Subject: [PATCH 4.14 062/167] x86/entry/64: Use PUSH_AND_CLEAN_REGS in more cases
Date: Wed, 21 Feb 2018 13:47:53 +0100
Message-Id: <20180221124527.894424371@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015566176751887?=
X-GMAIL-MSGID: =?utf-8?q?1593015566176751887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 30907fd13bb593202574bb20af58d67c70a1ee14 upstream.

entry_SYSCALL_64_after_hwframe() and nmi() can be converted to use
PUSH_AND_CLEAN_REGS instead of opencoded variants thereof. Due to
the interleaving, the additional XOR-based clearing of R8 and R9
in entry_SYSCALL_64_after_hwframe() should not have any noticeable
negative implications.

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
Link: http://lkml.kernel.org/r/20180211104949.12992-6-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |    6 ++--
 arch/x86/entry/entry_64.S |   65 ++--------------------------------------------
 2 files changed, 6 insertions(+), 65 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -137,7 +137,7 @@ For 32-bit we have the following convent
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
-	.macro PUSH_AND_CLEAR_REGS
+	.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -147,9 +147,9 @@ For 32-bit we have the following convent
 	 */
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
-	pushq   %rdx		/* pt_regs->dx */
+	pushq	\rdx		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
-	pushq   %rax		/* pt_regs->ax */
+	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
 	xorq    %r8, %r8	/* nospec   r8 */
 	pushq   %r9		/* pt_regs->r9 */
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -223,35 +223,8 @@ ENTRY(entry_SYSCALL_64)
 	pushq	%rcx				/* pt_regs->ip */
 GLOBAL(entry_SYSCALL_64_after_hwframe)
 	pushq	%rax				/* pt_regs->orig_ax */
-	pushq	%rdi				/* pt_regs->di */
-	pushq	%rsi				/* pt_regs->si */
-	pushq	%rdx				/* pt_regs->dx */
-	pushq	%rcx				/* pt_regs->cx */
-	pushq	$-ENOSYS			/* pt_regs->ax */
-	pushq	%r8				/* pt_regs->r8 */
-	pushq	%r9				/* pt_regs->r9 */
-	pushq	%r10				/* pt_regs->r10 */
-	/*
-	 * Clear extra registers that a speculation attack might
-	 * otherwise want to exploit. Interleave XOR with PUSH
-	 * for better uop scheduling:
-	 */
-	xorq	%r10, %r10			/* nospec   r10 */
-	pushq	%r11				/* pt_regs->r11 */
-	xorq	%r11, %r11			/* nospec   r11 */
-	pushq	%rbx				/* pt_regs->rbx */
-	xorl	%ebx, %ebx			/* nospec   rbx */
-	pushq	%rbp				/* pt_regs->rbp */
-	xorl	%ebp, %ebp			/* nospec   rbp */
-	pushq	%r12				/* pt_regs->r12 */
-	xorq	%r12, %r12			/* nospec   r12 */
-	pushq	%r13				/* pt_regs->r13 */
-	xorq	%r13, %r13			/* nospec   r13 */
-	pushq	%r14				/* pt_regs->r14 */
-	xorq	%r14, %r14			/* nospec   r14 */
-	pushq	%r15				/* pt_regs->r15 */
-	xorq	%r15, %r15			/* nospec   r15 */
-	UNWIND_HINT_REGS
+
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
 	TRACE_IRQS_OFF
 
@@ -1382,39 +1355,7 @@ ENTRY(nmi)
 	pushq	1*8(%rdx)	/* pt_regs->rip */
 	UNWIND_HINT_IRET_REGS
 	pushq   $-1		/* pt_regs->orig_ax */
-	pushq   %rdi		/* pt_regs->di */
-	pushq   %rsi		/* pt_regs->si */
-	pushq   (%rdx)		/* pt_regs->dx */
-	pushq   %rcx		/* pt_regs->cx */
-	pushq   %rax		/* pt_regs->ax */
-	/*
-	 * Sanitize registers of values that a speculation attack
-	 * might otherwise want to exploit. The lower registers are
-	 * likely clobbered well before they could be put to use in
-	 * a speculative execution gadget. Interleave XOR with PUSH
-	 * for better uop scheduling:
-	 */
-	pushq   %r8		/* pt_regs->r8 */
-	xorq    %r8, %r8	/* nospec   r8 */
-	pushq   %r9		/* pt_regs->r9 */
-	xorq    %r9, %r9	/* nospec   r9 */
-	pushq   %r10		/* pt_regs->r10 */
-	xorq    %r10, %r10	/* nospec   r10 */
-	pushq   %r11		/* pt_regs->r11 */
-	xorq    %r11, %r11	/* nospec   r11*/
-	pushq	%rbx		/* pt_regs->rbx */
-	xorl    %ebx, %ebx	/* nospec   rbx*/
-	pushq	%rbp		/* pt_regs->rbp */
-	xorl    %ebp, %ebp	/* nospec   rbp*/
-	pushq	%r12		/* pt_regs->r12 */
-	xorq    %r12, %r12	/* nospec   r12*/
-	pushq	%r13		/* pt_regs->r13 */
-	xorq    %r13, %r13	/* nospec   r13*/
-	pushq	%r14		/* pt_regs->r14 */
-	xorq    %r14, %r14	/* nospec   r14*/
-	pushq	%r15		/* pt_regs->r15 */
-	xorq    %r15, %r15	/* nospec   r15*/
-	UNWIND_HINT_REGS
+	PUSH_AND_CLEAR_REGS rdx=(%rdx)
 	ENCODE_FRAME_POINTER
 
 	/*
