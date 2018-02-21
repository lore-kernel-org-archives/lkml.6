Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227kvV24Y1SPdszzogh6sF7ki+SC2HbpVh7arr0Hvmkrl3eMBO74N/+uzAwP8+TNCAp/KyAV
ARC-Seal: i=1; a=rsa-sha256; t=1519218601; cv=none;
        d=google.com; s=arc-20160816;
        b=rrTwFzesjGqS3J1Jwi+fxzgnksuZpu+CUa+guTQvneyPjk/hmykfc+HD0senYcisKB
         UnePzfM36mAQVy3K8QuHbc9H6mCEdWIKWkavoAzMNu6NE/1CdHvpvZa8Ia5JyRtDTjxB
         m81t+1IKTA1xRvXEgeI8eZwweWgqngSIcFVmsL0YZCeJVoLWPiqx7t4ZML73rNqJUaPG
         q4Bc9xpICMul6lXS+prCL2SJhHvSb6iU4bfD4m2/zQMJLlQ2zXUGgzLl8T36F9TIfSe6
         nbEl6h19wvwGfrarmq74DWlnf56ZCnxe7a7vJJr56A5IZptwwt+uxzzoR63AMEGuFetz
         ZTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y3sX7qBhDOvM8L4D/Pp9dE8pjVPeYRtenk2kF6iJ21Y=;
        b=afAp1My54K3GgudSnVy96WNvQzKIrRSzdVMqWF4F+sbsVi5rrxLAGa17x8sduipjvH
         cF4joNLtdEMcZdVPqRUF9KDckdl96cl1HoHZVpZIhRqeJGzSJ1/BEucT09UNVwgVnXhB
         yaLTxvJRUDHIfOkMcdm2ywi5Nc+3XfLFMHTiClQ0ZQztiakaGQx+l2RCAQ/hpoYCLz69
         CMS5FfPvKbPLAd1xGjukOcJiuhvXeXnH9gDsVnGACrEp5odKlb6bjC9B/4Wis0qoYIIe
         kEvlvVnE1ZuLwYlwgqAUnEWPl6Q7wIXcgcksuEu5CQaVxp9JtkpHXcJQGuzyRm39Grxy
         aMIg==
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
Subject: [PATCH 4.15 063/163] x86/entry/64: Use PUSH_AND_CLEAN_REGS in more cases
Date: Wed, 21 Feb 2018 13:48:12 +0100
Message-Id: <20180221124533.950615182@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015566176751887?=
X-GMAIL-MSGID: =?utf-8?q?1593016164311843536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -227,35 +227,8 @@ ENTRY(entry_SYSCALL_64)
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
 
@@ -1388,39 +1361,7 @@ ENTRY(nmi)
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
