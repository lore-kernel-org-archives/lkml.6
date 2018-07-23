Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6324EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA5220846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TTBQPvoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA5220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbeGWKtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:49:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbeGWKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pNvjrD+hlTkqWSIrlyh6Ehx7ZfErlv2rQYTTNQpQcTQ=; b=TTBQPvoXpWbqEUDXKw+PlvqMU
        prj9EKFIFp+dq6LNCOKLjoUTXRL4NS1k8ddi6c2S0bljTzGn/2jXwNe8IYHjgKW4s+TG1TLvZqbUz
        UiVuHyzTM47f5DEmUB1BnzwCYTAV5aUdmwwmPi2GfE3gBLLsbc8/yZyaLmT5Fqdlkgt9iayZ2UWOm
        bBstdLSHkOGm9Zjek/lzb6fVl5Gf1+9oubkH78JoS+MP+xbx7f/fh2GGb1OuDmDr0g6YZdO7+zCfb
        xNsrOP/LizE6FY0hgoNO6x65q2Vt5k4fBUskLBf5E7hairekx+D036kh4z1PpmUf9y+c0qMxIJKMq
        YAWP1dSYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhXSk-0006vr-O3; Mon, 23 Jul 2018 09:49:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 874AD20275F4B; Mon, 23 Jul 2018 11:49:04 +0200 (CEST)
Date:   Mon, 23 Jul 2018 11:49:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alessio Balsini <alessio.balsini@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: sched_getattr() returns absolute
 dl-task information
Message-ID: <20180723094904.GB2494@hirez.programming.kicks-ass.net>
References: <20180629120947.14579-1-alessio.balsini@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629120947.14579-1-alessio.balsini@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:09:47PM +0200, Alessio Balsini wrote:

Joel nailed it wrt the Changelog, that needs improvement.


> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fbfc3f1d368a..f75a4169cd47 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2568,13 +2568,41 @@ void __setparam_dl(struct task_struct *p, const struct sched_attr *attr)
>  	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
>  }
>  
> -void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
> +void __getparam_dl(struct task_struct *p, struct sched_attr *attr,
> +		   unsigned int flags)
>  {
>  	struct sched_dl_entity *dl_se = &p->dl;
>  
>  	attr->sched_priority = p->rt_priority;
> -	attr->sched_runtime = dl_se->dl_runtime;
> -	attr->sched_deadline = dl_se->dl_deadline;
> +
> +	if (flags & SCHED_GETATTR_FLAGS_DL_ABSOLUTE) {
> +		/*
> +		 * If the task is not running, its runtime is already
> +		 * properly accounted. Otherwise, update clocks and the
> +		 * statistics for the task.
> +		 */
> +		if (task_running(task_rq(p), p)) {
> +			struct rq_flags rf;
> +			struct rq *rq;
> +
> +			rq = task_rq_lock(p, &rf);
> +			sched_clock_tick();

This isn't required here. The reason it is used elsewhere is because
those are interrupts, but this is a system call, the clock state should
be good.

> +			update_rq_clock(rq);
> +			task_tick_dl(rq, p, 0);

Do we really want task_tick_dl() here, or update_curr_dl()? Also, who
says the task still is dl ? :-)

> +			task_rq_unlock(rq, p, &rf);
> +		}
> +
> +		/*
> +		 * If the task is throttled, this value could be negative,
> +		 * but sched_runtime is unsigned.
> +		 */
> +		attr->sched_runtime = dl_se->runtime <= 0 ? 0 : dl_se->runtime;
> +		attr->sched_deadline = dl_se->deadline;

This is all very racy..

Even if the task wasn't running when you did the task_running() test, it
could be running now. And if it was running, it might not be running
anymore by the time you've acquired the rq->lock.

On 32bit reading these numbers without locks is broken to boot. And even
on 64bit, I suppose you can a consistent snapshot of runtime and
deadline together, which isn't possible without the locks.

And of course, by the time we get back to userspace, the returned values
will be out-of-date anyway. But that isn't to be helped I suppose.


> +	} else {
> +		attr->sched_runtime = dl_se->dl_runtime;
> +		attr->sched_deadline = dl_se->dl_deadline;
> +	}
> +
>  	attr->sched_period = dl_se->dl_period;
>  	attr->sched_flags = dl_se->flags;
>  }
