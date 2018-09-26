Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F1FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495942089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ONGgO6TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495942089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeIZNqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:46:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeIZNqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oafizKIcN4uSLdzDZamEnbzJjc6XZNuy5z9AD4S5UuA=; b=ONGgO6TLdfpYT9s+2eyd4Z6Y3
        TbY4QABIYbeybROx5pY63EOMBMQyuHv+JW0GtTwp2vCyPksGuEClVJArfb45uGqhBEvxEVz0LLgia
        TeP48uq9yCXrXQdmNctb+CE9J/mSlFanY7IujO8uakAOgSzRnTgdJVkJh2gpzm8KzK/0Lj6t1aujg
        JOBNdvDUvvBhxPDRSLhVeDUOkLKKpiNdb2cQXqMh/DAkVszPeMhzjruw687Iysw5rppIhP9t4UiYX
        OWm1ewzJ3hljcQkA/A8HV7betkQy7+MBoawixhkpnqsMPBeXEyjCR7r/RbmiSw5Sx+QWfeVcuYs30
        YUkBT2KjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g54L8-0006El-D7; Wed, 26 Sep 2018 07:34:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50D252029B098; Wed, 26 Sep 2018 09:34:26 +0200 (CEST)
Date:   Wed, 26 Sep 2018 09:34:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
Message-ID: <20180926073426.GA31905@hirez.programming.kicks-ass.net>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
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

I've tried really hard to reproduce this in userspace, but so far have
not had any luck. Looks to be a real tricky thing to make happen.
