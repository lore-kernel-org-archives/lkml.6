Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeDJRWq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:22:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751367AbeDJRWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:22:45 -0400
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/rwsem: Synchronize task state & waiter->task of readers
Date: Tue, 10 Apr 2018 13:22:18 -0400
Message-Id: <1523380938-19462-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was observed occasionally in PowerPC systems that there was reader
who had not been woken up but that its waiter->task had been cleared.

One probable cause of this missed wakeup may be the fact that the
waiter->task and the task state have not been properly synchronized as
the lock release-acquire pair of different locks in the wakeup code path
does not provide a full memory barrier guarantee. So smp_store_mb()
is now used to set waiter->task to NULL to provide a proper memory
barrier for synchronization.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index e795908..b3c588c 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -209,6 +209,23 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		smp_store_release(&waiter->task, NULL);
 	}
 
+	/*
+	 * To avoid missed wakeup of reader, we need to make sure
+	 * that task state and waiter->task are properly synchronized.
+	 *
+	 *     wakeup		      sleep
+	 *     ------		      -----
+	 * __rwsem_mark_wake:	rwsem_down_read_failed*:
+	 *   [S] waiter->task	  [S] set_current_state(state)
+	 *	 MB		      MB
+	 * try_to_wake_up:
+	 *   [L] state		  [L] waiter->task
+	 *
+	 * For the wakeup path, the original lock release-acquire pair
+	 * does not provide enough guarantee of proper synchronization.
+	 */
+	smp_mb();
+
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
 	if (list_empty(&sem->wait_list)) {
 		/* hit end of list above */
-- 
1.8.3.1
