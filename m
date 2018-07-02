Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE82C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D88F2550D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lX0Lasjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D88F2550D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeGBEt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 00:49:59 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41461 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeGBEt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 00:49:58 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so6888022pff.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 21:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bxgym+5QKqlD/8jmSh7EyWNv5FofjwD6jKAKdKBayws=;
        b=lX0Lasjoh4i9xat62xhCmFvDTWbMyhsWnE9bSKS4AElXniNeTIE6UOzew23rBDYpvR
         YWajUfOw/dPFeUFF3blT9aDzED7kGAHYrG9EJpTrWTbjn5ZFHG7Do0XgKVKdsl/f2NBs
         o6/SWxkHUA51w6BAOMEKXkq8CHVdSy3Et6FtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bxgym+5QKqlD/8jmSh7EyWNv5FofjwD6jKAKdKBayws=;
        b=BvuM8geeF5jMTBVSm/AbZuC1V5rDZiC3Q6F6dSnSviV6FxtNAq3rh0L9wUGG6J68xM
         +p4gQ+c6/4xBbXenl7Y8AfL32JtEsMHp4i4XCK58paYLP/LGqoySo4ZV+meA6XPGyECX
         nwsdNJUlz310gDbSu0MJs7d+i3MnO69xmuCZlRkLLTHMXJmM8iFVHARHdvJphwtJ16a8
         CbosDE2TjJnYoIvOkZrpJvOjhxQn4EsbyK/G6Tl+AZM0oYUncOIAVX56vekqJPHcWhMI
         o0AcFSz+F3uoIu7x7rLw0dZxfi0KFctmNAUz9YiwClrmT3hN5WAGx/lo4iSN7/qG82AE
         3ZIg==
X-Gm-Message-State: APt69E20xsli/v7CCwNx4xY+wUTCqD/dwd5NSCy2i2nuJll4z21h0siG
        pQftBTv04eNablUrrAiwOsycdA==
X-Google-Smtp-Source: AAOMgpc99LK96wj9rLSKH1Df+b0QDNXvVbPhIX3lJWe0hCPmtKIrWnkuasJNEJT2WJgCWBjwmFc/GQ==
X-Received: by 2002:a62:d94a:: with SMTP id s71-v6mr12064306pfg.164.1530506998046;
        Sun, 01 Jul 2018 21:49:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id 145-v6sm23529156pfz.69.2018.07.01.21.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 21:49:57 -0700 (PDT)
Date:   Sun, 1 Jul 2018 21:49:56 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 1/2] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Message-ID: <20180702044956.GB158348@joelaf.mtv.corp.google.com>
References: <20180627204835.GA25456@linux.vnet.ibm.com>
 <20180627204915.27253-1-paulmck@linux.vnet.ibm.com>
 <20180701183828.GB111992@joelaf.mtv.corp.google.com>
 <20180701222749.GD3593@linux.vnet.ibm.com>
 <20180702003553.GA95395@joelaf.mtv.corp.google.com>
 <20180702031132.GI3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702031132.GI3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 08:11:32PM -0700, Paul E. McKenney wrote:
> On Sun, Jul 01, 2018 at 05:35:53PM -0700, Joel Fernandes wrote:
> > On Sun, Jul 01, 2018 at 03:27:49PM -0700, Paul E. McKenney wrote:
> > [...]
> > > > > +/*
> > > > > + * Report a deferred quiescent state if needed and safe to do so.
> > > > > + * As with rcu_preempt_need_deferred_qs(), "safe" involves only
> > > > > + * not being in an RCU read-side critical section.  The caller must
> > > > > + * evaluate safety in terms of interrupt, softirq, and preemption
> > > > > + * disabling.
> > > > > + */
> > > > > +static void rcu_preempt_deferred_qs(struct task_struct *t)
> > > > > +{
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	if (!rcu_preempt_need_deferred_qs(t))
> > > > > +		return;
> > > > > +	local_irq_save(flags);
> > > > > +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Handle special cases during rcu_read_unlock(), such as needing to
> > > > > + * notify RCU core processing or task having blocked during the RCU
> > > > > + * read-side critical section.
> > > > > + */
> > > > > +static void rcu_read_unlock_special(struct task_struct *t)
> > > > > +{
> > > > > +	unsigned long flags;
> > > > > +	bool preempt_bh_were_disabled = !!(preempt_count() & ~HARDIRQ_MASK);
> > > > > +	bool irqs_were_disabled;
> > > > > +
> > > > > +	/* NMI handlers cannot block and cannot safely manipulate state. */
> > > > > +	if (in_nmi())
> > > > > +		return;
> > > > > +
> > > > > +	local_irq_save(flags);
> > > > > +	irqs_were_disabled = irqs_disabled_flags(flags);
> > > > > +	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
> > > > > +	    t->rcu_read_unlock_special.b.blocked) {
> > > > > +		/* Need to defer quiescent state until everything is enabled. */
> > > > > +		raise_softirq_irqoff(RCU_SOFTIRQ);
> > > > > +		local_irq_restore(flags);
> > > > > +		return;
> > > > > +	}
> > > > > +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Dump detailed information for all tasks blocking the current RCU
> > > > >   * grace period on the specified rcu_node structure.
> > > > > @@ -737,10 +784,20 @@ static void rcu_preempt_check_callbacks(void)
> > > > >  	struct rcu_state *rsp = &rcu_preempt_state;
> > > > >  	struct task_struct *t = current;
> > > > >  
> > > > > -	if (t->rcu_read_lock_nesting == 0) {
> > > > > -		rcu_preempt_qs();
> > > > > +	if (t->rcu_read_lock_nesting > 0 ||
> > > > > +	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
> > > > > +		/* No QS, force context switch if deferred. */
> > > > > +		if (rcu_preempt_need_deferred_qs(t))
> > > > > +			resched_cpu(smp_processor_id());
> > > > 
> > > > 
> > > > Hi Paul,
> > > > 
> > > > I had a similar idea of checking the preempt_count() sometime back but didn't
> > > > believe this path can be called with preempt enabled (for some reason ;-)).
> > > > Now that I've convinced myself that's possible, what do you think about
> > > > taking advantage of the opportunity to report a RCU-sched qs like below from
> > > > rcu_check_callbacks ?
> > > > 
> > > > Did some basic testing, can roll into a patch later if you're Ok with it.
> > > 
> > > The problem here is that the code patch above cannot be called
> > > with CONFIG_PREEMPT_COUNT=n, but the code below can.  And if
> > > CONFIG_PREEMPT_COUNT=n, the return value from preempt_count() can be
> > > misleading.
> > > 
> > > Or am I missing something here?
> > 
> > That is true! so then I could also test if PREEMPT_RCU is enabled like you're
> > doing in the other path.
> > 
> > thanks!
> > 
> > ---8<-----------------------
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index fb440baf8ac6..03a460921dca 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2683,6 +2683,12 @@ void rcu_check_callbacks(int user)
> >  		rcu_note_voluntary_context_switch(current);
> > 
> >  	} else if (!in_softirq()) {
> > +		/*
> > +		 * Report RCU-sched qs if not in an RCU-sched read-side
> > +		 * critical section.
> > +		 */
> > +		if (IS_ENABLED(PREEMPT_RCU) && !(preempt_count() & PREEMPT_MASK))
> 
> For more precision, s/PREEMPT_RCU/CONFIG_PREEMPT_COUNT/
> 
> Hmmm...  I recently queued a patch that redefines the RCU-bh update-side
> API in terms of the consolidated RCU implementation, so this "else"
> clause no longer exists.  One approach would be to fold this condition
> (with the addition of SOFTIRQ_MASK) into the previous "if" condition,
> but that would call rcu_note_voluntary_context_switch() at bad times.
> So maybe this becomes a new "else if" clause.
> 
> Another complication is an upcoming step that redefines the RCU-sched
> update-side API in terms of the consolidated RCU implementation, which
> will likely restructure this "if" statement yet again.
> 
> So I will try to fold this idea in (with attribution).  If I don't get
> it in place in a week or two, please remind me.  Of course, one good way
> to remind me is to supply a patch against whatever this turns into.  ;-)

Sounds good, I will keep these complications in mind and remind you in some
time and/or supply a patch doing the same. Will continue going through the
new code in your tree and let you know anything I find.

Cheers, thanks!

 - Joel

