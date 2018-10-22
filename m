Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6231C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603DD20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LkDLxTCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603DD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeJVX2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58530 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbeJVX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF4A4v151065;
        Mon, 22 Oct 2018 15:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=iaFyidp98AU+8invQp5MooLo3l+kzKrju8bFpT8sey0=;
 b=LkDLxTCdpyoKmdZ55p4l4S0OJ+ptqWME4iuZD3w4++/L0h/fcLKmDSP6uTEMKlDeZ4vY
 ka7nmRwAw16agajYDHKBtm/vzgHW/GB1A48srvaeixZ0vpcZnWb/T9wyydeV//Pkc1mt
 QBe+WSXWPiOG/5lI7SAKSGKEWvGqplD7NE7TTjF9hYCkrmpXxJk6rXGr6mORUh592BY+
 xGqNBRcimM8ZJGXK3cuAf5jCFvwTm8GTID2S+a2qq4aXiwu3EqflEMpXAn2nYwfuAIn5
 lRZ1cMOq2yiE/ub0ekgWM5XHxieUS5JV84yCntQMbW10dgmNP6cUGYqW/N6zo4NZfzph iQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n7usty8gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF9Bwp020284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:11 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MF9Bg1008376;
        Mon, 22 Oct 2018 15:09:11 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:11 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] sched/fair: Steal work from an overloaded CPU when CPU goes idle
Date:   Mon, 22 Oct 2018 07:59:39 -0700
Message-Id: <1540220381-424433-9-git-send-email-steven.sistare@oracle.com>
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

When a CPU has no more CFS tasks to run, and idle_balance() fails to find a
task, then attempt to steal a task from an overloaded CPU in the same LLC,
using the cfs_overload_cpus bitmap to efficiently identify candidates.  To
minimize search time, steal the first migratable task that is found when
the bitmap is traversed.  For fairness, search for migratable tasks on an
overloaded CPU in order of next to run.

This simple stealing yields a higher CPU utilization than idle_balance()
alone, because the search is cheap, so it may be called every time the CPU
is about to go idle.  idle_balance() does more work because it searches
widely for the busiest queue, so to limit its CPU consumption, it declines
to search if the system is too busy.  Simple stealing does not offload the
globally busiest queue, but it is much better than running nothing at all.

Stealing is controlled by the sched feature SCHED_STEAL, which is enabled
by default.

Stealing imprroves utilization with only a modest CPU overhead in scheduler
code.  In the following experiment, hackbench is run with varying numbers
of groups (40 tasks per group), and the delta in /proc/schedstat is shown
for each run, averaged per CPU, augmented with these non-standard stats:

  %find - percent of time spent in old and new functions that search for
    idle CPUs and tasks to steal and set the overloaded CPUs bitmap.

  steal - number of times a task is stolen from another CPU.

X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
hackbench <grps> process 100000
sched_wakeup_granularity_ns=15000000

  baseline
  grps  time  %busy  slice   sched   idle     wake %find  steal
  1    8.084  75.02   0.10  105476  46291    59183  0.31      0
  2   13.892  85.33   0.10  190225  70958   119264  0.45      0
  3   19.668  89.04   0.10  263896  87047   176850  0.49      0
  4   25.279  91.28   0.10  322171  94691   227474  0.51      0
  8   47.832  94.86   0.09  630636 144141   486322  0.56      0

  new
  grps  time  %busy  slice   sched   idle     wake %find  steal  %speedup
  1    5.938  96.80   0.24   31255   7190    24061  0.63   7433  36.1
  2   11.491  99.23   0.16   74097   4578    69512  0.84  19463  20.9
  3   16.987  99.66   0.15  115824   1985   113826  0.77  24707  15.8
  4   22.504  99.80   0.14  167188   2385   164786  0.75  29353  12.3
  8   44.441  99.86   0.11  389153   1616   387401  0.67  38190   7.6

Elapsed time improves by 8 to 36%, and CPU busy utilization is up
by 5 to 22% hitting 99% for 2 or more groups (80 or more tasks).
The cost is at most 0.4% more find time.

Additional performance results follow.  A negative "speedup" is a
regression.  Note: for all hackbench runs, sched_wakeup_granularity_ns
is set to 15 msec.  Otherwise, preemptions increase at higher loads and
distort the comparison between baseline and new.

------------------ 1 Socket Results ------------------

X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
Average of 10 runs of: hackbench <groups> process 100000

            --- base --    --- new ---
  groups    time %stdev    time %stdev  %speedup
       1   8.008    0.1   5.905    0.2      35.6
       2  13.814    0.2  11.438    0.1      20.7
       3  19.488    0.2  16.919    0.1      15.1
       4  25.059    0.1  22.409    0.1      11.8
       8  47.478    0.1  44.221    0.1       7.3

X6-2: 1 socket * 22 cores * 2 hyperthreads = 44 CPUs
Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
Average of 10 runs of: hackbench <groups> process 100000

            --- base --    --- new ---
  groups    time %stdev    time %stdev  %speedup
       1   4.586    0.8   4.596    0.6      -0.3
       2   7.693    0.2   5.775    1.3      33.2
       3  10.442    0.3   8.288    0.3      25.9
       4  13.087    0.2  11.057    0.1      18.3
       8  24.145    0.2  22.076    0.3       9.3
      16  43.779    0.1  41.741    0.2       4.8

KVM 4-cpu
Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
tbench, average of 11 runs

  clients    %speedup
        1        16.2
        2        11.7
        4         9.9
        8        12.8
       16        13.7

KVM 2-cpu
Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz

  Benchmark                     %speedup
  specjbb2015_critical_jops          5.7
  mysql_sysb1.0.14_mutex_2          40.6
  mysql_sysb1.0.14_oltp_2            3.9

------------------ 2 Socket Results ------------------

X6-2: 2 sockets * 10 cores * 2 hyperthreads = 40 CPUs
Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
Average of 10 runs of: hackbench <groups> process 100000

            --- base --    --- new ---
  groups    time %stdev    time %stdev  %speedup
       1   7.945    0.2   7.219    8.7      10.0
       2   8.444    0.4   6.689    1.5      26.2
       3  12.100    1.1   9.962    2.0      21.4
       4  15.001    0.4  13.109    1.1      14.4
       8  27.960    0.2  26.127    0.3       7.0

X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
Average of 10 runs of: hackbench <groups> process 100000

            --- base --    --- new ---
  groups    time %stdev    time %stdev  %speedup
       1   5.826    5.4   5.840    5.0      -0.3
       2   5.041    5.3   6.171   23.4     -18.4
       3   6.839    2.1   6.324    3.8       8.1
       4   8.177    0.6   7.318    3.6      11.7
       8  14.429    0.7  13.966    1.3       3.3
      16  26.401    0.3  25.149    1.5       4.9

X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
Oracle database OLTP, logging disabled, NVRAM storage

  Customers   Users   %speedup
    1200000      40       -1.2
    2400000      80        2.7
    3600000     120        8.9
    4800000     160        4.4
    6000000     200        3.0

X6-2: 2 sockets * 14 cores * 2 hyperthreads = 56 CPUs
Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
Results from the Oracle "Performance PIT".

  Benchmark                                           %speedup

  mysql_sysb1.0.14_fileio_56_rndrd                        19.6
  mysql_sysb1.0.14_fileio_56_seqrd                        12.1
  mysql_sysb1.0.14_fileio_56_rndwr                         0.4
  mysql_sysb1.0.14_fileio_56_seqrewr                      -0.3

  pgsql_sysb1.0.14_fileio_56_rndrd                        19.5
  pgsql_sysb1.0.14_fileio_56_seqrd                         8.6
  pgsql_sysb1.0.14_fileio_56_rndwr                         1.0
  pgsql_sysb1.0.14_fileio_56_seqrewr                       0.5

  opatch_time_ASM_12.2.0.1.0_HP2M                          7.5
  select-1_users-warm_asmm_ASM_12.2.0.1.0_HP2M             5.1
  select-1_users_asmm_ASM_12.2.0.1.0_HP2M                  4.4
  swingbenchv3_asmm_soebench_ASM_12.2.0.1.0_HP2M           5.8

  lm3_memlat_L2                                            4.8
  lm3_memlat_L1                                            0.0

  ub_gcc_56CPUs-56copies_Pipe-based_Context_Switching     60.1
  ub_gcc_56CPUs-56copies_Shell_Scripts_1_concurrent        5.2
  ub_gcc_56CPUs-56copies_Shell_Scripts_8_concurrent       -3.0
  ub_gcc_56CPUs-56copies_File_Copy_1024_bufsize_2000_maxblocks 2.4

X5-2: 2 sockets * 18 cores * 2 hyperthreads = 72 CPUs
Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz

  NAS_OMP
  bench class   ncpu    %improved(Mops)
  dc    B       72      1.3
  is    C       72      0.9
  is    D       72      0.7

  sysbench mysql, average of 24 runs
          --- base ---     --- new ---
  nthr   events  %stdev   events  %stdev %speedup
     1    331.0    0.25    331.0    0.24     -0.1
     2    661.3    0.22    661.8    0.22      0.0
     4   1297.0    0.88   1300.5    0.82      0.2
     8   2420.8    0.04   2420.5    0.04     -0.1
    16   4826.3    0.07   4825.4    0.05     -0.1
    32   8815.3    0.27   8830.2    0.18      0.1
    64  12823.0    0.24  12823.6    0.26      0.0

-------------------------------------------------------------

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/fair.c     | 160 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |   6 ++
 2 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6548bed..cb86ec9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3730,6 +3730,9 @@ static void overload_clear(struct rq *rq)
 {
 	struct sparsemask *overload_cpus;
 
+	if (!sched_feat(STEAL))
+		return;
+
 	rcu_read_lock();
 	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
 	if (overload_cpus)
@@ -3741,6 +3744,9 @@ static void overload_set(struct rq *rq)
 {
 	struct sparsemask *overload_cpus;
 
+	if (!sched_feat(STEAL))
+		return;
+
 	rcu_read_lock();
 	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
 	if (overload_cpus)
@@ -3748,6 +3754,8 @@ static void overload_set(struct rq *rq)
 	rcu_read_unlock();
 }
 
+static int try_steal(struct rq *this_rq, struct rq_flags *rf);
+
 #else /* CONFIG_SMP */
 
 #define UPDATE_TG	0x0
@@ -3783,6 +3791,11 @@ static inline void overload_set(struct rq *rq) {}
 util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p,
 		 bool task_sleep) {}
 
+static inline int try_steal(struct rq *this_rq, struct rq_flags *rf)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SMP */
 
 static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -6745,12 +6758,14 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 
 idle:
 	/*
-	 * We must set idle_stamp _before_ calling idle_balance(), such that we
-	 * measure the duration of idle_balance() as idle time.
+	 * We must set idle_stamp _before_ calling try_steal() or
+	 * idle_balance(), such that we measure the duration as idle time.
 	 */
 	IF_SMP(rq->idle_stamp = rq_clock(rq);)
 
 	new_tasks = idle_balance(rq, rf);
+	if (new_tasks == 0)
+		new_tasks = try_steal(rq, rf);
 
 	if (new_tasks)
 		IF_SMP(rq->idle_stamp = 0;)
@@ -6758,9 +6773,9 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	schedstat_end_time(rq->find_time, time);
 
 	/*
-	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
-	 * possible for any higher priority task to appear. In that case we
-	 * must re-start the pick_next_entity() loop.
+	 * Because try_steal() and idle_balance() release (and re-acquire)
+	 * rq->lock, it is possible for any higher priority task to appear.
+	 * In that case we must re-start the pick_next_entity() loop.
 	 */
 	if (new_tasks < 0)
 		return RETRY_TASK;
@@ -9683,6 +9698,141 @@ void trigger_load_balance(struct rq *rq)
 	nohz_balancer_kick(rq);
 }
 
+/*
+ * Search the runnable tasks in @cfs_rq in order of next to run, and find
+ * the first one that can be migrated to @dst_rq.  @cfs_rq is locked on entry.
+ * On success, dequeue the task from @cfs_rq and return it, else return NULL.
+ */
+static struct task_struct *
+detach_next_task(struct cfs_rq *cfs_rq, struct rq *dst_rq)
+{
+	int dst_cpu = dst_rq->cpu;
+	struct task_struct *p;
+	struct rq *rq = rq_of(cfs_rq);
+
+	lockdep_assert_held(&rq_of(cfs_rq)->lock);
+
+	list_for_each_entry_reverse(p, &rq->cfs_tasks, se.group_node) {
+		if (can_migrate_task_llc(p, rq, dst_rq)) {
+			detach_task(p, rq, dst_cpu);
+			return p;
+		}
+	}
+	return NULL;
+}
+
+/*
+ * Attempt to migrate a CFS task from @src_cpu to @dst_rq.  @locked indicates
+ * whether @dst_rq is already locked on entry.  This function may lock or
+ * unlock @dst_rq, and updates @locked to indicate the locked state on return.
+ * The locking protocol is based on idle_balance().
+ * Returns 1 on success and 0 on failure.
+ */
+static int steal_from(struct rq *dst_rq, struct rq_flags *dst_rf, bool *locked,
+		      int src_cpu)
+{
+	struct task_struct *p;
+	struct rq_flags rf;
+	int stolen = 0;
+	int dst_cpu = dst_rq->cpu;
+	struct rq *src_rq = cpu_rq(src_cpu);
+
+	if (dst_cpu == src_cpu || src_rq->cfs.h_nr_running < 2)
+		return 0;
+
+	if (*locked) {
+		rq_unpin_lock(dst_rq, dst_rf);
+		raw_spin_unlock(&dst_rq->lock);
+		*locked = false;
+	}
+	rq_lock_irqsave(src_rq, &rf);
+	update_rq_clock(src_rq);
+
+	if (src_rq->cfs.h_nr_running < 2 || !cpu_active(src_cpu))
+		p = NULL;
+	else
+		p = detach_next_task(&src_rq->cfs, dst_rq);
+
+	rq_unlock(src_rq, &rf);
+
+	if (p) {
+		raw_spin_lock(&dst_rq->lock);
+		rq_repin_lock(dst_rq, dst_rf);
+		*locked = true;
+		update_rq_clock(dst_rq);
+		attach_task(dst_rq, p);
+		stolen = 1;
+	}
+	local_irq_restore(rf.flags);
+
+	return stolen;
+}
+
+/*
+ * Try to steal a runnable CFS task from a CPU in the same LLC as @dst_rq,
+ * and migrate it to @dst_rq.  rq_lock is held on entry and return, but
+ * may be dropped in between.  Return 1 on success, 0 on failure, and -1
+ * if a task in a different scheduling class has become runnable on @dst_rq.
+ */
+static int try_steal(struct rq *dst_rq, struct rq_flags *dst_rf)
+{
+	int src_cpu;
+	int dst_cpu = dst_rq->cpu;
+	bool locked = true;
+	int stolen = 0;
+	struct sparsemask *overload_cpus;
+
+	if (!sched_feat(STEAL))
+		return 0;
+
+	if (!cpu_active(dst_cpu))
+		return 0;
+
+	/* Get bitmap of overloaded CPUs in the same LLC as @dst_rq */
+
+	rcu_read_lock();
+	overload_cpus = rcu_dereference(dst_rq->cfs_overload_cpus);
+	if (!overload_cpus) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * First try overloaded CPUs on the same core to preserve cache warmth.
+	 */
+	if (static_branch_likely(&sched_smt_present)) {
+		for_each_cpu(src_cpu, cpu_smt_mask(dst_cpu)) {
+			if (sparsemask_test_elem(src_cpu, overload_cpus) &&
+			    steal_from(dst_rq, dst_rf, &locked, src_cpu)) {
+				stolen = 1;
+				goto out;
+			}
+		}
+	}
+#endif	/* CONFIG_SCHED_SMT */
+
+	/* Accept any suitable task in the LLC */
+
+	for_each_sparse_wrap(src_cpu, overload_cpus, dst_cpu) {
+		if (steal_from(dst_rq, dst_rf, &locked, src_cpu)) {
+			stolen = 1;
+			break;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+	if (!locked) {
+		raw_spin_lock(&dst_rq->lock);
+		rq_repin_lock(dst_rq, dst_rf);
+	}
+	stolen |= (dst_rq->cfs.h_nr_running > 0);
+	if (dst_rq->nr_running != dst_rq->cfs.h_nr_running)
+		stolen = -1;
+	return stolen;
+}
+
 static void rq_online_fair(struct rq *rq)
 {
 	update_sysctl();
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 85ae848..4faab90 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -59,6 +59,12 @@
 SCHED_FEAT(SIS_PROP, true)
 
 /*
+ * Steal a CFS task from another CPU when going idle.
+ * Improves CPU utilization.
+ */
+SCHED_FEAT(STEAL, true)
+
+/*
  * Issue a WARN when we do multiple update_rq_clock() calls
  * in a single rq->lock section. Default disabled because the
  * annotations are not complete.
-- 
1.8.3.1

