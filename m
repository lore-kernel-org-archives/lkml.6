Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeDKNrr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:47:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44667 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeDKNrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:43 -0400
X-Google-Smtp-Source: AIpwx49TsR2FYjMoOIoN4ZWBNBXdVBn8R0TAmnTocSIYexk/1h7ZKNsEBB7maGjs5sLgfX/SNoQBMg==
X-ME-Sender: <xms:-xHOWqTYtOR0hit8iFprNvyCiiwsR7GPnd9N5Ih_5KSbFcCsBx3d7g>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 08/20] lockdep: Make __bfs(.match) return bool
Date: Wed, 11 Apr 2018 21:50:58 +0800
Message-Id: <20180411135110.9217-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "match" parameter of __bfs() is used for checking whether we hit a
match in the search, therefore it should return a boolean value rather
than an integer for better readability.

This patch then changes the return type of the function parameter and the
match functions to bool.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 53ce81e8a6a9..df1637db923a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1109,7 +1109,7 @@ static inline void bfs_init_root(struct lock_list *lock,
  */
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
-			     int (*match)(struct lock_list *entry, void *data),
+			     bool (*match)(struct lock_list *entry, void *data),
 			     struct lock_list **target_entry,
 			     int forward)
 {
@@ -1209,7 +1209,7 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 static inline enum bfs_result
 __bfs_forwards(struct lock_list *src_entry,
 	       void *data,
-	       int (*match)(struct lock_list *entry, void *data),
+	       bool (*match)(struct lock_list *entry, void *data),
 	       struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry, 1);
@@ -1219,7 +1219,7 @@ __bfs_forwards(struct lock_list *src_entry,
 static inline enum bfs_result
 __bfs_backwards(struct lock_list *src_entry,
 		void *data,
-		int (*match)(struct lock_list *entry, void *data),
+		bool (*match)(struct lock_list *entry, void *data),
 		struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry, 0);
@@ -1333,7 +1333,7 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 	return 0;
 }
 
-static inline int class_equal(struct lock_list *entry, void *data)
+static inline bool class_equal(struct lock_list *entry, void *data)
 {
 	return entry->class == data;
 }
@@ -1392,10 +1392,10 @@ static noinline int print_bfs_bug(int ret)
 	return 0;
 }
 
-static int noop_count(struct lock_list *entry, void *data)
+static bool noop_count(struct lock_list *entry, void *data)
 {
 	(*(unsigned long *)data)++;
-	return 0;
+	return false;
 }
 
 static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
@@ -1486,7 +1486,7 @@ check_redundant(struct lock_list *root, struct lock_class *target,
  * without creating any illegal irq-safe -> irq-unsafe lock dependency.
  */
 
-static inline int usage_match(struct lock_list *entry, void *bit)
+static inline bool usage_match(struct lock_list *entry, void *bit)
 {
 	return entry->class->usage_mask & (1 << (enum lock_usage_bit)bit);
 }
-- 
2.16.2
