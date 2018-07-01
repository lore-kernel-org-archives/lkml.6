Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11394C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7BB20855
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Kkl1r3LQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7BB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeGASig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:38:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40769 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeGASia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:38:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so6433126pfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Hn/cPL3kCV/ocRW3yBi7VjS2bCF9u6H71Dbb+8hCcE=;
        b=Kkl1r3LQwv+UE3kh1p+WEmMExIWi2hsoez6/dyW4BilS6w/O3cqj4qB2dIvkqZSq0G
         xxnwuOGJ5rMe7lNv0qn4Fq839Q1S0zLNuccukEwftW2oWTNdlH8OhzKjGn1NPA+i8PLH
         /MQnignFk+1fPDrteo/xYi8d4YQuJqgZPOebY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Hn/cPL3kCV/ocRW3yBi7VjS2bCF9u6H71Dbb+8hCcE=;
        b=p97cg+MRZAnJccl2X5shfslyxwNcV87CZzX4EDtLuCRMWuK6YqyfpHjrAcHMPtyUIC
         NoxVtdDKMPEiHUX3ytxf+NXvOEteLh8BfP9Ovox9MxldQjfwhHwTDgBfCWe2RdTH15pc
         /huCRtcejr2Ii5lhDxsF/6+AGLwx+WXuSL3N4kQf8rW90z66lPs5HhYn/cYgP2SMBuSz
         qBl/UvbO4lK6ZN7bVqxfdEDOzDtnY6qaRy+wRfdkFwhfTSGDP5qb73D0jNc9SiJMfdza
         ZVo6k+1oPQ1DyMo4KITLKQh/s0o2Aq9qJgQ4PBNB/qIkTZ/go/DcH8Q2peaHPUlh6d1U
         Vv9A==
X-Gm-Message-State: APt69E05ZklNPGwY9w6IggDSPHu8AtaKCISEtk4XY+RdL1uYh3amKQ6p
        PCdV/CMUOatsYoikFf/8ayd5aw==
X-Google-Smtp-Source: AAOMgpcHvKuKwpqUp/5xq831R2fYUtGtvkotOE8POFiG/9cGxwrxn9+N6/GivvoUz/bTD7rhPsWM3g==
X-Received: by 2002:a65:450a:: with SMTP id n10-v6mr14346650pgq.392.1530470309727;
        Sun, 01 Jul 2018 11:38:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id 10-v6sm27212189pgb.40.2018.07.01.11.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 11:38:29 -0700 (PDT)
Date:   Sun, 1 Jul 2018 11:38:28 -0700
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
Message-ID: <20180701183828.GB111992@joelaf.mtv.corp.google.com>
References: <20180627204835.GA25456@linux.vnet.ibm.com>
 <20180627204915.27253-1-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627204915.27253-1-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Jun 27, 2018 at 01:49:14PM -0700, Paul E. McKenney wrote:
[...]
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c1b17f5b9361..ff5c70eae47d 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -371,6 +371,9 @@ static void rcu_preempt_note_context_switch(bool preempt)
>  		 * behalf of preempted instance of __rcu_read_unlock().
>  		 */
>  		rcu_read_unlock_special(t);
> +		rcu_preempt_deferred_qs(t);
> +	} else {
> +		rcu_preempt_deferred_qs(t);
>  	}
>  
>  	/*
> @@ -464,54 +467,51 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
>  }
>  
>  /*
> - * Handle special cases during rcu_read_unlock(), such as needing to
> - * notify RCU core processing or task having blocked during the RCU
> - * read-side critical section.
> + * Report deferred quiescent states.  The deferral time can
> + * be quite short, for example, in the case of the call from
> + * rcu_read_unlock_special().
>   */
> -static void rcu_read_unlock_special(struct task_struct *t)
> +static void
> +rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  {
>  	bool empty_exp;
>  	bool empty_norm;
>  	bool empty_exp_now;
> -	unsigned long flags;
>  	struct list_head *np;
>  	bool drop_boost_mutex = false;
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  	union rcu_special special;
>  
> -	/* NMI handlers cannot block and cannot safely manipulate state. */
> -	if (in_nmi())
> -		return;
> -
> -	local_irq_save(flags);
> -
>  	/*
>  	 * If RCU core is waiting for this CPU to exit its critical section,
>  	 * report the fact that it has exited.  Because irqs are disabled,
>  	 * t->rcu_read_unlock_special cannot change.
>  	 */
>  	special = t->rcu_read_unlock_special;
> +	rdp = this_cpu_ptr(rcu_state_p->rda);
> +	if (!special.s && !rdp->deferred_qs) {
> +		local_irq_restore(flags);
> +		return;
> +	}
>  	if (special.b.need_qs) {
>  		rcu_preempt_qs();
>  		t->rcu_read_unlock_special.b.need_qs = false;
> -		if (!t->rcu_read_unlock_special.s) {
> +		if (!t->rcu_read_unlock_special.s && !rdp->deferred_qs) {
>  			local_irq_restore(flags);
>  			return;
>  		}
>  	}
>  
>  	/*
> -	 * Respond to a request for an expedited grace period, but only if
> -	 * we were not preempted, meaning that we were running on the same
> -	 * CPU throughout.  If we were preempted, the exp_need_qs flag
> -	 * would have been cleared at the time of the first preemption,
> -	 * and the quiescent state would be reported when we were dequeued.
> +	 * Respond to a request by an expedited grace period for a
> +	 * quiescent state from this CPU.  Note that requests from
> +	 * tasks are handled when removing the task from the
> +	 * blocked-tasks list below.
>  	 */
> -	if (special.b.exp_need_qs) {
> -		WARN_ON_ONCE(special.b.blocked);
> +	if (special.b.exp_need_qs || rdp->deferred_qs) {
>  		t->rcu_read_unlock_special.b.exp_need_qs = false;
> -		rdp = this_cpu_ptr(rcu_state_p->rda);
> +		rdp->deferred_qs = false;
>  		rcu_report_exp_rdp(rcu_state_p, rdp, true);
>  		if (!t->rcu_read_unlock_special.s) {
>  			local_irq_restore(flags);
> @@ -519,19 +519,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		}
>  	}
>  
> -	/* Hardware IRQ handlers cannot block, complain if they get here. */
> -	if (in_irq() || in_serving_softirq()) {
> -		lockdep_rcu_suspicious(__FILE__, __LINE__,
> -				       "rcu_read_unlock() from irq or softirq with blocking in critical section!!!\n");
> -		pr_alert("->rcu_read_unlock_special: %#x (b: %d, enq: %d nq: %d)\n",
> -			 t->rcu_read_unlock_special.s,
> -			 t->rcu_read_unlock_special.b.blocked,
> -			 t->rcu_read_unlock_special.b.exp_need_qs,
> -			 t->rcu_read_unlock_special.b.need_qs);
> -		local_irq_restore(flags);
> -		return;
> -	}
> -
>  	/* Clean up if blocked during RCU read-side critical section. */
>  	if (special.b.blocked) {
>  		t->rcu_read_unlock_special.b.blocked = false;
> @@ -602,6 +589,66 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  	}
>  }
>  
> +/*
> + * Is a deferred quiescent-state pending, and are we also not in
> + * an RCU read-side critical section?  It is the caller's responsibility
> + * to ensure it is otherwise safe to report any deferred quiescent
> + * states.  The reason for this is that it is safe to report a
> + * quiescent state during context switch even though preemption
> + * is disabled.  This function cannot be expected to understand these
> + * nuances, so the caller must handle them.
> + */
> +static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> +{
> +	return (this_cpu_ptr(&rcu_preempt_data)->deferred_qs ||
> +		READ_ONCE(t->rcu_read_unlock_special.s)) &&
> +	       !t->rcu_read_lock_nesting;
> +}
> +
> +/*
> + * Report a deferred quiescent state if needed and safe to do so.
> + * As with rcu_preempt_need_deferred_qs(), "safe" involves only
> + * not being in an RCU read-side critical section.  The caller must
> + * evaluate safety in terms of interrupt, softirq, and preemption
> + * disabling.
> + */
> +static void rcu_preempt_deferred_qs(struct task_struct *t)
> +{
> +	unsigned long flags;
> +
> +	if (!rcu_preempt_need_deferred_qs(t))
> +		return;
> +	local_irq_save(flags);
> +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> +}
> +
> +/*
> + * Handle special cases during rcu_read_unlock(), such as needing to
> + * notify RCU core processing or task having blocked during the RCU
> + * read-side critical section.
> + */
> +static void rcu_read_unlock_special(struct task_struct *t)
> +{
> +	unsigned long flags;
> +	bool preempt_bh_were_disabled = !!(preempt_count() & ~HARDIRQ_MASK);
> +	bool irqs_were_disabled;
> +
> +	/* NMI handlers cannot block and cannot safely manipulate state. */
> +	if (in_nmi())
> +		return;
> +
> +	local_irq_save(flags);
> +	irqs_were_disabled = irqs_disabled_flags(flags);
> +	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
> +	    t->rcu_read_unlock_special.b.blocked) {
> +		/* Need to defer quiescent state until everything is enabled. */
> +		raise_softirq_irqoff(RCU_SOFTIRQ);
> +		local_irq_restore(flags);
> +		return;
> +	}
> +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> +}
> +
>  /*
>   * Dump detailed information for all tasks blocking the current RCU
>   * grace period on the specified rcu_node structure.
> @@ -737,10 +784,20 @@ static void rcu_preempt_check_callbacks(void)
>  	struct rcu_state *rsp = &rcu_preempt_state;
>  	struct task_struct *t = current;
>  
> -	if (t->rcu_read_lock_nesting == 0) {
> -		rcu_preempt_qs();
> +	if (t->rcu_read_lock_nesting > 0 ||
> +	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
> +		/* No QS, force context switch if deferred. */
> +		if (rcu_preempt_need_deferred_qs(t))
> +			resched_cpu(smp_processor_id());

 
Hi Paul,

I had a similar idea of checking the preempt_count() sometime back but didn't
believe this path can be called with preempt enabled (for some reason ;-)).
Now that I've convinced myself that's possible, what do you think about
taking advantage of the opportunity to report a RCU-sched qs like below from
rcu_check_callbacks ?

Did some basic testing, can roll into a patch later if you're Ok with it.

thanks.

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fb440baf8ac6..caa1e68f4168 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2683,6 +2683,12 @@ void rcu_check_callbacks(int user)
 		rcu_note_voluntary_context_switch(current);
 
 	} else if (!in_softirq()) {
+		/*
+		 * Report RCU-sched qs if not in an RCU-sched read-side
+		 * critical section.
+		 */
+		if (!(preempt_count() & PREEMPT_MASK))
+			rcu_sched_qs();
 
 		/*
 		 * Get here if this CPU did not take its interrupt from
