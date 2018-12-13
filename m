Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AADC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5226B20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="c4UvT2w2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5226B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeLMBgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:36:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41928 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeLMBgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:36:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so214242plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 17:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IoHQwpL0rJhSTqL2suZk1mgmpF/tiPl3STGKg8CTiaA=;
        b=c4UvT2w2MEndzVyE+k1z0yEy1iOvuTm1GHlUoszuZCY2/NWFt86Q3L3oFy667yfBBF
         TozgbnvdkYaG/u9vcXe2DgqAlZ74lwDl6L2VAAyBSNR/a2QJ3vTyj3lne4YzzImxceA0
         FRQuZ4h0F0Db99vl8lRq4GuPi0wP9xoB6fcFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IoHQwpL0rJhSTqL2suZk1mgmpF/tiPl3STGKg8CTiaA=;
        b=p3YSy0g4fLKiqObHKjPH8cAj92c8acblyMUS7rPTH5t9sD8wQlI+MGc2cshRCpH481
         zklKUSYm2a29FCX81h7Mq+QOXjT+QT4zgAHqJNeqF8dYXRWlZVuv4KMAuX1VALWpq46G
         WT/wl361/xgKbZl0sAp4NhWSyzYzvD/MkMOB44ZJrJYj4QRnP99ub4PTDrPrYch85Wwa
         ucEMsmmUpCCbQly1C0rqriceJQnj7a9lRdUkuOAzH/kESBymktFBLphU2cWBjSJevWln
         Or9GsbzIKsIybjwjtraL0CtV6XLmluuthegunE3wmhJI30YbTbh/POUHvAtaG5zaUcRN
         vnMA==
X-Gm-Message-State: AA+aEWZyp0xZyzB6/0OHJNsZTZ3hxqn40t8EGpnTdzQdUgvDPqmd70Sa
        0ATvSUg6evCrBStE6NCSXPA1tw==
X-Google-Smtp-Source: AFSGD/UMBOTkJ/KJYhWyrisyFQbLdtP2olaksPKsPMXEo0nJpUvr6oKjhB3ydlwyx/77nj5Z5tL1xw==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr21759643plo.96.1544664993205;
        Wed, 12 Dec 2018 17:36:33 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id b10sm301250pfj.183.2018.12.12.17.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 17:36:32 -0800 (PST)
Date:   Wed, 12 Dec 2018 17:36:31 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        tglx@linutronix.de, tj@kernel.org
Subject: Re: [PATCH] srcu: Remove srcu_queue_delayed_work_on()
Message-ID: <20181213013631.GF89903@joelaf.mtv.corp.google.com>
References: <20181211111238.13474-1-bigeasy@linutronix.de>
 <20181212014016.GA97542@google.com>
 <20181212140519.GA10937@tardis>
 <20181212155546.GY4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212155546.GY4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 07:55:46AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 12, 2018 at 10:05:19PM +0800, Boqun Feng wrote:
> > Hi Joel,
> > 
> > On Tue, Dec 11, 2018 at 05:40:16PM -0800, Joel Fernandes wrote:
> > > On Tue, Dec 11, 2018 at 12:12:38PM +0100, Sebastian Andrzej Siewior wrote:
> > > > srcu_queue_delayed_work_on() disables preemption (and therefore CPU
> > > > hotplug in RCU's case) and then checks based on its own accounting if a
> > > > CPU is online. If the CPU is online it uses queue_delayed_work_on()
> > > > otherwise it fallbacks to queue_delayed_work().
> > > > The problem here is that queue_work() on -RT does not work with disabled
> > > > preemption.
> > > > 
> > > > queue_work_on() works also on an offlined CPU. queue_delayed_work_on()
> > > > has the problem that it is possible to program a timer on an offlined
> > > > CPU. This timer will fire once the CPU is online again. But until then,
> > > > the timer remains programmed and nothing will happen.
> > > > Add a local timer which will fire (as requested per delay) on the local
> > > > CPU and then enqueue the work on the specific CPU.
> > > > 
> > > > RCUtorture testing with SRCU-P for 24h showed no problems.
> > > > 
> > > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > ---
> > > >  include/linux/srcutree.h |  3 ++-
> > > >  kernel/rcu/srcutree.c    | 57 ++++++++++++++++++----------------------
> > > >  kernel/rcu/tree.c        |  4 ---
> > > >  kernel/rcu/tree.h        |  8 ------
> > > >  4 files changed, 27 insertions(+), 45 deletions(-)
> > > > 
> > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > index 6f292bd3e7db7..0faa978c98807 100644
> > > > --- a/include/linux/srcutree.h
> > > > +++ b/include/linux/srcutree.h
> > > > @@ -45,7 +45,8 @@ struct srcu_data {
> > > >  	unsigned long srcu_gp_seq_needed;	/* Furthest future GP needed. */
> > > >  	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
> > > >  	bool srcu_cblist_invoking;		/* Invoking these CBs? */
> > > > -	struct delayed_work work;		/* Context for CB invoking. */
> > > > +	struct timer_list delay_work;		/* Delay for CB invoking */
> > > > +	struct work_struct work;		/* Context for CB invoking. */
> > > >  	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
> > > >  	struct srcu_node *mynode;		/* Leaf srcu_node. */
> > > >  	unsigned long grpmask;			/* Mask for leaf srcu_node */
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 3600d88d8956b..7f041f2435df9 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -58,6 +58,7 @@ static bool __read_mostly srcu_init_done;
> > > >  static void srcu_invoke_callbacks(struct work_struct *work);
> > > >  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
> > > >  static void process_srcu(struct work_struct *work);
> > > > +static void srcu_delay_timer(struct timer_list *t);
> > > >  
> > > >  /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
> > > >  #define spin_lock_rcu_node(p)					\
> > > > @@ -156,7 +157,8 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
> > > >  			snp->grphi = cpu;
> > > >  		}
> > > >  		sdp->cpu = cpu;
> > > > -		INIT_DELAYED_WORK(&sdp->work, srcu_invoke_callbacks);
> > > > +		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
> > > > +		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> > > >  		sdp->ssp = ssp;
> > > >  		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > > >  		if (is_static)
> > > > @@ -386,13 +388,19 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
> > > >  	} else {
> > > >  		flush_delayed_work(&ssp->work);
> > > >  	}
> > > > -	for_each_possible_cpu(cpu)
> > > > +	for_each_possible_cpu(cpu) {
> > > > +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> > > > +
> > > >  		if (quiesced) {
> > > > -			if (WARN_ON(delayed_work_pending(&per_cpu_ptr(ssp->sda, cpu)->work)))
> > > > +			if (WARN_ON(timer_pending(&sdp->delay_work)))
> > > > +				return; /* Just leak it! */
> > > > +			if (WARN_ON(work_pending(&sdp->work)))
> > > >  				return; /* Just leak it! */
> > > >  		} else {
> > > > -			flush_delayed_work(&per_cpu_ptr(ssp->sda, cpu)->work);
> > > > +			del_timer_sync(&sdp->delay_work);
> > > > +			flush_work(&sdp->work);
> > > >  		}
> > > > +	}
> > > >  	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
> > > >  	    WARN_ON(srcu_readers_active(ssp))) {
> > > >  		pr_info("%s: Active srcu_struct %p state: %d\n",
> > > > @@ -463,39 +471,23 @@ static void srcu_gp_start(struct srcu_struct *ssp)
> > > >  	WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
> > > >  }
> > > >  
> > > > -/*
> > > > - * Track online CPUs to guide callback workqueue placement.
> > > > - */
> > > > -DEFINE_PER_CPU(bool, srcu_online);
> > > >  
> > > > -void srcu_online_cpu(unsigned int cpu)
> > > > +static void srcu_delay_timer(struct timer_list *t)
> > > >  {
> > > > -	WRITE_ONCE(per_cpu(srcu_online, cpu), true);
> > > > +	struct srcu_data *sdp = container_of(t, struct srcu_data, delay_work);
> > > > +
> > > > +	queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> > > >  }
> > > >  
> > > > -void srcu_offline_cpu(unsigned int cpu)
> > > > -{
> > > > -	WRITE_ONCE(per_cpu(srcu_online, cpu), false);
> > > > -}
> > > > -
> > > > -/*
> > > > - * Place the workqueue handler on the specified CPU if online, otherwise
> > > > - * just run it whereever.  This is useful for placing workqueue handlers
> > > > - * that are to invoke the specified CPU's callbacks.
> > > > - */
> > > > -static bool srcu_queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
> > > > -				       struct delayed_work *dwork,
> > > > +static void srcu_queue_delayed_work_on(struct srcu_data *sdp,
> > > >  				       unsigned long delay)
> > > >  {
> > > > -	bool ret;
> > > > +	if (!delay) {
> > > > +		queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> > > > +		return;
> > > > +	}
> > > >  
> > > > -	preempt_disable();
> > > > -	if (READ_ONCE(per_cpu(srcu_online, cpu)))
> > > > -		ret = queue_delayed_work_on(cpu, wq, dwork, delay);
> > > > -	else
> > > > -		ret = queue_delayed_work(wq, dwork, delay);
> > > > -	preempt_enable();
> > > 
> > > The deleted code looks like 'cpu' could be offlined.
> > > 
> > > Question for my clarification: According to sync_rcu_exp_select_cpus, we have
> > > to disable preemption before calling queue_work_on to ensure the CPU is online.
> > > 
> > > Also same is said in Boqun's presentation on the topic:
> > > https://linuxplumbersconf.org/event/2/contributions/158/attachments/68/79/workqueue_and_cpu_hotplug.pdf
> > > 
> > > Calling queue_work_on on an offline CPU sounds like could be problematic. So
> > > in your patch, don't you still need to disable preemption around
> > > queue_work_on, or the very least check if said CPU is online before calling
> > > queue_work_on?
> > > 
> > 
> > I should be the one who answers this ;-)
> > So I found something after my LPC topic, that is queue_work_on() may
> > work well even if racing with a cpu offline. The reason is that in the
> > cpu offline hook for workqueue only switches the percpu pool into an
> > unbound one, so as long as the related cpu has been online once, we are
> > fine here. 
> > 
> > Please note this is only my own analysis, and I'm the one who told
> > Sebastian and Paul about this.
> > 
> > I should send an email to check with workqueue maintainers about this,
> > but I didn't find the time. Sorry about this.. But let's do this right
> > now, while we at it.
> > 
> > (Cc TJ)
> > 
> > So Jiangshan and TJ, what's your opion on this one? If we call a
> > queue_work_on() at a place where that target cpu may be offlined, I
> > think we have the guarantee that the work will be eventually executed
> > even if the cpu is never online again, right? In other words, if a cpu
> > has been online once, queue_work_on() on it will be free from racing
> > with cpu hotplug.
> > 
> > Am I right about this, or did I miss something subtle?
> 
> Well, what I was relying on was Thomas Gleixner's assertion that it should
> work and would be fixed if it didn't.  ;-)

FWIW I did a simple manual test calling queue_work_on on an offline CPU to
see what happens and it appears to be working fine. On a 4 CPU system, I
offline CPU 3 and the work ends up executing on CPU 0 instead. But I haven't
done any stress tests to know of any possible races with doing so.

thanks,

- Joel

