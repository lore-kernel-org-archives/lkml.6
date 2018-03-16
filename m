Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeCPMUu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:20:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeCPMUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:20:48 -0400
Date: Fri, 16 Mar 2018 13:20:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernel/rtmutex: Handle non enqueued waiters gracefully
 in remove_waiter()
Message-ID: <20180316122041.GE4064@hirez.programming.kicks-ass.net>
References: <20180312142845.m4ohqyg3mak34umf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312142845.m4ohqyg3mak34umf@linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:28:45PM +0100, Sebastian Andrzej Siewior wrote:
> In -RT task_blocks_on_rt_mutex() may return with -EAGAIN due to
> (->pi_blocked_on == PI_WAKEUP_INPROGRESS) before it added itself as a
> waiter. In such a case we must not call remove_waiter() because without
> a waiter it will trigger the BUG_ON() statement.
> 
> This was initially reported by Yimin Deng. Thomas Gleixner fixed it then
> with an explicit check for waiters before calling remove_waiter() with
> the following note:
> 
> | Guard it with rt_mutex_has_waiters(). This is a quick fix which is
> | easy to backport. The proper fix is to have a central check in
> | remove_waiter() so we can call it unconditionally.
> 
> This is the suggested change.
> Now that it is possible to call remove_waiter() unconditionally I also
> remove that check from rt_mutex_slowlock().
> 
> Link: https://lkml.kernel.org/r/CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com
> Reported-and-debugged-by: Yimin Deng <yimin11.deng@gmail.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/locking/rtmutex.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 65cc0cb984e6..57d28d8f5280 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1068,12 +1068,15 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
>  static void remove_waiter(struct rt_mutex *lock,
>  			  struct rt_mutex_waiter *waiter)
>  {
> -	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));

I'm a little confused, but isn't it easier to make rt_mutex_top_waiter()
return NULL if there aren't in fact any waiters?

diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 68686b3ec3c1..70bcafc385c4 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -52,11 +52,13 @@ static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
 static inline struct rt_mutex_waiter *
 rt_mutex_top_waiter(struct rt_mutex *lock)
 {
-	struct rt_mutex_waiter *w;
+	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
+	struct rt_mutex_waiter *w = NULL;
 
-	w = rb_entry(lock->waiters.rb_leftmost,
-		     struct rt_mutex_waiter, tree_entry);
-	BUG_ON(w->lock != lock);
+	if (leftmost) {
+		w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
+		BUG_ON(w->lock != lock);
+	}
 
 	return w;
 }
