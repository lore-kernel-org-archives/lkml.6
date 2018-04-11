Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeDKNtY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:49:24 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45960 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeDKNr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:56 -0400
X-Google-Smtp-Source: AIpwx4+Pthq3NVnQYAxnGlxOeP29zwDEPLkf4cVCjUreJEKeP5D9yfPaK9magsrsjq4ekuiao/OnXA==
X-ME-Sender: <xms:CRLOWkWFyNPPm_Lvwv_Ls0KGfi6jqLCVk5cf3m8ClU4AEArQEkizmg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 12/20] lockdep: Add recursive read locks into dependency graph
Date: Wed, 11 Apr 2018 21:51:02 +0800
Message-Id: <20180411135110.9217-13-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have all the fundamental to handle recursive read locks, we now
add them into the dependency graph.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 18eb76189727..45a370438add 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2102,16 +2102,6 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	if (!check_prev_add_irq(curr, prev, next))
 		return 0;
 
-	/*
-	 * For recursive read-locks we do all the dependency checks,
-	 * but we dont store read-triggered dependencies (only
-	 * write-triggered dependencies). This ensures that only the
-	 * write-side dependencies matter, and that if for example a
-	 * write-lock never takes any other locks, then the reads are
-	 * equivalent to a NOP.
-	 */
-	if (next->read == 2 || prev->read == 2)
-		return 1;
 	/*
 	 * Is the <prev> -> <next> dependency already present?
 	 *
@@ -2243,11 +2233,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 		u16 distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
 
-		/*
-		 * Only non-recursive-read entries get new dependencies
-		 * added:
-		 */
-		if (hlock->read != 2 && hlock->check) {
+		if (hlock->check) {
 			int ret = check_prev_add(curr, hlock, next, distance, &trace, save_trace);
 			if (!ret)
 				return 0;
-- 
2.16.2
