Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7613DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF1A2151C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF1A2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeIZTF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:05:59 -0400
Received: from foss.arm.com ([217.140.101.70]:45394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIZTF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:05:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E75C7A9;
        Wed, 26 Sep 2018 05:53:07 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362B43F5B7;
        Wed, 26 Sep 2018 05:53:05 -0700 (PDT)
Date:   Wed, 26 Sep 2018 13:53:02 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
Message-ID: <20180926125301.GE2979@brain-police>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> cores).
> 
> Instrumentation show always the picture:
> 
> CPU0                                         CPU1
> => do_syscall_64                              => do_syscall_64
> => SyS_ptrace                                   => syscall_slow_exit_work
> => ptrace_check_attach                          => ptrace_do_notify / rt_read_unlock 
> => wait_task_inactive                              rt_spin_lock_slowunlock()
>    -> while task_running()                         __rt_mutex_unlock_common()
>   /   check_task_state()                           mark_wakeup_next_waiter()
>  |     raw_spin_lock_irq(&p->pi_lock);             raw_spin_lock(&current->pi_lock);
>  |     .                                               .
>  |     raw_spin_unlock_irq(&p->pi_lock);               .
>   \  cpu_relax()                                       .
>    -                                                   .
>     *IRQ*                                          <lock acquired>
> 
> In the error case we observe that the while() loop is repeated more than
> 5000 times which indicates that the pi_lock can be acquired. CPU1 on the
> other side does not make progress waiting for the same lock with interrupts
> disabled.
> 
> This continues until an IRQ hits CPU0. Once CPU0 starts processing the IRQ
> the other CPU is able to acquire pi_lock and the situation relaxes.
> 
> Peter suggested to do a clwb(&p->pi_lock); before the cpu_relax() in
> wait_task_inactive() which on both the Core2Duo and the SKL gets runtime
> patched to clflush(). That hides it as well.

Given the broadcast nature of cache-flushing, I'd be pretty nervous about
adding it on anything other than a case-by-case basis. That doesn't sound
like something we'd want to maintain... It would also be interesting to know
whether the problem is actually before the cache (i.e. if the lock actually
sits in the store buffer on CPU0). Does MFENCE/DSB after the unlock() help at
all?

We've previously seen something similar to this on arm64 in big/little
systems where the big cores can loop around and re-take a spinlock before
the little guys can get in the queue or take a ticket. I bodged that in
cpu_relax(), but there's a magic heuristic which I couldn't figure out how
to specify:

https://lkml.org/lkml/2017/7/28/172

For A72 (which is the core I think you're using) it would be interesting to
try both:

	(1) Removing the prfm instruction from spin_lock(), and
	(2) Setting bit 42 of CPUACTLR_EL1 on each CPU (probably needs a
	    firmware change)

That should prevent the lock() operation from speculatively pulling in the
cacheline in a unique state.

More recent Arm CPUs have atomic instructions which, apart from CAS,
*should* avoid this starvation issue entirely.

Will
