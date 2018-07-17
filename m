Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC608ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A03220684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="R9rcmQDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A03220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeGQRo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:44:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36769 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeGQRo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:44:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id d14-v6so823770pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ing71/zxnsCA/bPrPsBjnuB9MHbZUviffmF3hq3gbE0=;
        b=R9rcmQDRhEsEkQdmebLE+PKpt5UEoOOPOKq7jRDvQlOQqXZBnTC/eZR9Bmcptsw6r5
         +cPSL5WWiLeYL3mYX+UA/PYLKOWr6FaBIN2InrE+7ritkI/f28QhSE3Goy8WKMJ6TRAH
         swAlYudPyXteYhYn/fOP6Ui9MoAehKyf/TGJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ing71/zxnsCA/bPrPsBjnuB9MHbZUviffmF3hq3gbE0=;
        b=GkstK2i5+/KzGogRUTEVOXUjR48d8B0fmkl1U63kr4a7veGhKjJwsTSZ1rHURbxCcB
         WBTyMPlGd3fMyxQYtEcHKzXHFnwBNtQwIorB8FDzO2Bt/GyOnV9f6IS2Dwoh8rrH4qrT
         gP79SzPFPLjtPICo/dKqoibd/RekvdfFhcT34gL65DmdY1hGm698HzTwmQnvqwT1KQEI
         8W8fIwi+fLDL8FqhVDiSOOmnXO6G++Kiogcv4SSvICxcJhPWegh1q6er0hOymucGHZIQ
         6Lx2ardGywCA1HXrix28URdnmWdA4GIBZb0r6qlLGaAatO9RMxw2JYWCqKgExKNosBLL
         /jCw==
X-Gm-Message-State: AOUpUlHBYIw7MCIuXR069eY+Elno4Dr/hnjQwwDQqnW6qZQFEDJCwUeG
        pGaW4blb+00VQwegKVQlEJZMqA==
X-Google-Smtp-Source: AAOMgpefkdlvTZYJeJzuKdXFy0lfDMp2AESkif4UFLY/xQQPhJQWgzthLgT951UJsky/dExpVK3RDA==
X-Received: by 2002:a63:380d:: with SMTP id f13-v6mr2407738pga.124.1531847482166;
        Tue, 17 Jul 2018 10:11:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id j1-v6sm3712720pfk.125.2018.07.17.10.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 10:11:21 -0700 (PDT)
Date:   Tue, 17 Jul 2018 10:11:21 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v10 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180717171121.GA62094@joelaf.mtv.corp.google.com>
References: <20180713215547.255620-1-joel@joelfernandes.org>
 <20180713215547.255620-3-joel@joelfernandes.org>
 <1420383125.4964.1531578717837.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420383125.4964.1531578717837.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 10:31:57AM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 13, 2018, at 5:55 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > In recent tests with IRQ on/off tracepoints, a large performance
> > overhead ~10% is noticed when running hackbench. This is root caused to
> > calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
> > tracepoint code. Following a long discussion on the list [1] about this,
> > we concluded that srcu is a better alternative for use during rcu idle.
> > Although it does involve extra barriers, its lighter than the sched-rcu
> > version which has to do additional RCU calls to notify RCU idle about
> > entry into RCU sections.
> > 
> > In this patch, we change the underlying implementation of the
> > trace_*_rcuidle API to use SRCU. This has shown to improve performance
> > alot for the high frequency irq enable/disable tracepoints.
> > 
> > Test: Tested idle and preempt/irq tracepoints.
> > 
> > Here are some performance numbers:
> > 
> > With a run of the following 30 times on a single core x86 Qemu instance
> > with 1GB memory:
> > hackbench -g 4 -f 2 -l 3000
> > 
> > Completion times in seconds. CONFIG_PROVE_LOCKING=y.
> > 
> > No patches (without this series)
> > Mean: 3.048
> > Median: 3.025
> > Std Dev: 0.064
> > 
> > With Lockdep using irq tracepoints with RCU implementation:
> > Mean: 3.451   (-11.66 %)
> > Median: 3.447 (-12.22%)
> > Std Dev: 0.049
> > 
> > With Lockdep using irq tracepoints with SRCU implementation (this series):
> > Mean: 3.020   (I would consider the improvement against the "without
> >	       this series" case as just noise).
> > Median: 3.013
> > Std Dev: 0.033
> > 
> > [1] https://patchwork.kernel.org/patch/10344297/
> > 
> > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> I'm fine with the changes done since last iteration.
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks a lot Mathieu!

Steve, Peter, looks good to you too now?

thanks,

- Joel


[...] 
> > Cleaned-up-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > include/linux/tracepoint.h | 45 +++++++++++++++++++++++++++++++-------
> > kernel/tracepoint.c        | 16 +++++++++++++-
> > 2 files changed, 52 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 19a690b559ca..97e1d365a817 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -15,6 +15,7 @@
> >  */
> > 
> > #include <linux/smp.h>
> > +#include <linux/srcu.h>
> > #include <linux/errno.h>
> > #include <linux/types.h>
> > #include <linux/cpumask.h>
> > @@ -33,6 +34,8 @@ struct trace_eval_map {
> > 
> > #define TRACEPOINT_DEFAULT_PRIO	10
> > 
> > +extern struct srcu_struct tracepoint_srcu;
> > +
> > extern int
> > tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> > extern int
> > @@ -75,10 +78,16 @@ int unregister_tracepoint_module_notifier(struct
> > notifier_block *nb)
> >  * probe unregistration and the end of module exit to make sure there is no
> >  * caller executing a probe when it is freed.
> >  */
> > +#ifdef CONFIG_TRACEPOINTS
> > static inline void tracepoint_synchronize_unregister(void)
> > {
> > +	synchronize_srcu(&tracepoint_srcu);
> > 	synchronize_sched();
> > }
> > +#else
> > +static inline void tracepoint_synchronize_unregister(void)
> > +{ }
> > +#endif
> > 
> > #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> > extern int syscall_regfunc(void);
> > @@ -129,18 +138,34 @@ extern void syscall_unregfunc(void);
> >  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
> >  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
> >  */
> > -#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
> > +#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
> > 	do {								\
> > 		struct tracepoint_func *it_func_ptr;			\
> > 		void *it_func;						\
> > 		void *__data;						\
> > +		int __maybe_unused idx = 0;				\
> > 									\
> > 		if (!(cond))						\
> > 			return;						\
> > -		if (rcucheck)						\
> > -			rcu_irq_enter_irqson();				\
> > -		rcu_read_lock_sched_notrace();				\
> > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> > +									\
> > +		/* srcu can't be used from NMI */			\
> > +		if (rcuidle && in_nmi())				\
> > +			WARN_ON_ONCE(1);				\
> > +									\
> > +		/* keep srcu and sched-rcu usage consistent */		\
> > +		preempt_disable_notrace();				\
> > +									\
> > +		/*							\
> > +		 * For rcuidle callers, use srcu since sched-rcu	\
> > +		 * doesn't work from the idle path.			\
> > +		 */							\
> > +		if (rcuidle)						\
> > +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> > +		else							\
> > +			rcu_read_lock_sched_notrace();			\
> > +									\
> > +		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> > +									\
> > 		if (it_func_ptr) {					\
> > 			do {						\
> > 				it_func = (it_func_ptr)->func;		\
> > @@ -148,9 +173,13 @@ extern void syscall_unregfunc(void);
> > 				((void(*)(proto))(it_func))(args);	\
> > 			} while ((++it_func_ptr)->func);		\
> > 		}							\
> > -		rcu_read_unlock_sched_notrace();			\
> > -		if (rcucheck)						\
> > -			rcu_irq_exit_irqson();				\
> > +									\
> > +		if (rcuidle)						\
> > +			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> > +		else							\
> > +			rcu_read_unlock_sched_notrace();		\
> > +									\
> > +		preempt_enable_notrace();				\
> > 	} while (0)
> > 
> > #ifndef MODULE
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 6dc6356c3327..955148d91b74 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -31,6 +31,9 @@
> > extern struct tracepoint * const __start___tracepoints_ptrs[];
> > extern struct tracepoint * const __stop___tracepoints_ptrs[];
> > 
> > +DEFINE_SRCU(tracepoint_srcu);
> > +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> > +
> > /* Set to 1 to enable tracepoint debug output */
> > static const int tracepoint_debug;
> > 
> > @@ -67,16 +70,27 @@ static inline void *allocate_probes(int count)
> > 	return p == NULL ? NULL : p->probes;
> > }
> > 
> > -static void rcu_free_old_probes(struct rcu_head *head)
> > +static void srcu_free_old_probes(struct rcu_head *head)
> > {
> > 	kfree(container_of(head, struct tp_probes, rcu));
> > }
> > 
> > +static void rcu_free_old_probes(struct rcu_head *head)
> > +{
> > +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> > +}
> > +
> > static inline void release_probes(struct tracepoint_func *old)
> > {
> > 	if (old) {
> > 		struct tp_probes *tp_probes = container_of(old,
> > 			struct tp_probes, probes[0]);
> > +		/*
> > +		 * Tracepoint probes are protected by both sched RCU and SRCU,
> > +		 * by calling the SRCU callback in the sched RCU callback we
> > +		 * cover both cases. So let us chain the SRCU and sched RCU
> > +		 * callbacks to wait for both grace periods.
> > +		 */
> > 		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
> > 	}
> > }
> > --
> > 2.18.0.203.gfac676dfb9-goog
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
