Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeCaIAP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 04:00:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeCaIAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 04:00:13 -0400
Date: Sat, 31 Mar 2018 00:59:18 -0700
From: tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-5149cbac4235e12a34cf089592a8bd1c9fcfa467@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, longman@redhat.com, dave@stgolabs.net,
        akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, longman@redhat.com, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com
In-Reply-To: <1522445280-7767-2-git-send-email-longman@redhat.com>
References: <1522445280-7767-2-git-send-email-longman@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Add DEBUG_RWSEMS to look for
 lock/unlock mismatches
Git-Commit-ID: 5149cbac4235e12a34cf089592a8bd1c9fcfa467
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

Commit-ID:  5149cbac4235e12a34cf089592a8bd1c9fcfa467
Gitweb:     https://git.kernel.org/tip/5149cbac4235e12a34cf089592a8bd1c9fcfa467
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Fri, 30 Mar 2018 17:27:58 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 31 Mar 2018 07:30:50 +0200

locking/rwsem: Add DEBUG_RWSEMS to look for lock/unlock mismatches

For a rwsem, locking can either be exclusive or shared. The corresponding
exclusive or shared unlock must be used. Otherwise, the protected data
structures may get corrupted or the lock may be in an inconsistent state.

In order to detect such anomaly, a new configuration option DEBUG_RWSEMS
is added which can be enabled to look for such mismatches and print
warnings that that happens.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1522445280-7767-2-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.c | 4 ++++
 kernel/locking/rwsem.h | 8 +++++++-
 lib/Kconfig.debug      | 8 ++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f549c552dbf1..30465a2f2b6c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -117,6 +117,7 @@ EXPORT_SYMBOL(down_write_trylock);
 void up_read(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != RWSEM_READER_OWNED);
 
 	__up_read(sem);
 }
@@ -129,6 +130,7 @@ EXPORT_SYMBOL(up_read);
 void up_write(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
 	rwsem_clear_owner(sem);
 	__up_write(sem);
@@ -142,6 +144,7 @@ EXPORT_SYMBOL(up_write);
 void downgrade_write(struct rw_semaphore *sem)
 {
 	lock_downgrade(&sem->dep_map, _RET_IP_);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
 	rwsem_set_reader_owned(sem);
 	__downgrade_write(sem);
@@ -211,6 +214,7 @@ EXPORT_SYMBOL(down_write_killable_nested);
 
 void up_read_non_owner(struct rw_semaphore *sem)
 {
+	DEBUG_RWSEMS_WARN_ON(sem->owner != RWSEM_READER_OWNED);
 	__up_read(sem);
 }
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index a883b8f1fdc6..a17cba8d94bb 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -16,6 +16,12 @@
  */
 #define RWSEM_READER_OWNED	((struct task_struct *)1UL)
 
+#ifdef CONFIG_DEBUG_RWSEMS
+# define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
+#else
+# define DEBUG_RWSEMS_WARN_ON(c)
+#endif
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -41,7 +47,7 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 	 * do a write to the rwsem cacheline when it is really necessary
 	 * to minimize cacheline contention.
 	 */
-	if (sem->owner != RWSEM_READER_OWNED)
+	if (READ_ONCE(sem->owner) != RWSEM_READER_OWNED)
 		WRITE_ONCE(sem->owner, RWSEM_READER_OWNED);
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 64155e310a9f..88650ab5cedb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1075,6 +1075,13 @@ config DEBUG_WW_MUTEX_SLOWPATH
 	 even a debug kernel.  If you are a driver writer, enable it.  If
 	 you are a distro, do not.
 
+config DEBUG_RWSEMS
+	bool "RW Semaphore debugging: basic checks"
+	depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
+	help
+	  This debugging feature allows mismatched rw semaphore locks and unlocks
+	  to be detected and reported.
+
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
@@ -1097,6 +1104,7 @@ config PROVE_LOCKING
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
+	select DEBUG_RWSEMS if RWSEM_SPIN_ON_OWNER
 	select DEBUG_LOCK_ALLOC
 	select TRACE_IRQFLAGS
 	default n
