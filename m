Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeBVHGX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:06:23 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52645 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbeBVHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:18 -0500
X-Google-Smtp-Source: AH8x224GSmaiSVOsFSzAI3Gh8uRqeWhIK76ETY86JWrg86DpFwgnI8dfj7Du3k4pgSTgthYnsrVl0w==
X-ME-Sender: <xms:52uOWukfiO-2dtwwxwDDx_Q3-7NC43wQDcwpQcMsjV9qMo3j5FGZEw>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 07/17] lockdep: Adjust check_redundant() for recursive read change
Date: Thu, 22 Feb 2018 15:08:54 +0800
Message-Id: <20180222070904.548-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have four kinds of dependencies now, check_redundant() should only
report redundant if we have a dependency path which is equal or
_stronger_ than the current dependency. For example if in
check_prev_add() we have:

	prev->read == 2 && next->read != 2

, we should only report redundant if we find a path like:

	prev--(RN)-->....--(*N)-->next

and if we have:

	prev->read == 2 && next->read == 2

, we could report redundant if we find a path like:

	prev--(RN)-->....--(*N)-->next

or

	prev--(RN)-->....--(*R)-->next

To do so, we need to pass the recursive-read status of @next into
check_redundant(). This patch changes the parameter of check_redundant()
and the match function to achieve this.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e1be088a34c4..0b0ad3db78b4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1338,9 +1338,12 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 	return 0;
 }
 
-static inline int class_equal(struct lock_list *entry, void *data)
+static inline int hlock_equal(struct lock_list *entry, void *data)
 {
-	return entry->class == data;
+	struct held_lock *hlock = (struct held_lock *)data;
+
+	return hlock_class(hlock) == entry->class &&
+	       (hlock->read == 2 || !entry->is_rr);
 }
 
 static inline int hlock_conflict(struct lock_list *entry, void *data)
@@ -1480,14 +1483,14 @@ check_noncircular(struct lock_list *root, struct held_lock *target,
 }
 
 static noinline enum bfs_result
-check_redundant(struct lock_list *root, struct lock_class *target,
+check_redundant(struct lock_list *root, struct held_lock *target,
 		struct lock_list **target_entry)
 {
 	enum bfs_result result;
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	result = __bfs_forwards(root, target, class_equal, target_entry);
+	result = __bfs_forwards(root, target, hlock_equal, target_entry);
 
 	return result;
 }
@@ -2060,7 +2063,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * Is the <prev> -> <next> link redundant?
 	 */
 	bfs_init_root(&this, prev);
-	ret = check_redundant(&this, hlock_class(next), &target_entry);
+	ret = check_redundant(&this, next, &target_entry);
 	if (ret == BFS_RMATCH) {
 		debug_atomic_inc(nr_redundant);
 		return 2;
-- 
2.16.1
