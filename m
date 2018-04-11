Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbeDKNwj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:52:39 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42131 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeDKNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:52:37 -0400
X-Google-Smtp-Source: AIpwx49fb/osvpKXZ68VbA1D7iDVMpNsLFiyIx4RyA6z63Y6BZ8tGzi3okv3hKaOAHVE6PgiZj+dRw==
X-ME-Sender: <xms:IxPOWrZmcsprWr2pUjy-FW3zN9cqid_JXtlUWp0KwxvhPEsfz6zQ4Q>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC tip/locking/lockdep v6 19/20] rcu: Equip sleepable RCU with lockdep dependency graph checks
Date: Wed, 11 Apr 2018 21:56:44 +0800
Message-Id: <20180411135647.21496-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although all flavors of RCU are annotated correctly with lockdep
annotations as recursive read locks, the 'check' parameter for their
calls to lock_acquire() is unset. Which means RCU read locks are not
added into the lockdep dependency graph. This is fine for all flavors
except sleepable RCU, because the deadlock scenarios for them are
simple: calling synchronize_rcu() and its friends inside their read-side
critical sections. But for sleepable RCU, as there may be multiple
instances with multiple classes, there are more deadlock cases.
Considering the following:

	TASK 1				TASK 2
	=======				========
	i = srcu_read_lock(&sa);	i = srcu_read_lock(&sb);
	synchronize_srcu(&sb);		synchronize_srcu(&sa);
	srcu_read_unlock(&sa);		srcu_read_unlock(&sb);

Neither TASK 1 or 2 could go out of the read-side critical sections,
because they are waiting for each other at synchronize_srcu().

With the new improvement for lockdep, which allows us to detect
deadlocks for recursive read locks, we can actually detect this. What we
need to do are simply: a) mark srcu_read_{,un}lock() as 'check'
lock_acquire() and b) annotate synchronize_srcu() as a empty
grab-and-drop for a write lock (because synchronize_srcu() will wait for
previous srcu_read_lock() to release, and won't block the next
srcu_read_lock(), just like a empty write lock section).

This patch adds those to allow we check deadlocks related to sleepable
RCU with lockdep.

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h  | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/rcu/srcutiny.c |  2 ++
 kernel/rcu/srcutree.c |  2 ++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 33c1c698df09..23f397bd192c 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -99,6 +99,49 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
 	return lock_is_held(&sp->dep_map);
 }
 
+/**
+ * lockdep annotations for srcu_read_{un,}lock, and synchronize_srcu():
+ *
+ * srcu_read_lock() and srcu_read_unlock() are similar to rcu_read_lock() and
+ * rcu_read_unlock(), they are recursive read locks. But we mark them as
+ * "check", they will be added into lockdep dependency graph for deadlock
+ * detection. And we also annotate synchronize_srcu() as a
+ * write_lock()+write_unlock(), because synchronize_srcu() will wait for any
+ * corresponding previous srcu_read_lock() to release, and that acts like a
+ * empty grab-and-drop write lock.
+ *
+ * We do so because multiple sleepable rcu instances may cause deadlock as
+ * follow:
+ *
+ *   Task 1:
+ *     ia = srcu_read_lock(&srcu_A);
+ *     synchronize_srcu(&srcu_B);
+ *     srcu_read_unlock(&srcu_A, ia);
+ *
+ *   Task 2:
+ *     ib = srcu_read_lock(&srcu_B);
+ *     synchronize_srcu(&srcu_A);
+ *     srcu_read_unlock(&srcu_B, ib);
+ *
+ * And we want lockdep to detect this or more complicated deadlock with SRCU
+ * involved.
+ */
+static inline void srcu_lock_acquire(struct lockdep_map *map)
+{
+	lock_map_acquire_read(map);
+}
+
+static inline void srcu_lock_release(struct lockdep_map *map)
+{
+	lock_map_release(map);
+}
+
+static inline void srcu_lock_sync(struct lockdep_map *map)
+{
+	lock_map_acquire(map);
+	lock_map_release(map);
+}
+
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 static inline int srcu_read_lock_held(const struct srcu_struct *sp)
@@ -106,6 +149,10 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
 	return 1;
 }
 
+#define srcu_lock_acquire(m)	do { } while (0)
+#define srcu_lock_release(m)	do { } while (0)
+#define srcu_lock_sync(m)	do { } while (0)
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
@@ -157,7 +204,7 @@ static inline int srcu_read_lock(struct srcu_struct *sp) __acquires(sp)
 	int retval;
 
 	retval = __srcu_read_lock(sp);
-	rcu_lock_acquire(&(sp)->dep_map);
+	srcu_lock_acquire(&(sp)->dep_map);
 	return retval;
 }
 
@@ -171,7 +218,7 @@ static inline int srcu_read_lock(struct srcu_struct *sp) __acquires(sp)
 static inline void srcu_read_unlock(struct srcu_struct *sp, int idx)
 	__releases(sp)
 {
-	rcu_lock_release(&(sp)->dep_map);
+	srcu_lock_release(&(sp)->dep_map);
 	__srcu_read_unlock(sp, idx);
 }
 
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 76ac5f50b2c7..bc89cb48d800 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -188,6 +188,8 @@ void synchronize_srcu(struct srcu_struct *sp)
 {
 	struct rcu_synchronize rs;
 
+	srcu_lock_sync(&sp->dep_map);
+
 	init_rcu_head_on_stack(&rs.head);
 	init_completion(&rs.completion);
 	call_srcu(sp, &rs.head, wakeme_after_rcu);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d5cea81378cc..e2628e9275b9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -997,6 +997,8 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_expedited);
  */
 void synchronize_srcu(struct srcu_struct *sp)
 {
+	srcu_lock_sync(&sp->dep_map);
+
 	if (srcu_might_be_idle(sp) || rcu_gp_is_expedited())
 		synchronize_srcu_expedited(sp);
 	else
-- 
2.16.2
