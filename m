Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088AF20850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BMr2o0yX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088AF20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeGQPuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:50:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbeGQPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uDbwNf5XeHWoJiYzrz0sUTVyo8bqSpNrwPUZ1LDHh1o=; b=BMr2o0yXsBotaOjsGPwefFNqH
        c1iR23iViJrOhRU/f4NeJ3K9Sjm773PrS23+M5D02OE80IwWS89HMJdrg1acxn7cHa6DOWDl62cC3
        GzRlUydq9IU+WX1S0vFEqldjJCUp2TnmQvDU5/UgnaxlNPNkJdPzeKSdnwiAutA6ar7HbGJOqeQGe
        VKOyknFJyFZRR00FQ7sjy6gZvAQE5ob+yVtA2orDUnCleaKz4/PfpK4ux7kGqZb4NohhbcjwAY4g1
        19KyyZa7PsbuJYUdYOYne4e1e/E+3+Xpvx/60Z91Bvz2DWYRF18AKlUnygk/V+pyqxSo5gN8dtMkc
        +x+XvLvTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffRit-00032z-6M; Tue, 17 Jul 2018 15:17:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DB2B20289332; Tue, 17 Jul 2018 17:17:05 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:17:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180717151705.GH2494@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172942.10094-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
> index 04f1321d14c4..ac39435d1521 100644
> --- a/include/linux/sched/stat.h
> +++ b/include/linux/sched/stat.h
> @@ -28,10 +28,14 @@ static inline int sched_info_on(void)
>  	return 1;
>  #elif defined(CONFIG_TASK_DELAY_ACCT)
>  	extern int delayacct_on;
> -	return delayacct_on;
> -#else
> -	return 0;
> +	if (delayacct_on)
> +		return 1;
> +#elif defined(CONFIG_PSI)
> +	extern int psi_disabled;
> +	if (!psi_disabled)
> +		return 1;
>  #endif
> +	return 0;
>  }
>  
>  #ifdef CONFIG_SCHEDSTATS

> diff --git a/init/Kconfig b/init/Kconfig
> index 18b151f0ddc1..e34859bda33e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -457,6 +457,22 @@ config TASK_IO_ACCOUNTING
>  
>  	  Say N if unsure.
>  
> +config PSI
> +	bool "Pressure stall information tracking"
> +	select SCHED_INFO

What's the deal here? AFAICT it does not in fact use SCHED_INFO for
_anything_. You just hooked into the sched_info_{en,de}queue() hooks,
but you don't use any of the sched_info data.

So the dependency is an artificial one that should not exist.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9586a8141f16..16e8c8c8f432 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -744,7 +744,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  		update_rq_clock(rq);
>  
>  	if (!(flags & ENQUEUE_RESTORE))
> -		sched_info_queued(rq, p);
> +		sched_info_queued(rq, p, flags & ENQUEUE_WAKEUP);
>  
>  	p->sched_class->enqueue_task(rq, p, flags);
>  }
> @@ -755,7 +755,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  		update_rq_clock(rq);
>  
>  	if (!(flags & DEQUEUE_SAVE))
> -		sched_info_dequeued(rq, p);
> +		sched_info_dequeued(rq, p, flags & DEQUEUE_SLEEP);
>  
>  	p->sched_class->dequeue_task(rq, p, flags);
>  }

> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> index 8aea199a39b4..15b858cbbcb0 100644
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h

>  #ifdef CONFIG_SCHED_INFO
>  static inline void sched_info_reset_dequeued(struct task_struct *t)
>  {
>  	t->sched_info.last_queued = 0;
>  }
>  
> +static inline void sched_info_reset_queued(struct task_struct *t, u64 now)
> +{
> +	if (!t->sched_info.last_queued)
> +		t->sched_info.last_queued = now;
> +}
> +
>  /*
>   * We are interested in knowing how long it was from the *first* time a
>   * task was queued to the time that it finally hit a CPU, we call this routine
>   * from dequeue_task() to account for possible rq->clock skew across CPUs. The
>   * delta taken on each CPU would annul the skew.
>   */
> -static inline void sched_info_dequeued(struct rq *rq, struct task_struct *t)
> +static inline void sched_info_dequeued(struct rq *rq, struct task_struct *t,
> +				       bool sleep)
>  {
>  	unsigned long long now = rq_clock(rq), delta = 0;
>  
> -	if (unlikely(sched_info_on()))
> +	if (unlikely(sched_info_on())) {
>  		if (t->sched_info.last_queued)
>  			delta = now - t->sched_info.last_queued;
> +		psi_dequeue(t, now, sleep);
> +	}
>  	sched_info_reset_dequeued(t);
>  	t->sched_info.run_delay += delta;
>  
> @@ -104,11 +190,14 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
>   * the timestamp if it is already not set.  It's assumed that
>   * sched_info_dequeued() will clear that stamp when appropriate.
>   */
> -static inline void sched_info_queued(struct rq *rq, struct task_struct *t)
> +static inline void sched_info_queued(struct rq *rq, struct task_struct *t,
> +				     bool wakeup)
>  {
>  	if (unlikely(sched_info_on())) {
> -		if (!t->sched_info.last_queued)
> -			t->sched_info.last_queued = rq_clock(rq);
> +		unsigned long long now = rq_clock(rq);
> +
> +		sched_info_reset_queued(t, now);
> +		psi_enqueue(t, now, wakeup);
>  	}
>  }
>  
> @@ -127,7 +216,8 @@ static inline void sched_info_depart(struct rq *rq, struct task_struct *t)
>  	rq_sched_info_depart(rq, delta);
>  
>  	if (t->state == TASK_RUNNING)
> -		sched_info_queued(rq, t);
> +		if (unlikely(sched_info_on()))
> +			sched_info_reset_queued(t, rq_clock(rq));
>  }
