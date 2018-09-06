Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C3420857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C3420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbeIFGG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:06:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbeIFGG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:06:28 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A1E92083E;
        Thu,  6 Sep 2018 01:33:36 +0000 (UTC)
Date:   Wed, 5 Sep 2018 21:33:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180905213334.03375777@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[
  I'm currently testing this patch, and will push this to mainline,
  I'm  just looking for acks and review bys. Also, Peter, this is the
  bug that my patch that differentiates if lockdep is broken or if the
  code is broken when lockdep_assert_irqs_{dis,en}abled() triggers, and
  would have been helpful.
]

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

I hit the following splat in my tests:

------------[ cut here ]------------
IRQs not enabled as expected
WARNING: CPU: 3 PID: 0 at kernel/time/tick-sched.c:982 tick_nohz_idle_enter+0x44/0x8c
Modules linked in: ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables ipv6
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.19.0-rc2-test+ #2
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
EIP: tick_nohz_idle_enter+0x44/0x8c
Code: ec 05 00 00 00 75 26 83 b8 c0 05 00 00 00 75 1d 80 3d d0 36 3e c1 00
75 14 68 94 63 12 c1 c6 05 d0 36 3e c1 01 e8 04 ee f8 ff <0f> 0b 58 fa bb a0
e5 66 c1 e8 25 0f 04 00 64 03 1d 28 31 52 c1 8b
EAX: 0000001c EBX: f26e7f8c ECX: 00000006 EDX: 00000007
ESI: f26dd1c0 EDI: 00000000 EBP: f26e7f40 ESP: f26e7f38
DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010296
CR0: 80050033 CR2: 0813c6b0 CR3: 2f342000 CR4: 001406f0
Call Trace:
 do_idle+0x33/0x202
 cpu_startup_entry+0x61/0x63
 start_secondary+0x18e/0x1ed
 startup_32_smp+0x164/0x168
irq event stamp: 18773830
hardirqs last  enabled at (18773829): [<c040150c>] trace_hardirqs_on_thunk+0xc/0x10
hardirqs last disabled at (18773830): [<c040151c>] trace_hardirqs_off_thunk+0xc/0x10
softirqs last  enabled at (18773824): [<c0ddaa6f>] __do_softirq+0x25f/0x2bf
softirqs last disabled at (18773767): [<c0416bbe>] call_on_stack+0x45/0x4b
---[ end trace b7c64aa79e17954a ]---

After a bit of debugging, I found what was happening. This would trigger
when performing "perf" with a high NMI interrupt rate, while enabling and
disabling function tracer. Ftrace uses breakpoints to convert the nops at
the start of functions to calls to the function trampolines. The breakpoint
traps disable interrupts and this makes calls into lockdep via the
trace_hardirqs_off_thunk in the entry.S code. What happens is the following:

  do_idle {

    [interrupts enabled]

    <interrupt> [interrupts disabled]
	TRACE_IRQS_OFF [lockdep says irqs off]
	[...]
	TRACE_IRQS_IRET
	    test if pt_regs say return to interrupts enabled [yes]
	    TRACE_IRQS_ON [lockdep says irqs are on]

	    <nmi>
		nmi_enter() {
		    printk_nmi_enter() [traced by ftrace]
		    [ hit ftrace breakpoint ]
		    <breakpoint exception>
			TRACE_IRQS_OFF [lockdep says irqs off]
			[...]
			TRACE_IRQS_IRET [return from breakpoint]
			   test if pt_regs say interrupts enabled [no]
			   [iret back to interrupt]
	   [iret back to code]

    tick_nohz_idle_enter() {

	lockdep_assert_irqs_enabled() [lockdep say no!]

Although interrupts are indeed enabled, lockdep thinks it is not, and since
we now do asserts via lockdep, it gives a false warning. The issue here is
that printk_nmi_enter() is called before lockdep_off(), which disables
lockdep (for this reason) in NMIs. By simply not allowing ftrace to see
printk_nmi_enter() (via notrace annotation) we keep lockdep from getting
confused.

Cc: stable@vger.kernel.org
Fixes: 099f1c84c0052 ("printk: introduce per-cpu safe_print seq buffer")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/printk/printk_safe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index a0a74c533e4b..0913b4d385de 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -306,12 +306,12 @@ static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
 	return printk_safe_log_store(s, fmt, args);
 }
 
-void printk_nmi_enter(void)
+void notrace printk_nmi_enter(void)
 {
 	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
 }
 
-void printk_nmi_exit(void)
+void notrace printk_nmi_exit(void)
 {
 	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
 }
-- 
2.13.6

