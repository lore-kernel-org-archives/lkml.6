Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226nUe4SM6xmY+vuEsmN1lxTBg9C8w6xlu2XaVPFdrmrenKXJRG+iWg0+J7IShJHsl9eACC1
ARC-Seal: i=1; a=rsa-sha256; t=1519218441; cv=none;
        d=google.com; s=arc-20160816;
        b=qv6EjtA3XSP/nM97WYgHRjXVBY6a2J78iOxKvUobgwAVw0Q7Uq2Z8tZvYfBWhI4evS
         p/ms9i8xlfCROsyXAleluD/udm4at/BPZeNrxps9b/zMUpCuJAGev8pBEnXAYRMTjpz6
         1WFxX6SbQqCuoATo6W/n231N6gOFd0+gcWTiP+g4ZkUGeGypt0OUCEfmBR2wigU55Gmx
         UtyoESKLOnmEUSnwOFKQ5U/X4pJVYXNJ1cVqjhDhn1KHeVIpGnpGwyyg1ZL4Vynws6Km
         vjyC5WiwGzEUY6gtG0s09Pz8rBeMibcs7np/5ZdhXjmEEhNK5H4j9lyfCDRbdpUrbI/4
         aDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=C2EWzshnXRDh+0r6Yp/QsPMUacAeOJot/o2Qnc/S3n4=;
        b=THd0+/Q0ymIG11O89qUAR/1NwEN3f/mnOK5zey5ZiVOykFAD1ZzXRrpS7IUUZFz9Gd
         eMqeKCbSDPLw6tDiGxLptMxF1DIC+kaVWdvQ5saIjfu/5XWQulefoo+MkUk1oyF/otdF
         u1GnnALTkWK49ZX+XFaUj3ZjY4R+pKRoPl7/vsReHWxWsSnH5SaZ3rs88PCKEd+Ni9hG
         2ECv4izhfk/vXpoE4ijchUyXXpkG6SkPSh2znRkju+6cz+FqgnXSbgBH+BjuPRvZaH2l
         c9L3EJvnhCHUM9KiaUjb1ZUyrZQu/OJtqoZydgZAa7VHWX+r+RpgSSIvhRoPRZ/sVdL9
         6OJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.15 040/163] x86/entry/64: Clear extra registers beyond syscall arguments, to reduce speculation attack surface
Date: Wed, 21 Feb 2018 13:47:49 +0100
Message-Id: <20180221124532.559314707@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015611169662442?=
X-GMAIL-MSGID: =?utf-8?q?1593015996490436380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -235,13 +235,26 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
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
 	UNWIND_HINT_REGS
 
 	TRACE_IRQS_OFF
