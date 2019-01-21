Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDA9C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBFA2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NZ5N+ZGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfAUKvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:51:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41661 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfAUKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:51:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id a20so16188971edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mJMHBdkQexsknFUastnGo4BYttKPi0+5BH/HVX9RkGY=;
        b=NZ5N+ZGSC/G8G33gWeqDEKiuQjE8QtuINx4uVZ0vbFp1Njnq8Ah6M6CtxoA4yK0n5+
         vmhsLlb53r4PCAInYa6f0Or2U74th9Io4hwOIEVo3StaVpqH2PedJV5FtVTmfgw9p1rt
         mOq1iaYIm/8oZu1A4Yl7pMdB2BzxmLc9P7WM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJMHBdkQexsknFUastnGo4BYttKPi0+5BH/HVX9RkGY=;
        b=kDGgVLkHWC3lrvlaRMvuONuJyXd89tEeKQz5sByTNEKcWhNWq0SmOU7+nQHpBnJj1v
         3jf1MLCJ/Kvb7+RRsu3nEhaCgnrjD0M431+HiVNhhghpMBBBgHMeFQWDn/cGeXHzVCkE
         h+AdkFDLeY1glz788sk4VwkV+pQFpTmbDMXpibdT6Fp2cl+8PYrLZI0poJ4vyi1ta2El
         0NhX912WJHCPLMO5LDw6lXnNdN8gXyf6WtL+7HtfvaVoPonYF75Pz0egaCTug6se7teX
         Tyy22tsuO91WTXazahj3T6kudebJd8zS80grdW0n+qTcx35o7fc4XRZimb/Zu0CURzHf
         Xieg==
X-Gm-Message-State: AJcUukeDVmdXED/Gug/pDqdcDWTFV/mnxRmoYZUjrwJf3t1gWoO27hk+
        tegg+VfTG4iXrrOjCKjX74IA71h5IuYVsQ==
X-Google-Smtp-Source: ALg8bN6x3r34yCrpN1wxbawe0ARl11Xm4E919i+UuR/h+jQNM6aIf4JcBWvtsyEmm6c5IBAleyWoWQ==
X-Received: by 2002:a05:6402:8d2:: with SMTP id d18mr26863573edz.119.1548067889188;
        Mon, 21 Jan 2019 02:51:29 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id n16-v6sm4781867eja.6.2019.01.21.02.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 02:51:28 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:51:21 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] sched: Use READ_ONCE()/WRITE_ONCE() in
 task_cpu()/__set_task_cpu()
Message-ID: <20190121104707.GA5883@andrea>
References: <20190116184218.13757-1-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116184218.13757-1-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 07:42:18PM +0100, Andrea Parri wrote:
> The smp_wmb() in move_queued_task() (c.f., __set_task_cpu()) pairs with
> the composition of the dependency and the ACQUIRE in task_rq_lock():
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
> Use READ_ONCE() to load ->cpu in task_rq() (c.f., task_cpu()) to honour
> this address dependency between loads; also, mark the store to ->cpu in
> __set_task_cpu() by using WRITE_ONCE() in order to tell the compiler to
> not mess/tear this (synchronizing) memory access.

In the light of the recent discussion about the integration of plain
accesses in the LKMM (c.f., e.g., [1] and discussion thereof), I was
considering even further changes to this in order to "reinforce" the
above smp_wmb().  Here's two approaches (one of):

 1) replace this smp_wmb()+WRITE_ONCE() with an smp_store_release();

 2) or keep this smp_wmb()+WRITE_ONCE(), but use {WRITE,READ}_ONCE()
    also for the accesses to ->on_rq.

What do you think?  (maybe I'm just being too paranoid?)

Adding Will to the Cc:  ((1) should be "painless" for x86, not sure
about arm64...)

  Andrea

[1] http://lkml.kernel.org/r/20190118155638.GA24442@andrea


> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> ---
>  include/linux/sched.h | 4 ++--
>  kernel/sched/sched.h  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 224666226e87b..2bb02c9635bd8 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1753,9 +1753,9 @@ static __always_inline bool need_resched(void)
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
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d04530bf251fe..270a3333589d2 100644
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
> -- 
> 2.17.1
> 
