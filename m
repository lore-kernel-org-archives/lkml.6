Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeC1VHq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:07:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeC1VHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:07:45 -0400
Date: Wed, 28 Mar 2018 14:07:07 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-c28d62cf52d791ba5f6db7ce525ed06b86291c82@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, yimin11.deng@gmail.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        bigeasy@linutronix.de
Reply-To: hpa@zytor.com, bigeasy@linutronix.de, yimin11.deng@gmail.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
In-Reply-To: <20180327121438.sss7hxg3crqy4ecd@linutronix.de>
References: <CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com>
        <20180327121438.sss7hxg3crqy4ecd@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rtmutex: Handle non enqueued waiters
 gracefully in remove_waiter()
Git-Commit-ID: c28d62cf52d791ba5f6db7ce525ed06b86291c82
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c28d62cf52d791ba5f6db7ce525ed06b86291c82
Gitweb:     https://git.kernel.org/tip/c28d62cf52d791ba5f6db7ce525ed06b86291c82
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 27 Mar 2018 14:14:38 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Mar 2018 23:01:30 +0200

locking/rtmutex: Handle non enqueued waiters gracefully in remove_waiter()

In -RT task_blocks_on_rt_mutex() may return with -EAGAIN due to
(->pi_blocked_on == PI_WAKEUP_INPROGRESS) before it added itself as a
waiter. In such a case remove_waiter() must not be called because without a
waiter it will trigger the BUG_ON() statement.

This was initially reported by Yimin Deng. Thomas Gleixner fixed it then
with an explicit check for waiters before calling remove_waiter().

Instead of an explicit NULL check before calling rt_mutex_top_waiter() make
the function return NULL if there are no waiters. With that fixed the now
pointless NULL check is removed from rt_mutex_slowlock().

Reported-and-debugged-by: Yimin Deng <yimin11.deng@gmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com
Link: https://lkml.kernel.org/r/20180327121438.sss7hxg3crqy4ecd@linutronix.de
---
 kernel/locking/rtmutex.c        |  3 +--
 kernel/locking/rtmutex_common.h | 11 ++++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 940633c63254..4f014be7a4b8 100644
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
 
