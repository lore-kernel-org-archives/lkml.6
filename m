Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49xP8/3wN9/3ub3QLKFKGXTzEy5BOctRBdcie9wiPdXB39V575TOCWeY4L4+5EgkthS/rXT
ARC-Seal: i=1; a=rsa-sha256; t=1522168928; cv=none;
        d=google.com; s=arc-20160816;
        b=ZNL39fdld+CrIkSbwmpBHLde5YY4IUxE8yySWtgWQBaKlYcwwRNxdSC84eCmXvMh4+
         fpKTYIUunz2gJ0y7iGlhQerd+hzwEHeS4/umIq8KQDpf2oqx38yrMcb6rNZLMMGjVIIJ
         Zu43xSIbFmRnYluO1FTU/oH3yHA7+PKLKh5kPs0IjeQ2tdzRU9a0wSF26M5CeKNon0R/
         K9CKaqmBb7Y4qr8Ic1ynnvCsquNo9kr5cOJDiHqxeEFajrw8MYTpcu/9jda2Zz3KAswU
         +kkjscWuEUwfHljB9CcIyTsrPrg/SNuE13kT4Ew19gV2WF+An2aYIfAP6yhC7k0Lpfl6
         Lc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XGfvYn3FMQBROmQa0/xHoZprINvgmBNcBVp+54Qe2nA=;
        b=ati3u6NKzihxxYjvF/BZHSK9HMDtPCs8EqRnCbyTtkp3CTvHks7MUxR4Zx6Yq8tmPC
         Z1BsdDKyqFJzQuw8r8L7WrmRJE1F5cF8JbBG7Qaj/vr1n+ylXvcPEDP3KzvEbh/3YKpX
         5rKgABP7pXJ2Oj3pQPs6+UF02awwm0z5EvQE+9qKLsFcVWHduOqk3hFr9r8YN46zKoHE
         CjKYC7hVkRh+srZbGgJCR3pf9Yx1hJrxhwpOQR5W9S9ggZtVlZKt3iQL0ESFrlSazp0U
         /aC979mGIEFR2zGzKsH36PlBu7BRS9pW/W6hgfsfHNQAAzAv9Wpoofl/QLCjyz8qLH/q
         w4eQ==
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
Subject: [PATCH 4.15 083/105] x86/entry/64: Dont use IST entry for #BP stack
Date: Tue, 27 Mar 2018 18:28:03 +0200
Message-Id: <20180327162803.396185242@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109065580803384?=
X-GMAIL-MSGID: =?utf-8?q?1596109806142627102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1097,7 +1097,7 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTO
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
@@ -577,7 +577,6 @@ do_general_protection(struct pt_regs *re
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-/* May run on IST stack. */
 dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -592,6 +591,13 @@ dotraplinkage void notrace do_int3(struc
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
@@ -609,15 +615,10 @@ dotraplinkage void notrace do_int3(struc
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
