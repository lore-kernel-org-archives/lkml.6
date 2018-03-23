Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeCWXPA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:15:00 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44613 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752347AbeCWXNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:13:30 -0400
X-Google-Smtp-Source: AG47ELvKdNOMqZ5Z7fODj66tbDdzG7JKhlhqit2bGqc45hpddQ9g+79VknJstrwomvEp9VoYsbchcg==
From: Tejun Heo <tj@kernel.org>
To: lizefan@huawei.com, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, guro@fb.com,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/8] cgroup: Reorganize kernel/cgroup/rstat.c
Date: Fri, 23 Mar 2018 16:13:09 -0700
Message-Id: <20180323231313.1254142-5-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180323231313.1254142-1-tj@kernel.org>
References: <20180323231313.1254142-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rstat.c has rstat and base stat implementations intermixed.
Collect base stat implementation at the end of the file.  Also,
reorder the prototypes.

This patch doesn't make any functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup-internal.h |   2 +-
 kernel/cgroup/rstat.c           | 182 +++++++++++++++++++++-------------------
 2 files changed, 95 insertions(+), 89 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index aab4d0a..2bf6fb4 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -206,8 +206,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
 void cgroup_rstat_flush(struct cgroup *cgrp);
 int cgroup_rstat_init(struct cgroup *cgrp);
 void cgroup_rstat_exit(struct cgroup *cgrp);
-void cgroup_base_stat_cputime_show(struct seq_file *seq);
 void cgroup_rstat_boot(void);
+void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
 /*
  * namespace.c
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 7670191..87d7252 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -5,6 +5,8 @@
 static DEFINE_MUTEX(cgroup_rstat_mutex);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
+static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
+
 static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
 {
 	return per_cpu_ptr(cgrp->rstat_cpu, cpu);
@@ -128,6 +130,98 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	return pos;
 }
 
+/* see cgroup_rstat_flush() */
+static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
+{
+	int cpu;
+
+	lockdep_assert_held(&cgroup_rstat_mutex);
+
+	for_each_possible_cpu(cpu) {
+		raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
+						       cpu);
+		struct cgroup *pos = NULL;
+
+		raw_spin_lock_irq(cpu_lock);
+		while ((pos = cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu)))
+			cgroup_base_stat_flush(pos, cpu);
+		raw_spin_unlock_irq(cpu_lock);
+	}
+}
+
+/**
+ * cgroup_rstat_flush - flush stats in @cgrp's subtree
+ * @cgrp: target cgroup
+ *
+ * Collect all per-cpu stats in @cgrp's subtree into the global counters
+ * and propagate them upwards.  After this function returns, all cgroups in
+ * the subtree have up-to-date ->stat.
+ *
+ * This also gets all cgroups in the subtree including @cgrp off the
+ * ->updated_children lists.
+ */
+void cgroup_rstat_flush(struct cgroup *cgrp)
+{
+	mutex_lock(&cgroup_rstat_mutex);
+	cgroup_rstat_flush_locked(cgrp);
+	mutex_unlock(&cgroup_rstat_mutex);
+}
+
+int cgroup_rstat_init(struct cgroup *cgrp)
+{
+	int cpu;
+
+	/* the root cgrp has rstat_cpu preallocated */
+	if (!cgrp->rstat_cpu) {
+		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		if (!cgrp->rstat_cpu)
+			return -ENOMEM;
+	}
+
+	/* ->updated_children list is self terminated */
+	for_each_possible_cpu(cpu) {
+		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+
+		rstatc->updated_children = cgrp;
+		u64_stats_init(&rstatc->bsync);
+	}
+
+	return 0;
+}
+
+void cgroup_rstat_exit(struct cgroup *cgrp)
+{
+	int cpu;
+
+	cgroup_rstat_flush(cgrp);
+
+	/* sanity check */
+	for_each_possible_cpu(cpu) {
+		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+
+		if (WARN_ON_ONCE(rstatc->updated_children != cgrp) ||
+		    WARN_ON_ONCE(rstatc->updated_next))
+			return;
+	}
+
+	free_percpu(cgrp->rstat_cpu);
+	cgrp->rstat_cpu = NULL;
+}
+
+void __init cgroup_rstat_boot(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+
+	BUG_ON(cgroup_rstat_init(&cgrp_dfl_root.cgrp));
+}
+
+/*
+ * Functions for cgroup basic resource statistics implemented on top of
+ * rstat.
+ */
 static void cgroup_base_stat_accumulate(struct cgroup_base_stat *dst_bstat,
 					struct cgroup_base_stat *src_bstat)
 {
@@ -170,43 +264,6 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_accumulate(&parent->pending_bstat, &delta);
 }
 
-/* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
-{
-	int cpu;
-
-	lockdep_assert_held(&cgroup_rstat_mutex);
-
-	for_each_possible_cpu(cpu) {
-		raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
-						       cpu);
-		struct cgroup *pos = NULL;
-
-		raw_spin_lock_irq(cpu_lock);
-		while ((pos = cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu)))
-			cgroup_base_stat_flush(pos, cpu);
-		raw_spin_unlock_irq(cpu_lock);
-	}
-}
-
-/**
- * cgroup_rstat_flush - flush stats in @cgrp's subtree
- * @cgrp: target cgroup
- *
- * Collect all per-cpu stats in @cgrp's subtree into the global counters
- * and propagate them upwards.  After this function returns, all cgroups in
- * the subtree have up-to-date ->stat.
- *
- * This also gets all cgroups in the subtree including @cgrp off the
- * ->updated_children lists.
- */
-void cgroup_rstat_flush(struct cgroup *cgrp)
-{
-	mutex_lock(&cgroup_rstat_mutex);
-	cgroup_rstat_flush_locked(cgrp);
-	mutex_unlock(&cgroup_rstat_mutex);
-}
-
 static struct cgroup_rstat_cpu *
 cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp)
 {
@@ -284,54 +341,3 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		   "system_usec %llu\n",
 		   usage, utime, stime);
 }
-
-int cgroup_rstat_init(struct cgroup *cgrp)
-{
-	int cpu;
-
-	/* the root cgrp has rstat_cpu preallocated */
-	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-		if (!cgrp->rstat_cpu)
-			return -ENOMEM;
-	}
-
-	/* ->updated_children list is self terminated */
-	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-
-		rstatc->updated_children = cgrp;
-		u64_stats_init(&rstatc->bsync);
-	}
-
-	return 0;
-}
-
-void cgroup_rstat_exit(struct cgroup *cgrp)
-{
-	int cpu;
-
-	cgroup_rstat_flush(cgrp);
-
-	/* sanity check */
-	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-
-		if (WARN_ON_ONCE(rstatc->updated_children != cgrp) ||
-		    WARN_ON_ONCE(rstatc->updated_next))
-			return;
-	}
-
-	free_percpu(cgrp->rstat_cpu);
-	cgrp->rstat_cpu = NULL;
-}
-
-void __init cgroup_rstat_boot(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
-
-	BUG_ON(cgroup_rstat_init(&cgrp_dfl_root.cgrp));
-}
-- 
2.9.5
