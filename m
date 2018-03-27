Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49rKWto1wtGFAJAAqMPYcJiGjhJdyj6SpbPB4enK+3CVtDDul7/c/p3DqACID1j8QjDfsks
ARC-Seal: i=1; a=rsa-sha256; t=1522168636; cv=none;
        d=google.com; s=arc-20160816;
        b=oFA4pp9gm5DDbkVRImIUktxLRx9JlzqThBBFv1PbgQDHzC0cL8jmC0IxZxnGDcjiot
         finniAE40MRw2CV7b5qpZWX+bnoaBfH7dSM1W1SsRJLKEGVCtGU6B9RZsQvFln3zQqQn
         8yIrhSsdykJtwaL3+mDvX0DG+Vc4in3TIPnISwf/MrwLQwJ5XFoGVMS3oDGC3S+L5qYo
         bFEKm63ugMAXlsHTXzd8TWPxmskYSF7vpxU9nIFS63BeomP7BRxE7VXf6OxCjn6Afi9y
         ZUOenUbAq1j7vna8zbhuwDlz+dfIL5C49n1JVNWMqbP4Rd8A19ouIOS095ktRq+vz2nM
         l2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3v9OBasN6i6ky+Gx/0155PEEwGRK0/uaz0O18JPXNlQ=;
        b=GoDbvrqDF1GRVF3sSpoMY8c3XbhHxqh6TM4NQQPYmTSm6kyvNV/0t6kKx6CRmdXwKs
         EWaEBKIJKyOFzqS7cuJrCJmVlcWjcdghklkgjN6XClcmEtqHTtISaXQMjyLhCbks1/gI
         gMdfx0QSJf5AYibTwNwhRxO4jw1edGTc5uQ+jH3GESBRzrIJngWgrvmvjXHP4kzKFOQy
         mFULPp8C4rAzpNTDA6G8QnL02GGRAWUULbsSfJto0t3C/zL2If4kkgcAigecY99TR497
         sxWBEvCrF2NHkomm84zMWzMO9T7rG3kn54R/26lkDjjLG1d/CCr2dtJqoujMO/oDk2kU
         r3GA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 078/101] x86/entry/64: Dont use IST entry for #BP stack
Date: Tue, 27 Mar 2018 18:27:50 +0200
Message-Id: <20180327162754.869276053@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109065580803384?=
X-GMAIL-MSGID: =?utf-8?q?1596109499934387718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit d8ba61ba58c88d5207c1ba2f7d9a2280e7d03be9 upstream.

There's nothing IST-worthy about #BP/int3.  We don't allow kprobes
in the small handful of places in the kernel that run at CPL0 with
an invalid stack, and 32-bit kernels have used normal interrupt
gates for #BP forever.

Furthermore, we don't allow kprobes in places that have usergs while
in kernel mode, so "paranoid" is also unnecessary.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64.S |    2 +-
 arch/x86/kernel/idt.c     |    2 --
 arch/x86/kernel/traps.c   |   15 ++++++++-------
 3 files changed, 9 insertions(+), 10 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1091,7 +1091,7 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTO
 #endif /* CONFIG_HYPERV */
 
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
-idtentry int3			do_int3			has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
+idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
 #ifdef CONFIG_XEN
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -160,7 +160,6 @@ static const __initconst struct idt_data
  */
 static const __initconst struct idt_data dbg_idts[] = {
 	INTG(X86_TRAP_DB,	debug),
-	INTG(X86_TRAP_BP,	int3),
 };
 #endif
 
@@ -183,7 +182,6 @@ gate_desc debug_idt_table[IDT_ENTRIES] _
 static const __initconst struct idt_data ist_idts[] = {
 	ISTG(X86_TRAP_DB,	debug,		DEBUG_STACK),
 	ISTG(X86_TRAP_NMI,	nmi,		NMI_STACK),
-	SISTG(X86_TRAP_BP,	int3,		DEBUG_STACK),
 	ISTG(X86_TRAP_DF,	double_fault,	DOUBLEFAULT_STACK),
 #ifdef CONFIG_X86_MCE
 	ISTG(X86_TRAP_MC,	&machine_check,	MCE_STACK),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -571,7 +571,6 @@ do_general_protection(struct pt_regs *re
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-/* May run on IST stack. */
 dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -586,6 +585,13 @@ dotraplinkage void notrace do_int3(struc
 	if (poke_int3_handler(regs))
 		return;
 
+	/*
+	 * Use ist_enter despite the fact that we don't use an IST stack.
+	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
+	 * mode or even during context tracking state changes.
+	 *
+	 * This means that we can't schedule.  That's okay.
+	 */
 	ist_enter(regs);
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
@@ -603,15 +609,10 @@ dotraplinkage void notrace do_int3(struc
 			SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
-	/*
-	 * Let others (NMI) know that the debug stack is in use
-	 * as we may switch to the interrupt stack.
-	 */
-	debug_stack_usage_inc();
 	cond_local_irq_enable(regs);
 	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, NULL);
 	cond_local_irq_disable(regs);
-	debug_stack_usage_dec();
+
 exit:
 	ist_exit(regs);
 }
