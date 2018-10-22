Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FCC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CEB2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YRQXWf7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CEB2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeJVX2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52264 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeJVX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF49Vv104001;
        Mon, 22 Oct 2018 15:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=/K5xY4UMqAkT/2G39aOFk4aGbPXnfFdoKlxtk2kbsQA=;
 b=YRQXWf7h4Y6OeIMD2U9k5tUjmBoNKW46FhiasV6MMvSLs7GSay8rHTDXpkooUBfvuehQ
 SDnegsWUDWHv7KcFpydAw7HACwzsDNCxGCk2CpBL5K7wdqwt5Llg5SgTlINgq0PtzmZh
 HRn9vYg+cPd2ZODpA031MoccETTueHDfyTEHT9I5UqXokowv6nETod04r/hubjfRL40X
 oYg9WodbpFgCJdi1B8cE9YR3zFa2VMWaDKP06IfznaIKi09LG4h7b46DO3p4xrjReQTW
 qN3mzG/044cz9yi58T3nyJjR1LrQJk4P39DogwvIy0pABISiC5nRAyKi+nWLif2+vEbF pg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qf4tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF995k008949
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:09 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MF98nS029268;
        Mon, 22 Oct 2018 15:09:08 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:08 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] sched/fair: Dynamically update cfs_overload_cpus
Date:   Mon, 22 Oct 2018 07:59:35 -0700
Message-Id: <1540220381-424433-5-git-send-email-steven.sistare@oracle.com>
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

An overloaded CPU has more than 1 runnable task.  When a CFS task wakes
on a CPU, if h_nr_running transitions from 1 to more, then set the CPU in
the cfs_overload_cpus bitmap.  When a CFS task sleeps, if h_nr_running
transitions from 2 to less, then clear the CPU in cfs_overload_cpus.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/fair.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7fc4a37..c623338 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -23,6 +23,7 @@
 #include "sched.h"
 
 #include <trace/events/sched.h>
+#include <linux/sparsemask.h>
 
 /*
  * Targeted preemption latency for CPU-bound tasks:
@@ -3723,6 +3724,28 @@ static inline bool within_margin(int value, int margin)
 	WRITE_ONCE(p->se.avg.util_est, ue);
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
@@ -3746,6 +3769,9 @@ static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
 	return 0;
 }
 
+static inline void overload_clear(struct rq *rq) {}
+static inline void overload_set(struct rq *rq) {}
+
 static inline void
 util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 
@@ -4439,6 +4465,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
+	unsigned int prev_nr = rq->cfs.h_nr_running;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, dequeue = 1;
@@ -4466,8 +4493,12 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -4493,6 +4524,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
+	unsigned int prev_nr = rq->cfs.h_nr_running;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	int enqueue = 1;
@@ -4529,8 +4561,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -5064,6 +5099,7 @@ static inline void hrtick_update(struct rq *rq)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	unsigned int prev_nr = rq->cfs.h_nr_running;
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5111,8 +5147,12 @@ static inline void hrtick_update(struct rq *rq)
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
@@ -5129,6 +5169,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
+	unsigned int prev_nr = rq->cfs.h_nr_running;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -5170,8 +5211,11 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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

