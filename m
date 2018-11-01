Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAA0C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5663205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HewJoimV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5663205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeKASUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:20:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKASUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OxugYB6CvjJlRwnzNtWqL6eI25V8TMKto44QxHBvpME=; b=HewJoimVdXulna287crzutbRh
        UUUl6ZutMvRcEIL5Uo2fZoPWm7Wzt9OjwOiQgx+c7Fr46452UinJW4x66Ex9jama+bEjRgj6kyuPx
        cR4zo3Iit8QNnbGdDD+eM86vsXZNOVpGSuLDxo2aLS0c1lvodY/+qz8hALL6/oB6rMof03j90D9oW
        XyhFAZqxak1XCD9htrjSS1M01hwvIRuXRzuBn44JTJn9mGY2g8W7Xl+mJm95S+735BkN8IqxmjmVo
        6x0c0Lc3+vAGTIejAw/c8nVDCvo722K9OqIOhtU6eYI8FKbD0YippXgh12A89+SWv3oPi3evO0zpZ
        eYM+vhk6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gI97A-0006NT-S1; Thu, 01 Nov 2018 09:18:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAACB20296F15; Thu,  1 Nov 2018 10:18:06 +0100 (CET)
Date:   Thu, 1 Nov 2018 10:18:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Wagner <wagi@monom.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4.4] x86/kconfig: Fall back to ticket spinlocks
Message-ID: <20181101091806.GB3178@hirez.programming.kicks-ass.net>
References: <20181031081458.13996-1-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031081458.13996-1-wagi@monom.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:14:58AM +0100, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@siemens.com>
> 
> Sebastian writes:
> 
> """
> We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> cores).
> 
> The problem can be triggered with a v4.9-RT kernel by starting
> 
>     cyclictest -S -p98 -m  -i2000 -b 200
> 
> and as "load"
> 
>     stress-ng --ptrace 4
> 
> The reported maximal latency is usually less than 60us. If the problem
> triggers then values around 400us, 800us or even more are reported. The
> upperlimit is the -i parameter.
> 
> Reproduction with 4.9-RT is almost immediate on Core2Duo, ARM64 and SKL,
> but it took 7.5 hours to trigger on v4.14-RT on the Core2Duo.
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
> """
> 
> This matches with the observeration for v4.4-rt on a Core2Duo E6850:
> 
> CPU 0:
> 
> - no progress for a very long time in rt_mutex_dequeue_pi):
> 
> stress-n-1931    0d..11  5060.891219: function:             __try_to_take_rt_mutex
> stress-n-1931    0d..11  5060.891219: function:                rt_mutex_dequeue
> stress-n-1931    0d..21  5060.891220: function:                rt_mutex_enqueue_pi
> stress-n-1931    0....2  5060.891220: signal_generate:      sig=17 errno=0 code=262148 comm=stress-ng-ptrac pid=1928 grp=1 res=1
> stress-n-1931    0d..21  5060.894114: function:             rt_mutex_dequeue_pi
> stress-n-1931    0d.h11  5060.894115: local_timer_entry:    vector=239
> 
> CPU 1:
> 
> - IRQ at 5060.894114 on CPU 1 followed by the IRQ on CPU 0
> 
> stress-n-1928    1....0  5060.891215: sys_enter:            NR 101 (18, 78b, 0, 0, 17, 788)
> stress-n-1928    1d..11  5060.891216: function:             __try_to_take_rt_mutex
> stress-n-1928    1d..21  5060.891216: function:                rt_mutex_enqueue_pi
> stress-n-1928    1d..21  5060.891217: function:             rt_mutex_dequeue_pi
> stress-n-1928    1....1  5060.891217: function:             rt_mutex_adjust_prio
> stress-n-1928    1d..11  5060.891218: function:                __rt_mutex_adjust_prio
> stress-n-1928    1d.h10  5060.894114: local_timer_entry:    vector=239
> 
> Thomas writes:
> 
> """
> This has nothing to do with RT. RT is merily exposing the
> problem in an observable way. The same issue happens with upstream, it's
> harder to trigger and it's harder to observe for obvious reasons.
> 
> If you read through the discussions [see the links below] then you
> really see that there is an upstream issue with the x86 qrlock
> implementation and Peter has posted fixes which resolve it, both at
> the practical and the theoretical level.
> """
> 
> Backporting all qspinlock related patches is very likely to introduce
> regressions on v4.4. Therefore, the recommended solution by Peter and
> Thomas is to drop back to ticket spinlocks for v4.4.
> 
> Link :https://lkml.kernel.org/r/20180921120226.6xjgr4oiho22ex75@linutronix.de
> Link: https://lkml.kernel.org/r/20180926110117.405325143@infradead.org
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
