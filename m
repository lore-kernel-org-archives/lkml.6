Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83172C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1893E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Q84J9xIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1893E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbeIHCYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:15 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:43235 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbeIHCYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356478; x=1567892478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uDcSm583l5dIuuv1Ov9Iifp0Hl4nyKOqffrNNFSM2Fo=;
  b=Q84J9xIL7gHVn8qn+quNS2Oj0Nd3i4QXlYGXHjdHx73MGKrerfHz4EVU
   RRkndBoc+TbiT0/Pn3HwIl68tTFLfL0ESNO95IRgseUkaedLHMy1yChf1
   Xtt5W9YcQLoemu2Xb+hBlJ13naZczSB2sLQOHG2bRKGs/1JhvgBha+RGq
   0=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696509856"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:16 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfAHh014249
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:12 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lf82T027090
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:08 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lf7IN027086;
        Fri, 7 Sep 2018 23:41:07 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 01/60] sched: Store task_group->se[] pointers as part of cfs_rq
Date:   Fri,  7 Sep 2018 23:39:48 +0200
Message-Id: <20180907214047.26914-2-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move around the storage location of the scheduling entity references
of task groups. Instead of linking them from the task_group struct,
link each SE from the CFS runqueue itself with a new field "my_se".

This resembles the "my_q" field that is already available, just in
the other direction.

Adjust all users, simplifying many of them.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c  |  7 ++-----
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 36 ++++++++++++++++--------------------
 kernel/sched/sched.h |  5 ++---
 4 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc9897f62..fd1b0abd8474 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5915,7 +5915,7 @@ void __init sched_init(void)
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
+	alloc_size += nr_cpu_ids * sizeof(void **);
 #endif
 #ifdef CONFIG_RT_GROUP_SCHED
 	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
@@ -5924,9 +5924,6 @@ void __init sched_init(void)
 		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.se = (struct sched_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
-
 		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
 
@@ -6746,7 +6743,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		int i;
 
 		for_each_possible_cpu(i)
-			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+			ws += schedstat_val(tg->cfs_rq[i]->my_se->statistics.wait_sum);
 
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 60caf1fb94e0..4045bd8b2e5d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -385,7 +385,7 @@ void unregister_sched_domain_sysctl(void)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group *tg)
 {
-	struct sched_entity *se = tg->se[cpu];
+	struct sched_entity *se = tg->cfs_rq[cpu]->my_se;
 
 #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
 #define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)schedstat_val(F))
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb596f6c1..638fd14bb6c4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4367,7 +4367,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	long task_delta, dequeue = 1;
 	bool empty;
 
-	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
+	se = cfs_rq->my_se;
 
 	/* freeze hierarchy runnable averages while throttled */
 	rcu_read_lock();
@@ -4421,7 +4421,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	int enqueue = 1;
 	long task_delta;
 
-	se = cfs_rq->tg->se[cpu_of(rq)];
+	se = cfs_rq->my_se;
 
 	cfs_rq->throttled = 0;
 
@@ -7284,7 +7284,7 @@ static void update_blocked_averages(int cpu)
 			update_tg_load_avg(cfs_rq, 0);
 
 		/* Propagate pending load changes to the parent, if any: */
-		se = cfs_rq->tg->se[cpu];
+		se = cfs_rq->my_se;
 		if (se && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, 0);
 
@@ -7321,8 +7321,7 @@ static void update_blocked_averages(int cpu)
  */
 static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 {
-	struct rq *rq = rq_of(cfs_rq);
-	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
+	struct sched_entity *se = cfs_rq->my_se;
 	unsigned long now = jiffies;
 	unsigned long load;
 
@@ -9819,15 +9818,15 @@ void free_fair_sched_group(struct task_group *tg)
 
 	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
+	if (!tg->cfs_rq)
+		return;
+
 	for_each_possible_cpu(i) {
-		if (tg->cfs_rq)
-			kfree(tg->cfs_rq[i]);
-		if (tg->se)
-			kfree(tg->se[i]);
+		kfree(tg->cfs_rq[i]->my_se);
+		kfree(tg->cfs_rq[i]);
 	}
 
 	kfree(tg->cfs_rq);
-	kfree(tg->se);
 }
 
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
@@ -9839,9 +9838,6 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
 	if (!tg->cfs_rq)
 		goto err;
-	tg->se = kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
-	if (!tg->se)
-		goto err;
 
 	tg->shares = NICE_0_LOAD;
 
@@ -9859,7 +9855,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 			goto err_free_rq;
 
 		init_cfs_rq(cfs_rq);
-		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
+		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->cfs_rq[i]->my_se);
 		init_entity_runnable_average(se);
 	}
 
@@ -9879,7 +9875,7 @@ void online_fair_sched_group(struct task_group *tg)
 
 	for_each_possible_cpu(i) {
 		rq = cpu_rq(i);
-		se = tg->se[i];
+		se = tg->cfs_rq[i]->my_se;
 
 		raw_spin_lock_irq(&rq->lock);
 		update_rq_clock(rq);
@@ -9896,8 +9892,8 @@ void unregister_fair_sched_group(struct task_group *tg)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		if (tg->se[cpu])
-			remove_entity_load_avg(tg->se[cpu]);
+		if (tg->cfs_rq[cpu]->my_se)
+			remove_entity_load_avg(tg->cfs_rq[cpu]->my_se);
 
 		/*
 		 * Only empty task groups can be destroyed; so we can speculatively
@@ -9925,7 +9921,7 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	init_cfs_rq_runtime(cfs_rq);
 
 	tg->cfs_rq[cpu] = cfs_rq;
-	tg->se[cpu] = se;
+	cfs_rq->my_se = se;
 
 	/* se could be NULL for root_task_group */
 	if (!se)
@@ -9954,7 +9950,7 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	/*
 	 * We can't change the weight of the root cgroup.
 	 */
-	if (!tg->se[0])
+	if (!tg->cfs_rq[0]->my_se)
 		return -EINVAL;
 
 	shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));
@@ -9966,7 +9962,7 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	tg->shares = shares;
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
-		struct sched_entity *se = tg->se[i];
+		struct sched_entity *se = tg->cfs_rq[i]->my_se;
 		struct rq_flags rf;
 
 		/* Propagate contribution to hierarchy */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8cae63c4..8435bf70a701 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -354,8 +354,6 @@ struct task_group {
 	struct cgroup_subsys_state css;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	/* schedulable entities of this group on each CPU */
-	struct sched_entity	**se;
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
@@ -537,6 +535,7 @@ struct cfs_rq {
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	struct rq		*rq;	/* CPU runqueue to which this cfs_rq is attached */
+	struct sched_entity	*my_se;	/* entity representing this cfs_rq */
 
 	/*
 	 * leaf cfs_rqs are those that hold tasks (lowest schedulable entity in
@@ -1301,7 +1300,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
 	p->se.cfs_rq = tg->cfs_rq[cpu];
-	p->se.parent = tg->se[cpu];
+	p->se.parent = tg->cfs_rq[cpu]->my_se;
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-- 
2.9.3.1.gcba166c.dirty

