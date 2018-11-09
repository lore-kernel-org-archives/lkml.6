Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C9EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1303F20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YbCxH2v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1303F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeKIWlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:41:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54596 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeKIWlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:41:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA9Cwu7x122076;
        Fri, 9 Nov 2018 13:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=x7hLG6gfb0R5Ne7LUdpuIFBswxvF4Q1RLYfxtCo80i4=;
 b=YbCxH2v2f2cSkiAJuKKWwGbVIi5ltD1Gw9Qg+1r1tsd0VSGedLZCqA8AIfNazGKPy1Jt
 groYT8RCCt7q65PbWwr4rUIZha8T95p8j7J4PvoZkMAHZLjhssKxLqB2s3ZRGcUx3rWM
 FRc8PpNmhxsMHNtY4BLyiE4ru8HhAUP+xXlmcrkfgU7EEygaPXfIUs+y9FeKq5ycHOH2
 alLsQto9iiafUzrbBl5KrfkSgHpTzHo78DYzAcBYG0ksmWqAAUnOIfC+rzDipD9+4fuD
 5tbPM0uqWnHc4+2aI8yQ8qu5GgbKIgTGPBjD4ZoZVYH+g6qMQhZX142cthVZ/Oldool1 xw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nh3mq6x3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 13:00:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA9D0Ag6006169
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 13:00:10 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA9D09Su028141;
        Fri, 9 Nov 2018 13:00:09 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 05:00:09 -0800
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] sched/fair: Dynamically update cfs_overload_cpus
Date:   Fri,  9 Nov 2018 04:50:34 -0800
Message-Id: <1541767840-93588-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An overloaded CPU has more than 1 runnable task.  When a CFS task wakes
on a CPU, if h_nr_running transitions from 1 to more, then set the CPU in
the cfs_overload_cpus bitmap.  When a CFS task sleeps, if h_nr_running
transitions from 2 to less, then clear the CPU in cfs_overload_cpus.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/fair.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee271bb..9031d39 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -23,6 +23,7 @@
 #include "sched.h"
 
 #include <trace/events/sched.h>
+#include <linux/sparsemask.h>
 
 /*
  * Targeted preemption latency for CPU-bound tasks:
@@ -3724,6 +3725,28 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 	rq->misfit_task_load = task_h_load(p);
 }
 
+static void overload_clear(struct rq *rq)
+{
+	struct sparsemask *overload_cpus;
+
+	rcu_read_lock();
+	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
+	if (overload_cpus)
+		sparsemask_clear_elem(rq->cpu, overload_cpus);
+	rcu_read_unlock();
+}
+
+static void overload_set(struct rq *rq)
+{
+	struct sparsemask *overload_cpus;
+
+	rcu_read_lock();
+	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
+	if (overload_cpus)
+		sparsemask_set_elem(rq->cpu, overload_cpus);
+	rcu_read_unlock();
+}
+
 #else /* CONFIG_SMP */
 
 #define UPDATE_TG	0x0
@@ -3747,6 +3770,9 @@ static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
 	return 0;
 }
 
+static inline void overload_clear(struct rq *rq) {}
+static inline void overload_set(struct rq *rq) {}
+
 static inline void
 util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 
@@ -4441,6 +4467,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
+	unsigned int prev_nr = rq->cfs.h_nr_running;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, dequeue = 1;
@@ -4468,8 +4495,12 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 			dequeue = 0;
 	}
 
-	if (!se)
+	if (!se) {
 		sub_nr_running(rq, task_delta);
+		if (prev_nr >= 2 && prev_nr - task_delta < 2)
+			overload_clear(rq);
+
+	}
 
 	cfs_rq->throttled = 1;
 	cfs_rq->throttled_clock = rq_clock(rq);
@@ -4499,6 +4530,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
+	unsigned int prev_nr = rq->cfs.h_nr_running;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	int enqueue = 1;
@@ -4535,8 +4567,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			break;
 	}
 
-	if (!se)
+	if (!se) {
 		add_nr_running(rq, task_delta);
+		if (prev_nr < 2 && prev_nr + task_delta >= 2)
+			overload_set(rq);
+	}
 
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
@@ -5082,6 +5117,7 @@ static inline void hrtick_update(struct rq *rq)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	unsigned int prev_nr = rq->cfs.h_nr_running;
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5129,8 +5165,12 @@ static inline void hrtick_update(struct rq *rq)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	if (!se) {
 		add_nr_running(rq, 1);
+		if (prev_nr == 1)
+			overload_set(rq);
+
+	}
 
 	hrtick_update(rq);
 }
@@ -5147,6 +5187,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
+	unsigned int prev_nr = rq->cfs.h_nr_running;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -5188,8 +5229,11 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	if (!se) {
 		sub_nr_running(rq, 1);
+		if (prev_nr == 2)
+			overload_clear(rq);
+	}
 
 	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
-- 
1.8.3.1

