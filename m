Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40461C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F2921712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F2921712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeI0Uo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:44:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52095 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0Uo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:44:26 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1g5XEi-0005A1-CN; Thu, 27 Sep 2018 16:25:48 +0200
Date:   Thu, 27 Sep 2018 16:25:47 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Problem] Cache line starvation
Message-ID: <20180927142547.ucgh5elb7pxs46dq@linutronix.de>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
 <20180926125301.GE2979@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926125301.GE2979@brain-police>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, Sep 26, 2018 at 01:53:02PM +0100, Will Deacon wrote:
> Hi all,
>
> On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> > We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> > cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> > cores).
> >
> > Instrumentation show always the picture:
> >
> > CPU0                                         CPU1
> > => do_syscall_64                              => do_syscall_64
> > => SyS_ptrace                                   => syscall_slow_exit_work
> > => ptrace_check_attach                          => ptrace_do_notify / rt_read_unlock
> > => wait_task_inactive                              rt_spin_lock_slowunlock()
> >    -> while task_running()                         __rt_mutex_unlock_common()
> >   /   check_task_state()                           mark_wakeup_next_waiter()
> >  |     raw_spin_lock_irq(&p->pi_lock);             raw_spin_lock(&current->pi_lock);
> >  |     .                                               .
> >  |     raw_spin_unlock_irq(&p->pi_lock);               .
> >   \  cpu_relax()                                       .
> >    -                                                   .
> >     *IRQ*                                          <lock acquired>
> >
> > In the error case we observe that the while() loop is repeated more than
> > 5000 times which indicates that the pi_lock can be acquired. CPU1 on the
> > other side does not make progress waiting for the same lock with interrupts
> > disabled.
> >
> > This continues until an IRQ hits CPU0. Once CPU0 starts processing the IRQ
> > the other CPU is able to acquire pi_lock and the situation relaxes.
> >
> > Peter suggested to do a clwb(&p->pi_lock); before the cpu_relax() in
> > wait_task_inactive() which on both the Core2Duo and the SKL gets runtime
> > patched to clflush(). That hides it as well.
>
> Given the broadcast nature of cache-flushing, I'd be pretty nervous about
> adding it on anything other than a case-by-case basis. That doesn't sound
> like something we'd want to maintain... It would also be interesting to know
> whether the problem is actually before the cache (i.e. if the lock actually
> sits in the store buffer on CPU0). Does MFENCE/DSB after the unlock() help at
> all?
>
> We've previously seen something similar to this on arm64 in big/little
> systems where the big cores can loop around and re-take a spinlock before
> the little guys can get in the queue or take a ticket. I bodged that in
> cpu_relax(), but there's a magic heuristic which I couldn't figure out how
> to specify:
>
> https://lkml.org/lkml/2017/7/28/172
>
> For A72 (which is the core I think you're using) it would be interesting to
> try both:
>
> 	(1) Removing the prfm instruction from spin_lock(), and
> 	(2) Setting bit 42 of CPUACTLR_EL1 on each CPU (probably needs a
> 	    firmware change)

correct, we use the Cortex A72.

I followed your suggestions. I've removed the prefetch instructions from
the spin lock implementation in the v4.9 kernel. In addition I've
modified armv8/start.S in U-Boot to setup bit 42 in CPUACTLR_EL1
(S3_1_c15_c2_0). We've also made sure, that this bit is actually written
for each CPU by reading their register value in the kernel.

However, the issue still triggers fine. With stress-ng we're able to
generate latency in millisecond range. The only workaround we've found
so far is to add a "delay" in cpu_relax().

Any ideas, what we can test further?

Thanks,
Kurt

>
> That should prevent the lock() operation from speculatively pulling in the
> cacheline in a unique state.
>
> More recent Arm CPUs have atomic instructions which, apart from CAS,
> *should* avoid this starvation issue entirely.
>
> Will
>
