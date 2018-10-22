Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112FAC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5A82064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qt+rOWZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5A82064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJVX2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58486 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeJVX2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF498M151009;
        Mon, 22 Oct 2018 15:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=rHJsSac6Jjnr/PmB4YGpHfMwCImIaQSocfQL7xOtblY=;
 b=Qt+rOWZKtjf35cYwvGQa+OgaQ5liq7tkkQGIMNHkiUH60+i0dFxTWn/6HEajLwmqJxRl
 iM1sL04yQveMM2BLAA7qcEVgbeNT9XDZ0jWgmdvpyWkrA4nG9nVcPu4rjbYGv8w3eTYH
 E/gsX3+m4Z3AuxHaycyvRJYIIa279sZO34DDsChC2VqbNTYnyjh9X3RjA8aslX+0wDPr
 1YkdguKPpVwnsmvUUGNBj1+1toKVB1Q3cJAdAbKK8RG8RAkiefQtM3M4tGpdFIQVTXeg
 nIeWsgGpUvy65XvvXZTK+OHDMdrgrCGpmo1zsxW/9vh/JPugUuE8PS309OSyv4IuP4xC 5w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n7usty8gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:14 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF9DV1020416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:13 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF9CwJ020761;
        Mon, 22 Oct 2018 15:09:12 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:12 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] sched/fair: Provide idle search schedstats
Date:   Mon, 22 Oct 2018 07:59:41 -0700
Message-Id: <1540220381-424433-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add schedstats to measure the effectiveness of searching for idle CPUs
and stealing tasks.  This is a temporary patch intended for use during
development only.  SCHEDSTAT_VERSION is bumped to 16, and the following
fields are added to the per-CPU statistics of /proc/schedstat:

field 10: # of times select_idle_sibling "easily" found an idle CPU --
          prev or target is idle.
field 11: # of times select_idle_sibling searched and found an idle cpu.
field 12: # of times select_idle_sibling searched and found an idle core.
field 13: # of times select_idle_sibling failed to find anything idle.
field 14: time in nanoseconds spent in functions that search for idle
          CPUs and search for tasks to steal.
field 15: # of times an idle CPU steals a task from another CPU.
field 16: # of times try_steal finds overloaded CPUs but no task is
           migratable.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/core.c  | 30 +++++++++++++++++++++++++++--
 kernel/sched/fair.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |  9 +++++++++
 kernel/sched/stats.c | 11 ++++++++++-
 kernel/sched/stats.h | 13 +++++++++++++
 5 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad97f3b..b61d15d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2214,17 +2214,43 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
 DEFINE_STATIC_KEY_FALSE(sched_schedstats);
 static bool __initdata __sched_schedstats = false;
 
+unsigned long schedstat_skid;
+
+static void compute_skid(void)
+{
+	int i, n = 0;
+	s64 t, skid = 0;
+
+	for (i = 0; i < 100; i++) {
+		t = local_clock();
+		t = local_clock() - t;
+		if (t > 0 && t < 1000) {	/* only use sane samples */
+			skid += t;
+			n++;
+		}
+	}
+
+	if (n > 0)
+		schedstat_skid = skid / n;
+	else
+		schedstat_skid = 0;
+	pr_info("schedstat_skid = %lu\n", schedstat_skid);
+}
+
 static void set_schedstats(bool enabled)
 {
-	if (enabled)
+	if (enabled) {
+		compute_skid();
 		static_branch_enable(&sched_schedstats);
-	else
+	} else {
 		static_branch_disable(&sched_schedstats);
+	}
 }
 
 void force_schedstat_enabled(void)
 {
 	if (!schedstat_enabled()) {
+		compute_skid();
 		pr_info("kernel profiling enabled schedstats, disable via kernel.sched_schedstats.\n");
 		static_branch_enable(&sched_schedstats);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33d24ee..cdad63b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3739,29 +3739,35 @@ static inline bool steal_enabled(void)
 static void overload_clear(struct rq *rq)
 {
 	struct sparsemask *overload_cpus;
+	unsigned long time;
 
 	if (!steal_enabled())
 		return;
 
+	time = schedstat_start_time();
 	rcu_read_lock();
 	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
 	if (overload_cpus)
 		sparsemask_clear_elem(rq->cpu, overload_cpus);
 	rcu_read_unlock();
+	schedstat_end_time(rq->find_time, time);
 }
 
 static void overload_set(struct rq *rq)
 {
 	struct sparsemask *overload_cpus;
+	unsigned long time;
 
 	if (!steal_enabled())
 		return;
 
+	time = schedstat_start_time();
 	rcu_read_lock();
 	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
 	if (overload_cpus)
 		sparsemask_set_elem(rq->cpu, overload_cpus);
 	rcu_read_unlock();
+	schedstat_end_time(rq->find_time, time);
 }
 
 static int try_steal(struct rq *this_rq, struct rq_flags *rf);
@@ -6165,6 +6171,16 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	return cpu;
 }
 
+#define SET_STAT(STAT)							\
+	do {								\
+		if (schedstat_enabled()) {				\
+			struct rq *rq = this_rq();			\
+									\
+			if (rq)						\
+				__schedstat_inc(rq->STAT);		\
+		}							\
+	} while (0)
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
@@ -6173,14 +6189,18 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
-	if (available_idle_cpu(target))
+	if (available_idle_cpu(target)) {
+		SET_STAT(found_idle_cpu_easy);
 		return target;
+	}
 
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) && available_idle_cpu(prev))
+	if (prev != target && cpus_share_cache(prev, target) && available_idle_cpu(prev)) {
+		SET_STAT(found_idle_cpu_easy);
 		return prev;
+	}
 
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
@@ -6193,26 +6213,36 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		 * Replace recent_used_cpu with prev as it is a potential
 		 * candidate for the next wake:
 		 */
+		SET_STAT(found_idle_cpu_easy);
 		p->recent_used_cpu = prev;
 		return recent_used_cpu;
 	}
 
 	sd = rcu_dereference(per_cpu(sd_llc, target));
-	if (!sd)
+	if (!sd) {
+		SET_STAT(nofound_idle_cpu);
 		return target;
+	}
 
 	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
+	if ((unsigned)i < nr_cpumask_bits) {
+		SET_STAT(found_idle_core);
 		return i;
+	}
 
 	i = select_idle_cpu(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
+	if ((unsigned)i < nr_cpumask_bits) {
+		SET_STAT(found_idle_cpu);
 		return i;
+	}
 
 	i = select_idle_smt(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
+	if ((unsigned)i < nr_cpumask_bits) {
+		SET_STAT(found_idle_cpu);
 		return i;
+	}
 
+	SET_STAT(nofound_idle_cpu);
 	return target;
 }
 
@@ -6363,6 +6393,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
 {
+	unsigned long time = schedstat_start_time();
 	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
@@ -6411,6 +6442,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 			current->recent_used_cpu = cpu;
 	}
 	rcu_read_unlock();
+	schedstat_end_time(cpu_rq(cpu)->find_time, time);
 
 	return new_cpu;
 }
@@ -6657,6 +6689,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	struct sched_entity *se;
 	struct task_struct *p;
 	int new_tasks;
+	unsigned long time;
 
 again:
 	if (!cfs_rq->nr_running)
@@ -6767,6 +6800,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	return p;
 
 idle:
+	time = schedstat_start_time();
+
 	/*
 	 * We must set idle_stamp _before_ calling try_steal() or
 	 * idle_balance(), such that we measure the duration as idle time.
@@ -6782,6 +6817,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 
 	schedstat_end_time(rq->find_time, time);
 
+	schedstat_end_time(rq->find_time, time);
+
 	/*
 	 * Because try_steal() and idle_balance() release (and re-acquire)
 	 * rq->lock, it is possible for any higher priority task to appear.
@@ -9772,6 +9809,7 @@ static int steal_from(struct rq *dst_rq, struct rq_flags *dst_rf, bool *locked,
 		update_rq_clock(dst_rq);
 		attach_task(dst_rq, p);
 		stolen = 1;
+		schedstat_inc(dst_rq->steal);
 	}
 	local_irq_restore(rf.flags);
 
@@ -9790,6 +9828,7 @@ static int try_steal(struct rq *dst_rq, struct rq_flags *dst_rf)
 	int dst_cpu = dst_rq->cpu;
 	bool locked = true;
 	int stolen = 0;
+	bool any_overload = false;
 	struct sparsemask *overload_cpus;
 
 	if (!steal_enabled())
@@ -9829,6 +9868,7 @@ static int try_steal(struct rq *dst_rq, struct rq_flags *dst_rf)
 			stolen = 1;
 			break;
 		}
+		any_overload = true;
 	}
 
 out:
@@ -9840,6 +9880,8 @@ static int try_steal(struct rq *dst_rq, struct rq_flags *dst_rf)
 	stolen |= (dst_rq->cfs.h_nr_running > 0);
 	if (dst_rq->nr_running != dst_rq->cfs.h_nr_running)
 		stolen = -1;
+	if (!stolen && any_overload)
+		schedstat_inc(dst_rq->steal_fail);
 	return stolen;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f181e9..9f58e17 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -907,6 +907,15 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+
+	/* Idle search stats */
+	unsigned int		found_idle_core;
+	unsigned int		found_idle_cpu;
+	unsigned int		found_idle_cpu_easy;
+	unsigned int		nofound_idle_cpu;
+	unsigned long		find_time;
+	unsigned int		steal;
+	unsigned int		steal_fail;
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c..00b3de5 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -10,7 +10,7 @@
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 15
+#define SCHEDSTAT_VERSION 16
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -37,6 +37,15 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		    rq->rq_cpu_time,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
 
+		seq_printf(seq, " %u %u %u %u %lu %u %u",
+			   rq->found_idle_cpu_easy,
+			   rq->found_idle_cpu,
+			   rq->found_idle_core,
+			   rq->nofound_idle_cpu,
+			   rq->find_time,
+			   rq->steal,
+			   rq->steal_fail);
+
 		seq_printf(seq, "\n");
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 8aea199..50c3cf8 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -39,6 +39,17 @@
 #define   schedstat_set(var, val)	do { if (schedstat_enabled()) { var = (val); } } while (0)
 #define   schedstat_val(var)		(var)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
+#define   schedstat_start_time()	schedstat_val_or_zero(local_clock())
+#define   schedstat_end_time(stat, time)			\
+	do {							\
+		unsigned long endtime;				\
+								\
+		if (schedstat_enabled() && (time)) {		\
+			endtime = local_clock() - (time) - schedstat_skid; \
+			schedstat_add((stat), endtime);		\
+		}						\
+	} while (0)
+extern unsigned long schedstat_skid;
 
 #else /* !CONFIG_SCHEDSTATS: */
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
@@ -53,6 +64,8 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
 # define   schedstat_set(var, val)	do { } while (0)
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
+# define   schedstat_start_time()	0
+# define   schedstat_end_time(stat, t)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_SCHED_INFO
-- 
1.8.3.1

