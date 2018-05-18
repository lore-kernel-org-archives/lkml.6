Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeERHyz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:54:55 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44440 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeERHt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:49:59 -0400
X-Google-Smtp-Source: AB8JxZqQ2AFoSAUplCmErIoOaoUPHdIyTR/anMQETPE59PqhZWJv8knYU27R4/jTSNtVSdoG0WNFhQ==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 03/10] locking: bring back lglocks
Date: Fri, 18 May 2018 03:49:04 -0400
Message-Id: <20180518074918.13816-7-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcachefs makes use of them - also, add a proper lg_lock_init()

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/lglock.h  |  97 +++++++++++++++++++++++++++++++++++++
 kernel/locking/Makefile |   1 +
 kernel/locking/lglock.c | 105 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 include/linux/lglock.h
 create mode 100644 kernel/locking/lglock.c

diff --git a/include/linux/lglock.h b/include/linux/lglock.h
new file mode 100644
index 0000000000..c1fbe64bd2
--- /dev/null
+++ b/include/linux/lglock.h
@@ -0,0 +1,97 @@
+/*
+ * Specialised local-global spinlock. Can only be declared as global variables
+ * to avoid overhead and keep things simple (and we don't want to start using
+ * these inside dynamically allocated structures).
+ *
+ * "local/global locks" (lglocks) can be used to:
+ *
+ * - Provide fast exclusive access to per-CPU data, with exclusive access to
+ *   another CPU's data allowed but possibly subject to contention, and to
+ *   provide very slow exclusive access to all per-CPU data.
+ * - Or to provide very fast and scalable read serialisation, and to provide
+ *   very slow exclusive serialisation of data (not necessarily per-CPU data).
+ *
+ * Brlocks are also implemented as a short-hand notation for the latter use
+ * case.
+ *
+ * Copyright 2009, 2010, Nick Piggin, Novell Inc.
+ */
+#ifndef __LINUX_LGLOCK_H
+#define __LINUX_LGLOCK_H
+
+#include <linux/spinlock.h>
+#include <linux/lockdep.h>
+#include <linux/percpu.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
+
+#ifdef CONFIG_SMP
+
+struct lglock {
+	arch_spinlock_t __percpu *lock;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map    dep_map;
+#endif
+};
+
+#define DEFINE_LGLOCK(name)						\
+	static DEFINE_PER_CPU(arch_spinlock_t, name ## _lock)		\
+	= __ARCH_SPIN_LOCK_UNLOCKED;					\
+	struct lglock name = { .lock = &name ## _lock }
+
+#define DEFINE_STATIC_LGLOCK(name)					\
+	static DEFINE_PER_CPU(arch_spinlock_t, name ## _lock)		\
+	= __ARCH_SPIN_LOCK_UNLOCKED;					\
+	static struct lglock name = { .lock = &name ## _lock }
+
+static inline void lg_lock_free(struct lglock *lg)
+{
+	free_percpu(lg->lock);
+}
+
+#define lg_lock_lockdep_init(lock)					\
+do {									\
+	static struct lock_class_key __key;				\
+									\
+	lockdep_init_map(&(lock)->dep_map, #lock, &__key, 0);		\
+} while (0)
+
+static inline int __lg_lock_init(struct lglock *lg)
+{
+	lg->lock = alloc_percpu(*lg->lock);
+	return lg->lock ? 0 : -ENOMEM;
+}
+
+#define lg_lock_init(lock)						\
+({									\
+	lg_lock_lockdep_init(lock);					\
+	__lg_lock_init(lock);						\
+})
+
+void lg_local_lock(struct lglock *lg);
+void lg_local_unlock(struct lglock *lg);
+void lg_local_lock_cpu(struct lglock *lg, int cpu);
+void lg_local_unlock_cpu(struct lglock *lg, int cpu);
+
+void lg_double_lock(struct lglock *lg, int cpu1, int cpu2);
+void lg_double_unlock(struct lglock *lg, int cpu1, int cpu2);
+
+void lg_global_lock(struct lglock *lg);
+void lg_global_unlock(struct lglock *lg);
+
+#else
+/* When !CONFIG_SMP, map lglock to spinlock */
+#define lglock spinlock
+#define DEFINE_LGLOCK(name) DEFINE_SPINLOCK(name)
+#define DEFINE_STATIC_LGLOCK(name) static DEFINE_SPINLOCK(name)
+#define lg_lock_init(lg)	({ spin_lock_init(lg); 0; })
+#define lg_lock_free(lg)	do {} while (0)
+#define lg_local_lock spin_lock
+#define lg_local_unlock spin_unlock
+#define lg_local_lock_cpu(lg, cpu) spin_lock(lg)
+#define lg_local_unlock_cpu(lg, cpu) spin_unlock(lg)
+#define lg_global_lock spin_lock
+#define lg_global_unlock spin_unlock
+#endif
+
+#endif
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 392c7f23af..e5bb62823d 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_LOCKDEP) += lockdep_proc.o
 endif
 obj-$(CONFIG_SMP) += spinlock.o
 obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_lock.o
+obj-$(CONFIG_SMP) += lglock.o
 obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
 obj-$(CONFIG_RT_MUTEXES) += rtmutex.o
diff --git a/kernel/locking/lglock.c b/kernel/locking/lglock.c
new file mode 100644
index 0000000000..051feaccc4
--- /dev/null
+++ b/kernel/locking/lglock.c
@@ -0,0 +1,105 @@
+/* See include/linux/lglock.h for description */
+#include <linux/module.h>
+#include <linux/lglock.h>
+#include <linux/cpu.h>
+#include <linux/string.h>
+
+/*
+ * Note there is no uninit, so lglocks cannot be defined in
+ * modules (but it's fine to use them from there)
+ * Could be added though, just undo lg_lock_init
+ */
+
+void lg_local_lock(struct lglock *lg)
+{
+	arch_spinlock_t *lock;
+
+	preempt_disable();
+	lock_acquire_shared(&lg->dep_map, 0, 0, NULL, _RET_IP_);
+	lock = this_cpu_ptr(lg->lock);
+	arch_spin_lock(lock);
+}
+EXPORT_SYMBOL(lg_local_lock);
+
+void lg_local_unlock(struct lglock *lg)
+{
+	arch_spinlock_t *lock;
+
+	lock_release(&lg->dep_map, 1, _RET_IP_);
+	lock = this_cpu_ptr(lg->lock);
+	arch_spin_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(lg_local_unlock);
+
+void lg_local_lock_cpu(struct lglock *lg, int cpu)
+{
+	arch_spinlock_t *lock;
+
+	preempt_disable();
+	lock_acquire_shared(&lg->dep_map, 0, 0, NULL, _RET_IP_);
+	lock = per_cpu_ptr(lg->lock, cpu);
+	arch_spin_lock(lock);
+}
+EXPORT_SYMBOL(lg_local_lock_cpu);
+
+void lg_local_unlock_cpu(struct lglock *lg, int cpu)
+{
+	arch_spinlock_t *lock;
+
+	lock_release(&lg->dep_map, 1, _RET_IP_);
+	lock = per_cpu_ptr(lg->lock, cpu);
+	arch_spin_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(lg_local_unlock_cpu);
+
+void lg_double_lock(struct lglock *lg, int cpu1, int cpu2)
+{
+	BUG_ON(cpu1 == cpu2);
+
+	/* lock in cpu order, just like lg_global_lock */
+	if (cpu2 < cpu1)
+		swap(cpu1, cpu2);
+
+	preempt_disable();
+	lock_acquire_shared(&lg->dep_map, 0, 0, NULL, _RET_IP_);
+	arch_spin_lock(per_cpu_ptr(lg->lock, cpu1));
+	arch_spin_lock(per_cpu_ptr(lg->lock, cpu2));
+}
+
+void lg_double_unlock(struct lglock *lg, int cpu1, int cpu2)
+{
+	lock_release(&lg->dep_map, 1, _RET_IP_);
+	arch_spin_unlock(per_cpu_ptr(lg->lock, cpu1));
+	arch_spin_unlock(per_cpu_ptr(lg->lock, cpu2));
+	preempt_enable();
+}
+
+void lg_global_lock(struct lglock *lg)
+{
+	int i;
+
+	preempt_disable();
+	lock_acquire_exclusive(&lg->dep_map, 0, 0, NULL, _RET_IP_);
+	for_each_possible_cpu(i) {
+		arch_spinlock_t *lock;
+		lock = per_cpu_ptr(lg->lock, i);
+		arch_spin_lock(lock);
+	}
+}
+EXPORT_SYMBOL(lg_global_lock);
+
+void lg_global_unlock(struct lglock *lg)
+{
+	int i;
+
+	lock_release(&lg->dep_map, 1, _RET_IP_);
+	for_each_possible_cpu(i) {
+		arch_spinlock_t *lock;
+		lock = per_cpu_ptr(lg->lock, i);
+		arch_spin_unlock(lock);
+	}
+	preempt_enable();
+}
+EXPORT_SYMBOL(lg_global_unlock);
-- 
2.17.0
