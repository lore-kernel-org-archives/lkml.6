Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMvy8smBG+6h2XjMWNAKHlGNQ+f05d14YqS5144kVhuK88EyPfvIe35DEZsVfFr31AK4Us
ARC-Seal: i=1; a=rsa-sha256; t=1520955080; cv=none;
        d=google.com; s=arc-20160816;
        b=sCSwyWp5WBkBHKPtwmwoDr/S7/tygjmtfK2tGUcoKX749UtK0jPLDKtPR/K5COOp36
         fq2/iBBt1+qrVaKMtTdnheurqRrtxE0D4k+YvBR/tRpm74Ms40890+wVO//VH147zynZ
         qmeUJrNB4dECPqpIdu6dhcYb/2l/qA68tqWqtQr6XRFb0eHcuNsdSG34RrJDuvmaHBll
         7Rqk9Y8YnlKNYWHU8w4ta+Z+dTNbUo4qHDHIK02/dOITQi/CIpKCgplRL0/TbzXm2wrF
         klOod+X6F80wF0wD1iQxtqmE4L0GwL6O3h2NdYHd32mrncrdWAs0OIfDt0D6gA76DlAp
         w7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RKGQcML/oW96FBXAV81CgBj2jfLfUUTFHP17Nyb8h2A=;
        b=mkU+eLvfWBDNI0eOvWLUnBhubLjsIqCvBnG5o7pOq3NmCKbniAgJ0fYnBOa0cTtfO9
         RYqDktMQQpsoUV+vehmgJoASxMP+3s1ch3xh29qLvnQtFo4nTvZhR6olGJTkYbKGVXqO
         XYkYt1idhxnLUbJk9wkLTzaZHlOAmp3mLvs6BJYBieyRuXNUFGC8Qbkplgrkw5SXN4FI
         R7baSiOhGupT68xPONexlMoSEK2LTf/wDO+AY/Qilt514hxIywDjUYXC9FgTIBLABNX8
         Zac+mJgN6GRKmIMNkC4DBnV0+VDavMegN/o8SvmbDxrMF2/eR3TUVYshXicIjdAcac66
         hEUQ==
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
Subject: [PATCH 4.15 082/146] x86/entry: Reduce the code footprint of the idtentry macro
Date: Tue, 13 Mar 2018 16:24:09 +0100
Message-Id: <20180313152327.127947652@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836994350650853?=
X-GMAIL-MSGID: =?utf-8?q?1594836994350650853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 9e809d15d6b692fa061d74be7aaab1c79f6784b8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   11 ++++++++++-
 arch/x86/entry/entry_64.S |   18 ++++++++----------
 2 files changed, 18 insertions(+), 11 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,7 +97,7 @@ For 32-bit we have the following convent
 
 #define SIZEOF_PTREGS	21*8
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -105,8 +105,14 @@ For 32-bit we have the following convent
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
@@ -131,6 +137,9 @@ For 32-bit we have the following convent
 	pushq	%r15		/* pt_regs->r15 */
 	xorq    %r15, %r15	/* nospec   r15*/
 	UNWIND_HINT_REGS
+	.if \save_ret
+	pushq	%rsi		/* return address on top of stack */
+	.endif
 .endm
 
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -871,12 +871,8 @@ ENTRY(\sym)
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
 
@@ -1123,13 +1119,15 @@ idtentry machine_check		do_mce			has_err
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
@@ -1174,12 +1172,14 @@ ENTRY(paranoid_exit)
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
 
@@ -1570,8 +1570,6 @@ end_repeat_nmi:
 	 * frame to point back to repeat_nmi.
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
 
 	/*
 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
