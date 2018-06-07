Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id r5CEJKlYGVsgAwAAmS7hNA
	; Thu, 07 Jun 2018 16:12:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A6A2F6074D; Thu,  7 Jun 2018 16:12:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 16C1A605A2;
	Thu,  7 Jun 2018 16:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16C1A605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935321AbeFGQMM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:12:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39168 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932970AbeFGOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:01 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0005a0-Gb; Thu, 07 Jun 2018 15:08:59 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002ir-82; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andy Lutomirski" <luto@kernel.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.754426041@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 034/410] x86/entry/64: Don't use IST entry for #BP stack
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
[carnil: Backport to 3.16:
 - Adjust finename change: arch/x86/kernel/entry_64.S
 - Context changes
]
[bwh: Rebase on top of "x86/traps: Enable DEBUG_STACK after cpu_init() for
 TRAP_DB/BP", and restore change in trap_init() instead of early_trap_init()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1322,7 +1322,7 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTO
 #endif /* CONFIG_HYPERV */
 
 idtentry debug do_debug has_error_code=0 paranoid=1 shift_ist=DEBUG_STACK
-idtentry int3 do_int3 has_error_code=0 paranoid=1 shift_ist=DEBUG_STACK
+idtentry int3 do_int3 has_error_code=0
 idtentry stack_segment do_stack_segment has_error_code=1
 #ifdef CONFIG_XEN
 idtentry xen_debug do_debug has_error_code=0
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -334,7 +334,6 @@ exit:
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-/* May run on IST stack. */
 dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 {
 	enum ctx_state prev_state;
@@ -367,15 +366,9 @@ dotraplinkage void notrace do_int3(struc
 			SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
-	/*
-	 * Let others (NMI) know that the debug stack is in use
-	 * as we may switch to the interrupt stack.
-	 */
-	debug_stack_usage_inc();
 	preempt_conditional_sti(regs);
 	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, NULL);
 	preempt_conditional_cli(regs);
-	debug_stack_usage_dec();
 exit:
 	exception_exit(prev_state);
 }
@@ -862,19 +855,16 @@ void __init trap_init(void)
 	cpu_init();
 
 	/*
-	 * X86_TRAP_DB and X86_TRAP_BP have been set
-	 * in early_trap_init(). However, DEBUG_STACK works only after
-	 * cpu_init() loads TSS. See comments in early_trap_init().
+	 * X86_TRAP_DB was installed in early_trap_init(). However,
+	 * DEBUG_STACK works only after cpu_init() loads TSS. See comments
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
