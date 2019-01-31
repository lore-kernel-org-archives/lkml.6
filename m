Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473F3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1035320B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Df4OHNKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfAaS0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:26:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40070 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfAaS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:26:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so3386602edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hdrji1vIYD3XigGUrn3eBBMdU3Pqeq9oNb1AQsojoD0=;
        b=Df4OHNKf7EIIdAnfvF7TxECBl/LyZQPik2N7upy8CYOmdYNfVy/peCDqDyIPzzEhuh
         hu7wtv5nvaDs6/KlJ+ggEVMODIynNipXI6WZuCl6N1AYNFVkqFUsHZwasKi3o4dGg4vE
         k4Yx8PH1DjLfC4PuDyEEEpWLLxR2qmbj0iWj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hdrji1vIYD3XigGUrn3eBBMdU3Pqeq9oNb1AQsojoD0=;
        b=rmJG+FYzMTfHiwxlRrPkqrBgnve7uVM8iTDL/8kBbX3uT+zM5qRvttcK0z25bdiFYa
         gEiS3sn1wA0DrETG9sMT+tDtZzPV//W9tqChW6weaXe42Mrc6kbUkqFl6a8/dblcrcwv
         fuiLLwWmiyRWg2DDoKdWiklaITInVzAAHL6oeph4PvZt9d+uWkNw7WOFFrCR5Uf8XRG3
         uDMRYjAyw8g7J9fqg4VJexPqZ/jhNMm0Svr3NZc6+Mvt8xBPz8sQgyajv87jvV/iDFeN
         4VVYIcFEbG29MwM9EDJH5hyyVOaIIZvDEgxZgydaX7eulOnVSZAhwmUkcBe3qoNHLHcK
         YbIQ==
X-Gm-Message-State: AJcUukcePjLxUrUCpD1fzzEkVWpIxXj5xAE+aTzbeRG725e1aVzz/+0w
        JW4Pu/K8FA7crOBmmN/KParHj+cCzt26Gg==
X-Google-Smtp-Source: ALg8bN5OewF/EzETdO45i8c+QrrkElCB+JNJmfl+SRic2iUnTEnSU9dfy0sOokE/9EuSkdfCpbgfvQ==
X-Received: by 2002:a50:8262:: with SMTP id 89mr34128827edf.125.1548959165744;
        Thu, 31 Jan 2019 10:26:05 -0800 (PST)
Received: from andrea ([91.253.220.247])
        by smtp.gmail.com with ESMTPSA id p24sm883817ejz.46.2019.01.31.10.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:26:05 -0800 (PST)
Date:   Thu, 31 Jan 2019 19:25:57 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] sched: Use READ_ONCE()/WRITE_ONCE() in
 move_queued_task()/task_rq_lock()
Message-ID: <20190131182557.GA3873@andrea>
References: <20190121155240.27173-1-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121155240.27173-1-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:52:40PM +0100, Andrea Parri wrote:
> move_queued_task() synchronizes with task_rq_lock() as follows:
> 
> 	move_queued_task()		task_rq_lock()
> 
> 	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
> 	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
> 	[S] ->cpu = new_cpu		[L] ->on_rq
> 
> where "[L] rq = task_rq()" is ordered before "ACQUIRE (rq->lock)" by an
> address dependency and, in turn, "ACQUIRE (rq->lock)" is ordered before
> "[L] ->on_rq" by the ACQUIRE itself.
> 
> Use READ_ONCE() to load ->cpu in task_rq() (c.f., task_cpu()) to honor
> this address dependency.  Also, mark the accesses to ->cpu and ->on_rq
> with READ_ONCE()/WRITE_ONCE() to comply with the LKMM.
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>

ping

  Andrea


> ---
>  Changes in v2:
>  - mark accesses to ->on_rq as well
>  - update inline comment for task_rq_lock()
>  - minor editing in the subject/changelog
>  
>  include/linux/sched.h | 4 ++--
>  kernel/sched/core.c   | 9 +++++----
>  kernel/sched/sched.h  | 6 +++---
>  3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d2f90fa924683..41212d725a0eb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1754,9 +1754,9 @@ static __always_inline bool need_resched(void)
>  static inline unsigned int task_cpu(const struct task_struct *p)
>  {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
> -	return p->cpu;
> +	return READ_ONCE(p->cpu);
>  #else
> -	return task_thread_info(p)->cpu;
> +	return READ_ONCE(task_thread_info(p)->cpu);
>  #endif
>  }
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a674c7db2f29d..d6e08faaa2843 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -107,11 +107,12 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
>  		 *					[L] ->on_rq
>  		 *	RELEASE (rq->lock)
>  		 *
> -		 * If we observe the old CPU in task_rq_lock, the acquire of
> +		 * If we observe the old CPU in task_rq_lock(), the acquire of
>  		 * the old rq->lock will fully serialize against the stores.
>  		 *
> -		 * If we observe the new CPU in task_rq_lock, the acquire will
> -		 * pair with the WMB to ensure we must then also see migrating.
> +		 * If we observe the new CPU in task_rq_lock(), the address
> +		 * dependency headed by '[L] rq = task_rq()' and the acquire
> +		 * will pair with the WMB to ensure we then also see migrating.
>  		 */
>  		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
>  			rq_pin_lock(rq, rf);
> @@ -915,7 +916,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
>  {
>  	lockdep_assert_held(&rq->lock);
>  
> -	p->on_rq = TASK_ON_RQ_MIGRATING;
> +	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
>  	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
>  	set_task_cpu(p, new_cpu);
>  	rq_unlock(rq, rf);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d04530bf251fe..425a5589e5f60 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1460,9 +1460,9 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
>  	 */
>  	smp_wmb();
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
> -	p->cpu = cpu;
> +	WRITE_ONCE(p->cpu, cpu);
>  #else
> -	task_thread_info(p)->cpu = cpu;
> +	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
>  #endif
>  	p->wake_cpu = cpu;
>  #endif
> @@ -1563,7 +1563,7 @@ static inline int task_on_rq_queued(struct task_struct *p)
>  
>  static inline int task_on_rq_migrating(struct task_struct *p)
>  {
> -	return p->on_rq == TASK_ON_RQ_MIGRATING;
> +	return READ_ONCE(p->on_rq) == TASK_ON_RQ_MIGRATING;
>  }
>  
>  /*
> -- 
> 2.17.1
> 
