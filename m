Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x2240oCEOxkJyVLSzNId8y0EXnNgoin5xv4oRQiB49TGpU/XSvt4f79nAw2QyAml0NSW6EPnz
ARC-Seal: i=1; a=rsa-sha256; t=1518868304; cv=none;
        d=google.com; s=arc-20160816;
        b=GZ6cvO4Xkh3YVvginB6YZVrVenyuBDNit7gl05Ttm9nuntG81Sl99qp1Ny3sqEhEKN
         JmXe/wbG1ZdXmpxb194sqezWprnoP7h2hr3wevtcmpCeDq43TQ70LM4WrDrKanH3Q7HR
         6j8A0EeZEyXFAwuGmy5eB3HLX1nykv/nFPJ6NRB9QNsVe6V9P91QgaOeO9Q9q16rte3X
         y9rrtpIDZEgIZEwe0HlrI9WhNs+dgX8GNoxW2OYDAYS0jitK8T32sByrEO/7isCh03ce
         G5Y559ovrm5beLmvwdrR0DR6X5GLhZ+qgYA8fmuKpuyF34/XtWpW8fRvYK6S13VE/mwC
         588w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=bLg+LxN5wDHPUUzfoKL6y7K5AtHN6Keuula3/vbk+WQ=;
        b=XxZREdaYT3fgDz5MzEZ3YAgQ4iGh9ZDI7rAU6JX/Yw+Gs26vintX7Gx3d+K7CKEUI2
         O/l5CYdLYFBFYPTXiGsmMHenU+Ww8YbsimBp0z+0bMt3D3nRR+UgplP1JIXESqxxB0FR
         UCtehczCdLo3qj9MqHiUZmRV6Kv7ejMULV945DVOlYfSAfjO9f/D789bz+6j3QCovfvS
         KA4TkbYdki1hBjMzIDeBpqZ5BQh8FbJG/maGTHC28Vy5VRPAOsGrOFbuwiNeApm4jHBv
         CFuYPEyLb+X6tmLbzkKcEc/hQXrm7PvTg8PZ7v9Hjrty3vhKeg+WslqnaMVVsSQ2kntk
         9iuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 17 Feb 2018 03:40:13 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-9e809d15d6b692fa061d74be7aaab1c79f6784b8@git.kernel.org>
Cc: arjan@linux.intel.com, mingo@kernel.org, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, bp@alien8.de, luto@kernel.org,
        linux@dominikbrodowski.net, torvalds@linux-foundation.org,
        dwmw2@infradead.org, jpoimboe@redhat.com, hpa@zytor.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: arjan@linux.intel.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        dan.j.williams@intel.com, luto@kernel.org, bp@alien8.de,
        linux@dominikbrodowski.net, torvalds@linux-foundation.org,
        dwmw2@infradead.org, hpa@zytor.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20180214175924.23065-2-linux@dominikbrodowski.net>
References: <20180214175924.23065-2-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry: Reduce the code footprint of the
 'idtentry' macro
Git-Commit-ID: 9e809d15d6b692fa061d74be7aaab1c79f6784b8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592648851534933862?=
X-GMAIL-MSGID: =?utf-8?q?1592648851534933862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  9e809d15d6b692fa061d74be7aaab1c79f6784b8
Gitweb:     https://git.kernel.org/tip/9e809d15d6b692fa061d74be7aaab1c79f6784b8
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Wed, 14 Feb 2018 18:59:23 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 11:14:33 +0100

x86/entry: Reduce the code footprint of the 'idtentry' macro

Play a little trick in the generic PUSH_AND_CLEAR_REGS macro
to insert the GP registers "above" the original return address.

This allows us to (re-)insert the macro in error_entry() and
paranoid_entry() and to remove it from the idtentry macro. This
reduces the static footprint significantly:

   text	   data	    bss	    dec	    hex	filename
  24307	      0	      0	  24307	   5ef3	entry_64.o-orig
  20987	      0	      0	  20987	   51fb	entry_64.o

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
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
Link: http://lkml.kernel.org/r/20180214175924.23065-2-linux@dominikbrodowski.net
[ Small tweaks to comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h  | 11 ++++++++++-
 arch/x86/entry/entry_64.S | 18 ++++++++----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index dce7092..196b610 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,7 +97,7 @@ For 32-bit we have the following conventions - kernel is built with
 
 #define SIZEOF_PTREGS	21*8
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -105,8 +105,14 @@ For 32-bit we have the following conventions - kernel is built with
 	 * could be put to use in a speculative execution gadget.
 	 * Interleave XOR with PUSH for better uop scheduling:
 	 */
+	.if \save_ret
+	pushq	%rsi		/* pt_regs->si */
+	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
+	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
+	.else
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
+	.endif
 	pushq	\rdx		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
@@ -131,6 +137,9 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%r15		/* pt_regs->r15 */
 	xorq    %r15, %r15	/* nospec   r15*/
 	UNWIND_HINT_REGS
+	.if \save_ret
+	pushq	%rsi		/* return address on top of stack */
+	.endif
 .endm
 
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8971bd6..77edc23 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -875,12 +875,8 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
-	/* Save all registers in pt_regs */
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
-
 	.if \paranoid < 2
-	testb	$3, CS(%rsp)			/* If coming from userspace, switch stacks */
+	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
 	jnz	.Lfrom_usermode_switch_stack_\@
 	.endif
 
@@ -1130,13 +1126,15 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Switch gs if needed.
+ * Save all registers in pt_regs, and switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
 	rdmsr
@@ -1181,12 +1179,14 @@ ENTRY(paranoid_exit)
 END(paranoid_exit)
 
 /*
- * Switch gs if needed.
+ * Save all registers in pt_regs, and switch GS if needed.
  * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
 ENTRY(error_entry)
-	UNWIND_HINT_REGS offset=8
+	UNWIND_HINT_FUNC
 	cld
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1577,8 +1577,6 @@ end_repeat_nmi:
 	 * frame to point back to repeat_nmi.
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
 
 	/*
 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
