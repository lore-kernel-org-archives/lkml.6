Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1122208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyfF2YyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1122208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404219AbeKTDUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403780AbeKTDUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:20:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A31D206BA;
        Mon, 19 Nov 2018 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646577;
        bh=nYqsLoaa3YNk5zpV7HgIr4MPLuws3VDPSweBjeSryMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyfF2YyBFsp3mhnjdMI0FoS06yn3IJF0xfdBBxDRfSc6Ta71K2Gft9alwvsCMZZ5g
         gLZnJniq6XxCI/oQobTqXXrdHnSbUtYlIDEyUa1nU5ID9xLX95/vI6c5gZ31CSFObZ
         PcCXlz6HTpGJOAYO0yAiWBea4or8LE14cvn5c25M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: [PATCH 4.4 011/160] x86/kconfig: Fall back to ticket spinlocks
Date:   Mon, 19 Nov 2018 17:27:30 +0100
Message-Id: <20181119162631.388413420@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Wagner <daniel.wagner@siemens.com>

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

Thomas writes:

"""
This has nothing to do with RT. RT is merily exposing the
problem in an observable way. The same issue happens with upstream, it's
harder to trigger and it's harder to observe for obvious reasons.

If you read through the discussions [see the links below] then you
really see that there is an upstream issue with the x86 qrlock
implementation and Peter has posted fixes which resolve it, both at
the practical and the theoretical level.
"""

Backporting all qspinlock related patches is very likely to introduce
regressions on v4.4. Therefore, the recommended solution by Peter and
Thomas is to drop back to ticket spinlocks for v4.4.

Link :https://lkml.kernel.org/r/20180921120226.6xjgr4oiho22ex75@linutronix.de
Link: https://lkml.kernel.org/r/20180926110117.405325143@infradead.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Thomas suggest following plan for fixing the issues on the varous
stable trees:

   4.4:  Trivial by switching back to ticket locks.

   4.9:  Decide whether bringing back ticket locks or backporting all qrlock
   	 fixes. Sebastian has done the latter already and it's probably the
   	 right solution

   4.14:
   4.18: Backporting the qrlock fixes

   4.19: Either the fix ends up in 4.19 final or it needs to be backported


 arch/x86/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -41,7 +41,6 @@ config X86
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_64
 	select ARCH_USE_QUEUED_RWLOCKS
-	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANT_FRAME_POINTERS


