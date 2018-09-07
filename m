Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F34C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F152083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="PrmHjEjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F152083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeIHC0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:26:05 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:52451 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbeIHC0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356587; x=1567892587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K9aJ8DJEQMllulzw2sihXE8g9779xgpbghjXne0iJJI=;
  b=PrmHjEjl3QCJ+oLgDG3iM+WZxkw+bZEauj48c6NYl8d3DsQvWM2Zyc+y
   QfL/zpAJkEzwN7yjIqc+MZwPGntLS07ayelyWSZ4oEXedl56zImm6KqEX
   4B2YcjfFVYZ0CiKIVviFrbdUFVTGRBP1jLkSSA/MWxRDQgsCg60c82HUf
   8=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530522"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:03 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgtLs043641
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:57 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lgr0r027801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:54 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgrPC027800;
        Fri, 7 Sep 2018 23:42:53 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 52/60] cosched: Support SD-SEs in enqueuing and dequeuing
Date:   Fri,  7 Sep 2018 23:40:39 +0200
Message-Id: <20180907214047.26914-53-jschoenh@amazon.de>
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

SD-SEs require some attention during enqueuing and dequeuing. In some
aspects they behave similar to TG-SEs, for example, we must not dequeue
a SD-SE if it still represents other load. But SD-SEs are also different
due to the concurrent load updates by multiple CPUs and that we need to
be careful when to access it, as an SD-SE belongs to the next hierarchy
level which is protected by a different lock.

Make sure to propagate enqueues and dequeues correctly, and to notify
the leader when needed.

Additionally, we define cfs_rq->h_nr_running to refer to number tasks
and SD-SEs below the CFS runqueue without drilling down into SD-SEs.
(Phrased differently, h_nr_running counts non-TG-SEs along the task
group hierarchy.) This makes later adjustments for load-balancing
more natural, as SD-SEs now appear similar to tasks, allowing to
balance coscheduled sets individually.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 483db54ee20a..bc219c9c3097 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4600,17 +4600,40 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
 			break;
+		if (is_sd_se(se)) {
+			/*
+			 * don't dequeue sd_se if it represents other
+			 * children besides the dequeued one
+			 */
+			if (se->load.weight)
+				dequeue = 0;
+
+			task_delta = 1;
+		}
 
 		if (dequeue)
 			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
+		if (dequeue && is_sd_se(se)) {
+			/*
+			 * If we dequeued an SD-SE and we are not the leader,
+			 * the leader might want to select another task group
+			 * right now.
+			 *
+			 * FIXME: Change leadership instead?
+			 */
+			if (leader_of(se) != cpu_of(rq))
+				resched_cpu_locked(leader_of(se));
+		}
+		if (!dequeue && is_sd_se(se))
+			break;
 		qcfs_rq->h_nr_running -= task_delta;
 
 		if (qcfs_rq->load.weight)
 			dequeue = 0;
 	}
 
-	if (!se)
-		sub_nr_running(rq, task_delta);
+	if (!se || !is_cpu_rq(hrq_of(cfs_rq_of(se))))
+		sub_nr_running(rq, cfs_rq->h_nr_running);
 
 	rq_chain_unlock(&rc);
 
@@ -4641,8 +4664,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	int enqueue = 1;
-	long task_delta;
+	long task_delta, orig_task_delta;
 	struct rq_chain rc;
+#ifdef CONFIG_COSCHEDULING
+	int lcpu = rq->sdrq_data.leader;
+#endif
 
 	SCHED_WARN_ON(!is_cpu_rq(rq));
 
@@ -4669,24 +4695,40 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		return;
 
 	task_delta = cfs_rq->h_nr_running;
+	orig_task_delta = task_delta;
 	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
 		rq_chain_lock(&rc, se);
 		update_sdse_load(se);
 		if (se->on_rq)
 			enqueue = 0;
+		if (is_sd_se(se))
+			task_delta = 1;
 
 		cfs_rq = cfs_rq_of(se);
 		if (enqueue)
 			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
+		if (!enqueue && is_sd_se(se))
+			break;
 		cfs_rq->h_nr_running += task_delta;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
+
+#ifdef CONFIG_COSCHEDULING
+		/*
+		 * FIXME: Pro-actively reschedule the leader, can't tell
+		 *        currently whether we actually have to.
+		 */
+		if (lcpu != cfs_rq->sdrq.data->leader) {
+			lcpu = cfs_rq->sdrq.data->leader;
+			resched_cpu_locked(lcpu);
+		}
+#endif /* CONFIG_COSCHEDULING */
 	}
 
-	if (!se)
-		add_nr_running(rq, task_delta);
+	if (!se || !is_cpu_rq(hrq_of(cfs_rq_of(se))))
+		add_nr_running(rq, orig_task_delta);
 
 	rq_chain_unlock(&rc);
 
@@ -5213,6 +5255,9 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 {
 	struct cfs_rq *cfs_rq;
 	struct rq_chain rc;
+#ifdef CONFIG_COSCHEDULING
+	int lcpu = rq->sdrq_data.leader;
+#endif
 
 	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
@@ -5221,6 +5266,8 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 		if (se->on_rq)
 			break;
 		cfs_rq = cfs_rq_of(se);
+		if (is_sd_se(se))
+			task_delta = 1;
 		enqueue_entity(cfs_rq, se, flags);
 
 		/*
@@ -5234,6 +5281,22 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 		cfs_rq->h_nr_running += task_delta;
 
 		flags = ENQUEUE_WAKEUP;
+
+#ifdef CONFIG_COSCHEDULING
+		/*
+		 * FIXME: Pro-actively reschedule the leader, can't tell
+		 *        currently whether we actually have to.
+		 *
+		 *        There are some cases that slip through
+		 *        check_preempt_curr(), like the leader not getting
+		 *        notified (and not becoming aware of the addition
+		 *        timely), when an RT task is running.
+		 */
+		if (lcpu != cfs_rq->sdrq.data->leader) {
+			lcpu = cfs_rq->sdrq.data->leader;
+			resched_cpu_locked(lcpu);
+		}
+#endif /* CONFIG_COSCHEDULING */
 	}
 
 	for_each_sched_entity(se) {
@@ -5241,6 +5304,9 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 		rq_chain_lock(&rc, se);
 		update_sdse_load(se);
 		cfs_rq = cfs_rq_of(se);
+
+		if (is_sd_se(se))
+			task_delta = 0;
 		cfs_rq->h_nr_running += task_delta;
 
 		if (cfs_rq_throttled(cfs_rq))
@@ -5304,8 +5370,36 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 		rq_chain_lock(&rc, se);
 		update_sdse_load(se);
 		cfs_rq = cfs_rq_of(se);
+
+		if (is_sd_se(se)) {
+			/*
+			 * don't dequeue sd_se if it represents other
+			 * children besides the dequeued one
+			 */
+			if (se->load.weight)
+				break;
+
+			/* someone else did our job */
+			if (!se->on_rq)
+				break;
+
+			task_delta = 1;
+		}
+
 		dequeue_entity(cfs_rq, se, flags);
 
+		if (is_sd_se(se)) {
+			/*
+			 * If we dequeued an SD-SE and we are not the leader,
+			 * the leader might want to select another task group
+			 * right now.
+			 *
+			 * FIXME: Change leadership instead?
+			 */
+			if (leader_of(se) != cpu_of(rq))
+				resched_cpu_locked(leader_of(se));
+		}
+
 		/*
 		 * end evaluation on encountering a throttled cfs_rq
 		 *
@@ -5339,6 +5433,9 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 		rq_chain_lock(&rc, se);
 		update_sdse_load(se);
 		cfs_rq = cfs_rq_of(se);
+
+		if (is_sd_se(se))
+			task_delta = 0;
 		cfs_rq->h_nr_running -= task_delta;
 
 		if (cfs_rq_throttled(cfs_rq))
-- 
2.9.3.1.gcba166c.dirty

