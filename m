Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62383C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C920823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uGs5ws0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6C920823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJ3Mgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 08:36:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46238 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3Mgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 08:36:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id m9-v6so2218867pgl.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 20:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0vdQSew9KTnsyh9iTbCPjsnKs8NogKfWpXN3AJgik0w=;
        b=uGs5ws0P6RD1ikOuV93jXAPbPff3eP25CYkwmZgJfmqhJJhcYWgqVGjb2jcFfP9lBU
         gRwq9dQGmc8bWJIf1azImct2TgQSCX001wSpw0P23LBQ/0a/LPrHxhF6BuO65BwgbdVA
         Mtbs2QeOht2py7RVlwobmw+j6dLqKtMTHCRcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0vdQSew9KTnsyh9iTbCPjsnKs8NogKfWpXN3AJgik0w=;
        b=M/ORxGibvhyP+5aA0SfhDxLmNv2Jsbgx+N/XSo9avHJw9rdkSsNMJtyYIvX3Q54pz7
         uhvNrfY9V8mIxpqS5oUBHYRDgfNNv5ZrNxwzAZHiz7f60LAlP9IA84GNAa3bUPEuL4u0
         3VEO3u6oJYh7dgLopXtjfTL9xjVYZwuO1o4SxJyYZyeoUP202fWqWlxjXONptse4NE82
         7wXQtOUu4TYqAvCUxMmJ+cOYjTac5Y8oks1yM2AycO9BBWWiMgol5qwR6n4vjS6Zj5DU
         ASlfRgDvU4jdBAI9MiC6ns6XMVTUd/kbNulrs/XUECzsbUQ7k2SDjxRUetR1FXts5tC3
         vY1A==
X-Gm-Message-State: AGRZ1gIpAnsmFThn9LyMlu38C/YF9Z5Lqs1UJAYGi+NlRw7Jawcz9rkj
        phzioUKbxqi7xIdKeRwzkndRTA==
X-Google-Smtp-Source: AJdET5dUNguCklqmWsZjsg+zFHxtM7caaMqJGbIg9iXzPMBqg7kbXFROB6XG0qV9uF5+Wjms+0MEKg==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr15904246pgv.407.1540871095286;
        Mon, 29 Oct 2018 20:44:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 134-v6sm36675835pfy.97.2018.10.29.20.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 20:44:53 -0700 (PDT)
Date:   Mon, 29 Oct 2018 20:44:52 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Ran Rozenstein <ranro@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Message-ID: <20181030034452.GA224709@google.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-2-paulmck@linux.vnet.ibm.com>
 <AM4PR0501MB27691ECD1B0ECB0531B16F20C5F30@AM4PR0501MB2769.eurprd05.prod.outlook.com>
 <20181029142735.GZ4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029142735.GZ4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 07:27:35AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 29, 2018 at 11:24:42AM +0000, Ran Rozenstein wrote:
> > Hi Paul and all,
> > 
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > > owner@vger.kernel.org] On Behalf Of Paul E. McKenney
> > > Sent: Thursday, August 30, 2018 01:21
> > > To: linux-kernel@vger.kernel.org
> > > Cc: mingo@kernel.org; jiangshanlai@gmail.com; dipankar@in.ibm.com;
> > > akpm@linux-foundation.org; mathieu.desnoyers@efficios.com;
> > > josh@joshtriplett.org; tglx@linutronix.de; peterz@infradead.org;
> > > rostedt@goodmis.org; dhowells@redhat.com; edumazet@google.com;
> > > fweisbec@gmail.com; oleg@redhat.com; joel@joelfernandes.org; Paul E.
> > > McKenney <paulmck@linux.vnet.ibm.com>
> > > Subject: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
> > > quiescent states when disabled
> > > 
> > > This commit defers reporting of RCU-preempt quiescent states at
> > > rcu_read_unlock_special() time when any of interrupts, softirq, or
> > > preemption are disabled.  These deferred quiescent states are reported at a
> > > later RCU_SOFTIRQ, context switch, idle entry, or CPU-hotplug offline
> > > operation.  Of course, if another RCU read-side critical section has started in
> > > the meantime, the reporting of the quiescent state will be further deferred.
> > > 
> > > This also means that disabling preemption, interrupts, and/or softirqs will act
> > > as an RCU-preempt read-side critical section.
> > > This is enforced by checking preempt_count() as needed.
> > > 
> > > Some special cases must be handled on an ad-hoc basis, for example,
> > > context switch is a quiescent state even though both the scheduler and
> > > do_exit() disable preemption.  In these cases, additional calls to
> > > rcu_preempt_deferred_qs() override the preemption disabling.  Similar logic
> > > overrides disabled interrupts in rcu_preempt_check_callbacks() because in
> > > this case the quiescent state happened just before the corresponding
> > > scheduling-clock interrupt.
> > > 
> > > In theory, this change lifts a long-standing restriction that required that if
> > > interrupts were disabled across a call to rcu_read_unlock() that the matching
> > > rcu_read_lock() also be contained within that interrupts-disabled region of
> > > code.  Because the reporting of the corresponding RCU-preempt quiescent
> > > state is now deferred until after interrupts have been enabled, it is no longer
> > > possible for this situation to result in deadlocks involving the scheduler's
> > > runqueue and priority-inheritance locks.  This may allow some code
> > > simplification that might reduce interrupt latency a bit.  Unfortunately, in
> > > practice this would also defer deboosting a low-priority task that had been
> > > subjected to RCU priority boosting, so real-time-response considerations
> > > might well force this restriction to remain in place.
> > > 
> > > Because RCU-preempt grace periods are now blocked not only by RCU read-
> > > side critical sections, but also by disabling of interrupts, preemption, and
> > > softirqs, it will be possible to eliminate RCU-bh and RCU-sched in favor of
> > > RCU-preempt in CONFIG_PREEMPT=y kernels.  This may require some
> > > additional plumbing to provide the network denial-of-service guarantees
> > > that have been traditionally provided by RCU-bh.  Once these are in place,
> > > CONFIG_PREEMPT=n kernels will be able to fold RCU-bh into RCU-sched.
> > > This would mean that all kernels would have but one flavor of RCU, which
> > > would open the door to significant code cleanup.
> > > 
> > > Moving to a single flavor of RCU would also have the beneficial effect of
> > > reducing the NOCB kthreads by at least a factor of two.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com> [ paulmck:
> > > Apply rcu_read_unlock_special() preempt_count() feedback
> > >   from Joel Fernandes. ]
> > > [ paulmck: Adjust rcu_eqs_enter() call to rcu_preempt_deferred_qs() in
> > >   response to bug reports from kbuild test robot. ] [ paulmck: Fix bug located
> > > by kbuild test robot involving recursion
> > >   via rcu_preempt_deferred_qs(). ]
> > > ---
> > >  .../RCU/Design/Requirements/Requirements.html |  50 +++---
> > >  include/linux/rcutiny.h                       |   5 +
> > >  kernel/rcu/tree.c                             |   9 ++
> > >  kernel/rcu/tree.h                             |   3 +
> > >  kernel/rcu/tree_exp.h                         |  71 +++++++--
> > >  kernel/rcu/tree_plugin.h                      | 144 +++++++++++++-----
> > >  6 files changed, 205 insertions(+), 77 deletions(-)
> > > 
> > 
> > We started seeing the trace below in our regression system, after I bisected I found this is the offending commit.
> > This appears immediately on boot. 
> > Please let me know if you need any additional details.
> 
> Interesting.  Here is the offending function:
> 
> 	static void rcu_preempt_deferred_qs(struct task_struct *t)
> 	{
> 		unsigned long flags;
> 		bool couldrecurse = t->rcu_read_lock_nesting >= 0;
> 
> 		if (!rcu_preempt_need_deferred_qs(t))
> 			return;
> 		if (couldrecurse)
> 			t->rcu_read_lock_nesting -= INT_MIN;
> 		local_irq_save(flags);
> 		rcu_preempt_deferred_qs_irqrestore(t, flags);
> 		if (couldrecurse)
> 			t->rcu_read_lock_nesting += INT_MIN;
> 	}
> 
> Using twos-complement arithmetic (which the kernel build gcc arguments
> enforce, last I checked) this does work.  But as UBSAN says, subtracting
> INT_MIN is unconditionally undefined behavior according to the C standard.
> 
> Good catch!!!
> 
> So how do I make the above code not simply function, but rather meet
> the C standard?
> 
> One approach to add INT_MIN going in, then add INT_MAX and then add 1
> coming out.
> 
> Another approach is to sacrifice the INT_MAX value (should be plenty
> safe), thus subtract INT_MAX going in and add INT_MAX coming out.
> For consistency, I suppose that I should change the INT_MIN in
> __rcu_read_unlock() to -INT_MAX.
> 
> I could also leave __rcu_read_unlock() alone and XOR the top
> bit of t->rcu_read_lock_nesting on entry and exit to/from
> rcu_preempt_deferred_qs().
> 
> Sacrificing the INT_MIN value seems most maintainable, as in the following
> patch.  Thoughts?

The INT_MAX naming could be very confusing for nesting levels, could we not
instead just define something like:
#define RCU_NESTING_MIN (INT_MIN - 1)
#define RCU_NESTING_MAX (INT_MAX)

and just use that? also one more comment below:

> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index bd8186d0f4a7..f1b40c6d36e4 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -424,7 +424,7 @@ void __rcu_read_unlock(void)
>  		--t->rcu_read_lock_nesting;
>  	} else {
>  		barrier();  /* critical section before exit code. */
> -		t->rcu_read_lock_nesting = INT_MIN;
> +		t->rcu_read_lock_nesting = -INT_MAX;
>  		barrier();  /* assign before ->rcu_read_unlock_special load */
>  		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
>  			rcu_read_unlock_special(t);
> @@ -617,11 +617,11 @@ static void rcu_preempt_deferred_qs(struct task_struct *t)
>  	if (!rcu_preempt_need_deferred_qs(t))
>  		return;
>  	if (couldrecurse)
> -		t->rcu_read_lock_nesting -= INT_MIN;
> +		t->rcu_read_lock_nesting -= INT_MAX;

Shouldn't this be:  t->rcu_read_lock_nesting -= -INT_MAX; ?

>  	local_irq_save(flags);
>  	rcu_preempt_deferred_qs_irqrestore(t, flags);
>  	if (couldrecurse)
> -		t->rcu_read_lock_nesting += INT_MIN;
> +		t->rcu_read_lock_nesting += INT_MAX;

And t->rcu_read_lock_nesting += -INT_MAX; ?

But apologies if I missed something, thanks,

 - Joel

