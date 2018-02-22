Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeBVHGQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:06:16 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33318 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeBVHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:14 -0500
X-Google-Smtp-Source: AH8x227rUByaXiDlA3ERdVP1fjxUnwCEZlNCZcrmcjU/m2/UYfprILfTuzUSZ/LRG5z/zJPz+FFPQg==
X-ME-Sender: <xms:4muOWknR-6K6AyUAX8mt4aDyoyjZhLzy4yGFuhva8rmNFoZjz273QQ>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 06/17] lockdep: Support deadlock detection for recursive read in check_noncircular()
Date: Thu, 22 Feb 2018 15:08:53 +0800
Message-Id: <20180222070904.548-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, lockdep only has limit support for deadlock detection for
recursive read locks.

The basic idea of the detection is:

Since we make __bfs() able to traverse only the strong dependency paths,
so we report a circular deadlock if we could find a circle of a strong
dependency path.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 07bcfaac6fe2..e1be088a34c4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1343,6 +1343,14 @@ static inline int class_equal(struct lock_list *entry, void *data)
 	return entry->class == data;
 }
 
+static inline int hlock_conflict(struct lock_list *entry, void *data)
+{
+	struct held_lock *hlock = (struct held_lock *)data;
+
+	return hlock_class(hlock) == entry->class &&
+	       (hlock->read != 2 || !entry->is_rr);
+}
+
 static noinline int print_circular_bug(struct lock_list *this,
 				struct lock_list *target,
 				struct held_lock *check_src,
@@ -1455,18 +1463,18 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 }
 
 /*
- * Prove that the dependency graph starting at <entry> can not
+ * Prove that the dependency graph starting at <root> can not
  * lead to <target>. Print an error and return BFS_RMATCH if it does.
  */
 static noinline enum bfs_result
-check_noncircular(struct lock_list *root, struct lock_class *target,
+check_noncircular(struct lock_list *root, struct held_lock *target,
 		  struct lock_list **target_entry)
 {
 	enum bfs_result result;
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	result = __bfs_forwards(root, target, class_equal, target_entry);
+	result = __bfs_forwards(root, target, hlock_conflict, target_entry);
 
 	return result;
 }
@@ -1994,7 +2002,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * keep the stackframe size of the recursive functions low:
 	 */
 	bfs_init_root(&this, next);
-	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
+	ret = check_noncircular(&this, prev, &target_entry);
 	if (unlikely(ret == BFS_RMATCH)) {
 		if (!trace->entries) {
 			/*
-- 
2.16.1
