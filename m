Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeBVHJ2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:09:28 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52595 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbeBVHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:06 -0500
X-Google-Smtp-Source: AH8x225murhvrkcfSl8j/ooUoahoVKrOSAsR13Dgw8pmk4mrje6nAA+4Fg3IjkiVcKIv9m3ophhk1Q==
X-ME-Sender: <xms:22uOWjOVR16h1iry52-IFY4KeSvZnnRH30THWryzF8Fq0DVO29quIQ>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 04/17] lockdep: Introduce lock_list::dep
Date: Thu, 22 Feb 2018 15:08:51 +0800
Message-Id: <20180222070904.548-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To add recursive read locks into the dependency graph, we need to store
the types of dependencies for the BFS later. There are four kinds of
dependencies:

*	Non-recursive -> Non-recursive dependencies(NN)
	e.g. write_lock(prev) -> write_lock(next), we can also write
	this as "prev --(NN)--> next".

*	Recursive -> Non-recursive dependencies(RN)
	e.g. read_lock(prev) -> write_lock(next), we can also write this
	as "prev --(RN)--> next".

*	Non-recursive -> recursive dependencies(NR)
	e.g. write_lock(prev) -> read_lock(next), we can also write this
	as "prev --(NR)--> next".

*	Recursive -> recursive dependencies(RR)
	e.g. read_lock(prev) -> read_lock(next), we can also write this
	as "prev --(RR)--> next".

Given a pair of two locks, four kinds of dependencies could all exist
between them, so we use 4 bit for the presence of each kind(stored in
lock_list::dep). Helper functions and marcos are also introduced to
convert a pair of locks into ::dep bit and maintain the addition of
different kinds of dependencies.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |  2 ++
 kernel/locking/lockdep.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6fc77d4dbdcd..ab1e5a7d8864 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -187,6 +187,8 @@ struct lock_list {
 	struct lock_class		*class;
 	struct stack_trace		trace;
 	int				distance;
+	/* bitmap of different dependencies from head to this */
+	u16				dep;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5e6bf8d6954d..acd25bfc336d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -859,7 +859,7 @@ static struct lock_list *alloc_list_entry(void)
  * Add a new dependency to the head of the list:
  */
 static int add_lock_to_list(struct lock_class *this, struct list_head *head,
-			    unsigned long ip, int distance,
+			    unsigned long ip, int distance, unsigned int dep,
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
@@ -1012,6 +1013,33 @@ static inline bool bfs_error(enum bfs_result res)
 	return res < 0;
 }
 
+#define DEP_NN_BIT 0
+#define DEP_RN_BIT 1
+#define DEP_NR_BIT 2
+#define DEP_RR_BIT 3
+
+#define DEP_NN_MASK (1U << (DEP_NN_BIT))
+#define DEP_RN_MASK (1U << (DEP_RN_BIT))
+#define DEP_NR_MASK (1U << (DEP_NR_BIT))
+#define DEP_RR_MASK (1U << (DEP_RR_BIT))
+
+static inline unsigned int __calc_dep_bit(int prev, int next)
+{
+	if (prev == 2 && next != 2)
+		return DEP_RN_BIT;
+	if (prev != 2 && next == 2)
+		return DEP_NR_BIT;
+	if (prev == 2 && next == 2)
+		return DEP_RR_BIT;
+	else
+		return DEP_NN_BIT;
+}
+
+static inline unsigned int calc_dep(int prev, int next)
+{
+	return 1U << __calc_dep_bit(prev, next);
+}
+
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
 			     int (*match)(struct lock_list *entry, void *data),
@@ -1921,6 +1949,16 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		if (entry->class == hlock_class(next)) {
 			if (distance == 1)
 				entry->distance = 1;
+			entry->dep |= calc_dep(prev->read, next->read);
+		}
+	}
+
+	/* Also, update the reverse dependency in @next's ->locks_before list */
+	list_for_each_entry(entry, &hlock_class(next)->locks_before, entry) {
+		if (entry->class == hlock_class(prev)) {
+			if (distance == 1)
+				entry->distance = 1;
+			entry->dep |= calc_dep(next->read, prev->read);
 			return 1;
 		}
 	}
@@ -1948,14 +1986,18 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 */
 	ret = add_lock_to_list(hlock_class(next),
 			       &hlock_class(prev)->locks_after,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance,
+			       calc_dep(prev->read, next->read),
+			       trace);
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev),
 			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance,
+			       calc_dep(next->read, prev->read),
+			       trace);
 	if (!ret)
 		return 0;
 
-- 
2.16.1
