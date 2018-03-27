Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeC0MOm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:14:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47802 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeC0MOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:14:40 -0400
Date: Tue, 27 Mar 2018 14:14:38 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2] locking/rtmutex: Handle non enqueued waiters gracefully
 in remove_waiter()
Message-ID: <20180327121438.sss7hxg3crqy4ecd@linutronix.de>
References: <20180312142845.m4ohqyg3mak34umf@linutronix.de>
 <20180316122041.GE4064@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1803191611120.2010@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803191611120.2010@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In -RT task_blocks_on_rt_mutex() may return with -EAGAIN due to
(->pi_blocked_on == PI_WAKEUP_INPROGRESS) before it added itself as a
waiter. In such a case we must not call remove_waiter() because without
a waiter it will trigger the BUG_ON() statement.

This was initially reported by Yimin Deng. Thomas Gleixner fixed it then
with an explicit check for waiters before calling remove_waiter().
Instead of an explicit check before calling rt_mutex_top_waiter() we
could make it return NULL if there are no waiters.

Now that it is possible to call remove_waiter() unconditionally I also
remove that check from rt_mutex_slowlock().

Link: https://lkml.kernel.org/CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com
Reported-and-debugged-by: Yimin Deng <yimin11.deng@gmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c        |  3 +--
 kernel/locking/rtmutex_common.h | 11 ++++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 65cc0cb984e6..355716d03b1a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1268,8 +1268,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 
 	if (unlikely(ret)) {
 		__set_current_state(TASK_RUNNING);
-		if (rt_mutex_has_waiters(lock))
-			remove_waiter(lock, &waiter);
+		remove_waiter(lock, &waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	}
 
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 68686b3ec3c1..d1d62f942be2 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -52,12 +52,13 @@ static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
 static inline struct rt_mutex_waiter *
 rt_mutex_top_waiter(struct rt_mutex *lock)
 {
-	struct rt_mutex_waiter *w;
-
-	w = rb_entry(lock->waiters.rb_leftmost,
-		     struct rt_mutex_waiter, tree_entry);
-	BUG_ON(w->lock != lock);
+	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
+	struct rt_mutex_waiter *w = NULL;
 
+	if (leftmost) {
+		w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
+		BUG_ON(w->lock != lock);
+	}
 	return w;
 }
 
-- 
2.16.3
