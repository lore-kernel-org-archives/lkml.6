Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeBVHG5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:06:57 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34999 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeBVHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:54 -0500
X-Google-Smtp-Source: AH8x225j5QwxmbnlQXp3S87t3myadbWX+QafzCaLh5QvVQtMKJHJhZVAn6vWaOyuMaYgf33yPegfHg==
X-ME-Sender: <xms:CmyOWjW_IDER1j9fPsdKt-qw3ZccnPxBfCMFINdUwAUHQjuDSuA1sQ>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 15/17] lockdep: Reduce the size of lock_list
Date: Thu, 22 Feb 2018 15:09:02 +0800
Message-Id: <20180222070904.548-16-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We actually only need 4 bits for lock_list::dep and 1 bit for
lock_list::is_rr, besides lock_list::distance should always be no
greater than MAX_LOCKDEP_DEPTH(which is 48 right now), so a u16 will
fit, this patch then reduces the sizes of those fields to save space for
lock_list structure, as a result we can reduce the size increment
introduced by recursive read lock detection and keep the lock_list the
same size as before.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |  6 +++---
 kernel/locking/lockdep.c | 11 ++++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a1f91f8680bd..3fce8dbf5091 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -186,11 +186,11 @@ struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
 	struct stack_trace		trace;
-	int				distance;
+	u16				distance;
 	/* bitmap of different dependencies from head to this */
-	u16				dep;
+	u8				dep;
 	/* used by BFS to record whether this is picked as a recursive read */
-	u16				is_rr;
+	bool				is_rr;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1b981dc4c061..e8b83b36669c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -874,7 +874,7 @@ static struct lock_list *alloc_list_entry(void)
  * Add a new dependency to the head of the list:
  */
 static int add_lock_to_list(struct lock_class *this, struct list_head *head,
-			    unsigned long ip, int distance, unsigned int dep,
+			    unsigned long ip, u16 distance, unsigned int dep,
 			    struct stack_trace *trace)
 {
 	struct lock_list *entry;
@@ -1063,7 +1063,7 @@ static inline unsigned int calc_dep(int prev, int next)
  * N: non-recursive lock
  * R: recursive read lock
  */
-static inline int pick_dep(u16 is_rr, u16 cap_dep)
+static inline int pick_dep(bool is_rr, u8 cap_dep)
 {
 	if (is_rr) { /* could only pick -(N*)-> */
 		if (cap_dep & DEP_NN_MASK)
@@ -1148,7 +1148,8 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
 	enum bfs_result ret = BFS_RNOMATCH;
-	int is_rr, next_is_rr;
+	bool is_rr;
+	int next_is_rr;
 
 	if (match(source_entry, data)) {
 		*target_entry = source_entry;
@@ -1204,7 +1205,7 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 			next_is_rr = pick_dep(is_rr, entry->dep);
 			if (next_is_rr < 0)
 				continue;
-			entry->is_rr = next_is_rr;
+			entry->is_rr = !!next_is_rr;
 
 			visit_lock_entry(entry, lock);
 			if (match(entry, data)) {
@@ -2153,7 +2154,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 		goto out_bug;
 
 	for (;;) {
-		int distance = curr->lockdep_depth - depth + 1;
+		u16 distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
 
 		if (hlock->check) {
-- 
2.16.1
