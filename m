Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933090AbeCSPLf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:11:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60492 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932496AbeCSPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:11:34 -0400
Date: Mon, 19 Mar 2018 16:11:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/rtmutex: Handle non enqueued waiters gracefully
 in remove_waiter()
In-Reply-To: <20180316122041.GE4064@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1803191611120.2010@nanos.tec.linutronix.de>
References: <20180312142845.m4ohqyg3mak34umf@linutronix.de> <20180316122041.GE4064@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Peter Zijlstra wrote:

> On Mon, Mar 12, 2018 at 03:28:45PM +0100, Sebastian Andrzej Siewior wrote:
> > In -RT task_blocks_on_rt_mutex() may return with -EAGAIN due to
> > (->pi_blocked_on == PI_WAKEUP_INPROGRESS) before it added itself as a
> > waiter. In such a case we must not call remove_waiter() because without
> > a waiter it will trigger the BUG_ON() statement.
> > 
> > This was initially reported by Yimin Deng. Thomas Gleixner fixed it then
> > with an explicit check for waiters before calling remove_waiter() with
> > the following note:
> > 
> > | Guard it with rt_mutex_has_waiters(). This is a quick fix which is
> > | easy to backport. The proper fix is to have a central check in
> > | remove_waiter() so we can call it unconditionally.
> > 
> > This is the suggested change.
> > Now that it is possible to call remove_waiter() unconditionally I also
> > remove that check from rt_mutex_slowlock().
> > 
> > Link: https://lkml.kernel.org/r/CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com
> > Reported-and-debugged-by: Yimin Deng <yimin11.deng@gmail.com>
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/locking/rtmutex.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> > index 65cc0cb984e6..57d28d8f5280 100644
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -1068,12 +1068,15 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
> >  static void remove_waiter(struct rt_mutex *lock,
> >  			  struct rt_mutex_waiter *waiter)
> >  {
> > -	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
> 
> I'm a little confused, but isn't it easier to make rt_mutex_top_waiter()
> return NULL if there aren't in fact any waiters?

That works as well.

Thanks,

	tglx

> diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
> index 68686b3ec3c1..70bcafc385c4 100644
> --- a/kernel/locking/rtmutex_common.h
> +++ b/kernel/locking/rtmutex_common.h
> @@ -52,11 +52,13 @@ static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
>  static inline struct rt_mutex_waiter *
>  rt_mutex_top_waiter(struct rt_mutex *lock)
>  {
> -	struct rt_mutex_waiter *w;
> +	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
> +	struct rt_mutex_waiter *w = NULL;
>  
> -	w = rb_entry(lock->waiters.rb_leftmost,
> -		     struct rt_mutex_waiter, tree_entry);
> -	BUG_ON(w->lock != lock);
> +	if (leftmost) {
> +		w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
> +		BUG_ON(w->lock != lock);
> +	}
>  
>  	return w;
>  }
> 
