Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B27214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B27214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeIZOQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:16:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48561 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:16:28 -0400
Received: from [217.9.97.180] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g54oM-0000yc-5n; Wed, 26 Sep 2018 10:04:42 +0200
Date:   Wed, 26 Sep 2018 10:04:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
In-Reply-To: <20180926073426.GA31905@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1809261002510.2974@nanos.tec.linutronix.de>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de> <20180926073426.GA31905@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018, Peter Zijlstra wrote:
> On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
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
> 
> I've tried really hard to reproduce this in userspace, but so far have
> not had any luck. Looks to be a real tricky thing to make happen.

It's probably equally tricky to write a reproducer as it was to instrument
the thing. I assume it's a combination of code sequences on both CPUs which
involve other (unrelated) lock instructions on the way.

Thanks,

	tglx

