Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeEPKf5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:35:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57995 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeEPKfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:35:55 -0400
Date: Wed, 16 May 2018 03:35:24 -0700
From: tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-5a817641f68a6399a5fac8b7d2da67a73698ffed@git.kernel.org>
Cc: willy@infradead.org, amir73il@gmail.com, hpa@zytor.com, jack@suse.cz,
        oleg@redhat.com, akpm@linux-foundation.org, will.deacon@arm.com,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, tglx@linutronix.de,
        dave@stgolabs.net, tytso@mit.edu, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org
Reply-To: longman@redhat.com, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, tytso@mit.edu, peterz@infradead.org,
        dave@stgolabs.net, tglx@linutronix.de, akpm@linux-foundation.org,
        hpa@zytor.com, jack@suse.cz, oleg@redhat.com, willy@infradead.org,
        amir73il@gmail.com, torvalds@linux-foundation.org, will.deacon@arm.com,
        mingo@kernel.org
In-Reply-To: <1526420991-21213-3-git-send-email-longman@redhat.com>
References: <1526420991-21213-3-git-send-email-longman@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
Git-Commit-ID: 5a817641f68a6399a5fac8b7d2da67a73698ffed
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

Commit-ID:  5a817641f68a6399a5fac8b7d2da67a73698ffed
Gitweb:     https://git.kernel.org/tip/5a817641f68a6399a5fac8b7d2da67a73698ffed
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 15 May 2018 17:49:51 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 16 May 2018 11:45:16 +0200

locking/percpu-rwsem: Annotate rwsem ownership transfer by setting RWSEM_OWNER_UNKNOWN

The filesystem freezing code needs to transfer ownership of a rwsem
embedded in a percpu-rwsem from the task that does the freezing to
another one that does the thawing by calling percpu_rwsem_release()
after freezing and percpu_rwsem_acquire() before thawing.

However, the new rwsem debug code runs afoul with this scheme by warning
that the task that releases the rwsem isn't the one that acquires it,
as reported by Amir Goldstein:

  DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
  WARNING: CPU: 1 PID: 1401 at /home/amir/build/src/linux/kernel/locking/rwsem.c:133 up_write+0x59/0x79

  Call Trace:
   percpu_up_write+0x1f/0x28
   thaw_super_locked+0xdf/0x120
   do_vfs_ioctl+0x270/0x5f1
   ksys_ioctl+0x52/0x71
   __x64_sys_ioctl+0x16/0x19
   do_syscall_64+0x5d/0x167
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

To work properly with the rwsem debug code, we need to annotate that the
rwsem ownership is unknown during the tranfer period until a brave soul
comes forward to acquire the ownership. During that period, optimistic
spinning will be disabled.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Tested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-fsdevel@vger.kernel.org
Link: http://lkml.kernel.org/r/1526420991-21213-3-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/percpu-rwsem.h | 6 +++++-
 include/linux/rwsem.h        | 6 ++++++
 kernel/locking/rwsem-xadd.c  | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index b1f37a89e368..79b99d653e03 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -133,7 +133,7 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 	lock_release(&sem->rw_sem.dep_map, 1, ip);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
-		sem->rw_sem.owner = NULL;
+		sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
 #endif
 }
 
@@ -141,6 +141,10 @@ static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
 	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+	if (!read)
+		sem->rw_sem.owner = current;
+#endif
 }
 
 #endif
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 56707d5ff6ad..ab93b6eae696 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -44,6 +44,12 @@ struct rw_semaphore {
 #endif
 };
 
+/*
+ * Setting bit 0 of the owner field with other non-zero bits will indicate
+ * that the rwsem is writer-owned with an unknown owner.
+ */
+#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1L)
+
 extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 604d247ea8c3..a90336779375 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -352,6 +352,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	struct task_struct *owner;
 	bool ret = true;
 
+	BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN));
+
 	if (need_resched())
 		return false;
 
