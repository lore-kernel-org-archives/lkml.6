Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF4C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5087256F7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="avqeTScW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5087256F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031195AbeGARkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:40:52 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46147 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030436AbeGARkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:40:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so3349817pfl.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gV01AziQeeFV23+2lMm3zRlbGm5A1h4ZewiDsaY1wnM=;
        b=avqeTScWz/cw3+zzitQoTKSPixV4OfiJWtO8y6N97EasuHNvKgVZhca2dUiSNLnK4d
         JbnU3wmBwepxpsXu661rAZLMun0awInpcH1uzK0231myTgHmcGcYGXdEeY2axr6jQ1I1
         9oKDDK3bg9WSU3jsHH1lBQaOhgTkqXtSyvGe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gV01AziQeeFV23+2lMm3zRlbGm5A1h4ZewiDsaY1wnM=;
        b=nq07unHd2ljyo+WcVPoJSuN6UQ6G90hBsXgNnf125Nlx2Ih1xWfvv/lAjhuBhA/j8b
         MS8gLHRjt8uvc/U4MUO6YdLyvBFcXorSi8r0sTim3ZqpYP3PQ1ZcQzL76YuoPwdoFGx2
         pDyaN+B+42nZiYukZyb9nsJQsg6RzbKpPll6u/rXueUd47HXZXdwiTCmvcj2X/UTSCns
         qi7LWi6uEILO9m7gjEUDEJSDgPJZDH9zyI/T3pNavgDA0iDO23LWo5kIRC28911qrSL7
         bpgER5u+b0aO6POexRwi+pZLc2Xc6MnAWkXQYowfL/9Rgo/iSVs8/nA59bhW01XItagd
         iCFg==
X-Gm-Message-State: APt69E04DQPH6Lyajce6VNGvpVjLUaVFU9O7oFtzZ0evDqBrjuI2lon6
        iEg2NdgQt7ca9JNCEdfftncs5A==
X-Google-Smtp-Source: AAOMgpfae11qF8SB1AryLstAnmQod65NkoSBaOXeTSKFycZdyXTyfcRU/v2hPeyn742nXVhx385uOw==
X-Received: by 2002:a63:7a43:: with SMTP id j3-v6mr2634182pgn.363.1530466846209;
        Sun, 01 Jul 2018 10:40:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id m6-v6sm5897660pfh.153.2018.07.01.10.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 10:40:45 -0700 (PDT)
Date:   Sun, 1 Jul 2018 10:40:45 -0700
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
Message-ID: <20180701174045.GA111992@joelaf.mtv.corp.google.com>
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

On Wed, Jun 27, 2018 at 01:49:14PM -0700, Paul E. McKenney wrote:
> This commit defers reporting of RCU-preempt quiescent states at
> rcu_read_unlock_special() time when any of interrupts, softirq, or
> preemption are disabled.  These deferred quiescent states are reported
> at a later RCU_SOFTIRQ, context switch, idle entry, or CPU-hotplug
> offline operation.  Of course, if another RCU read-side critical
> section has started in the meantime, the reporting of the quiescent
> state will be further deferred.
> 
> This also means that disabling preemption, interrupts, and/or
> softirqs will act as an RCU-preempt read-side critical section.
> This is enforced by checking preempt_count() as needed.
> 
> Some special cases must be handled on an ad-hoc basis, for example,
> context switch is a quiescent state even though both the scheduler and
> do_exit() disable preemption.  In these cases, additional calls to
> rcu_preempt_deferred_qs() override the preemption disabling.  Similar
> logic overrides disabled interrupts in rcu_preempt_check_callbacks()
> because in this case the quiescent state happened just before the
> corresponding scheduling-clock interrupt.
> 
> This change lifts a long-standing restriction that required that if
> interrupts were disabled across a call to rcu_read_unlock() that the
> matching rcu_read_lock() also be contained within that interrupts-disabled
> region of code.  Because the reporting of the corresponding RCU-preempt
> quiescent state is now deferred until after interrupts have been enabled,
> it is no longer possible for this situation to result in deadlocks
> involving the scheduler's runqueue and priority-inheritance locks.
> This may allow some code simplification that might reduce interrupt
> latency a bit.  Unfortunately, this would also defer deboosting a
> low-priority task that had been subjected to RCU priority boosting,
> so real-time-response considerations might well force this restriction
> to remain in place.
> 
> Because RCU-preempt grace periods are now blocked not only by RCU
> read-side critical sections, but also by disabling of interrupts,
> preemption, and softirqs, it will be possible to eliminate RCU-bh and
> RCU-sched in favor of RCU-preempt in CONFIG_PREEMPT=y kernels.  This may
> require some additional plumbing to provide the network denial-of-service
> guarantees that have been traditionally provided by RCU-bh.  Once these
> are in place, CONFIG_PREEMPT=n kernels will be able to fold RCU-bh
> into RCU-sched.  This would mean that all kernels would have but
> one flavor of RCU, which would open the door to significant code
> cleanup.
> 
> Moving to a single flavor of RCU would also have the beneficial effect
> of reducing the NOCB kthreads by at least a factor of two.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
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

Would it be better to just test for those bits just to be safe the higher
order bits don't bleed in, such as PREEMPT_NEED_RESCHED, something like the
following based on the 'dev' branch?

thanks,

- Joel

---8<-----------------------

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dfeca11c9fe7..ca7cfdf422f1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -626,7 +626,8 @@ static void rcu_preempt_deferred_qs(struct task_struct *t)
 static void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
-	bool preempt_bh_were_disabled = !!(preempt_count() & ~HARDIRQ_MASK);
+	bool preempt_bh_were_disabled = !!(preempt_count() &
+					   (PREEMPT_MASK | SOFTIRQ_MASK));
 	bool irqs_were_disabled;
 
 	/* NMI handlers cannot block and cannot safely manipulate state. */
