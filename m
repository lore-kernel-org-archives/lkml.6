Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeEOVuT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:50:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752061AbeEOVuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:50:05 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 2/2] locking/percpu-rwsem: Annotate rwsem ownership transfer by setting RWSEM_OWNER_UNKNOWN
Date: Tue, 15 May 2018 17:49:51 -0400
Message-Id: <1526420991-21213-3-git-send-email-longman@redhat.com>
In-Reply-To: <1526420991-21213-1-git-send-email-longman@redhat.com>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The filesystem freezing code needs to transfer ownership of a rwsem
embedded in a percpu-rwsem from the task that does the freezing to
another one that does the thawing by calling percpu_rwsem_release()
after freezing and percpu_rwsem_acquire() before thawing.

However, the new rwsem debug code runs afoul with this scheme by warning
that the task that releases the rwsem isn't the one that acquires it.

[   20.302978] ------------[ cut here ]------------
[   20.305016] DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
[   20.305029] WARNING: CPU: 1 PID: 1401 at
/home/amir/build/src/linux/kernel/locking/rwsem.c:133 up_write+0x59/0x79
[   20.311252] CPU: 1 PID: 1401 Comm: fsfreeze Not tainted 4.17.0-rc3-xfstests-00049-g39e47bf59eb3 #3276
[   20.314808] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   20.318403] RIP: 0010:up_write+0x59/0x79
[   20.320928] RSP: 0018:ffffc90000717e48 EFLAGS: 00010286
[   20.322955] RAX: 0000000000000030 RBX: ffff880078f1c680 RCX: ffff880078e42200
[   20.325665] RDX: ffffffff810cc9c1 RSI: 0000000000000001 RDI: 0000000000000202
[   20.328844] RBP: ffffc90000717e80 R08: 0000000000000001 R09: 0000000000000001
[   20.332340] R10: ffffc90000717c58 R11: ffffffff836807ad R12: ffff880078f1c388
[   20.335095] R13: ffff880078a8b980 R14: 0000000000000000 R15: 00000000fffffff7
[   20.338009] FS:  00007fb61ca42700(0000) GS:ffff88007f400000(0000) knlGS:0000000000000000
[   20.341423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.343772] CR2: 00007fb61c559b30 CR3: 0000000078da6000 CR4: 00000000000006e0
[   20.346463] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.349201] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   20.351960] Call Trace:
[   20.352911]  percpu_up_write+0x1f/0x28
[   20.354344]  thaw_super_locked+0xdf/0x120
[   20.355944]  do_vfs_ioctl+0x270/0x5f1
[   20.357390]  ? __se_sys_newfstat+0x2e/0x39
[   20.358969]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[   20.360991]  ksys_ioctl+0x52/0x71
[   20.362384]  __x64_sys_ioctl+0x16/0x19
[   20.363702]  do_syscall_64+0x5d/0x167
[   20.365099]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

To work properly with the rwsem debug code, we need to annotate that the
rwsem ownership is unknown during the tranfer period until a brave soul
comes forward to acquire the ownership. During that period, optimistic
spinning will be disabled.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/percpu-rwsem.h | 6 +++++-
 include/linux/rwsem.h        | 6 ++++++
 kernel/locking/rwsem-xadd.c  | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index b1f37a8..79b99d6 100644
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
index 56707d5..ab93b6e 100644
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
index 604d247..a903367 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -352,6 +352,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	struct task_struct *owner;
 	bool ret = true;
 
+	BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN));
+
 	if (need_resched())
 		return false;
 
-- 
1.8.3.1
