Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeCLO2s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:28:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46294 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeCLO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:28:46 -0400
Date: Mon, 12 Mar 2018 15:28:45 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] kernel/rtmutex: Handle non enqueued waiters gracefully in
 remove_waiter()
Message-ID: <20180312142845.m4ohqyg3mak34umf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In -RT task_blocks_on_rt_mutex() may return with -EAGAIN due to
(->pi_blocked_on == PI_WAKEUP_INPROGRESS) before it added itself as a
waiter. In such a case we must not call remove_waiter() because without
a waiter it will trigger the BUG_ON() statement.

This was initially reported by Yimin Deng. Thomas Gleixner fixed it then
with an explicit check for waiters before calling remove_waiter() with
the following note:

| Guard it with rt_mutex_has_waiters(). This is a quick fix which is
| easy to backport. The proper fix is to have a central check in
| remove_waiter() so we can call it unconditionally.

This is the suggested change.
Now that it is possible to call remove_waiter() unconditionally I also
remove that check from rt_mutex_slowlock().

Link: https://lkml.kernel.org/r/CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com
Reported-and-debugged-by: Yimin Deng <yimin11.deng@gmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 65cc0cb984e6..57d28d8f5280 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1068,12 +1068,15 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 static void remove_waiter(struct rt_mutex *lock,
 			  struct rt_mutex_waiter *waiter)
 {
-	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
+	bool is_top_waiter = false;
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock;
 
 	lockdep_assert_held(&lock->wait_lock);
 
+	if (rt_mutex_has_waiters(lock))
+		is_top_waiter = waiter == rt_mutex_top_waiter(lock);
+
 	raw_spin_lock(&current->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
 	current->pi_blocked_on = NULL;
@@ -1268,8 +1271,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 
 	if (unlikely(ret)) {
 		__set_current_state(TASK_RUNNING);
-		if (rt_mutex_has_waiters(lock))
-			remove_waiter(lock, &waiter);
+		remove_waiter(lock, &waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	}
 
-- 
2.16.2
