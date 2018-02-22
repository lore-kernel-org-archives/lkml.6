Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeBVHGb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:06:31 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56043 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeBVHG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:27 -0500
X-Google-Smtp-Source: AH8x227ay375DxmxUyZ6R0ChbSkIRRqdvctnfW92+ULyJxvvoRk62gKDIjFHuIFCYNNXoEt+8Ilv1w==
X-ME-Sender: <xms:8GuOWjJFXMsJkIdhsEiAGfbffHrnKmuqvXZ6gX2_7qhVAIFtwhPAFA>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 09/17] lockdep: Add recursive read locks into dependency graph
Date: Thu, 22 Feb 2018 15:08:56 +0800
Message-Id: <20180222070904.548-10-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
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
index bd3eef664f9d..254f90bade54 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2038,16 +2038,6 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
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
@@ -2151,11 +2141,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 		int distance = curr->lockdep_depth - depth + 1;
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
2.16.1
