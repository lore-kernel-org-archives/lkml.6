Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD7020661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD7020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeH3GqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeH3GqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:46:06 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56DB620647;
        Thu, 30 Aug 2018 02:46:11 +0000 (UTC)
Date:   Wed, 29 Aug 2018 22:46:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH tip/core/rcu 3/3] srcu: Make early-boot call_srcu()
 reuse workqueue lists
Message-ID: <20180829224609.5ffdc9ec@vmware.local.home>
In-Reply-To: <20180830020701.GE4225@linux.vnet.ibm.com>
References: <20180829212036.GA22033@linux.vnet.ibm.com>
        <20180829212313.22903-3-paulmck@linux.vnet.ibm.com>
        <20180829215616.1c10e476@vmware.local.home>
        <20180830020701.GE4225@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 19:07:01 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Aug 29, 2018 at 09:56:16PM -0400, Steven Rostedt wrote:
> > On Wed, 29 Aug 2018 14:23:13 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> >   
> > > Allocating a list_head structure that is almost never used, and, when
> > > used, is used only during early boot (rcu_init() and earlier), is a bit
> > > wasteful.  This commit therefore eliminates that list_head in favor of
> > > the one in the work_struct structure.  This is safe because the work_struct
> > > structure cannot be used until after rcu_init() returns.
> > > 
> > > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > ---
> > >  include/linux/srcutiny.h |  2 --
> > >  include/linux/srcutree.h |  3 +--
> > >  kernel/rcu/srcutiny.c    | 10 +++++-----
> > >  kernel/rcu/srcutree.c    | 11 +++++------
> > >  4 files changed, 11 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > index 2b5c0822e683..f41d2fb09f87 100644
> > > --- a/include/linux/srcutiny.h
> > > +++ b/include/linux/srcutiny.h
> > > @@ -36,7 +36,6 @@ struct srcu_struct {
> > >  	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
> > >  	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
> > >  	struct work_struct srcu_work;	/* For driving grace periods. */
> > > -	struct list_head srcu_boot_entry; /* Early-boot callbacks. */
> > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > >  	struct lockdep_map dep_map;
> > >  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > > @@ -49,7 +48,6 @@ void srcu_drive_gp(struct work_struct *wp);
> > >  	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
> > >  	.srcu_cb_tail = &name.srcu_cb_head,				\
> > >  	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
> > > -	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
> > >  	__SRCU_DEP_MAP_INIT(name)					\
> > >  }
> > >  
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index 9cfa4610113a..0ae91b3a7406 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -94,7 +94,6 @@ struct srcu_struct {
> > >  						/*  callback for the barrier */
> > >  						/*  operation. */
> > >  	struct delayed_work work;
> > > -	struct list_head srcu_boot_entry;	/* Early-boot callbacks. */
> > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > >  	struct lockdep_map dep_map;
> > >  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > > @@ -110,7 +109,7 @@ struct srcu_struct {
> > >  	.sda = &pcpu_name,						\
> > >  	.lock = __SPIN_LOCK_UNLOCKED(name.lock),			\
> > >  	.srcu_gp_seq_needed = -1UL,					\
> > > -	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
> > > +	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),		\  
> > 
> > Thanks!  
> 
> Glad you like it!  Does it actually work for you?  ;-)

Oh, you want me to actually test it too? ;-)

I'll try to add that in my todo list tomorrow.

-- Steve

> 
> 							Thanx, Paul
> 
> > -- Steve
> >   
> > >  	__SRCU_DEP_MAP_INIT(name)					\
> > >  }
> > >  
> > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > index d233f0c63f6f..b46e6683f8c9 100644
> > > --- a/kernel/rcu/srcutiny.c
> > > +++ b/kernel/rcu/srcutiny.c
> > > @@ -48,7 +48,7 @@ static int init_srcu_struct_fields(struct srcu_struct *sp)
> > >  	sp->srcu_gp_waiting = false;
> > >  	sp->srcu_idx = 0;
> > >  	INIT_WORK(&sp->srcu_work, srcu_drive_gp);
> > > -	INIT_LIST_HEAD(&sp->srcu_boot_entry);
> > > +	INIT_LIST_HEAD(&sp->srcu_work.entry);
> > >  	return 0;
> > >  }
> > >  
> > > @@ -185,8 +185,8 @@ void call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
> > >  	if (!READ_ONCE(sp->srcu_gp_running)) {
> > >  		if (likely(srcu_init_done))
> > >  			schedule_work(&sp->srcu_work);
> > > -		else if (list_empty(&sp->srcu_boot_entry))
> > > -			list_add(&sp->srcu_boot_entry, &srcu_boot_list);
> > > +		else if (list_empty(&sp->srcu_work.entry))
> > > +			list_add(&sp->srcu_work.entry, &srcu_boot_list);
> > >  	}
> > >  }
> > >  EXPORT_SYMBOL_GPL(call_srcu);
> > > @@ -224,8 +224,8 @@ void __init srcu_init(void)
> > >  	srcu_init_done = true;
> > >  	while (!list_empty(&srcu_boot_list)) {
> > >  		sp = list_first_entry(&srcu_boot_list,
> > > -				      struct srcu_struct, srcu_boot_entry);
> > > -		list_del_init(&sp->srcu_boot_entry);
> > > +				      struct srcu_struct, srcu_work.entry);
> > > +		list_del_init(&sp->srcu_work.entry);
> > >  		schedule_work(&sp->srcu_work);
> > >  	}
> > >  }
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index e79c1929328f..36a2857c84e0 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -186,7 +186,6 @@ static int init_srcu_struct_fields(struct srcu_struct *sp, bool is_static)
> > >  	mutex_init(&sp->srcu_barrier_mutex);
> > >  	atomic_set(&sp->srcu_barrier_cpu_cnt, 0);
> > >  	INIT_DELAYED_WORK(&sp->work, process_srcu);
> > > -	INIT_LIST_HEAD(&sp->srcu_boot_entry);
> > >  	if (!is_static)
> > >  		sp->sda = alloc_percpu(struct srcu_data);
> > >  	init_srcu_struct_nodes(sp, is_static);
> > > @@ -709,8 +708,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *sp, struct srcu_data *sdp,
> > >  		if (likely(srcu_init_done))
> > >  			queue_delayed_work(rcu_gp_wq, &sp->work,
> > >  					   srcu_get_delay(sp));
> > > -		else if (list_empty(&sp->srcu_boot_entry))
> > > -			list_add(&sp->srcu_boot_entry, &srcu_boot_list);
> > > +		else if (list_empty(&sp->work.work.entry))
> > > +			list_add(&sp->work.work.entry, &srcu_boot_list);
> > >  	}
> > >  	spin_unlock_irqrestore_rcu_node(sp, flags);
> > >  }
> > > @@ -1324,10 +1323,10 @@ void __init srcu_init(void)
> > >  
> > >  	srcu_init_done = true;
> > >  	while (!list_empty(&srcu_boot_list)) {
> > > -		sp = list_first_entry(&srcu_boot_list,
> > > -				      struct srcu_struct, srcu_boot_entry);
> > > +		sp = list_first_entry(&srcu_boot_list, struct srcu_struct,
> > > +				      work.work.entry);
> > >  		check_init_srcu_struct(sp);
> > > -		list_del_init(&sp->srcu_boot_entry);
> > > +		list_del_init(&sp->work.work.entry);
> > >  		queue_work(rcu_gp_wq, &sp->work.work);
> > >  	}
> > >  }  
> >   

