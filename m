Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/o/p7MRZz76a7aqrcQltpOLgyVEc+lImifKJ3Smd4pgoXQxh6buOSY5XZY8BnDxxXAyVt9
ARC-Seal: i=1; a=rsa-sha256; t=1522168363; cv=none;
        d=google.com; s=arc-20160816;
        b=OGFm/ohD/Xvn5veA7j3U2JaWgja+q58RKdcmerZQ6WFTVJWxs0zq50+d8mYChrCObF
         9ndAosg7mRVhIORrFQYCBOa/mKwy0ucmxLKPgVdLw5O5kad4jH/LFVfBQSqnzIdAa53c
         9qJIZEIL8MFsoD5ZOSLkzN08wXAPFnkQAUlMJeCpiUWchZZu9c6X9jtsyw2Y9fpaGnpD
         kDuummmrYRr7knbQKDDUzNB/I+oW/4APMousqsGhRbgebsCsJtdbmVphY/ZaSH8Mj5rD
         eY7S86IdKt4KXjK5IQ6l+94BvrQsHATQMap0lkWGprY6vM+Dsoy0QyOgwYN2Ph01/bjB
         Y1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CvYXXS37PYL8I1FVpLSKIgElGYcM+C80aNBehCp43iM=;
        b=iVmhotjphbtWDaIsNvGrMJzG/sTB2Z7uhaSrXLg9nyqj9BBZ8DgCh1K+p0ujXnR92r
         bSvYcQgcz450Zi7yTes/w/GZPY5nuJeswNVe9s5FfMR8zHCXHCG9v0GvwZwqexvvnlqr
         dCwo46WRZRzkhqriRVuyZT0CPW04puj/jcir0KtOqMtMSyVfWlMDjdxCnFDq3KV5gD+H
         cxRfw3+N9xy/YGhmP5LVyw4QH0cV4xIzXCTuhFkuPUDToxZjDHyb7j4ib4BrgKKpvdYl
         i6wXyNNiVcS2kJCsxcamcTQkyT7tRgnnIhcEXHf52tLhzN+rb6dWGy5Ny+1+wp3ik9XM
         2Kgg==
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
Subject: [PATCH 4.9 53/67] x86/entry/64: Dont use IST entry for #BP stack
Date: Tue, 27 Mar 2018 18:27:45 +0200
Message-Id: <20180327162730.431033236@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109065580803384?=
X-GMAIL-MSGID: =?utf-8?q?1596109213918809131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/x86/kernel/traps.c   |   24 +++++++++++-------------
 2 files changed, 12 insertions(+), 14 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -943,7 +943,7 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTO
 #endif /* CONFIG_HYPERV */
 
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
-idtentry int3			do_int3			has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
+idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
 #ifdef CONFIG_XEN
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -526,7 +526,6 @@ do_general_protection(struct pt_regs *re
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-/* May run on IST stack. */
 dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -541,7 +540,15 @@ dotraplinkage void notrace do_int3(struc
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
+
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
@@ -558,17 +565,11 @@ dotraplinkage void notrace do_int3(struc
 			SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
-	/*
-	 * Let others (NMI) know that the debug stack is in use
-	 * as we may switch to the interrupt stack.
-	 */
-	debug_stack_usage_inc();
 	preempt_disable();
 	cond_local_irq_enable(regs);
 	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, NULL);
 	cond_local_irq_disable(regs);
 	preempt_enable_no_resched();
-	debug_stack_usage_dec();
 exit:
 	ist_exit(regs);
 }
@@ -989,19 +990,16 @@ void __init trap_init(void)
 	cpu_init();
 
 	/*
-	 * X86_TRAP_DB and X86_TRAP_BP have been set
-	 * in early_trap_init(). However, ITS works only after
-	 * cpu_init() loads TSS. See comments in early_trap_init().
+	 * X86_TRAP_DB was installed in early_trap_init(). However,
+	 * IST works only after cpu_init() loads TSS. See comments
+	 * in early_trap_init().
 	 */
 	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
-	/* int3 can be called from all */
-	set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
 
 	x86_init.irqs.trap_init();
 
 #ifdef CONFIG_X86_64
 	memcpy(&debug_idt_table, &idt_table, IDT_ENTRIES * 16);
 	set_nmi_gate(X86_TRAP_DB, &debug);
-	set_nmi_gate(X86_TRAP_BP, &int3);
 #endif
 }
