Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226CnBpYsQ/3jrajAxr8l8Deji+Kq8zd2tk2KTklNjQX4mhHsfhhgVDuWyVzER6uzSwt2Obf
ARC-Seal: i=1; a=rsa-sha256; t=1519217861; cv=none;
        d=google.com; s=arc-20160816;
        b=VuJSozgzGgn86/tubxLow2nHsLtpl91a/4ImEz5rtKkLZ6YUA226hXNiJrOUlJ2rhe
         yhYLR6TT4HOATMEM97+w8Ky95Q9L4cpqP3ORavq1VpD7oNee9wt11XDpdAzeYk0vhlU/
         23nC7fWI0XBB8BkYEZBvJ/+vHBJZwAFYBGPhTVyenMOX8/oYmdDZkp2QacYNd5JTBX0L
         96iG/oZnO18PSHvZV6nrEBS006ReRiD027tI3GPzIttNy5Nts+4tNICKj7Blo/Q+PFug
         r1GL/aJPwulELAMpFek+ZpDUzXNorcWWampL1sWLlPTOg1j4ScCOwwJQ97EHo4zOda5C
         pwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zxrfJOUf2Y6Y7cm2maE/u3CLEJDwkz+EtjFTD5AT4Og=;
        b=NGzJBaqG7ACq/qzitMP48hbOcLqIY7mPq4Hivmm3r3fq5CPG2nmCadxaNyENLacRLV
         j9GLA0kVQx1gWupAS+1mF7D7VXPZkQi3KFDBzcjkV5JVYIxnpapn+M5J1UZmFDcJTtli
         OKfey+GLOLIA7MSGoTLWSd8aLOuDCL00yhl4ncxQ2c/ffUoAJyOgA65Z1QpP8ThTKBGS
         ONE9Vh+yL0crp0xj1/q5ewxWH6UqcdQZBUulX8IE5tr3d+JnO47v7AbZjaGgMeFlg+iH
         H+fOXFhLGxQqBjb17k8suxM09lnyvr8vvz6G86UNhtUmjCuaDbe2dXFXiHG3FdEigRXP
         BI+A==
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
Subject: [PATCH 4.9 50/77] x86/entry/64/compat: Clear registers for compat syscalls, to reduce speculation attack surface
Date: Wed, 21 Feb 2018 13:48:59 +0100
Message-Id: <20180221124434.315881447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015388581637403?=
X-GMAIL-MSGID: =?utf-8?q?1593015388581637403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -83,15 +83,25 @@ ENTRY(entry_SYSENTER_compat)
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
@@ -209,15 +219,25 @@ ENTRY(entry_SYSCALL_compat)
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
@@ -320,15 +340,25 @@ ENTRY(entry_INT80_compat)
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
