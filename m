Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1557C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3469255FA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xEmfBm4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3469255FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeGBAf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:35:56 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37413 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbeGBAfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:35:55 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so7062748plc.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 17:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CxML7gC3LiJeWkG8eV22ANNhCsMMENIRktEkMPV4O54=;
        b=xEmfBm4DFYBgrDFiu9WuC1VoBbO9Gn583FcVwYpLH6SwCJeWqsnIJcmUSZD1TGIn0J
         4cRXcYqy3f/iAg8I+MO2oi3wNk8QjCHjrpj20f22XPjzz2uWgHiJRZv58gIDFz1pf1xs
         LuEiFNp0IN8wQRkZWyxLXjzng+PV+wkculGN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CxML7gC3LiJeWkG8eV22ANNhCsMMENIRktEkMPV4O54=;
        b=hC1ioULWXwhcIA1/6jjI1UxMHPyTFKztbN7z7Dic/3RoUWSeMYWrepsKdCLAkAvJt4
         nOvnBbu5+cwfCcA0YO8OKEa8e+/YpfcPbKqF4yAN4qUpEmEmThiOIR7iVYAWpiXKmSla
         Qvo15BlGP5gSHqP687clHIjvlyBZ3awqDV1D8v7VXjkOv86RuU6uqqhUFdSwEmtzZzAM
         M9MYzgVguLWMemSka4wnPi4rj3SLmWpkTjoPe8Xfa5u2m/yzoSGMb/vseItjndavvHkm
         gjAi7KjBpp+cxpePESg8+1phyPfpWFoUo+2k3lMAG6e2SzYOdNlOfIBeryE7ZeBuwT8W
         7DHQ==
X-Gm-Message-State: APt69E0lHPsU7Ht/n3qaBbY0MDBn6BmWU2R9jsmi99TXircGDcFpec4k
        l90hhngE6Gcu8jev6+M86pQ1IQ==
X-Google-Smtp-Source: ADUXVKLd3nzlLk94qTc9+wskImJZpL27c7SNHVoFHYT1KWyn7u03YK3vCPKhG2+axU1kTv3SFXpyRg==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9-v6mr23518208plk.302.1530491754922;
        Sun, 01 Jul 2018 17:35:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id d7-v6sm17760077pfa.51.2018.07.01.17.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 17:35:53 -0700 (PDT)
Date:   Sun, 1 Jul 2018 17:35:53 -0700
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
Message-ID: <20180702003553.GA95395@joelaf.mtv.corp.google.com>
References: <20180627204835.GA25456@linux.vnet.ibm.com>
 <20180627204915.27253-1-paulmck@linux.vnet.ibm.com>
 <20180701183828.GB111992@joelaf.mtv.corp.google.com>
 <20180701222749.GD3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701222749.GD3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 03:27:49PM -0700, Paul E. McKenney wrote:
[...]
> > > +/*
> > > + * Report a deferred quiescent state if needed and safe to do so.
> > > + * As with rcu_preempt_need_deferred_qs(), "safe" involves only
> > > + * not being in an RCU read-side critical section.  The caller must
> > > + * evaluate safety in terms of interrupt, softirq, and preemption
> > > + * disabling.
> > > + */
> > > +static void rcu_preempt_deferred_qs(struct task_struct *t)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	if (!rcu_preempt_need_deferred_qs(t))
> > > +		return;
> > > +	local_irq_save(flags);
> > > +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > +}
> > > +
> > > +/*
> > > + * Handle special cases during rcu_read_unlock(), such as needing to
> > > + * notify RCU core processing or task having blocked during the RCU
> > > + * read-side critical section.
> > > + */
> > > +static void rcu_read_unlock_special(struct task_struct *t)
> > > +{
> > > +	unsigned long flags;
> > > +	bool preempt_bh_were_disabled = !!(preempt_count() & ~HARDIRQ_MASK);
> > > +	bool irqs_were_disabled;
> > > +
> > > +	/* NMI handlers cannot block and cannot safely manipulate state. */
> > > +	if (in_nmi())
> > > +		return;
> > > +
> > > +	local_irq_save(flags);
> > > +	irqs_were_disabled = irqs_disabled_flags(flags);
> > > +	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
> > > +	    t->rcu_read_unlock_special.b.blocked) {
> > > +		/* Need to defer quiescent state until everything is enabled. */
> > > +		raise_softirq_irqoff(RCU_SOFTIRQ);
> > > +		local_irq_restore(flags);
> > > +		return;
> > > +	}
> > > +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > +}
> > > +
> > >  /*
> > >   * Dump detailed information for all tasks blocking the current RCU
> > >   * grace period on the specified rcu_node structure.
> > > @@ -737,10 +784,20 @@ static void rcu_preempt_check_callbacks(void)
> > >  	struct rcu_state *rsp = &rcu_preempt_state;
> > >  	struct task_struct *t = current;
> > >  
> > > -	if (t->rcu_read_lock_nesting == 0) {
> > > -		rcu_preempt_qs();
> > > +	if (t->rcu_read_lock_nesting > 0 ||
> > > +	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
> > > +		/* No QS, force context switch if deferred. */
> > > +		if (rcu_preempt_need_deferred_qs(t))
> > > +			resched_cpu(smp_processor_id());
> > 
> > 
> > Hi Paul,
> > 
> > I had a similar idea of checking the preempt_count() sometime back but didn't
> > believe this path can be called with preempt enabled (for some reason ;-)).
> > Now that I've convinced myself that's possible, what do you think about
> > taking advantage of the opportunity to report a RCU-sched qs like below from
> > rcu_check_callbacks ?
> > 
> > Did some basic testing, can roll into a patch later if you're Ok with it.
> 
> The problem here is that the code patch above cannot be called
> with CONFIG_PREEMPT_COUNT=n, but the code below can.  And if
> CONFIG_PREEMPT_COUNT=n, the return value from preempt_count() can be
> misleading.
> 
> Or am I missing something here?

That is true! so then I could also test if PREEMPT_RCU is enabled like you're
doing in the other path.

thanks!

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fb440baf8ac6..03a460921dca 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2683,6 +2683,12 @@ void rcu_check_callbacks(int user)
 		rcu_note_voluntary_context_switch(current);
 
 	} else if (!in_softirq()) {
+		/*
+		 * Report RCU-sched qs if not in an RCU-sched read-side
+		 * critical section.
+		 */
+		if (IS_ENABLED(PREEMPT_RCU) && !(preempt_count() & PREEMPT_MASK))
+			rcu_sched_qs();
 
 		/*
 		 * Get here if this CPU did not take its interrupt from
