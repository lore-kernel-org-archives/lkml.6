Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeDKNuu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:50:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32883 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeDKNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:33 -0400
X-Google-Smtp-Source: AIpwx49zPaOk8O5Wy6yuN1BDKhi1ElkKJtAr6lcxRvYDbC1TGeRzmzURN+R0+qEtVQECoRNgBOg4Vw==
X-ME-Sender: <xms:8RHOWpYU2ib1CmWqHptS8Lb-lKlql2wb-t3LXK7YPwASKCvgctVJPQ>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 05/20] lockdep: Reduce the size of lock_list::distance
Date: Wed, 11 Apr 2018 21:50:55 +0800
Message-Id: <20180411135110.9217-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lock_list::distance is always not greater than MAX_LOCKDEP_DEPTH (which
is 48 right now), so a u16 will fit. This patch reduces the size of
lock_list::distance to save space, so that we can introduce other fields
to help detect recursive read lock deadlocks without increasing the size
of lock_list structure.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  | 2 +-
 kernel/locking/lockdep.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6fc77d4dbdcd..d2af32387aaa 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -186,7 +186,7 @@ struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
 	struct stack_trace		trace;
-	int				distance;
+	u16				distance;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 14af2327b52a..1806060c88ce 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -859,7 +859,7 @@ static struct lock_list *alloc_list_entry(void)
  * Add a new dependency to the head of the list:
  */
 static int add_lock_to_list(struct lock_class *this, struct list_head *head,
-			    unsigned long ip, int distance,
+			    unsigned long ip, u16 distance,
 			    struct stack_trace *trace)
 {
 	struct lock_list *entry;
@@ -1996,7 +1996,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 		goto out_bug;
 
 	for (;;) {
-		int distance = curr->lockdep_depth - depth + 1;
+		u16 distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
 
 		/*
-- 
2.16.2
