Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756783AbeDZQCl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:02:41 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40804 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756519AbeDZQCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:02:37 -0400
X-Google-Smtp-Source: AB8JxZrF6z3FS799rrL2RRyoBYjVYzPYNIT8DHqkwAXqzLAUq7cAVzR35OdUUcIE7BAymyXsWYtt0g==
Date: Thu, 26 Apr 2018 18:02:27 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gaurav Kohli <gkohli@codeaurora.org>, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180426160227.GA6297@andrea>
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

On Thu, Apr 26, 2018 at 10:41:31AM +0200, Peter Zijlstra wrote:

[...]

> +/*
> + * Special states are those that do not use the normal wait-loop pattern. See
> + * the comment with set_special_state().
> + */
> +#define is_special_state(state)		\
> +	((state) == TASK_DEAD ||	\
> +	 (state) == TASK_STOPPED)
> +
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>  
> +/*
> + * Assert we don't use the regular *set_current_state() helpers for special
> + * states. See the comment with set_special_state().
> + */
> +#define assert_special_state(state)	WARN_ON_ONCE(is_special_state(state))

Nitpicking, this name suggests "Shout if the state is NOT special" to me:
maybe,

#define assert_special_state(state)	WARN_ON_ONCE(!is_special_state(state))
#define assert_regular_state(state)	WARN_ON_ONCE(is_special_state(state))

or just do with the WARN_ON_ONCE()s ?

  Andrea


> +
>  #define __set_current_state(state_value)			\
>  	do {							\
> +		assert_special_state(state_value);		\
>  		current->task_state_change = _THIS_IP_;		\
>  		current->state = (state_value);			\
>  	} while (0)
> +
>  #define set_current_state(state_value)				\
>  	do {							\
> +		assert_special_state(state_value);		\
>  		current->task_state_change = _THIS_IP_;		\
>  		smp_store_mb(current->state, (state_value));	\
>  	} while (0)
>  
> +#define set_special_state(state_value)					\
> +	do {								\
> +		unsigned long flags; /* may shadow */			\
> +		WARN_ON_ONCE(!is_special_state(state_value));		\
> +		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
> +		current->task_state_change = _THIS_IP_;			\
> +		current->state = (state_value);				\
> +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
> +	} while (0)
