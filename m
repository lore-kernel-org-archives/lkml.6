Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF18C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC379206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="tJz5JoxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC379206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeIHCci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:32:38 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:42560 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbeIHCZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356577; x=1567892577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YZeaBs6bQwAyKdtvL96N+LC8VPinOgTwTPuPCYkvXsw=;
  b=tJz5JoxF4fEIWCfQWncHYW3CxtZuTnfcD+iV5QL26J4UelkmwGPtXDo6
   E1EKsW9ymlkKZ9yHK55OUTHT+pElzdCvFcvRWn4dko0y/rBf5ju2OkKRB
   QKyHIU4NeEzllu7zIHiWARwmQszdqpgNntTMezxzy/+6/qFkX4kvY+Kj3
   8=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696510016"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:56 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgoBL056568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:52 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lgmko027751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:48 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lglul027750;
        Fri, 7 Sep 2018 23:42:47 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 49/60] cosched: Adjust locking for enqueuing and dequeueing
Date:   Fri,  7 Sep 2018 23:40:36 +0200
Message-Id: <20180907214047.26914-50-jschoenh@amazon.de>
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

Enqueuing and dequeuing of tasks (or entities) are a general activities
that span across leader boundaries. They start from the bottom of the
runqueue hierarchy and bubble upwards, until they hit their terminating
condition (for example, enqueuing stops when the parent entity is already
enqueued).

We employ chain-locking in these cases to minimize lock contention.
For example, if enqueuing has moved past a hierarchy level of a different
leader, that leader can already make scheduling decisions again. Also,
this opens the possibility to combine concurrent enqueues/dequeues to
some extend, so that only one of multiple CPUs has to walk up the
hierarchy.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d64f4478fda..0dc4d289497c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4510,6 +4510,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct sched_entity *se;
 	long task_delta, dequeue = 1;
 	bool empty;
+	struct rq_chain rc;
 
 	/*
 	 * FIXME: We can only handle CPU runqueues at the moment.
@@ -4532,8 +4533,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	rcu_read_unlock();
 
 	task_delta = cfs_rq->h_nr_running;
+	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
+
+		rq_chain_lock(&rc, se);
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
 			break;
@@ -4549,6 +4553,8 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	if (!se)
 		sub_nr_running(rq, task_delta);
 
+	rq_chain_unlock(&rc);
+
 	cfs_rq->throttled = 1;
 	cfs_rq->throttled_clock = rq_clock(rq);
 	raw_spin_lock(&cfs_b->lock);
@@ -4577,6 +4583,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct sched_entity *se;
 	int enqueue = 1;
 	long task_delta;
+	struct rq_chain rc;
 
 	SCHED_WARN_ON(!is_cpu_rq(rq));
 
@@ -4598,7 +4605,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		return;
 
 	task_delta = cfs_rq->h_nr_running;
+	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
+		rq_chain_lock(&rc, se);
 		if (se->on_rq)
 			enqueue = 0;
 
@@ -4614,6 +4623,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	if (!se)
 		add_nr_running(rq, task_delta);
 
+	rq_chain_unlock(&rc);
+
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && nr_cfs_tasks(rq))
 		resched_curr(rq);
@@ -5136,8 +5147,11 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 			 unsigned int task_delta)
 {
 	struct cfs_rq *cfs_rq;
+	struct rq_chain rc;
 
+	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
+		rq_chain_lock(&rc, se);
 		if (se->on_rq)
 			break;
 		cfs_rq = cfs_rq_of(se);
@@ -5157,6 +5171,8 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 	}
 
 	for_each_sched_entity(se) {
+		/* FIXME: taking locks up to the top is bad */
+		rq_chain_lock(&rc, se);
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running += task_delta;
 
@@ -5167,6 +5183,8 @@ bool enqueue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 		update_cfs_group(se);
 	}
 
+	rq_chain_unlock(&rc);
+
 	return se != NULL;
 }
 
@@ -5211,9 +5229,12 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 			 unsigned int task_delta)
 {
 	struct cfs_rq *cfs_rq;
+	struct rq_chain rc;
 	int task_sleep = flags & DEQUEUE_SLEEP;
 
+	rq_chain_init(&rc, rq);
 	for_each_sched_entity(se) {
+		rq_chain_lock(&rc, se);
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
 
@@ -5231,6 +5252,9 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 		if (cfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
 			se = parent_entity(se);
+			if (se)
+				rq_chain_lock(&rc, se);
+
 			/*
 			 * Bias pick_next to pick a task from this cfs_rq, as
 			 * p is sleeping when it is within its sched_slice.
@@ -5243,6 +5267,8 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 	}
 
 	for_each_sched_entity(se) {
+		/* FIXME: taking locks up to the top is bad */
+		rq_chain_lock(&rc, se);
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running -= task_delta;
 
@@ -5253,6 +5279,8 @@ bool dequeue_entity_fair(struct rq *rq, struct sched_entity *se, int flags,
 		update_cfs_group(se);
 	}
 
+	rq_chain_unlock(&rc);
+
 	return se != NULL;
 }
 
@@ -9860,11 +9888,15 @@ static inline bool vruntime_normalized(struct task_struct *p)
 static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq;
+	struct rq_chain rc;
+
+	rq_chain_init(&rc, hrq_of(cfs_rq_of(se)));
 
 	/* Start to propagate at parent */
 	se = parent_entity(se);
 
 	for_each_sched_entity(se) {
+		rq_chain_lock(&rc, se);
 		cfs_rq = cfs_rq_of(se);
 
 		if (cfs_rq_throttled(cfs_rq))
@@ -9872,6 +9904,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
+	rq_chain_unlock(&rc);
 }
 #else
 static void propagate_entity_cfs_rq(struct sched_entity *se) { }
-- 
2.9.3.1.gcba166c.dirty

