Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7904BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A50020652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHxydYWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeJEQsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:48:22 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45573 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:48:22 -0400
Received: by mail-wr1-f53.google.com with SMTP id q5-v6so12859063wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=apeSDNAWkq0Q0NiQ+gPxHLIvLj5LNMtOn2oUue7IgP0=;
        b=LHxydYWRd7vyne0JVBM6Z8m4x72vAdElEVFSyNj0jYe8yet344Qiq0g2qS1ZuSOeus
         QFMilSsaDWKoMQ2tVxXdE79qGfIn7O1eQOC9xQ1JDnkN3hBvtbOtfnkMGlayHIGFNkrD
         CQ33NMaZF4dKBkON/EoPYR3KXe6MRZ9zxXoJuf43eb7aZAmK9W78eJxMsquD8Y31z7BV
         Alp0DN1yoes5+T0y3GvRIlsx6cw68tqVOHVNcrDAfWAH03nl5eywVkiam4rPb9JtIaQ+
         g+AvN/BxQ4ksx0mZY87PL2Q/FFA3hWcKRK/AxgvvUBEVQ+zFuyXfIuxOzzjPjtZsvfcc
         3hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=apeSDNAWkq0Q0NiQ+gPxHLIvLj5LNMtOn2oUue7IgP0=;
        b=FBtfCvwot7ddoCbJeIqCA2vfu0fw8tyWo+ATaug7vhIgHvofL9wg7dQ+NCBCd4Luss
         wJv3R7mVJz4SbNdKtUkxNNxLlrG4DRvcpG/GSDjJqn9L2pa3wnbV9sOKIEnrTEm5E9cn
         VVr1VZay/Vqb4VpazJ4IYOIIquUGI3ncy8swuGwv7VNyREz2QuY0tJHlvhjZMY9/OhOo
         a8tEBw018k5OeuvW4ld4kwq14nen4a4tTzsE87X+KMRuHiZDbDvlc6CCVdBuaOmasSK6
         d5UUGEFrqjMPMmfdaG9vcSFWy+40eknW4iPGhWcDUUjHlbC73FAFK2Gr0XI9eNSyC1tw
         +CPg==
X-Gm-Message-State: ABuFfohs40hji59DEhvcIBs/03gRZXbJgMitUu4u0tVNeW87NqMZPmc4
        nRMwn+xZHS9G4+aQCWbgR9j5FHia
X-Google-Smtp-Source: ACcGV61jjfPytGE3YQpGI/UtgV1hzdn2eNXxZLrBTgOkthzAxOrey5DZ5gzyuHrF13Z8EmpKZfCG9w==
X-Received: by 2002:adf:ee52:: with SMTP id w18-v6mr7762890wro.63.1538733019969;
        Fri, 05 Oct 2018 02:50:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z69-v6sm1259344wmz.18.2018.10.05.02.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 02:50:19 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:50:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, mel@gmail.com,
        Jirka Hladky <jhladky@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20181005095017.GA78013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 37355bdc5a129899f6b245900a8eb944a092f7fd sched/numa: Migrate pages to local nodes quicker early in the lifetime of a task

These fixes address a rather involved performance regression between v4.17->v4.19 in the 
sched/numa auto-balancing code. Since distros really need this fix we accelerated it to 
sched/urgent for a faster upstream merge.

NUMA scheduling and balancing performance is now largely back to v4.17 levels, without 
reintroducing the NUMA placement bugs that v4.18 and v4.19 fixed.

Many thanks to Srikar Dronamraju, Mel Gorman and Jirka Hladky, for reporting, testing, 
re-testing and solving this rather complex set of bugs.

 Thanks,

	Ingo

------------------>
Mel Gorman (3):
      sched/numa: Limit the conditions where scan period is reset
      mm, sched/numa: Remove rate-limiting of automatic NUMA balancing migration
      sched/numa: Migrate pages to local nodes quicker early in the lifetime of a task

Srikar Dronamraju (5):
      sched/numa: Stop multiple tasks from moving to the CPU at the same time
      sched/numa: Pass destination CPU as a parameter to migrate_task_rq
      sched/numa: Reset scan rate whenever task moves across nodes
      mm/migrate: Use spin_trylock() while resetting rate limit
      sched/numa: Avoid task migration for small NUMA improvement


 include/linux/mmzone.h         |   6 ---
 include/trace/events/migrate.h |  27 -----------
 kernel/sched/core.c            |   2 +-
 kernel/sched/deadline.c        |   2 +-
 kernel/sched/fair.c            | 104 +++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h           |   3 +-
 mm/migrate.c                   |  57 ----------------------
 mm/page_alloc.c                |   2 -
 8 files changed, 95 insertions(+), 108 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1e22d96734e0..3f4c0b167333 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -671,12 +671,6 @@ typedef struct pglist_data {
 #ifdef CONFIG_NUMA_BALANCING
 	/* Lock serializing the migrate rate limiting window */
 	spinlock_t numabalancing_migrate_lock;
-
-	/* Rate limiting time interval */
-	unsigned long numabalancing_migrate_next_window;
-
-	/* Number of pages migrated during the rate limiting time interval */
-	unsigned long numabalancing_migrate_nr_pages;
 #endif
 	/*
 	 * This is a per-node reserve of pages that are not available
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 711372845945..705b33d1e395 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -70,33 +70,6 @@ TRACE_EVENT(mm_migrate_pages,
 		__print_symbolic(__entry->mode, MIGRATE_MODE),
 		__print_symbolic(__entry->reason, MIGRATE_REASON))
 );
-
-TRACE_EVENT(mm_numa_migrate_ratelimit,
-
-	TP_PROTO(struct task_struct *p, int dst_nid, unsigned long nr_pages),
-
-	TP_ARGS(p, dst_nid, nr_pages),
-
-	TP_STRUCT__entry(
-		__array(	char,		comm,	TASK_COMM_LEN)
-		__field(	pid_t,		pid)
-		__field(	int,		dst_nid)
-		__field(	unsigned long,	nr_pages)
-	),
-
-	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
-		__entry->pid		= p->pid;
-		__entry->dst_nid	= dst_nid;
-		__entry->nr_pages	= nr_pages;
-	),
-
-	TP_printk("comm=%s pid=%d dst_nid=%d nr_pages=%lu",
-		__entry->comm,
-		__entry->pid,
-		__entry->dst_nid,
-		__entry->nr_pages)
-);
 #endif /* _TRACE_MIGRATE_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc9897f62..ad97f3ba5ec5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1167,7 +1167,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 
 	if (task_cpu(p) != new_cpu) {
 		if (p->sched_class->migrate_task_rq)
-			p->sched_class->migrate_task_rq(p);
+			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
 		rseq_migrate(p);
 		perf_event_task_migrate(p);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 997ea7b839fa..91e4202b0634 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1607,7 +1607,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 	return cpu;
 }
 
-static void migrate_task_rq_dl(struct task_struct *p)
+static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	struct rq *rq;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f808ddf2a868..7fc4a371bdd2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1392,6 +1392,17 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	int last_cpupid, this_cpupid;
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
+	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
+
+	/*
+	 * Allow first faults or private faults to migrate immediately early in
+	 * the lifetime of a task. The magic number 4 is based on waiting for
+	 * two full passes of the "multi-stage node selection" test that is
+	 * executed below.
+	 */
+	if ((p->numa_preferred_nid == -1 || p->numa_scan_seq <= 4) &&
+	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
+		return true;
 
 	/*
 	 * Multi-stage node selection is used in conjunction with a periodic
@@ -1410,7 +1421,6 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	 * This quadric squishes small probabilities, making it less likely we
 	 * act on an unlikely task<->page relation.
 	 */
-	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
 	if (!cpupid_pid_unset(last_cpupid) &&
 				cpupid_to_nid(last_cpupid) != dst_nid)
 		return false;
@@ -1514,6 +1524,21 @@ struct task_numa_env {
 static void task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
+	struct rq *rq = cpu_rq(env->dst_cpu);
+
+	/* Bail out if run-queue part of active NUMA balance. */
+	if (xchg(&rq->numa_migrate_on, 1))
+		return;
+
+	/*
+	 * Clear previous best_cpu/rq numa-migrate flag, since task now
+	 * found a better CPU to move/swap.
+	 */
+	if (env->best_cpu != -1) {
+		rq = cpu_rq(env->best_cpu);
+		WRITE_ONCE(rq->numa_migrate_on, 0);
+	}
+
 	if (env->best_task)
 		put_task_struct(env->best_task);
 	if (p)
@@ -1552,6 +1577,13 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 	return (imb > old_imb);
 }
 
+/*
+ * Maximum NUMA importance can be 1998 (2*999);
+ * SMALLIMP @ 30 would be close to 1998/64.
+ * Used to deter task migration.
+ */
+#define SMALLIMP	30
+
 /*
  * This checks if the overall compute and NUMA accesses of the system would
  * be improved if the source tasks was migrated to the target dst_cpu taking
@@ -1569,6 +1601,9 @@ static void task_numa_compare(struct task_numa_env *env,
 	long moveimp = imp;
 	int dist = env->dist;
 
+	if (READ_ONCE(dst_rq->numa_migrate_on))
+		return;
+
 	rcu_read_lock();
 	cur = task_rcu_dereference(&dst_rq->curr);
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
@@ -1582,7 +1617,7 @@ static void task_numa_compare(struct task_numa_env *env,
 		goto unlock;
 
 	if (!cur) {
-		if (maymove || imp > env->best_imp)
+		if (maymove && moveimp >= env->best_imp)
 			goto assign;
 		else
 			goto unlock;
@@ -1625,15 +1660,21 @@ static void task_numa_compare(struct task_numa_env *env,
 			       task_weight(cur, env->dst_nid, dist);
 	}
 
-	if (imp <= env->best_imp)
-		goto unlock;
-
 	if (maymove && moveimp > imp && moveimp > env->best_imp) {
-		imp = moveimp - 1;
+		imp = moveimp;
 		cur = NULL;
 		goto assign;
 	}
 
+	/*
+	 * If the NUMA importance is less than SMALLIMP,
+	 * task migration might only result in ping pong
+	 * of tasks and also hurt performance due to cache
+	 * misses.
+	 */
+	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
+		goto unlock;
+
 	/*
 	 * In the overloaded case, try and keep the load balanced.
 	 */
@@ -1710,6 +1751,7 @@ static int task_numa_migrate(struct task_struct *p)
 		.best_cpu = -1,
 	};
 	struct sched_domain *sd;
+	struct rq *best_rq;
 	unsigned long taskweight, groupweight;
 	int nid, ret, dist;
 	long taskimp, groupimp;
@@ -1805,20 +1847,17 @@ static int task_numa_migrate(struct task_struct *p)
 	if (env.best_cpu == -1)
 		return -EAGAIN;
 
-	/*
-	 * Reset the scan period if the task is being rescheduled on an
-	 * alternative node to recheck if the tasks is now properly placed.
-	 */
-	p->numa_scan_period = task_scan_start(p);
-
+	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
 		ret = migrate_task_to(p, env.best_cpu);
+		WRITE_ONCE(best_rq->numa_migrate_on, 0);
 		if (ret != 0)
 			trace_sched_stick_numa(p, env.src_cpu, env.best_cpu);
 		return ret;
 	}
 
 	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
+	WRITE_ONCE(best_rq->numa_migrate_on, 0);
 
 	if (ret != 0)
 		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
@@ -2596,6 +2635,39 @@ void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	}
 }
 
+static void update_scan_period(struct task_struct *p, int new_cpu)
+{
+	int src_nid = cpu_to_node(task_cpu(p));
+	int dst_nid = cpu_to_node(new_cpu);
+
+	if (!static_branch_likely(&sched_numa_balancing))
+		return;
+
+	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
+		return;
+
+	if (src_nid == dst_nid)
+		return;
+
+	/*
+	 * Allow resets if faults have been trapped before one scan
+	 * has completed. This is most likely due to a new task that
+	 * is pulled cross-node due to wakeups or load balancing.
+	 */
+	if (p->numa_scan_seq) {
+		/*
+		 * Avoid scan adjustments if moving to the preferred
+		 * node or if the task was not previously running on
+		 * the preferred node.
+		 */
+		if (dst_nid == p->numa_preferred_nid ||
+		    (p->numa_preferred_nid != -1 && src_nid != p->numa_preferred_nid))
+			return;
+	}
+
+	p->numa_scan_period = task_scan_start(p);
+}
+
 #else
 static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
@@ -2609,6 +2681,10 @@ static inline void account_numa_dequeue(struct rq *rq, struct task_struct *p)
 {
 }
 
+static inline void update_scan_period(struct task_struct *p, int new_cpu)
+{
+}
+
 #endif /* CONFIG_NUMA_BALANCING */
 
 static void
@@ -6275,7 +6351,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
  * cfs_rq_of(p) references at time of call are still valid and identify the
  * previous CPU. The caller guarantees p->pi_lock or task_rq(p)->lock is held.
  */
-static void migrate_task_rq_fair(struct task_struct *p)
+static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
@@ -6328,6 +6404,8 @@ static void migrate_task_rq_fair(struct task_struct *p)
 
 	/* We have migrated, no longer consider this task hot */
 	p->se.exec_start = 0;
+
+	update_scan_period(p, new_cpu);
 }
 
 static void task_dead_fair(struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8cae63c4..455fa330de04 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -783,6 +783,7 @@ struct rq {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
 	unsigned int		nr_preferred_running;
+	unsigned int		numa_migrate_on;
 #endif
 	#define CPU_LOAD_IDX_MAX 5
 	unsigned long		cpu_load[CPU_LOAD_IDX_MAX];
@@ -1523,7 +1524,7 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
-	void (*migrate_task_rq)(struct task_struct *p);
+	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index d6a2e89b086a..5e285c1249a0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1855,46 +1855,6 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
 	return newpage;
 }
 
-/*
- * page migration rate limiting control.
- * Do not migrate more than @pages_to_migrate in a @migrate_interval_millisecs
- * window of time. Default here says do not migrate more than 1280M per second.
- */
-static unsigned int migrate_interval_millisecs __read_mostly = 100;
-static unsigned int ratelimit_pages __read_mostly = 128 << (20 - PAGE_SHIFT);
-
-/* Returns true if the node is migrate rate-limited after the update */
-static bool numamigrate_update_ratelimit(pg_data_t *pgdat,
-					unsigned long nr_pages)
-{
-	/*
-	 * Rate-limit the amount of data that is being migrated to a node.
-	 * Optimal placement is no good if the memory bus is saturated and
-	 * all the time is being spent migrating!
-	 */
-	if (time_after(jiffies, pgdat->numabalancing_migrate_next_window)) {
-		spin_lock(&pgdat->numabalancing_migrate_lock);
-		pgdat->numabalancing_migrate_nr_pages = 0;
-		pgdat->numabalancing_migrate_next_window = jiffies +
-			msecs_to_jiffies(migrate_interval_millisecs);
-		spin_unlock(&pgdat->numabalancing_migrate_lock);
-	}
-	if (pgdat->numabalancing_migrate_nr_pages > ratelimit_pages) {
-		trace_mm_numa_migrate_ratelimit(current, pgdat->node_id,
-								nr_pages);
-		return true;
-	}
-
-	/*
-	 * This is an unlocked non-atomic update so errors are possible.
-	 * The consequences are failing to migrate when we potentiall should
-	 * have which is not severe enough to warrant locking. If it is ever
-	 * a problem, it can be converted to a per-cpu counter.
-	 */
-	pgdat->numabalancing_migrate_nr_pages += nr_pages;
-	return false;
-}
-
 static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
 	int page_lru;
@@ -1967,14 +1927,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	if (page_is_file_cache(page) && PageDirty(page))
 		goto out;
 
-	/*
-	 * Rate-limit the amount of data that is being migrated to a node.
-	 * Optimal placement is no good if the memory bus is saturated and
-	 * all the time is being spent migrating!
-	 */
-	if (numamigrate_update_ratelimit(pgdat, 1))
-		goto out;
-
 	isolated = numamigrate_isolate_page(pgdat, page);
 	if (!isolated)
 		goto out;
@@ -2021,14 +1973,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	unsigned long mmun_start = address & HPAGE_PMD_MASK;
 	unsigned long mmun_end = mmun_start + HPAGE_PMD_SIZE;
 
-	/*
-	 * Rate-limit the amount of data that is being migrated to a node.
-	 * Optimal placement is no good if the memory bus is saturated and
-	 * all the time is being spent migrating!
-	 */
-	if (numamigrate_update_ratelimit(pgdat, HPAGE_PMD_NR))
-		goto out_dropref;
-
 	new_page = alloc_pages_node(node,
 		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
 		HPAGE_PMD_ORDER);
@@ -2125,7 +2069,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 
 out_fail:
 	count_vm_events(PGMIGRATE_FAIL, HPAGE_PMD_NR);
-out_dropref:
 	ptl = pmd_lock(mm, pmd);
 	if (pmd_same(*pmd, entry)) {
 		entry = pmd_modify(entry, vma->vm_page_prot);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 89d2a2ab3fe6..706a738c0aee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6197,8 +6197,6 @@ static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
 static void pgdat_init_numabalancing(struct pglist_data *pgdat)
 {
 	spin_lock_init(&pgdat->numabalancing_migrate_lock);
-	pgdat->numabalancing_migrate_nr_pages = 0;
-	pgdat->numabalancing_migrate_next_window = jiffies;
 }
 #else
 static void pgdat_init_numabalancing(struct pglist_data *pgdat) {}
