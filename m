Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDKNrb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:47:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38446 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeDKNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:26 -0400
X-Google-Smtp-Source: AIpwx49dvF2aU7l7MeiPDsDaKQpXNi1JWWvtrnTUv9D5VXmZGIVV6VmJ6dTYU9g+QSDSVSoq8hMfNg==
X-ME-Sender: <xms:6hHOWl2dWO8vl12xTzXUlbmKBTnKp9NyEZFxdQiwux9OoUWAlHCi5w>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 03/20] lockdep: Make __bfs() visit every dependency until a match
Date: Wed, 11 Apr 2018 21:50:53 +0800
Message-Id: <20180411135110.9217-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, __bfs() will do a breadth-first search in the dependency
graph and visit each lock class in the graph exactly once, so for
example, in the following graph:

	A ---------> B
	|            ^
	|            |
	+----------> C

a __bfs() call starts at A, will visit B through dependency A -> B and
visit C through dependency A -> C and that's it, IOW, __bfs() will not
visit dependency C -> B.

This is OK for now, as we only have strong dependencies in the
dependency graph, so whenever there is a traverse path from A to B in
__bfs(), it means A has strong dependency to B (IOW, B depends on A
strongly). So no need to visit all dependencies in the graph.

However, as we are going to add recursive-read lock into the dependency
graph, afterwards, not all the paths mean strong dependencies, in the
same example above, dependency A -> B may be a weak dependency and
traverse A -> C -> B may be a strong dependency path. And with the old
way of __bfs() (i.e. visiting every lock class exactly once), we will
miss the strong dependency path, which will result into failing to find
a deadlock. To cure this for the future, we need to find a way for
__bfs() to visit each dependency, rather than each class, exactly once
in the search until we find a match.

The solution is simple:

We used to mark lock_class::lockdep_dependency_gen_id to indicate a
class has been visited in __bfs(), now we change the semantics a little
bit: we now mark lock_class::lockdep_dependency_gen_id to indicate _all
the dependencies_ in its lock_{after,before} have been visited in the
__bfs() (note we only take one direction in a __bfs() search). In this
way, every dependency is guaranteed to be visited until we find a match.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 61 +++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2dbaff381778..f39a071ef0a8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -948,24 +948,20 @@ static inline unsigned int  __cq_get_elem_count(struct circular_queue *cq)
 	return (cq->rear - cq->front) & CQ_MASK;
 }
 
-static inline void mark_lock_accessed(struct lock_list *lock,
-					struct lock_list *parent)
+static inline void mark_lock_list_accessed(struct lock_class *class)
 {
-	unsigned long nr;
+	class->dep_gen_id = lockdep_dependency_gen_id;
+}
 
-	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+static inline void visit_lock_entry(struct lock_list *lock,
+				    struct lock_list *parent)
+{
 	lock->parent = parent;
-	lock->class->dep_gen_id = lockdep_dependency_gen_id;
 }
 
-static inline unsigned long lock_accessed(struct lock_list *lock)
+static inline unsigned long lock_list_accessed(struct lock_class *class)
 {
-	unsigned long nr;
-
-	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
-	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
+	return class->dep_gen_id == lockdep_dependency_gen_id;
 }
 
 static inline struct lock_list *get_lock_parent(struct lock_list *child)
@@ -1054,6 +1050,18 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 			goto exit;
 		}
 
+		/*
+		 * If we have visited all the dependencies from this @lock to
+		 * others (iow, if we have visited all lock_list entries in
+		 * @lock->class->locks_{after,before}) we skip, otherwise go
+		 * and visit all the dependencies in the list and mark this
+		 * list accessed.
+		 */
+		if (lock_list_accessed(lock->class))
+			continue;
+		else
+			mark_lock_list_accessed(lock->class);
+
 		if (forward)
 			head = &lock->class->locks_after;
 		else
@@ -1062,23 +1070,22 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
 		list_for_each_entry_rcu(entry, head, entry) {
-			if (!lock_accessed(entry)) {
-				unsigned int cq_depth;
-				mark_lock_accessed(entry, lock);
-				if (match(entry, data)) {
-					*target_entry = entry;
-					ret = BFS_RMATCH;
-					goto exit;
-				}
+			unsigned int cq_depth;
 
-				if (__cq_enqueue(cq, (unsigned long)entry)) {
-					ret = BFS_EQUEUEFULL;
-					goto exit;
-				}
-				cq_depth = __cq_get_elem_count(cq);
-				if (max_bfs_queue_depth < cq_depth)
-					max_bfs_queue_depth = cq_depth;
+			visit_lock_entry(entry, lock);
+			if (match(entry, data)) {
+				*target_entry = entry;
+				ret = BFS_RMATCH;
+				goto exit;
+			}
+
+			if (__cq_enqueue(cq, (unsigned long)entry)) {
+				ret = BFS_EQUEUEFULL;
+				goto exit;
 			}
+			cq_depth = __cq_get_elem_count(cq);
+			if (max_bfs_queue_depth < cq_depth)
+				max_bfs_queue_depth = cq_depth;
 		}
 	}
 exit:
-- 
2.16.2
