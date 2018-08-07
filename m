Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93307C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3924821A70
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3924821A70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbeHGDxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbeHGDxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:53:01 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E194921A5E;
        Tue,  7 Aug 2018 01:41:08 +0000 (UTC)
Date:   Mon, 6 Aug 2018 21:41:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] lockdep: Have assert functions test for actual interrupts
 disabled
Message-ID: <20180806214107.110626d0@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

While working on irqs disabled tracepoints, I triggered the following
warning:

 ------------[ cut here ]------------
 IRQs not disabled as expected
 WARNING: CPU: 0 PID: 0 at kernel/softirq.c:144 __local_bh_enable+0x9b/0xe0
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.18.0-rc6-test+ #1099
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 RIP: 0010:__local_bh_enable+0x9b/0xe0
 Code: 5b d2 30 00 8b 85 98 08 00 00 85 c0 74 bf 80 3d ff eb 06 02 00 75 b6 48 c7 c7 80 89 46 8c c6 05 ef eb 06 02 01 e8 15 4e ff ff <0f> 0b eb 9f 48 8b 7c 24 10 e8 67 5f 09 00 eb b2 48 8b 6c 24 10 48 
 RSP: 0018:ffff8800d3e07f50 EFLAGS: 00010082
 RAX: 0000000000000000 RBX: 0000000000000100 RCX: 0000000000000000
 RDX: 0000000000000102 RSI: dffffc0000000000 RDI: ffffffff8e57dc00
 RBP: ffffffff8cc1f980 R08: fffffbfff199f449 R09: fffffbfff199f448
 R10: ffff8800d3e2643f R11: ffffed001a7c4c88 R12: 0000000000000007
 R13: 0000000000000008 R14: 0000000000000007 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff8800d3e00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000000cac14001 CR4: 00000000001606f0
 Call Trace:
  <IRQ>
  __do_softirq+0x4a0/0x55a
  irq_exit+0x128/0x130
  reschedule_interrupt+0xf/0x20
  </IRQ>
 RIP: 0010:cpuidle_enter_state+0xcc/0x430
 Code: 63 55 ff 48 89 04 24 0f 1f 44 00 00 31 ff e8 7b 8d 55 ff 80 7c 24 10 00 0f 85 fb 02 00 00 e8 eb a8 69 ff fb 66 0f 1f 44 00 00 <4c> 8b 3c 24 4c 2b 7c 24 08 48 ba cf f7 53 e3 a5 9b c4 20 48 8d 7b 
 RSP: 0018:ffffffff8cc07d18 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff02
 RAX: 0000000000025140 RBX: ffff8800d3e34f00 RCX: ffffffff8b1cec2e
 RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffffffff8cd4a868
 RBP: ffffffff8cf1b660 R08: ffffed001a7c43db R09: 0000000000000000
 R10: ffff8800d3e2643f R11: ffffed001a7c4c88 R12: ffffffff8cf1b7f8
 R13: 0000000000000004 R14: ffffffff8cf1b7e0 R15: ffffffff8cf1b820
  ? __srcu_read_unlock+0x1e/0x40
  ? cpuidle_enter_state+0xc5/0x430
  do_idle+0x28f/0x300
  ? arch_cpu_idle_exit+0x40/0x40
  ? schedule_idle+0x39/0x50
  cpu_startup_entry+0xc2/0xd0
  ? cpu_in_idle+0x20/0x20
  ? preempt_count_sub+0xaa/0x100
  ? preempt_count_add+0xaf/0xd0
  start_kernel+0x640/0x67d
  ? thread_stack_cache_init+0x6/0x6
  ? load_ucode_intel_bsp+0x5f/0xa5
  ? load_ucode_intel_bsp+0x5f/0xa5
  ? init_intel_microcode+0xb0/0xb0
  ? load_ucode_bsp+0xbb/0x156
  secondary_startup_64+0xa5/0xb0
 irq event stamp: 9229434
 hardirqs last  enabled at (9229434): [<ffffffff8b004453>] trace_hardirqs_on_thunk+0x1a/0x1c
 hardirqs last disabled at (9229433): [<ffffffff8b00446f>] trace_hardirqs_off_thunk+0x1a/0x1c
 softirqs last  enabled at (9229416): [<ffffffff8b10d35c>] irq_enter+0x7c/0x80
 softirqs last disabled at (9229417): [<ffffffff8b10d488>] irq_exit+0x128/0x130
 ---[ end trace 35ba8f92a3c06fd6 ]---
 ------------[ cut here ]------------

When investigating, I found that interrupts were actually disabled, but
the bug was that lockdep was confused. As the asserts for expecting
interrupts disabled is now done by lockdep state tracking, it would be
nice to know if the bug is the interrupts not being disabled or lockdep
just thinking that they are disabled. Add a check within the WARN_ON()
to do the actual irqs_disabled() check (which only gets done when
lockdep thinks there's an error), and show that lockdep is broken if it
does not match up with the real state of interrupts.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
----
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a8113357ceeb..c50c80eea41d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -601,12 +601,16 @@ do {									\
 #define lockdep_assert_irqs_enabled()	do {				\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
 			  !current->hardirqs_enabled,			\
-			  "IRQs not enabled as expected\n");		\
+			  irqs_disabled() ?				\
+			  "IRQs not enabled as expected\n" :		\
+			  "IRQs enabled but lockdep reports they are disabled\n"); \
 	} while (0)
 
 #define lockdep_assert_irqs_disabled()	do {				\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
 			  current->hardirqs_enabled,			\
+			  irqs_disabled() ?				\
+			  "IRQs disabled but lockdep reports they are enabled\n" : \
 			  "IRQs not disabled as expected\n");		\
 	} while (0)
 
