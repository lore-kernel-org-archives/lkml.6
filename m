Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDKNrj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:47:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36719 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbeDKNrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:36 -0400
X-Google-Smtp-Source: AIpwx491SN2LmJ4gElXlkYLG4y/XcUytX/AM4SqLYgxiOEezU2HA3E8t8ndjxkqlCM/UYy3PzM80HA==
X-ME-Sender: <xms:9BHOWguYacgEVfDDqR3LoSfBln2gUAOuRpuZ0dBd7f6HJYvSWEGMeg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 06/20] lockdep: Introduce lock_list::dep
Date: Wed, 11 Apr 2018 21:50:56 +0800
Message-Id: <20180411135110.9217-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To add recursive read locks into the dependency graph, we need to store
the types of dependencies for the BFS later. There are four types of
dependencies:

*	Non-recursive -> Non-recursive dependencies: NN
	e.g. write_lock(prev) held and try to acquire write_lock(next),
	which can be represented as "prev -(NN)-> next".

*	Recursive -> Non-recursive dependencies: RN
	e.g. read_lock(prev) held and try to acquire write_lock(next),
	which can be represented as "prev -(RN)-> next".

*	Non-recursive -> recursive dependencies: NR
	e.g. write_lock(prev) held and try to acquire read_lock(next),
	which can be represented as "prev -(NR)-> next".

*	Recursive -> recursive dependencies: RR
	e.g. read_lock(prev) held and try to acquire read_lock(next),
	which can be represented as "prev -(RR)-> next".

So we use 4 bits for the presence of each type in lock_list::dep. Helper
functions and marcos are also introduced to convert a pair of locks into
lock_list::dep bit and maintain the addition of different types of
dependencies.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |  2 ++
 kernel/locking/lockdep.c | 76 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index d2af32387aaa..cbd257f62877 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -187,6 +187,8 @@ struct lock_list {
 	struct lock_class		*class;
 	struct stack_trace		trace;
 	u16				distance;
+	/* bitmap of different dependencies from head to this */
+	u8				dep;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1806060c88ce..0892855b6c57 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -859,7 +859,7 @@ static struct lock_list *alloc_list_entry(void)
  * Add a new dependency to the head of the list:
  */
 static int add_lock_to_list(struct lock_class *this, struct list_head *head,
-			    unsigned long ip, u16 distance,
+			    unsigned long ip, u16 distance, u8 dep,
 			    struct stack_trace *trace)
 {
 	struct lock_list *entry;
@@ -872,6 +872,7 @@ static int add_lock_to_list(struct lock_class *this, struct list_head *head,
 		return 0;
 
 	entry->class = this;
+	entry->dep = dep;
 	entry->distance = distance;
 	entry->trace = *trace;
 	/*
@@ -1012,6 +1013,41 @@ static inline bool bfs_error(enum bfs_result res)
 	return res < 0;
 }
 
+/*
+ * DEP_*_BIT in lock_list::dep
+ *
+ * For dependency @prev -> @next:
+ *
+ *   RR: both @prev and @next are recursive read locks, i.e. ->read == 2.
+ *   NR: @prev is a non-recursive and @next is recursive.
+ *   RN: @prev is recursive and @next is non-recursive.
+ *   NN: both @prev and @next are non-recursive.
+ *
+ * Note that we define the value of DEP_*_BITs so that:
+ *   bit0 is prev->read != 2
+ *   bit1 is next->read != 2
+ */
+#define DEP_RR_BIT (0 + (0 << 1)) /* 0 */
+#define DEP_NR_BIT (1 + (0 << 1)) /* 1 */
+#define DEP_RN_BIT (0 + (1 << 1)) /* 2 */
+#define DEP_NN_BIT (1 + (1 << 1)) /* 3 */
+
+#define DEP_RR_MASK (1U << (DEP_RR_BIT))
+#define DEP_NR_MASK (1U << (DEP_NR_BIT))
+#define DEP_RN_MASK (1U << (DEP_RN_BIT))
+#define DEP_NN_MASK (1U << (DEP_NN_BIT))
+
+static inline unsigned int
+__calc_dep_bit(struct held_lock *prev, struct held_lock *next)
+{
+	return (prev->read != 2) + ((next->read != 2) << 1);
+}
+
+static inline u8 calc_dep(struct held_lock *prev, struct held_lock *next)
+{
+	return 1U << __calc_dep_bit(prev, next);
+}
+
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
 			     int (*match)(struct lock_list *entry, void *data),
@@ -1921,7 +1957,35 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		if (entry->class == hlock_class(next)) {
 			if (distance == 1)
 				entry->distance = 1;
-			return 1;
+			entry->dep |= calc_dep(prev, next);
+
+			/*
+			 * Also, update the reverse dependency in @next's
+			 * ->locks_before list.
+			 *
+			 *  Here we reuse @entry as the cursor, which is fine
+			 *  because we won't go to the next iteration of the
+			 *  outer loop:
+			 *
+			 *  For normal cases, we return in the inner loop.
+			 *
+			 *  If we fail to return, we have inconsistency, i.e.
+			 *  <prev>::locks_after contains <next> while
+			 *  <next>::locks_before doesn't contain <prev>. In
+			 *  that case, we return after the inner and indicate
+			 *  something is wrong.
+			 */
+			list_for_each_entry(entry, &hlock_class(next)->locks_before, entry) {
+				if (entry->class == hlock_class(prev)) {
+					if (distance == 1)
+						entry->distance = 1;
+					entry->dep |= calc_dep(next, prev);
+					return 1;
+				}
+			}
+
+			/* <prev> is not found in <next>::locks_before */
+			return 0;
 		}
 	}
 
@@ -1948,14 +2012,18 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 */
 	ret = add_lock_to_list(hlock_class(next),
 			       &hlock_class(prev)->locks_after,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance,
+			       calc_dep(prev, next),
+			       trace);
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev),
 			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance,
+			       calc_dep(next, prev),
+			       trace);
 	if (!ret)
 		return 0;
 
-- 
2.16.2
