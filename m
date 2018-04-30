Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeD3LUh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:20:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeD3LUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:20:36 -0400
Date: Mon, 30 Apr 2018 13:20:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Gaurav Kohli <gkohli@codeaurora.org>, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180430112029.GF4082@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
 <20180426161820.GA15391@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426161820.GA15391@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 06:18:20PM +0200, Oleg Nesterov wrote:
> On 04/26, Peter Zijlstra wrote:
> >
> > For the others, I think we want to do something like the below. I still
> > need to look at TASK_TRACED, which I suspect is also special,
> 
> Yes, and TASK_STOPPED.

I already did that one, right ;-)

> 
> ptrace_freeze_traced() and ptrace_unfreeze_traced() should be fine, but
> ptrace_stop() wants set_special_state() too, I think.

Thanks for going through that, I'll update the patch.

> > +/*
> > + * set_special_state() should be used for those states when the blocking task
> > + * can not use the regular condition based wait-loop. In that case we must
> > + * serialize against wakeups such that any possible in-flight TASK_RUNNING stores
> > + * will not collide with out state change.
> > + */
> > +#define set_special_state(state_value)					\
> > +	do {								\
> > +		unsigned long flags; /* may shadow */			\
> > +		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
> > +		current->state = (state_value);				\
> > +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
> > +	} while (0)
> > +
> 
> Agreed.
> 
> I thought that perhaps we can change ttwu_do_wakeup() cmpxchg() instead of
> plain p->state = TASK_RUNNING, but this helper looks much more clear and simple.

Aside from cmpxchg() slowing down the common fast path, that also
would not work on architectures where cmpxchg() is not in fact atomic vs
regular stores (and yes, sadly we still have those, PARISC and SPARC32
come to mind).
