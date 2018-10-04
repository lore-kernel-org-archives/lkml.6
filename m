Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B7BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82EE20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82EE20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeJDU7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:59:23 -0400
Received: from thoth.sbs.de ([192.35.17.2]:41960 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJDU7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:59:23 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w94DjvGI008315
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Oct 2018 15:45:57 +0200
Received: from localhost ([139.25.0.78])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w94DjsAL029229;
        Thu, 4 Oct 2018 15:45:54 +0200
From:   Daniel Wagner <daniel.wagner@siemens.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Cc:     Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RT 1/2] x86/kconfig: Use ticket spinlocks for -rt
Date:   Thu,  4 Oct 2018 15:46:21 +0200
Message-Id: <20181004134622.23181-2-daniel.wagner@siemens.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004134622.23181-1-daniel.wagner@siemens.com>
References: <20181004134622.23181-1-daniel.wagner@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.4.148-rt166-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Sebastian writes:

"""
We reproducibly observe cache line starvation on a Core2Duo E6850 (2
cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
cores).

The problem can be triggered with a v4.9-RT kernel by starting

    cyclictest -S -p98 -m  -i2000 -b 200

and as "load"

    stress-ng --ptrace 4

The reported maximal latency is usually less than 60us. If the problem
triggers then values around 400us, 800us or even more are reported. The
upperlimit is the -i parameter.

Reproduction with 4.9-RT is almost immediate on Core2Duo, ARM64 and SKL,
but it took 7.5 hours to trigger on v4.14-RT on the Core2Duo.

Instrumentation show always the picture:

CPU0                                         CPU1
=> do_syscall_64                              => do_syscall_64
=> SyS_ptrace                                   => syscall_slow_exit_work
=> ptrace_check_attach                          => ptrace_do_notify / rt_read_unlock
=> wait_task_inactive                              rt_spin_lock_slowunlock()
   -> while task_running()                         __rt_mutex_unlock_common()
  /   check_task_state()                           mark_wakeup_next_waiter()
 |     raw_spin_lock_irq(&p->pi_lock);             raw_spin_lock(&current->pi_lock);
 |     .                                               .
 |     raw_spin_unlock_irq(&p->pi_lock);               .
  \  cpu_relax()                                       .
   -                                                   .
    *IRQ*                                          <lock acquired>

In the error case we observe that the while() loop is repeated more than
5000 times which indicates that the pi_lock can be acquired. CPU1 on the
other side does not make progress waiting for the same lock with interrupts
disabled.

This continues until an IRQ hits CPU0. Once CPU0 starts processing the IRQ
the other CPU is able to acquire pi_lock and the situation relaxes.
"""

This matches with the observeration for v4.4-rt on a Core2Duo E6850:

CPU 0:

- no progress for a very long time in rt_mutex_dequeue_pi):

stress-n-1931    0d..11  5060.891219: function:             __try_to_take_rt_mutex
stress-n-1931    0d..11  5060.891219: function:                rt_mutex_dequeue
stress-n-1931    0d..21  5060.891220: function:                rt_mutex_enqueue_pi
stress-n-1931    0....2  5060.891220: signal_generate:      sig=17 errno=0 code=262148 comm=stress-ng-ptrac pid=1928 grp=1 res=1
stress-n-1931    0d..21  5060.894114: function:             rt_mutex_dequeue_pi
stress-n-1931    0d.h11  5060.894115: local_timer_entry:    vector=239

CPU 1:

- IRQ at 5060.894114 on CPU 1 followed by the IRQ on CPU 0

stress-n-1928    1....0  5060.891215: sys_enter:            NR 101 (18, 78b, 0, 0, 17, 788)
stress-n-1928    1d..11  5060.891216: function:             __try_to_take_rt_mutex
stress-n-1928    1d..21  5060.891216: function:                rt_mutex_enqueue_pi
stress-n-1928    1d..21  5060.891217: function:             rt_mutex_dequeue_pi
stress-n-1928    1....1  5060.891217: function:             rt_mutex_adjust_prio
stress-n-1928    1d..11  5060.891218: function:                __rt_mutex_adjust_prio
stress-n-1928    1d.h10  5060.894114: local_timer_entry:    vector=239

Backporting all qspinlock related patches is very likely to introduce
regressions. Therefore, the recommended solution by Peter Z is to drop
back to ticket spinlocks for -rt.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6df130a37d41..21f9418d850f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -42,7 +42,7 @@ config X86
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_64
 	select ARCH_USE_QUEUED_RWLOCKS
-	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS	if !PREEMPT_RT_FULL
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANT_FRAME_POINTERS
-- 
2.17.1

