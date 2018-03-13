Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvJjGlq8oeoOv83AC4M+xeR+myYT6Eh6iaNnA6g5EnV+3KMgh6txV9yY3YFkk+7PlM0UDvL
ARC-Seal: i=1; a=rsa-sha256; t=1520955636; cv=none;
        d=google.com; s=arc-20160816;
        b=JuP3RJEVAhk9vbZeKJjyRw7hTK+wMvAkW2+dUZCTCFNGddZLh9nPK45JgKWpscmg23
         3DGVLornR4zTuj2CBX6cYy65Jad7k2kQK+6ct/e2fmCzP6EerDt+vi/9zYrPdT0uk+3j
         0EzFlaLafldchfc9mfRxbnplXVsKq6XKtzrwUaTH3HETJDrin7Mr1ch05dRD+yxjM0ID
         hU81R53ZwEJQ3a2FlH+W6980YaUMShJbVps49JFJfLy84Oy81CjQNgc97MEFTiQ0I1X2
         qVmeoerxi/818L4pa3qA7nuDRbnFK3T1cokOwTu6lRpRlVSdDKtTU5A79sFt7W4wQAqN
         AYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+i8er+EEiu8gQyH0yUnHCad1OxVzffyy9fiibZminLE=;
        b=K/wNSAm+fIsr0vYAMAQOa8vimlmPpdUmXbEdDmlNxEUcjM3YGW1QV/IRht+wExVd1Y
         T3htfLj5YypI91KewX1lBuI9Vh62LuizW375jwn/oCr9E6yxqx8yp2FkDqHqZAlD4jat
         aKaqhtjvtwhlZCY0git+5Gl3IRZzE93Rjv3FTG0H8NQeCsfimXu1EJvubY1YAs9IOh4R
         T+NDMgyYn/jsP/Fg4hNiASBmqA50ieOiy21TlKW6shuRdSNDjX1ntttME4tsiWF+1sln
         Hrg9fv6pIMr43DX+ynFGu2ZLunknNmZCH8TORyQAV/Qo46J8jUhSa733mRrA3ltVt31l
         SG0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 118/140] x86/entry/64: Use xorl for faster register clearing
Date: Tue, 13 Mar 2018 16:25:21 +0100
Message-Id: <20180313152506.118623579@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836996970474110?=
X-GMAIL-MSGID: =?utf-8?q?1594837577860023656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit ced5d0bf603fa0baee8ea889e1d70971fd210894 upstream.

On some x86 CPU microarchitectures using 'xorq' to clear general-purpose
registers is slower than 'xorl'. As 'xorl' is sufficient to clear all
64 bits of these registers due to zero-extension [*], switch the x86
64-bit entry code to use 'xorl'.

No change in functionality and no change in code size.

[*] According to Intel 64 and IA-32 Architecture Software Developer's
    Manual, section 3.4.1.1, the result of 32-bit operands are "zero-
    extended to a 64-bit result in the destination general-purpose
    register." The AMD64 Architecture Programmer’s Manual Volume 3,
    Appendix B.1, describes the same behaviour.

Suggested-by: Denys Vlasenko <dvlasenk@redhat.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180214175924.23065-3-linux@dominikbrodowski.net
[ Improved on the changelog a bit. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h         |   16 +++++------
 arch/x86/entry/entry_64_compat.S |   54 +++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -117,25 +117,25 @@ For 32-bit we have the following convent
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
-	xorq    %r8, %r8	/* nospec   r8 */
+	xorl	%r8d, %r8d	/* nospec   r8 */
 	pushq   %r9		/* pt_regs->r9 */
-	xorq    %r9, %r9	/* nospec   r9 */
+	xorl	%r9d, %r9d	/* nospec   r9 */
 	pushq   %r10		/* pt_regs->r10 */
-	xorq    %r10, %r10	/* nospec   r10 */
+	xorl	%r10d, %r10d	/* nospec   r10 */
 	pushq   %r11		/* pt_regs->r11 */
-	xorq    %r11, %r11	/* nospec   r11*/
+	xorl	%r11d, %r11d	/* nospec   r11*/
 	pushq	%rbx		/* pt_regs->rbx */
 	xorl    %ebx, %ebx	/* nospec   rbx*/
 	pushq	%rbp		/* pt_regs->rbp */
 	xorl    %ebp, %ebp	/* nospec   rbp*/
 	pushq	%r12		/* pt_regs->r12 */
-	xorq    %r12, %r12	/* nospec   r12*/
+	xorl	%r12d, %r12d	/* nospec   r12*/
 	pushq	%r13		/* pt_regs->r13 */
-	xorq    %r13, %r13	/* nospec   r13*/
+	xorl	%r13d, %r13d	/* nospec   r13*/
 	pushq	%r14		/* pt_regs->r14 */
-	xorq    %r14, %r14	/* nospec   r14*/
+	xorl	%r14d, %r14d	/* nospec   r14*/
 	pushq	%r15		/* pt_regs->r15 */
-	xorq    %r15, %r15	/* nospec   r15*/
+	xorl	%r15d, %r15d	/* nospec   r15*/
 	UNWIND_HINT_REGS
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -85,25 +85,25 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
-	xorq	%r8, %r8		/* nospec   r8 */
+	xorl	%r8d, %r8d		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
-	xorq	%r9, %r9		/* nospec   r9 */
+	xorl	%r9d, %r9d		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
-	xorq	%r10, %r10		/* nospec   r10 */
+	xorl	%r10d, %r10d		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
-	xorq	%r11, %r11		/* nospec   r11 */
+	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
 	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
-	xorq	%r12, %r12		/* nospec   r12 */
+	xorl	%r12d, %r12d		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
-	xorq	%r13, %r13		/* nospec   r13 */
+	xorl	%r13d, %r13d		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
-	xorq	%r14, %r14		/* nospec   r14 */
+	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
-	xorq	%r15, %r15		/* nospec   r15 */
+	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
 	/*
@@ -224,25 +224,25 @@ GLOBAL(entry_SYSCALL_compat_after_hwfram
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
-	xorq	%r8, %r8		/* nospec   r8 */
+	xorl	%r8d, %r8d		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
-	xorq	%r9, %r9		/* nospec   r9 */
+	xorl	%r9d, %r9d		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
-	xorq	%r10, %r10		/* nospec   r10 */
+	xorl	%r10d, %r10d		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
-	xorq	%r11, %r11		/* nospec   r11 */
+	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
 	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
-	xorq	%r12, %r12		/* nospec   r12 */
+	xorl	%r12d, %r12d		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
-	xorq	%r13, %r13		/* nospec   r13 */
+	xorl	%r13d, %r13d		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
-	xorq	%r14, %r14		/* nospec   r14 */
+	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
-	xorq	%r15, %r15		/* nospec   r15 */
+	xorl	%r15d, %r15d		/* nospec   r15 */
 
 	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
@@ -298,9 +298,9 @@ sysret32_from_system_call:
 	 */
 	SWITCH_TO_USER_CR3_NOSTACK scratch_reg=%r8 scratch_reg2=%r9
 
-	xorq	%r8, %r8
-	xorq	%r9, %r9
-	xorq	%r10, %r10
+	xorl	%r8d, %r8d
+	xorl	%r9d, %r9d
+	xorl	%r10d, %r10d
 	swapgs
 	sysretl
 END(entry_SYSCALL_compat)
@@ -358,25 +358,25 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
-	xorq	%r8, %r8		/* nospec   r8 */
+	xorl	%r8d, %r8d		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
-	xorq	%r9, %r9		/* nospec   r9 */
+	xorl	%r9d, %r9d		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
-	xorq	%r10, %r10		/* nospec   r10 */
+	xorl	%r10d, %r10d		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
-	xorq	%r11, %r11		/* nospec   r11 */
+	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp */
 	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   %r12                    /* pt_regs->r12 */
-	xorq	%r12, %r12		/* nospec   r12 */
+	xorl	%r12d, %r12d		/* nospec   r12 */
 	pushq   %r13                    /* pt_regs->r13 */
-	xorq	%r13, %r13		/* nospec   r13 */
+	xorl	%r13d, %r13d		/* nospec   r13 */
 	pushq   %r14                    /* pt_regs->r14 */
-	xorq	%r14, %r14		/* nospec   r14 */
+	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   %r15                    /* pt_regs->r15 */
-	xorq	%r15, %r15		/* nospec   r15 */
+	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
 	/*
