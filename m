Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756625AbeDZQSY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:18:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753207AbeDZQSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:18:23 -0400
Date: Thu, 26 Apr 2018 18:18:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gaurav Kohli <gkohli@codeaurora.org>, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180426161820.GA15391@redhat.com>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426084131.GV4129@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26, Peter Zijlstra wrote:
>
> For the others, I think we want to do something like the below. I still
> need to look at TASK_TRACED, which I suspect is also special,

Yes, and TASK_STOPPED.

ptrace_freeze_traced() and ptrace_unfreeze_traced() should be fine, but
ptrace_stop() wants set_special_state() too, I think.

> but ptrace always hurts my brain.

mine too ;)

> +/*
> + * set_special_state() should be used for those states when the blocking task
> + * can not use the regular condition based wait-loop. In that case we must
> + * serialize against wakeups such that any possible in-flight TASK_RUNNING stores
> + * will not collide with out state change.
> + */
> +#define set_special_state(state_value)					\
> +	do {								\
> +		unsigned long flags; /* may shadow */			\
> +		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
> +		current->state = (state_value);				\
> +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
> +	} while (0)
> +

Agreed.

I thought that perhaps we can change ttwu_do_wakeup() cmpxchg() instead of
plain p->state = TASK_RUNNING, but this helper looks much more clear and simple.

Oleg.
