Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeBAQvZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:51:25 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:54984 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeBAQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:51:16 -0500
X-Google-Smtp-Source: AH8x2250HB0OhsKrpw6IJnbGcwY/Sc9sc2w+VTlBTtEFgOflrar/JxLGazft/Z1MLYpNF7OXkTfdMA==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/7] cpuset: Rebuild root domain deadline accounting information
Date: Thu,  1 Feb 2018 09:51:04 -0700
Message-Id: <1517503869-3179-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the topology of root domains is modified by CPUset or CPUhotplug
operations information about the current deadline bandwidth held in the
root domain is lost.

This patch address the issue by recalculating the lost deadline
bandwidth information by circling through the deadline tasks held in
CPUsets and adding their current load to the root domain they are
associated with.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/sched.h          |  3 ++
 include/linux/sched/deadline.h |  8 ++++++
 kernel/cgroup/cpuset.c         | 63 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/deadline.c        | 31 +++++++++++++++++++++
 kernel/sched/sched.h           |  3 --
 kernel/sched/topology.c        | 14 +++++++++-
 6 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2588263a989..18d00914ae6c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -239,6 +239,9 @@ struct vtime {
 	u64			gtime;
 };
 
+extern struct root_domain def_root_domain;
+extern struct mutex sched_domains_mutex;
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index a5bc8728ead7..050961659b1d 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -29,4 +29,12 @@ static inline bool dl_time_before(u64 a, u64 b)
 	return (s64)(a - b) < 0;
 }
 
+#ifdef CONFIG_SMP
+
+struct root_domain;
+extern void dl_add_task_root_domain(struct task_struct *p);
+extern void dl_clear_root_domain(struct root_domain *rd);
+
+#endif /* CONFIG_SMP */
+
 #endif /* _LINUX_SCHED_DEADLINE_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fbf40cbd37c9..fc5c709f99cf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -44,6 +44,7 @@
 #include <linux/proc_fs.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/deadline.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/seq_file.h>
@@ -812,6 +813,66 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
+static void update_tasks_root_domain(struct cpuset *cs)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	css_task_iter_start(&cs->css, 0, &it);
+
+	while ((task = css_task_iter_next(&it)))
+		dl_add_task_root_domain(task);
+
+	css_task_iter_end(&it);
+}
+
+/*
+ * Called with cpuset_mutex held (rebuild_sched_domains())
+ * Called with hotplug lock held (rebuild_sched_domains_locked())
+ * Called with sched_domains_mutex held (partition_and_rebuild_domains())
+ */
+static void rebuild_root_domains(void)
+{
+	struct cpuset *cs = NULL;
+	struct cgroup_subsys_state *pos_css;
+
+	rcu_read_lock();
+
+	/*
+	 * Clear default root domain DL accounting, it will be computed again
+	 * if a task belongs to it.
+	 */
+	dl_clear_root_domain(&def_root_domain);
+
+	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
+
+		if (cpumask_empty(cs->effective_cpus)) {
+			pos_css = css_rightmost_descendant(pos_css);
+			continue;
+		}
+
+		css_get(&cs->css);
+
+		rcu_read_unlock();
+
+		update_tasks_root_domain(cs);
+
+		rcu_read_lock();
+		css_put(&cs->css);
+	}
+	rcu_read_unlock();
+}
+
+static void
+partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
+	rebuild_root_domains();
+	mutex_unlock(&sched_domains_mutex);
+}
+
 /*
  * Rebuild scheduler domains.
  *
@@ -844,7 +905,7 @@ static void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_sched_domains(ndoms, doms, attr);
+	partition_and_rebuild_sched_domains(ndoms, doms, attr);
 out:
 	put_online_cpus();
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2473736c7616..1a5c42e7b076 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2208,6 +2208,37 @@ void __init init_sched_dl_class(void)
 					GFP_KERNEL, cpu_to_node(i));
 }
 
+void dl_add_task_root_domain(struct task_struct *p)
+{
+	unsigned long flags;
+	struct rq_flags rf;
+	struct rq *rq;
+	struct dl_bw *dl_b;
+
+	rq = task_rq_lock(p, &rf);
+	if (!dl_task(p))
+		goto unlock;
+
+	dl_b = &rq->rd->dl_bw;
+	raw_spin_lock_irqsave(&dl_b->lock, flags);
+
+	dl_b->total_bw += p->dl.dl_bw;
+
+	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+}
+
+void dl_clear_root_domain(struct root_domain *rd)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
+	rd->dl_bw.total_bw = 0;
+	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
+}
+
 #endif /* CONFIG_SMP */
 
 static void switched_from_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b19552a212de..d369b748c5a1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -659,9 +659,6 @@ struct root_domain {
 	unsigned long max_cpu_capacity;
 };
 
-extern struct root_domain def_root_domain;
-extern struct mutex sched_domains_mutex;
-
 extern void init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
 extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 892e1f9c78f0..371468593f4a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3,6 +3,7 @@
  * Scheduler topology setup/handling methods
  */
 #include <linux/sched.h>
+#include <linux/sched/deadline.h>
 #include <linux/mutex.h>
 #include <linux/sched/isolation.h>
 #include <linux/proc_fs.h>
@@ -1875,8 +1876,19 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j])
-			    && dattrs_equal(dattr_cur, i, dattr_new, j))
+			    && dattrs_equal(dattr_cur, i, dattr_new, j)) {
+				struct root_domain *rd;
+
+				/*
+				 * This domain won't be destroyed and as such
+				 * its dl_bw->total_bw needs to be cleared.  It
+				 * will be recomputed in function
+				 * update_tasks_root_domain().
+				 */
+				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
+				dl_clear_root_domain(rd);
 				goto match1;
+			}
 		}
 		/* No match - a current sched domain not in new doms_new[] */
 		detach_destroy_domains(doms_cur[i]);
-- 
2.7.4
