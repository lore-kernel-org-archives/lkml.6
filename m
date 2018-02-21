Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227NxiRfx6/hD0jV1/EuBz8XJChuPfEQWHdDtghc32Z4otV4H9njjMR0UHEwtjXlHPQHujYN
ARC-Seal: i=1; a=rsa-sha256; t=1519217964; cv=none;
        d=google.com; s=arc-20160816;
        b=v/CpUSxwkS1SztmqwxiiTTWNfZrXfRNz//YP/tgt+QkmkM7eWGRtj3xAqOWSi3yCIU
         frHPCCjlbLp3NxNHsjREM8e3Cw1cmRbiaiUz8Q2nd9TNt2SUEaB4Kjj6MBHSctib4o34
         jyv8A40v3iq18gGQzVJ4m/1MhhHTXiqi5QhiDNb42vJznmM2bqAcpqeLbC3FOJPEJ8Ks
         MuE6WpD+57HoRt0upzDSHaSwjRAQdxtvj5ngUuKxkthHJk88O9PqDDVbVqzKf5hSQ1rk
         Cy6dNrF9LpGIlLACM9ddr+XJQfvZu/AMRfGeQ1m0NBqACERfHuooiuZCGT7P3e7ep+6o
         BEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HcmMe7RSf9Ju3n1xJTuKg/nuMUiTjajycO4b50EmFJQ=;
        b=rM9B+Tqmy/ImTEbe/Zhq5scFx0Rcp9V/ram1MKUOQgzqOlvhH50YMw+IboSSsHyzGG
         H6CkxTc9zFxdtL+TsSzFIV4eWY9mdIXbSlN2XTing1Kz9RR3Sk3SR2L0y50fGssSbMGT
         woCMs4rSVWdoJhqht1hDyMrWPv+z3DZvj6CbXg7lKUY6FbWVrriS0y94qwI6AC0oI3hH
         SAEWqvGq4DnGtDPenkethoSCE4Nv2LSyehW47pN3UTgQNUTVEaRLQ6dX3TbTtgdubBiv
         /1LcS3hprqcL2JTOAqDqSDpPLp4QWKXZqNo2ed0Dtrhutqa47sGGhOJYIrItACO/kdV+
         SvIQ==
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
Subject: [PATCH 4.14 041/167] x86/entry/64/compat: Clear registers for compat syscalls, to reduce speculation attack surface
Date: Wed, 21 Feb 2018 13:47:32 +0100
Message-Id: <20180221124526.835017151@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015388581637403?=
X-GMAIL-MSGID: =?utf-8?q?1593015496229681171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 6b8cf5cc9965673951f1ab3f0e3cf23d06e3e2ee upstream.

At entry userspace may have populated registers with values that could
otherwise be useful in a speculative execution attack. Clear them to
minimize the kernel's attack surface.

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
Link: http://lkml.kernel.org/r/151787989697.7847.4083702787288600552.stgit@dwillia2-desk3.amr.corp.intel.com
[ Made small improvements to the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64_compat.S |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -85,15 +85,25 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
+	xorq	%r15, %r15		/* nospec   r15 */
 	cld
 
 	/*
@@ -214,15 +224,25 @@ GLOBAL(entry_SYSCALL_compat_after_hwfram
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
+	xorq	%r15, %r15		/* nospec   r15 */
 
 	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
@@ -338,15 +358,25 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   %r12                    /* pt_regs->r12 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   %r13                    /* pt_regs->r13 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   %r14                    /* pt_regs->r14 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   %r15                    /* pt_regs->r15 */
+	xorq	%r15, %r15		/* nospec   r15 */
 	cld
 
 	/*
