Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965450AbeEIVOz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 17:14:55 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:39628 "EHLO
        mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964849AbeEIVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 17:14:53 -0400
From: greearb@candelatech.com
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com,
        Ben Greear <greearb@candelatech.com>
Subject: [PATCH] lockdep:  Change __lock_acquire to __lock_acquire_lockdep
Date: Wed,  9 May 2018 14:14:42 -0700
Message-Id: <1525900482-31661-1-git-send-email-greearb@candelatech.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This should make it easier to notice one is using lockdep when
looking at 'perf top' and related output.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 kernel/locking/lockdep.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 89b5f83..818fc8b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3283,10 +3283,13 @@ static int __lock_is_held(const struct lockdep_map *lock, int read);
  * This gets called for every mutex_lock*()/spin_lock*() operation.
  * We maintain the dependency maps and validate the locking attempt:
  */
-static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
-			  int trylock, int read, int check, int hardirqs_off,
-			  struct lockdep_map *nest_lock, unsigned long ip,
-			  int references, int pin_count)
+static int __lock_acquire_lockdep(struct lockdep_map *lock,
+				  unsigned int subclass,
+				  int trylock, int read, int check,
+				  int hardirqs_off,
+				  struct lockdep_map *nest_lock,
+				  unsigned long ip,
+				  int references, int pin_count)
 {
 	struct task_struct *curr = current;
 	struct lock_class *class = NULL;
@@ -3564,13 +3567,14 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
 	struct held_lock *hlock;
 
 	for (hlock = curr->held_locks + idx; idx < depth; idx++, hlock++) {
-		if (!__lock_acquire(hlock->instance,
-				    hlock_class(hlock)->subclass,
-				    hlock->trylock,
-				    hlock->read, hlock->check,
-				    hlock->hardirqs_off,
-				    hlock->nest_lock, hlock->acquire_ip,
-				    hlock->references, hlock->pin_count))
+		if (!__lock_acquire_lockdep(hlock->instance,
+					    hlock_class(hlock)->subclass,
+					    hlock->trylock,
+					    hlock->read, hlock->check,
+					    hlock->hardirqs_off,
+					    hlock->nest_lock, hlock->acquire_ip,
+					    hlock->references,
+					    hlock->pin_count))
 			return 1;
 	}
 	return 0;
@@ -3917,8 +3921,8 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	current->lockdep_recursion = 1;
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
-	__lock_acquire(lock, subclass, trylock, read, check,
-		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
+	__lock_acquire_lockdep(lock, subclass, trylock, read, check,
+			       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 }
-- 
2.4.11
