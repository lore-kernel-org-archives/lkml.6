Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeCWXNi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:13:38 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34179 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbeCWXNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:13:36 -0400
X-Google-Smtp-Source: AG47ELtlr/EiVoTXJcvA+z8sikvMNeLOE1eRRLypjxw2buPmZD+vhNiYHNCddcKVs1Y6B8SjOJ597A==
From: Tejun Heo <tj@kernel.org>
To: lizefan@huawei.com, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, guro@fb.com,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/8] cgroup: Replace cgroup_rstat_mutex with a spinlock
Date: Fri, 23 Mar 2018 16:13:11 -0700
Message-Id: <20180323231313.1254142-7-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180323231313.1254142-1-tj@kernel.org>
References: <20180323231313.1254142-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rstat flush path is protected with a mutex which is fine as
all the existing users are from interface file show path.  However,
rstat is being generalized for use by controllers and flushing from
atomic contexts will be necessary.

This patch replaces cgroup_rstat_mutex with a spinlock and adds a
irq-safe flush function - cgroup_rstat_flush_irqsafe().  Explicit
yield handling is added to the flush path so that other flush
functions can yield to other threads and flushers.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 57 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 5c6018f..c9fdf6f 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -696,6 +696,7 @@ static inline void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
  */
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
+void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(void);
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index e3c4461..a5f9338 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -2,7 +2,7 @@
 
 #include <linux/sched/cputime.h>
 
-static DEFINE_MUTEX(cgroup_rstat_mutex);
+static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
@@ -131,21 +131,30 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 }
 
 /* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
+static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 {
 	int cpu;
 
-	lockdep_assert_held(&cgroup_rstat_mutex);
+	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
 		raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
 						       cpu);
 		struct cgroup *pos = NULL;
 
-		raw_spin_lock_irq(cpu_lock);
+		raw_spin_lock(cpu_lock);
 		while ((pos = cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu)))
 			cgroup_base_stat_flush(pos, cpu);
-		raw_spin_unlock_irq(cpu_lock);
+		raw_spin_unlock(cpu_lock);
+
+		/* if @may_sleep, play nice and yield if necessary */
+		if (may_sleep && (need_resched() ||
+				  spin_needbreak(&cgroup_rstat_lock))) {
+			spin_unlock_irq(&cgroup_rstat_lock);
+			if (!cond_resched())
+				cpu_relax();
+			spin_lock_irq(&cgroup_rstat_lock);
+		}
 	}
 }
 
@@ -159,12 +168,31 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  *
  * This also gets all cgroups in the subtree including @cgrp off the
  * ->updated_children lists.
+ *
+ * This function may block.
  */
 void cgroup_rstat_flush(struct cgroup *cgrp)
 {
-	mutex_lock(&cgroup_rstat_mutex);
-	cgroup_rstat_flush_locked(cgrp);
-	mutex_unlock(&cgroup_rstat_mutex);
+	might_sleep();
+
+	spin_lock_irq(&cgroup_rstat_lock);
+	cgroup_rstat_flush_locked(cgrp, true);
+	spin_unlock_irq(&cgroup_rstat_lock);
+}
+
+/**
+ * cgroup_rstat_flush_irqsafe - irqsafe version of cgroup_rstat_flush()
+ * @cgrp: target cgroup
+ *
+ * This function can be called from any context.
+ */
+void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cgroup_rstat_lock, flags);
+	cgroup_rstat_flush_locked(cgrp, false);
+	spin_unlock_irqrestore(&cgroup_rstat_lock, flags);
 }
 
 /**
@@ -173,21 +201,24 @@ void cgroup_rstat_flush(struct cgroup *cgrp)
  *
  * Flush stats in @cgrp's subtree and prevent further flushes.  Must be
  * paired with cgroup_rstat_flush_release().
+ *
+ * This function may block.
  */
 void cgroup_rstat_flush_hold(struct cgroup *cgrp)
-	__acquires(&cgroup_rstat_mutex)
+	__acquires(&cgroup_rstat_lock)
 {
-	mutex_lock(&cgroup_rstat_mutex);
-	cgroup_rstat_flush_locked(cgrp);
+	might_sleep();
+	spin_lock_irq(&cgroup_rstat_lock);
+	cgroup_rstat_flush_locked(cgrp, true);
 }
 
 /**
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
  */
 void cgroup_rstat_flush_release(void)
-	__releases(&cgroup_rstat_mutex)
+	__releases(&cgroup_rstat_lock)
 {
-	mutex_unlock(&cgroup_rstat_mutex);
+	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)
-- 
2.9.5
