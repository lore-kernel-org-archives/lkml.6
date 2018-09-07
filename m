Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBC0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072BA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="oX6VQs5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072BA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbeIHC1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:27:22 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:25342 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeIHC1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356665; x=1567892665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4pRsmGqdugcRrG2MlZySzZAQSI0j4Y4+vQkmTRohyw=;
  b=oX6VQs5HpV17Sazviu4pMpR9B8AXdi3Heq+ta/CO6+d9k7cd+SS+Sby5
   u9fcfTfBF78RgMWtgkpo9cn9puHiwHbdQmjJj+J+cGYPzPUQFW+jh4Q8W
   G2RAyc+G/vRy/leMEeCnZLle2a+bYLfvmpuZjGrkBOQyW8s3O0nJM23vy
   U=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="355981087"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:24 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lh58t053112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:43:08 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgxbV027838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:59 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgwHt027834;
        Fri, 7 Sep 2018 23:42:58 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 55/60] cosched: Adjust task selection for coscheduling
Date:   Fri,  7 Sep 2018 23:40:42 +0200
Message-Id: <20180907214047.26914-56-jschoenh@amazon.de>
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

Introduce the selection and notification mechanism used to realize
coscheduling.

Every CPU starts selecting tasks from its current_sdrq, which points
into the currently active coscheduled set and which is only updated by
the leader. Whenever task selection crosses a hierarchy level, the
leaders of the next hierarchy level are notified to switch coscheduled
sets.

Contrary to the original task picking algorithm, we're no longer
guaranteed to find an executable task, as the coscheduled set may
be partly idle. If that is the case and the (not yet adjusted) idle
balancing also cannot find something to execute, then we force the
CPU into idle.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 150 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 137 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9e8b8119cdea..07fd9dd5561d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -591,6 +591,75 @@ static inline int __leader_of(struct sched_entity *se)
 #define for_each_owned_sched_entity(se) \
 	for (; se; se = owned_parent_entity(se))
 
+#ifdef CONFIG_COSCHEDULING
+static struct sdrq *get_and_set_next_sdrq(struct sdrq *sdrq)
+{
+	int cpu = sdrq->data->leader;
+	struct sdrq *child_sdrq;
+	struct sdrq *ret = NULL;
+
+	/* find our child, notify others */
+	list_for_each_entry(child_sdrq, &sdrq->children, siblings) {
+		/* FIXME: should protect against leader change of child_sdrq */
+		if (cpu == child_sdrq->data->leader) {
+			/* this is our child */
+			ret = child_sdrq;
+			child_sdrq->data->current_sdrq = child_sdrq;
+		} else {
+			/* not our child, notify it */
+			if (child_sdrq->data->current_sdrq != child_sdrq) {
+				WRITE_ONCE(child_sdrq->data->current_sdrq,
+					   child_sdrq);
+				resched_cpu_locked(child_sdrq->data->leader);
+			}
+		}
+	}
+	return ret;
+}
+
+static void notify_remaining_sdrqs(struct cfs_rq *cfs_rq)
+{
+	struct sdrq *sdrq = &cfs_rq->sdrq;
+
+	while (sdrq)
+		sdrq = get_and_set_next_sdrq(sdrq);
+}
+
+static struct cfs_rq *pick_next_cfs(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	if (!is_sd_se(se))
+		return group_cfs_rq(se);
+
+	cfs_rq = get_and_set_next_sdrq(&cfs_rq->sdrq)->cfs_rq;
+
+	if (!cfs_rq->nr_running || cfs_rq->throttled) {
+		notify_remaining_sdrqs(cfs_rq);
+		return NULL;
+	}
+
+	return cfs_rq;
+}
+
+static struct cfs_rq *current_cfs(struct rq *rq)
+{
+	struct sdrq *sdrq = READ_ONCE(rq->sdrq_data.current_sdrq);
+
+	return sdrq->cfs_rq;
+}
+#else
+static struct cfs_rq *pick_next_cfs(struct sched_entity *se)
+{
+	return group_cfs_rq(se);
+}
+
+static struct cfs_rq *current_cfs(struct rq *rq)
+{
+	return &rq->cfs;
+}
+#endif
+
 /**************************************************************
  * Scheduling class tree data structure manipulation methods:
  */
@@ -6901,14 +6970,31 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 {
 	struct cfs_rq *cfs_rq, *top_cfs_rq;
 	struct rq_owner_flags orf;
-	struct sched_entity *se;
-	struct task_struct *p;
-	int new_tasks;
+	struct sched_entity *se = NULL;
+	struct task_struct *p = NULL;
+	int new_tasks = 0;
 
 again:
-	top_cfs_rq = cfs_rq = &rq_lock_owned(rq, &orf)->cfs;
-	if (!cfs_rq->nr_running)
+	top_cfs_rq = cfs_rq = current_cfs(rq_lock_owned(rq, &orf));
+	/*
+	 * FIXME: There are issues with respect to the scheduling
+	 * classes, if there was a class between fair and idle.
+	 * Then, greater care must be taken whether it is appropriate
+	 * to return NULL to give the next class a chance to run,
+	 * or to return the idle-thread so that nothing else runs.
+	 */
+
+	if (!cfs_rq->nr_running || cfs_rq->throttled) {
+#ifdef CONFIG_COSCHEDULING
+		notify_remaining_sdrqs(cfs_rq);
+		if (!cfs_rq->sdrq.is_root) {
+			se = cfs_rq->sdrq.sd_parent->sd_se;
+			put_prev_task(rq, prev);
+			goto retidle;
+		}
+#endif
 		goto idle;
+	}
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (prev->sched_class != &fair_sched_class)
@@ -6946,17 +7032,29 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 			if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
 				cfs_rq = top_cfs_rq;
 
-				if (!cfs_rq->nr_running)
+				if (!cfs_rq->nr_running || cfs_rq->throttled) {
+#ifdef CONFIG_COSCHEDULING
+					notify_remaining_sdrqs(cfs_rq);
+					if (!cfs_rq->sdrq.is_root) {
+						se = cfs_rq->sdrq.sd_parent->sd_se;
+						put_prev_task(rq, prev);
+						goto retidle;
+					}
+#endif
 					goto idle;
+				}
 
 				goto simple;
 			}
 		}
 
 		se = pick_next_entity(cfs_rq, curr);
-		cfs_rq = group_cfs_rq(se);
+		cfs_rq = pick_next_cfs(se);
 	} while (cfs_rq);
 
+	if (is_sd_se(se))
+		se = cosched_set_idle(rq, se);
+
 	p = task_of(se);
 
 	/*
@@ -6966,23 +7064,31 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	 */
 	if (prev != p) {
 		struct sched_entity *pse = &prev->se;
+		int cpu = leader_of(pse);
+
+		if (cosched_is_idle(rq, p))
+			se = cosched_get_idle_se(rq);
 
 		while (!(cfs_rq = is_same_group(se, pse))) {
 			int se_depth = se->depth;
 			int pse_depth = pse->depth;
 
-			if (se_depth <= pse_depth) {
+			if (se_depth <= pse_depth && leader_of(pse) == cpu) {
 				put_prev_entity(cfs_rq_of(pse), pse);
 				pse = parent_entity(pse);
 			}
-			if (se_depth >= pse_depth) {
+			if (se_depth >= pse_depth && leader_of(se) == cpu) {
 				set_next_entity(cfs_rq_of(se), se);
 				se = parent_entity(se);
 			}
+			if (leader_of(pse) != cpu && leader_of(se) != cpu)
+				break;
 		}
 
-		put_prev_entity(cfs_rq, pse);
-		set_next_entity(cfs_rq, se);
+		if (leader_of(pse) == cpu)
+			put_prev_entity(cfs_rq, pse);
+		if (leader_of(se) == cpu)
+			set_next_entity(cfs_rq, se);
 	}
 
 	goto done;
@@ -6994,9 +7100,13 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	do {
 		se = pick_next_entity(cfs_rq, NULL);
 		set_next_entity(cfs_rq, se);
-		cfs_rq = group_cfs_rq(se);
+		cfs_rq = pick_next_cfs(se);
 	} while (cfs_rq);
 
+retidle: __maybe_unused;
+	if (is_sd_se(se))
+		se = cosched_set_idle(rq, se);
+
 	p = task_of(se);
 
 done: __maybe_unused;
@@ -7006,7 +7116,8 @@ done: __maybe_unused;
 	 * the list, so our cfs_tasks list becomes MRU
 	 * one.
 	 */
-	list_move(&p->se.group_node, &rq->cfs_tasks);
+	if (!cosched_is_idle(rq, p))
+		list_move(&p->se.group_node, &rq->cfs_tasks);
 #endif
 
 	if (hrtick_enabled(rq))
@@ -7019,6 +7130,19 @@ done: __maybe_unused;
 idle:
 	rq_unlock_owned(rq, &orf);
 
+#ifdef CONFIG_COSCHEDULING
+	/*
+	 * With coscheduling idle_balance() may think there are tasks, when they
+	 * are in fact not eligible right now. Exit, if we still did not find
+	 * a suitable task after one idle_balance() round.
+	 *
+	 * FIXME: idle_balance() should only look at tasks that can actually
+	 *        be executed.
+	 */
+	if (new_tasks)
+		return NULL;
+#endif
+
 	new_tasks = idle_balance(rq, rf);
 
 	/*
-- 
2.9.3.1.gcba166c.dirty

