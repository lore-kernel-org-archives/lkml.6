Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeE3LQN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:16:13 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60683 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751526AbeE3LHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:24 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.677973116@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 023/153] x86/entry/64: Don't use IST entry for #BP stack
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
 TRAP_DB/BP", and restore change in trap_init() instead of early_trap_init().
 Backport to 3.2:
 - Use zeroentry macro in entry_64.S
 - Drop changes related to breakpoint-in-NMI support
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1401,7 +1401,7 @@ apicinterrupt XEN_HVM_EVTCHN_CALLBACK \
 	.pushsection .kprobes.text, "ax"
 
 paranoidzeroentry_ist debug do_debug DEBUG_STACK
-paranoidzeroentry_ist int3 do_int3 DEBUG_STACK
+zeroentry int3 do_int3
 errorentry stack_segment do_stack_segment
 #ifdef CONFIG_XEN
 zeroentry xen_debug do_debug
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -314,7 +314,6 @@ gp_in_kernel:
 	die("general protection fault", regs, error_code);
 }
 
-/* May run on IST stack. */
 dotraplinkage void __kprobes do_int3(struct pt_regs *regs, long error_code)
 {
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
@@ -790,13 +789,11 @@ void __init trap_init(void)
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
 }
