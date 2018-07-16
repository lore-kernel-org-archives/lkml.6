Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55FDECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725DA20779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725DA20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbeGPI4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:56:25 -0400
Received: from foss.arm.com ([217.140.101.70]:54494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731687AbeGPI4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:56:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E30A15A1;
        Mon, 16 Jul 2018 01:30:09 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.210.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1E1C3F5A0;
        Mon, 16 Jul 2018 01:30:06 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 12/12] sched/core: uclamp: use percentage clamp values
Date:   Mon, 16 Jul 2018 09:29:06 +0100
Message-Id: <20180716082906.6061-13-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716082906.6061-1-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The utilization is a well defined property of tasks and CPUs with an
in-kernel representation based on power-of-two values.
The current representation, in the [0..SCHED_CAPACITY_SCALE] range,
allows efficient computations in hot-paths and a sufficient fixed point
arithmetic precision.
However, the utilization values range is still an implementation detail
which is also possibly subject to changes in the future.

Since we don't want to commit new user-space APIs to any in-kernel
implementation detail, let's add an abstraction layer on top of the APIs
used by util_clamp, i.e. sched_{set,get}attr syscalls and the cgroup's
cpu.util_{min,max} attributes.

We do that by adding a couple of conversion function which can be used
to conveniently transform utilization/capacity values from/to the internal
SCHED_FIXEDPOINT_SCALE representation to/from a more generic percentage
in the standard [0..100] range.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Paul Turner <pjt@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 Documentation/admin-guide/cgroup-v2.rst |  6 +++---
 include/linux/sched.h                   | 20 ++++++++++++++++++++
 include/uapi/linux/sched/types.h        | 14 ++++++++------
 kernel/sched/core.c                     | 18 ++++++++++++------
 4 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 328c011cc105..08b8062e55cd 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -973,7 +973,7 @@ All time durations are in microseconds.
         A read-write single value file which exists on non-root cgroups.
         The default is "0", i.e. no bandwidth boosting.
 
-        The minimum utilization in the range [0, 1023].
+        The minimum percentage of utilization in the range [0, 100].
 
         This interface allows reading and setting minimum utilization clamp
         values similar to the sched_setattr(2). This minimum utilization
@@ -981,9 +981,9 @@ All time durations are in microseconds.
 
   cpu.util_max
         A read-write single value file which exists on non-root cgroups.
-        The default is "1023". i.e. no bandwidth clamping
+        The default is "100". i.e. no bandwidth clamping
 
-        The maximum utilization in the range [0, 1023].
+        The maximum percentage of utilization in the range [0, 100].
 
         This interface allows reading and setting maximum utilization clamp
         values similar to the sched_setattr(2). This maximum utilization
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5dd76a27ec17..f5970903c187 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -321,6 +321,26 @@ struct sched_info {
 # define SCHED_FIXEDPOINT_SHIFT		10
 # define SCHED_FIXEDPOINT_SCALE		(1L << SCHED_FIXEDPOINT_SHIFT)
 
+static inline unsigned int scale_from_percent(unsigned int pct)
+{
+	WARN_ON(pct > 100);
+
+	return ((SCHED_FIXEDPOINT_SCALE * pct) / 100);
+}
+
+static inline unsigned int scale_to_percent(unsigned int value)
+{
+	unsigned int rounding = 0;
+
+	WARN_ON(value > SCHED_FIXEDPOINT_SCALE);
+
+	/* Compensate rounding errors for: 0, 256, 512, 768, 1024 */
+	if (likely((value & 0xFF) && ~(value & 0x700)))
+		rounding = 1;
+
+	return (rounding + ((100 * value) / SCHED_FIXEDPOINT_SCALE));
+}
+
 struct load_weight {
 	unsigned long			weight;
 	u32				inv_weight;
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 7421cd25354d..e2c2acb1c6af 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -84,15 +84,17 @@ struct sched_param {
  *
  *  @sched_util_min	represents the minimum utilization
  *  @sched_util_max	represents the maximum utilization
+ *  @sched_util_min	represents the minimum utilization percentage
+ *  @sched_util_max	represents the maximum utilization percentage
  *
- * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE] which
- * represents the percentage of CPU time used by a task when running at the
- * maximum frequency on the highest capacity CPU of the system. Thus, for
- * example, a 20% utilization task is a task running for 2ms every 10ms.
+ * Utilization is a value in the range [0..100] which represents the
+ * percentage of CPU time used by a task when running at the maximum frequency
+ * on the highest capacity CPU of the system. Thus, for example, a 20%
+ * utilization task is a task running for 2ms every 10ms.
  *
- * A task with a min utilization value bigger then 0 is more likely to be
+ * A task with a min utilization value bigger then 0% is more likely to be
  * scheduled on a CPU which can provide that bandwidth.
- * A task with a max utilization value smaller then 1024 is more likely to be
+ * A task with a max utilization value smaller then 100% is more likely to be
  * scheduled on a CPU which do not provide more then the required bandwidth.
  */
 struct sched_attr {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 42cff5ffddae..da7b8630cc8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1381,7 +1381,7 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 
 	if (attr->sched_util_min > attr->sched_util_max)
 		return -EINVAL;
-	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
+	if (attr->sched_util_max > 100)
 		return -EINVAL;
 
 	mutex_lock(&uclamp_mutex);
@@ -1389,12 +1389,12 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 	/* Update min utilization clamp */
 	uc_se = &p->uclamp[UCLAMP_MIN];
 	retval |= uclamp_group_get(p, NULL, UCLAMP_MIN, uc_se,
-				   attr->sched_util_min);
+				   scale_from_percent(attr->sched_util_min));
 
 	/* Update max utilization clamp */
 	uc_se = &p->uclamp[UCLAMP_MAX];
 	retval |= uclamp_group_get(p, NULL, UCLAMP_MAX, uc_se,
-				   attr->sched_util_max);
+				   scale_from_percent(attr->sched_util_max));
 
 	mutex_unlock(&uclamp_mutex);
 
@@ -5493,6 +5493,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	if (task_group(p)->uclamp[UCLAMP_MAX].value < attr.sched_util_max)
 		attr.sched_util_max = task_group(p)->uclamp[UCLAMP_MAX].value;
 #endif
+	attr.sched_util_min = scale_to_percent(attr.sched_util_min);
+	attr.sched_util_max = scale_to_percent(attr.sched_util_max);
 #endif
 
 	rcu_read_unlock();
@@ -7284,8 +7286,10 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	struct task_group *tg;
 	int ret = -EINVAL;
 
-	if (min_value > SCHED_CAPACITY_SCALE)
+	/* Check range and scale to internal representation */
+	if (min_value > 100)
 		return -ERANGE;
+	min_value = scale_from_percent(min_value);
 
 	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
@@ -7316,8 +7320,10 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	struct task_group *tg;
 	int ret = -EINVAL;
 
-	if (max_value > SCHED_CAPACITY_SCALE)
+	/* Check range and scale to internal representation */
+	if (max_value > 100)
 		return -ERANGE;
+	max_value = scale_from_percent(max_value);
 
 	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
@@ -7352,7 +7358,7 @@ static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
 	util_clamp = tg->uclamp[clamp_id].value;
 	rcu_read_unlock();
 
-	return util_clamp;
+	return scale_to_percent(util_clamp);
 }
 
 static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
-- 
2.17.1

