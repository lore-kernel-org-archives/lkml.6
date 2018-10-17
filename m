Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE56ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A032145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OjAkm+W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A032145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeJRCMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:12:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37918 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJRCMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:12:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so12910974pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A7OJafXuKzsXTZzW6/O4gfzp5OBBpfMXcMHu0ZInyAk=;
        b=OjAkm+W4qr0DDf+Qt8RsTW1ixNV7FLts7WpRrm5nFdAl1lUvAz8h+x7GsBs7Avg21h
         lC4asn/fs4BGYX6p05FT7w32F5eb9buXVnZnFq7vRmhKtiqCq+NgalEZyIOAkIjqkmx0
         4DtdhWCtI3jpbbeDputVlmqRaX1xBENFSZoeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A7OJafXuKzsXTZzW6/O4gfzp5OBBpfMXcMHu0ZInyAk=;
        b=aD4N69OKrtiY1hpOGw2Gb+jnk1tepL5dLhvR6m5EDelHi2U+2jCEKYoQ+aakTdLTyE
         pfsFfAZig7tGXYf5Clz3C3+u534R8vD43Kl/B0XSVWRrXIxjSw9iU7oAWa/Q0I+dTIjI
         Xffjji1RhDWcFsiTQNgD7flc9M8Y15DKbbF5P4bvJzfWkB2lYwzsg2I+JXY1Mma1AHM+
         HYa1Q+2/yo14VXOLjAJdYWJ9ST6va5+DQw+xrzJJKtSzbxF4SZ1ooYX4dngeIw7IS3Z2
         o7PRuK+wLzJ/Tpc8xccGgXhGN51UO8yclKS+qjHUppVT8ZV+mRaHQW0JJT7lXjIRJyMV
         o/3A==
X-Gm-Message-State: ABuFfojvmaPH0m84IlJTpLpUOS7qN+CCuEpRBFf+03Y/Kt8GW53Dpe5A
        wabS/yevoHep/XZhI85mMWGwew==
X-Google-Smtp-Source: ACcGV63SCzNut/2NgqHahgHkxnjAdkwW75SN0qHdEaO4z/kuLdgaGgyTrh2Cp/hnAJE0UiE/BqSvyQ==
X-Received: by 2002:a63:415:: with SMTP id 21-v6mr3370560pge.204.1539800109428;
        Wed, 17 Oct 2018 11:15:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id k70-v6sm22988572pfc.76.2018.10.17.11.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 11:15:06 -0700 (PDT)
Date:   Wed, 17 Oct 2018 11:15:05 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Message-ID: <20181017181505.GC107185@joelaf.mtv.corp.google.com>
References: <20181015024758.GA227989@joelaf.mtv.corp.google.com>
 <5151da01-343b-bb37-353e-b6652ae530f5@suse.com>
 <20181015112112.GT2674@linux.ibm.com>
 <20181015193951.GA33528@joelaf.mtv.corp.google.com>
 <20181015195426.GD2674@linux.ibm.com>
 <20181015201556.GA43575@joelaf.mtv.corp.google.com>
 <20181015210856.GE2674@linux.ibm.com>
 <20181016112611.GA27405@linux.ibm.com>
 <20181016204122.GA8176@joelaf.mtv.corp.google.com>
 <20181017161100.GP2674@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017161100.GP2674@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:11:00AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 16, 2018 at 01:41:22PM -0700, Joel Fernandes wrote:
> > On Tue, Oct 16, 2018 at 04:26:11AM -0700, Paul E. McKenney wrote:
> > > On Mon, Oct 15, 2018 at 02:08:56PM -0700, Paul E. McKenney wrote:
> > > > On Mon, Oct 15, 2018 at 01:15:56PM -0700, Joel Fernandes wrote:
> > > > > On Mon, Oct 15, 2018 at 12:54:26PM -0700, Paul E. McKenney wrote:
> > > > > [...]
> > > > > > > > In any case, please don't spin for milliseconds with preemption disabled.
> > > > > > > > The real-time guys are unlikely to be happy with you if you do this!
> > > > > > > 
> > > > > > > Well just to clarify, I was just running Oleg's test which did this. This
> > > > > > > test was mentioned in the original documentation that I deleted. Ofcourse I
> > > > > > > would not dare do such a thing in production code :-D. I guess to Oleg's
> > > > > > > defense, he did it to very that synchronize_rcu() was not blocked on
> > > > > > > preempt-disable sections which was a different test.
> > > > > > 
> > > > > > Understood!  Just pointing out that RCU's tolerating a given action does
> > > > > > not necessarily mean that it is a good idea to take that action.  ;-)
> > > > > 
> > > > > Makes sense :-) thanks.
> > > > 
> > > > Don't worry, that won't happen again.  ;-)
> > > > 
> > > > > > > > > > +		pr_crit("SPIN done!\n");
> > > > > > > > > > +		preempt_enable();
> > > > > > > > > > +		break;
> > > > > > > > > > +	case 777:
> > > > > > > > > > +		pr_crit("SYNC start\n");
> > > > > > > > > > +		synchronize_rcu();
> > > > > > > > > > +		pr_crit("SYNC done!\n");
> > > > > > > > > 
> > > > > > > > > But you are using the console printing infrastructure which is rather
> > > > > > > > > heavyweight. Try replacing pr_* calls with trace_printk so that you
> > > > > > > > > write to the lock-free ring buffer, this will reduce the noise from the
> > > > > > > > > heavy console printing infrastructure.
> > > > > > > > 
> > > > > > > > And this might be a problem as well.
> > > > > > > 
> > > > > > > This was not the issue (or atleast not fully the issue) since I saw the same
> > > > > > > thing with trace_printk. It was exactly what you said - which is the
> > > > > > > excessively long preempt disabled times.
> > > > > > 
> > > > > > One approach would be to apply this patch against (say) v4.18, which
> > > > > > does not have consolidated grace periods.  You might then be able to
> > > > > > tell if the pr_crit() calls make any difference.
> > > > > 
> > > > > I could do that, yeah. But since the original problem went away due to
> > > > > disabling preempts for a short while, I will move on and continue to focus on
> > > > > updating other parts of the documenation. Just to mention I
> > > > > brought this up because I thought its better to do that than not to, just
> > > > > incase there is any lurking issue with the consolidation. Sorry if that ended
> > > > > up with me being noisy.
> > > > 
> > > > Not a problem, no need to apologize!
> > > 
> > > Besides, digging through the code did point out a reasonable optimization.
> > > In the common case, this would buy 100s of microseconds rather than
> > > milliseconds, but it seems simple enough to be worthwhile.  Thoughts?
> > 
> > Cool, thanks. One comment below:
> > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit 07921e8720907f58f82b142f2027fc56d5abdbfd
> > > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > > Date:   Tue Oct 16 04:12:58 2018 -0700
> > > 
> > >     rcu: Speed up expedited GPs when interrupting RCU reader
> > >     
> > >     In PREEMPT kernels, an expedited grace period might send an IPI to a
> > >     CPU that is executing an RCU read-side critical section.  In that case,
> > >     it would be nice if the rcu_read_unlock() directly interacted with the
> > >     RCU core code to immediately report the quiescent state.  And this does
> > >     happen in the case where the reader has been preempted.  But it would
> > >     also be a nice performance optimization if immediate reporting also
> > >     happened in the preemption-free case.
> > >     
> > >     This commit therefore adds an ->exp_hint field to the task_struct structure's
> > >     ->rcu_read_unlock_special field.  The IPI handler sets this hint when
> > >     it has interrupted an RCU read-side critical section, and this causes
> > >     the outermost rcu_read_unlock() call to invoke rcu_read_unlock_special(),
> > >     which, if preemption is enabled, reports the quiescent state immediately.
> > >     If preemption is disabled, then the report is required to be deferred
> > >     until preemption (or bottom halves or interrupts or whatever) is re-enabled.
> > >     
> > >     Because this is a hint, it does nothing for more complicated cases.  For
> > >     example, if the IPI interrupts an RCU reader, but interrupts are disabled
> > >     across the rcu_read_unlock(), but another rcu_read_lock() is executed
> > >     before interrupts are re-enabled, the hint will already have been cleared.
> > >     If you do crazy things like this, reporting will be deferred until some
> > >     later RCU_SOFTIRQ handler, context switch, cond_resched(), or similar.
> > >     
> > >     Reported-by: Joel Fernandes <joel@joelfernandes.org>
> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 004ca21f7e80..64ce751b5fe9 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -571,8 +571,10 @@ union rcu_special {
> > >  	struct {
> > >  		u8			blocked;
> > >  		u8			need_qs;
> > > +		u8			exp_hint; /* Hint for performance. */
> > > +		u8			pad; /* No garbage from compiler! */
> > >  	} b; /* Bits. */
> > > -	u16 s; /* Set of bits. */
> > > +	u32 s; /* Set of bits. */
> > >  };
> > >  
> > >  enum perf_event_task_context {
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index e669ccf3751b..928fe5893a57 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -692,8 +692,10 @@ static void sync_rcu_exp_handler(void *unused)
> > >  	 */
> > >  	if (t->rcu_read_lock_nesting > 0) {
> > >  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > -		if (rnp->expmask & rdp->grpmask)
> > > +		if (rnp->expmask & rdp->grpmask) {
> > >  			rdp->deferred_qs = true;
> > > +			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > > +		}
> > >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  	}
> > >  
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 8b48bb7c224c..d6286eb6e77e 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -643,8 +643,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > >  	local_irq_save(flags);
> > >  	irqs_were_disabled = irqs_disabled_flags(flags);
> > >  	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
> > > -	    t->rcu_read_unlock_special.b.blocked) {
> > > +	    t->rcu_read_unlock_special.s) {
> > >  		/* Need to defer quiescent state until everything is enabled. */
> > > +		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > >  		raise_softirq_irqoff(RCU_SOFTIRQ);
> > 
> > Still going through this patch, but it seems to me like the fact that
> > rcu_read_unlock_special is called means someone has requested for a grace
> > period. Then in that case, does it not make sense to raise the softirq
> > for processing anyway?
> 
> Not necessarily.  Another reason that rcu_read_unlock_special() might
> be called is if the RCU read-side critical section had been preempted,
> in which case there might not even be a grace period in progress.

Yes true, it was at the back of my head ;) It needs to remove itself from the
blocked lists on the unlock. And ofcourse the preemption case is alsoo
clearly mentioned in this function's comments. (slaps self).

> In addition, if interrupts, bottom halves, and preemption are all enabled,
> the code in rcu_preempt_deferred_qs_irqrestore() doesn't need to bother
> raising softirq, as it can instead just immediately report the quiescent
> state.

Makes sense. I will go through these code paths more today. Thank you for the
explanations!

I think something like need_exp_qs instead of 'exp_hint' may be more
descriptive?

Otherwise,
Reviewed-by: Joel Fernandes <joel@joelfernandes.org>

thanks,

 - Joel

