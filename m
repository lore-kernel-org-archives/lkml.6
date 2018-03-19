Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755321AbeCSHfT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:35:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44985 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCSHfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:35:18 -0400
X-Google-Smtp-Source: AG47ELsHfFtwRON4Mypd3EDA0bdmKS47ZaEInHm0UfL0mA1nAZB7YUNREB7XJImVvmcS5XNqkbEWcw==
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] workqueue: make manage_workers() and pool destruction exclusive
Date: Mon, 19 Mar 2018 15:35:07 +0800
Message-Id: <20180319073508.3100-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code allows destroying the pool when the pool
is still active in manage_workers(). A synchronization
mechanism between manage_workers() and pool destruction
was added for protection.

This patch simply makes manage_workers() and pool destruction
exclusive by getting an indirect refcount of the pool in
manage_workers(). "indirect" means it gets a refcount of
the first involved pwq which holds a refcount of the pool.
This refcount can prevent the pool from being destroyed.

The original synchronization mechanism (wq_manager_wait)
is also removed.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bb9a519cbf50..316dbed5f40c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -300,7 +300,6 @@ static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
 
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
 
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -1980,10 +1979,18 @@ __acquires(&pool->lock)
 static bool manage_workers(struct worker *worker)
 {
 	struct worker_pool *pool = worker->pool;
+	struct pool_workqueue *pwq;
 
 	if (pool->flags & POOL_MANAGER_ACTIVE)
 		return false;
 
+	/*
+	 * Get a refcount of the pwq which holds a refcount of the pool
+	 * to prevent the pool from being destroyed.
+	 */
+	pwq = get_work_pwq(list_first_entry(&pool->worklist,
+				struct work_struct, entry));
+	get_pwq(pwq);
 	pool->flags |= POOL_MANAGER_ACTIVE;
 	pool->manager = worker;
 
@@ -1991,7 +1998,7 @@ static bool manage_workers(struct worker *worker)
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-	wake_up(&wq_manager_wait);
+	put_pwq(pwq);
 	return true;
 }
 
@@ -3295,16 +3302,8 @@ static void put_unbound_pool(struct worker_pool *pool)
 		idr_remove(&worker_pool_idr, pool->id);
 	hash_del(&pool->hash_node);
 
-	/*
-	 * Become the manager and destroy all workers.  This prevents
-	 * @pool's workers from blocking on attach_mutex.  We're the last
-	 * manager and @pool gets freed with the flag set.
-	 */
 	spin_lock_irq(&pool->lock);
-	wait_event_lock_irq(wq_manager_wait,
-			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
-	pool->flags |= POOL_MANAGER_ACTIVE;
-
+	WARN_ON(pool->nr_workers != pool->nr_idle);
 	while ((worker = first_idle_worker(pool)))
 		destroy_worker(worker);
 	WARN_ON(pool->nr_workers || pool->nr_idle);
-- 
2.14.3 (Apple Git-98)
