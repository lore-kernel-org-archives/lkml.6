Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D2EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97E8214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97E8214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbeIURvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:51:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389968AbeIURvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:51:05 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g3K8g-0000ey-MZ; Fri, 21 Sep 2018 14:02:26 +0200
Date:   Fri, 21 Sep 2018 14:02:26 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Wagner <daniel.wagner@siemens.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [Problem] Cache line starvation
Message-ID: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This matches Daniel Wagner's observations which he described in [0] on
v4.4-RT.

It took us weeks to hunt this down as it's really showing true Heisenbug
behaviour and instrumentation at the wrong place makes it vanish
immediately.

Other data points:

Replacing the single rep_nop() in cpu_relax() with two consecutive
rep_nop() makes it harder to trigger on the Core2Duo machine. Adding a
third one seems to resolve it completely, though no long term runs done
yet. Also our attempt of instrumenting the lock()/unlock() sequence more
deeply with rdtsc() timestamps made it go away. On SKL the identical
instrumentation hides it.

Peter suggested to do a clwb(&p->pi_lock); before the cpu_relax() in
wait_task_inactive() which on both the Core2Duo and the SKL gets runtime
patched to clflush(). That hides it as well.

On ARM64 we suspected something like this without having real proof a week
ago and added a delay loop to cpu_relax(). That "resolved" the issue. By
now we have traces on ARM64 which proof it to be the same issue.

Daniel reported that disabling ticket locks on 4.4 makes the problem go
away, but he hasn't run a long time test yet and as we saw with 4.14 it can
take quite a while.

While it is pretty reliable reproducible with an RT kernel, this is not an
RT kernel issue at all. Mainline has similar or even the same code
patterns, but it's harder to observe as there are no latency guarantees for
an observer like cyclictest. The fact that an interrupt makes it go away
makes it even harder because the rare stalls just go unnoticed because they
are canceled early.

[0] https://lkml.kernel.org/r/4d878d3e-bd1b-3d6e-bdde-4ce840191093@monom.org

Sebastian
