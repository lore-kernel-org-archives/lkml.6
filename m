Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1950EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D285F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfAOKQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:16:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46900 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbfAOKPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:15:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58F521596;
        Tue, 15 Jan 2019 02:15:50 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4083D3F70D;
        Tue, 15 Jan 2019 02:15:47 -0800 (PST)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v6 07/16] sched/core: uclamp: Add system default clamps
Date:   Tue, 15 Jan 2019 10:15:04 +0000
Message-Id: <20190115101513.2822-8-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190115101513.2822-1-patrick.bellasi@arm.com>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasks without a user-defined clamp value are considered not clamped
and by default their utilization can have any value in the
[0..SCHED_CAPACITY_SCALE] range.

Tasks with a user-defined clamp value are allowed to request any value
in that range, and we unconditionally enforce the required clamps.
However, a "System Management Software" could be interested in limiting
the range of clamp values allowed for all tasks.

Add a privileged interface to define a system default configuration via:

  /proc/sys/kernel/sched_uclamp_util_{min,max}

which works as an unconditional clamp range restriction for all tasks.

If a task specific value is not compliant with the system default range,
it will be forced to the corresponding system default value.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
The current restriction could be too aggressive since, for example if a
task has a util_min which is higher then the system default max, it
will be forced to the system default min unconditionally.

Let say we have:

   Task Clamp:    min=30, max=40
   System Clamps: min=10, max=20

In principle we should set the task's min=20, since the system allows
boosts up to 20%. In the current implementation, however, since the task
mins exceed the system max, we just go for task min=10.

We should probably better restrict util_min to the maximum system
default value, but that would make the code more complex since it
required to track a cross clamp_id dependency.
Let's keep this as a possible future extension whenever we should really
see the need for it.

Changes in v6:
 Others:
 - wholesale s/group/bucket/
 - make use of the bit_for() macro
---
 include/linux/sched.h        |   5 ++
 include/linux/sched/sysctl.h |  11 +++
 kernel/sched/core.c          | 137 ++++++++++++++++++++++++++++++++++-
 kernel/sysctl.c              |  16 ++++
 4 files changed, 166 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 84294925d006..c8f391d1cdc5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -625,6 +625,11 @@ struct uclamp_se {
 	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
 	unsigned int mapped		: 1;
 	unsigned int active		: 1;
+	/* Clamp bucket and value actually used by a RUNNABLE task */
+	struct {
+		unsigned int value	: bits_per(SCHED_CAPACITY_SCALE);
+		unsigned int bucket_id	: bits_per(UCLAMP_BUCKETS);
+	} effective;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index a9c32daeb9d8..445fb54eaeff 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -56,6 +56,11 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 
+#ifdef CONFIG_UCLAMP_TASK
+extern unsigned int sysctl_sched_uclamp_util_min;
+extern unsigned int sysctl_sched_uclamp_util_max;
+#endif
+
 #ifdef CONFIG_CFS_BANDWIDTH
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
@@ -75,6 +80,12 @@ extern int sched_rt_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos);
 
+#ifdef CONFIG_UCLAMP_TASK
+extern int sched_uclamp_handler(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp,
+				loff_t *ppos);
+#endif
+
 extern int sysctl_numa_balancing(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp,
 				 loff_t *ppos);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b7ac516a70be..d1ea5825501a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -731,6 +731,23 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 static DEFINE_MUTEX(uclamp_mutex);
 
 /*
+ * Minimum utilization for FAIR tasks
+ * default: 0
+ */
+unsigned int sysctl_sched_uclamp_util_min;
+
+/*
+ * Maximum utilization for FAIR tasks
+ * default: 1024
+ */
+unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
+
+/*
+ * Tasks specific clamp values are required to be within this range
+ */
+static struct uclamp_se uclamp_default[UCLAMP_CNT];
+
+/**
  * Reference count utilization clamp buckets
  * @value:	the utilization "clamp value" tracked by this clamp bucket
  * @se_count:	the number of scheduling entities using this "clamp value"
@@ -827,6 +844,72 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id,
 	WRITE_ONCE(rq->uclamp[clamp_id].value, max_value);
 }
 
+/*
+ * The effective clamp bucket index of a task depends on, by increasing
+ * priority:
+ * - the task specific clamp value, explicitly requested from userspace
+ * - the system default clamp value, defined by the sysadmin
+ *
+ * As a side effect, update the task's effective value:
+ *    task_struct::uclamp::effective::value
+ * to represent the clamp value of the task effective bucket index.
+ */
+static inline void
+uclamp_effective_get(struct task_struct *p, unsigned int clamp_id,
+		     unsigned int *clamp_value, unsigned int *bucket_id)
+{
+	/* Task specific clamp value */
+	*clamp_value = p->uclamp[clamp_id].value;
+	*bucket_id = p->uclamp[clamp_id].bucket_id;
+
+	/* System default restriction */
+	if (unlikely(*clamp_value < uclamp_default[UCLAMP_MIN].value ||
+		     *clamp_value > uclamp_default[UCLAMP_MAX].value)) {
+		/* Keep it simple: unconditionally enforce system defaults */
+		*clamp_value = uclamp_default[clamp_id].value;
+		*bucket_id = uclamp_default[clamp_id].bucket_id;
+	}
+}
+
+static inline void
+uclamp_effective_assign(struct task_struct *p, unsigned int clamp_id)
+{
+	unsigned int clamp_value, bucket_id;
+
+	uclamp_effective_get(p, clamp_id, &clamp_value, &bucket_id);
+
+	p->uclamp[clamp_id].effective.value = clamp_value;
+	p->uclamp[clamp_id].effective.bucket_id = bucket_id;
+}
+
+static inline unsigned int uclamp_effective_bucket_id(struct task_struct *p,
+						      unsigned int clamp_id)
+{
+	unsigned int clamp_value, bucket_id;
+
+	/* Task currently refcounted: use back-annotate effective value */
+	if (p->uclamp[clamp_id].active)
+		return p->uclamp[clamp_id].effective.bucket_id;
+
+	uclamp_effective_get(p, clamp_id, &clamp_value, &bucket_id);
+
+	return bucket_id;
+}
+
+static unsigned int uclamp_effective_value(struct task_struct *p,
+					   unsigned int clamp_id)
+{
+	unsigned int clamp_value, bucket_id;
+
+	/* Task currently refcounted: use back-annotate effective value */
+	if (p->uclamp[clamp_id].active)
+		return p->uclamp[clamp_id].effective.value;
+
+	uclamp_effective_get(p, clamp_id, &clamp_value, &bucket_id);
+
+	return clamp_value;
+}
+
 /*
  * When a task is enqueued on a CPU's rq, the clamp bucket currently defined by
  * the task's uclamp::bucket_id is reference counted on that CPU. This also
@@ -843,14 +926,15 @@ static inline void uclamp_cpu_inc_id(struct task_struct *p, struct rq *rq,
 
 	if (unlikely(!p->uclamp[clamp_id].mapped))
 		return;
+	uclamp_effective_assign(p, clamp_id);
 
-	bucket_id = p->uclamp[clamp_id].bucket_id;
+	bucket_id = uclamp_effective_bucket_id(p, clamp_id);
 	p->uclamp[clamp_id].active = true;
 
 	rq->uclamp[clamp_id].bucket[bucket_id].tasks++;
 
 	/* Reset clamp holds on idle exit */
-	tsk_clamp = p->uclamp[clamp_id].value;
+	tsk_clamp = uclamp_effective_value(p, clamp_id);
 	uclamp_idle_reset(rq, clamp_id, tsk_clamp);
 
 	/* CPU's clamp buckets track the max effective clamp value */
@@ -880,7 +964,7 @@ static inline void uclamp_cpu_dec_id(struct task_struct *p, struct rq *rq,
 	if (unlikely(!p->uclamp[clamp_id].mapped))
 		return;
 
-	bucket_id = p->uclamp[clamp_id].bucket_id;
+	bucket_id = uclamp_effective_bucket_id(p, clamp_id);
 	p->uclamp[clamp_id].active = false;
 
 	SCHED_WARN_ON(!rq->uclamp[clamp_id].bucket[bucket_id].tasks);
@@ -1068,6 +1152,50 @@ static void uclamp_bucket_inc(struct task_struct *p, struct uclamp_se *uc_se,
 	uc_se->mapped = true;
 }
 
+int sched_uclamp_handler(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp,
+			 loff_t *ppos)
+{
+	int old_min, old_max;
+	int result = 0;
+
+	mutex_lock(&uclamp_mutex);
+
+	old_min = sysctl_sched_uclamp_util_min;
+	old_max = sysctl_sched_uclamp_util_max;
+
+	result = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (result)
+		goto undo;
+	if (!write)
+		goto done;
+
+	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
+	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
+		result = -EINVAL;
+		goto undo;
+	}
+
+	if (old_min != sysctl_sched_uclamp_util_min) {
+		uclamp_bucket_inc(NULL, &uclamp_default[UCLAMP_MIN],
+				  UCLAMP_MIN, sysctl_sched_uclamp_util_min);
+	}
+	if (old_max != sysctl_sched_uclamp_util_max) {
+		uclamp_bucket_inc(NULL, &uclamp_default[UCLAMP_MAX],
+				  UCLAMP_MAX, sysctl_sched_uclamp_util_max);
+	}
+	goto done;
+
+undo:
+	sysctl_sched_uclamp_util_min = old_min;
+	sysctl_sched_uclamp_util_max = old_max;
+
+done:
+	mutex_unlock(&uclamp_mutex);
+
+	return result;
+}
+
 static int __setscheduler_uclamp(struct task_struct *p,
 				 const struct sched_attr *attr)
 {
@@ -1151,6 +1279,9 @@ static void __init init_uclamp(void)
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		uc_se = &init_task.uclamp[clamp_id];
 		uclamp_bucket_inc(NULL, uc_se, clamp_id, uclamp_none(clamp_id));
+
+		uc_se = &uclamp_default[clamp_id];
+		uclamp_bucket_inc(NULL, uc_se, clamp_id, uclamp_none(clamp_id));
 	}
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ba4d9e85feb8..b0fa4a883999 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -446,6 +446,22 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sched_rr_handler,
 	},
+#ifdef CONFIG_UCLAMP_TASK
+	{
+		.procname	= "sched_uclamp_util_min",
+		.data		= &sysctl_sched_uclamp_util_min,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_uclamp_handler,
+	},
+	{
+		.procname	= "sched_uclamp_util_max",
+		.data		= &sysctl_sched_uclamp_util_max,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_uclamp_handler,
+	},
+#endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
 		.procname	= "sched_autogroup_enabled",
-- 
2.19.2

