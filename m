Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966391AbeEYJvs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:51:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33399 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965442AbeEYJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:51:46 -0400
Date: Fri, 25 May 2018 02:51:16 -0700
From: tip-bot for Oleg Nesterov <tipbot@zytor.com>
Message-ID: <tip-1b22fc609cecd1b16c4a015e1a6b3c9717484e3a@git.kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, amir73il@gmail.com, tytso@mit.edu, willy@infradead.org,
        torvalds@linux-foundation.org, longman@redhat.com, dave@stgolabs.net,
        jack@suse.cz, oleg@redhat.com, mingo@kernel.org
Reply-To: tytso@mit.edu, amir73il@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, dave@stgolabs.net, oleg@redhat.com, jack@suse.cz,
        longman@redhat.com, torvalds@linux-foundation.org, willy@infradead.org
In-Reply-To: <20180518165534.GA22348@redhat.com>
References: <20180518165534.GA22348@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Simplify the is-owner-spinnable
 checks
Git-Commit-ID: 1b22fc609cecd1b16c4a015e1a6b3c9717484e3a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1b22fc609cecd1b16c4a015e1a6b3c9717484e3a
Gitweb:     https://git.kernel.org/tip/1b22fc609cecd1b16c4a015e1a6b3c9717484e3a
Author:     Oleg Nesterov <oleg@redhat.com>
AuthorDate: Fri, 18 May 2018 18:55:35 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 25 May 2018 08:11:47 +0200

locking/rwsem: Simplify the is-owner-spinnable checks

Add the trivial owner_on_cpu() helper for rwsem_can_spin_on_owner() and
rwsem_spin_on_owner(), it also allows to make rwsem_can_spin_on_owner()
a bit more clear.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180518165534.GA22348@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index a90336779375..3064c50e181e 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -347,6 +347,15 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 	}
 }
 
+static inline bool owner_on_cpu(struct task_struct *owner)
+{
+	/*
+	 * As lock holder preemption issue, we both skip spinning if
+	 * task is not on cpu or its cpu is preempted
+	 */
+	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+}
+
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner;
@@ -359,17 +368,10 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	rcu_read_lock();
 	owner = READ_ONCE(sem->owner);
-	if (!owner || !is_rwsem_owner_spinnable(owner)) {
-		ret = !owner;	/* !owner is spinnable */
-		goto done;
+	if (owner) {
+		ret = is_rwsem_owner_spinnable(owner) &&
+		      owner_on_cpu(owner);
 	}
-
-	/*
-	 * As lock holder preemption issue, we both skip spinning if task is not
-	 * on cpu or its cpu is preempted
-	 */
-	ret = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
-done:
 	rcu_read_unlock();
 	return ret;
 }
@@ -398,8 +400,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 * abort spinning when need_resched or owner is not running or
 		 * owner's cpu is preempted.
 		 */
-		if (!owner->on_cpu || need_resched() ||
-				vcpu_is_preempted(task_cpu(owner))) {
+		if (need_resched() || !owner_on_cpu(owner)) {
 			rcu_read_unlock();
 			return false;
 		}
