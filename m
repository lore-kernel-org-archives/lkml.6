Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965931AbeEJOWw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:22:52 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50242 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965078AbeEJOWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:22:51 -0400
Date: Thu, 10 May 2018 10:24:42 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>, Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>, Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 6/7] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180510142442.GG19348@cmpxchg.org>
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-7-hannes@cmpxchg.org>
 <20180509102100.GN12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509102100.GN12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 12:21:00PM +0200, Peter Zijlstra wrote:
> On Mon, May 07, 2018 at 05:01:34PM -0400, Johannes Weiner wrote:
> > +	local_irq_disable();
> > +	rq = this_rq();
> > +	raw_spin_lock(&rq->lock);
> > +	rq_pin_lock(rq, &rf);
> 
> Given that churn in sched.h, you seen rq_lock() and friends.
> 
> Either write this like:
> 
> 	local_irq_disable();
> 	rq = this_rq();
> 	rq_lock(rq, &rf);
> 
> Or instroduce "rq = this_rq_lock_irq()", which we could also use in
> do_sched_yield().

Sounds good, I'll add that.

> > +	update_rq_clock(rq);
> > +
> > +	current->flags |= PF_MEMSTALL;
> > +	psi_task_change(current, rq_clock(rq), 0, TSK_MEMSTALL);
> > +
> > +	rq_unpin_lock(rq, &rf);
> > +	raw_spin_unlock(&rq->lock);
> > +	local_irq_enable();
> 
> That's called rq_unlock_irq().

I'll use that. This code was first written against a kernel that
didn't have 8a8c69c32778 ("sched/core: Add rq->lock wrappers.") yet ;)
