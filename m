Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeCYItz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 04:49:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41511 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeCYItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 04:49:52 -0400
X-Google-Smtp-Source: AG47ELunRSF1r4g6Fc5Ujo/PghGLtSpxCgKLLWbHqzKYBJQ4rYAVgGn+rDWNDFVIhWmTNnJ3URmytA==
Date: Sun, 25 Mar 2018 10:49:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: [GIT PULL] locking fixes
Message-ID: <20180325084948.rq3idmeirrlpv4c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: 578ae447e7e5d78c90ac40a06406c1741f79ba96 jump_label: Disable jump labels in __exit code

Two fixes: tighten up a jump-labels warning to not trigger on certain modules and 
fix confusing (and non-existent) mutex API documentation.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      jump_label: Disable jump labels in __exit code

Matthew Wilcox (1):
      locking/mutex: Improve documentation


 include/linux/jump_label.h |  4 ++--
 init/main.c                |  2 +-
 kernel/jump_label.c        |  7 ++++---
 kernel/locking/mutex.c     | 37 ++++++++++++++++++++++++++++++-------
 4 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 2168cc6b8b30..b46b541c67c4 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -151,7 +151,7 @@ extern struct jump_entry __start___jump_table[];
 extern struct jump_entry __stop___jump_table[];
 
 extern void jump_label_init(void);
-extern void jump_label_invalidate_init(void);
+extern void jump_label_invalidate_initmem(void);
 extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
@@ -199,7 +199,7 @@ static __always_inline void jump_label_init(void)
 	static_key_initialized = true;
 }
 
-static inline void jump_label_invalidate_init(void) {}
+static inline void jump_label_invalidate_initmem(void) {}
 
 static __always_inline bool static_key_false(struct static_key *key)
 {
diff --git a/init/main.c b/init/main.c
index 969eaf140ef0..21efbf6ace93 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1001,7 +1001,7 @@ static int __ref kernel_init(void *unused)
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
 	ftrace_free_init_mem();
-	jump_label_invalidate_init();
+	jump_label_invalidate_initmem();
 	free_initmem();
 	mark_readonly();
 	system_state = SYSTEM_RUNNING;
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index e7214093dcd1..01ebdf1f9f40 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -16,6 +16,7 @@
 #include <linux/jump_label_ratelimit.h>
 #include <linux/bug.h>
 #include <linux/cpu.h>
+#include <asm/sections.h>
 
 #ifdef HAVE_JUMP_LABEL
 
@@ -421,15 +422,15 @@ void __init jump_label_init(void)
 	cpus_read_unlock();
 }
 
-/* Disable any jump label entries in __init code */
-void __init jump_label_invalidate_init(void)
+/* Disable any jump label entries in __init/__exit code */
+void __init jump_label_invalidate_initmem(void)
 {
 	struct jump_entry *iter_start = __start___jump_table;
 	struct jump_entry *iter_stop = __stop___jump_table;
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (init_kernel_text(iter->code))
+		if (init_section_contains((void *)(unsigned long)iter->code, 1))
 			iter->code = 0;
 	}
 }
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 858a07590e39..2048359f33d2 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -1082,15 +1082,16 @@ static noinline int __sched
 __mutex_lock_interruptible_slowpath(struct mutex *lock);
 
 /**
- * mutex_lock_interruptible - acquire the mutex, interruptible
- * @lock: the mutex to be acquired
+ * mutex_lock_interruptible() - Acquire the mutex, interruptible by signals.
+ * @lock: The mutex to be acquired.
  *
- * Lock the mutex like mutex_lock(), and return 0 if the mutex has
- * been acquired or sleep until the mutex becomes available. If a
- * signal arrives while waiting for the lock then this function
- * returns -EINTR.
+ * Lock the mutex like mutex_lock().  If a signal is delivered while the
+ * process is sleeping, this function will return without acquiring the
+ * mutex.
  *
- * This function is similar to (but not equivalent to) down_interruptible().
+ * Context: Process context.
+ * Return: 0 if the lock was successfully acquired or %-EINTR if a
+ * signal arrived.
  */
 int __sched mutex_lock_interruptible(struct mutex *lock)
 {
@@ -1104,6 +1105,18 @@ int __sched mutex_lock_interruptible(struct mutex *lock)
 
 EXPORT_SYMBOL(mutex_lock_interruptible);
 
+/**
+ * mutex_lock_killable() - Acquire the mutex, interruptible by fatal signals.
+ * @lock: The mutex to be acquired.
+ *
+ * Lock the mutex like mutex_lock().  If a signal which will be fatal to
+ * the current process is delivered while the process is sleeping, this
+ * function will return without acquiring the mutex.
+ *
+ * Context: Process context.
+ * Return: 0 if the lock was successfully acquired or %-EINTR if a
+ * fatal signal arrived.
+ */
 int __sched mutex_lock_killable(struct mutex *lock)
 {
 	might_sleep();
@@ -1115,6 +1128,16 @@ int __sched mutex_lock_killable(struct mutex *lock)
 }
 EXPORT_SYMBOL(mutex_lock_killable);
 
+/**
+ * mutex_lock_io() - Acquire the mutex and mark the process as waiting for I/O
+ * @lock: The mutex to be acquired.
+ *
+ * Lock the mutex like mutex_lock().  While the task is waiting for this
+ * mutex, it will be accounted as being in the IO wait state by the
+ * scheduler.
+ *
+ * Context: Process context.
+ */
 void __sched mutex_lock_io(struct mutex *lock)
 {
 	int token;
