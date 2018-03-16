Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeCPPA5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:00:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56205 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbeCPPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:00:56 -0400
Date: Fri, 16 Mar 2018 16:00:53 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT PATCH 1/2] kernel/cpu_chill: use schedule_hrtimeout()
In-Reply-To: <20180316142135.9664-1-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.21.1803161549390.1598@nanos.tec.linutronix.de>
References: <20180316142135.9664-1-bigeasy@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Mar 2018, Sebastian Andrzej Siewior wrote:

> cpu_chill() uses __hrtimer_nanosleep() with a hack to get
> TASK_UNINTERRUPTIBLE state. It seems to work but it does not.
> The problem is that we may have a signal pending and receive a sporadic
> wake up _before_ the timer expires. At that point the code will look at

_We_ have nothing pending. Please describe it in a factual way and not like
you are running the code yourself.

> ->restart_block and use it based on its value from the previous syscall
> resulting in a possible copy-to-user.

What you want to describe is:

If a task calls cpu_chill() and gets woken up by a regular or spurious
wakeup and has a signal pending, then it exits the sleep loop in
do_nanosleep() and sets up the restart block. If restart->nanosleep.type is
not TI_NONE then this results in accessing a stale user pointer from a
previously interrupted syscall and a copy to user based on the stale
pointer or a BUG() when 'type' is not supported in nanosleep_copyout().

> instead all this trouble, we could use schedule_hrtimeout() which is not

Sentences start with an uppercase letter.

> instead all this trouble, we could use schedule_hrtimeout() which is not

s/we could// ....

> an user-space interface and does not have this side effects.

hmm?

> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/time/hrtimer.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 6c77643eaf02..c0efc22ba635 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1873,14 +1873,13 @@ COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
>   */
>  void cpu_chill(void)
>  {
> -	struct timespec64 tu = {
> -		.tv_nsec = NSEC_PER_MSEC,
> -	};
> +	ktime_t chill_time;
>  	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
>  
> +	chill_time = ktime_set(0, NSEC_PER_MSEC);
> +	set_current_state(TASK_UNINTERRUPTIBLE);
>  	current->flags |= PF_NOFREEZE;
> -	__hrtimer_nanosleep(&tu, HRTIMER_MODE_REL_HARD, CLOCK_MONOTONIC,
> -			    TASK_UNINTERRUPTIBLE);
> +	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
>  	if (!freeze_flag)
>  		current->flags &= ~PF_NOFREEZE;
>  }
> -- 
> 2.16.2
> 
> 
