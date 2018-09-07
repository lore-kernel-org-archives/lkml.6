Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A537020844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="SD/5N2I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A537020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeIHC0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:26:04 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:52451 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbeIHC0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356588; x=1567892588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hwnEQoq6ldCCie6h2Sv2htZO+cbI97s2MGGh7GktFSM=;
  b=SD/5N2I//l6FOt9pmKxKbmPlNELuUc6tASh669dczZ5FQtB17momAoVz
   Y0gxfk1IFV+6EHoPe/4hJPyMfwazRHwAdwVu7K09bx/erPoYHK8s/adi1
   MdSDeSApxGxC1ZHDuDU7CgxSfzIaOlA3HQWktgJTKa6aLJCdNe05iHkTK
   4=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530526"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:07 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lgwgn112064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:43:02 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lgvve027824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:57 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LguVo027820;
        Fri, 7 Sep 2018 23:42:56 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 54/60] cosched: Support idling in a coscheduled set
Date:   Fri,  7 Sep 2018 23:40:41 +0200
Message-Id: <20180907214047.26914-55-jschoenh@amazon.de>
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

If a coscheduled set is partly idle, some CPUs *must* do nothing, even
if they have other tasks (in other coscheduled sets). This forced idle
mode must work similar to normal task execution, e.g., not just any
task is allowed to replace the forced idle task.

Lay the ground work for this by introducing the general helper functions
to enter and leave the forced idle mode.

Whenever we are in forced idle, we execute the normal idle task, but we
forward many decisions to the fair scheduling class. The functions in
the fair scheduling class are made aware of the forced idle mode and
base their actual decisions on the (SD-)SE, under which there were no
tasks.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c  | 11 +++++++----
 kernel/sched/fair.c  | 43 +++++++++++++++++++++++++++++++++-------
 kernel/sched/idle.c  |  7 ++++++-
 kernel/sched/sched.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b3ff885a88d4..75de3b83a8c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -856,13 +856,16 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
-	const struct sched_class *class;
+	const struct sched_class *class, *curr_class = rq->curr->sched_class;
+
+	if (cosched_is_idle(rq, rq->curr))
+		curr_class = &fair_sched_class;
 
-	if (p->sched_class == rq->curr->sched_class) {
-		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
+	if (p->sched_class == curr_class) {
+		curr_class->check_preempt_curr(rq, p, flags);
 	} else {
 		for_each_class(class) {
-			if (class == rq->curr->sched_class)
+			if (class == curr_class)
 				break;
 			if (class == p->sched_class) {
 				resched_curr(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 210fcd534917..9e8b8119cdea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5206,12 +5206,14 @@ static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
 static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	if (cosched_is_idle(rq, p))
+		se = cosched_get_idle_se(rq);
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
 	if (nr_cfs_tasks(rq) > 1) {
-		u64 slice = sched_slice(cfs_rq, se);
+		u64 slice = sched_slice(cfs_rq_of(se), se);
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
 		s64 delta = slice - ran;
 
@@ -5232,11 +5234,17 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 static void hrtick_update(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
+	struct sched_entity *se = &curr->se;
+
+	if (!hrtick_enabled(rq))
+		return;
 
-	if (!hrtick_enabled(rq) || curr->sched_class != &fair_sched_class)
+	if (cosched_is_idle(rq, curr))
+		se = cosched_get_idle_se(rq);
+	else if (curr->sched_class != &fair_sched_class)
 		return;
 
-	if (cfs_rq_of(&curr->se)->nr_running < sched_nr_latency)
+	if (cfs_rq_of(se)->nr_running < sched_nr_latency)
 		hrtick_start_fair(rq, curr);
 }
 #else /* !CONFIG_SCHED_HRTICK */
@@ -6802,13 +6810,20 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_entity *se = &curr->se, *pse = &p->se;
-	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
-	int scale = cfs_rq->nr_running >= sched_nr_latency;
 	int next_buddy_marked = 0;
+	struct cfs_rq *cfs_rq;
+	int scale;
+
+	/* FIXME: locking may be off after fetching the idle_se */
+	if (cosched_is_idle(rq, curr))
+		se = cosched_get_idle_se(rq);
 
 	if (unlikely(se == pse))
 		return;
 
+	cfs_rq = cfs_rq_of(se);
+	scale = cfs_rq->nr_running >= sched_nr_latency;
+
 	/*
 	 * This is possible from callers such as attach_tasks(), in which we
 	 * unconditionally check_prempt_curr() after an enqueue (which may have
@@ -7038,7 +7053,15 @@ void put_prev_entity_fair(struct rq *rq, struct sched_entity *se)
  */
 static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 {
-	put_prev_entity_fair(rq, &prev->se);
+	struct sched_entity *se = &prev->se;
+
+	if (cosched_is_idle(rq, prev)) {
+		se = cosched_get_and_clear_idle_se(rq);
+		if (__leader_of(se) != cpu_of(rq))
+			return;
+	}
+
+	put_prev_entity_fair(rq, se);
 }
 
 /*
@@ -9952,6 +9975,12 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	struct sched_entity *se = &curr->se;
 	struct rq_owner_flags orf;
 
+	if (cosched_is_idle(rq, curr)) {
+		se = cosched_get_idle_se(rq);
+		if (__leader_of(se) != cpu_of(rq))
+			return;
+	}
+
 	rq_lock_owned(rq, &orf);
 	for_each_owned_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 16f84142f2f4..4df136ef1aeb 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -391,7 +391,8 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	put_prev_task(rq, prev);
+	if (prev)
+		put_prev_task(rq, prev);
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
 
@@ -413,6 +414,8 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
+	if (cosched_is_idle(rq, prev))
+		fair_sched_class.put_prev_task(rq, prev);
 }
 
 /*
@@ -425,6 +428,8 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
  */
 static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 {
+	if (cosched_is_idle(rq, curr))
+		fair_sched_class.task_tick(rq, curr, queued);
 }
 
 static void set_curr_task_idle(struct rq *rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 48939c8e539d..f6146feb7e55 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1914,6 +1914,61 @@ extern const struct sched_class rt_sched_class;
 extern const struct sched_class fair_sched_class;
 extern const struct sched_class idle_sched_class;
 
+#ifdef CONFIG_COSCHEDULING
+static inline bool cosched_is_idle(struct rq *rq, struct task_struct *p)
+{
+	if (!rq->sdrq_data.idle_se)
+		return false;
+	if (SCHED_WARN_ON(p != rq->idle))
+		return false;
+	return true;
+}
+
+static inline struct sched_entity *cosched_get_idle_se(struct rq *rq)
+{
+	return rq->sdrq_data.idle_se;
+}
+
+static inline struct sched_entity *cosched_get_and_clear_idle_se(struct rq *rq)
+{
+	struct sched_entity *se = rq->sdrq_data.idle_se;
+
+	rq->sdrq_data.idle_se = NULL;
+
+	return se;
+}
+
+static inline struct sched_entity *cosched_set_idle(struct rq *rq,
+						    struct sched_entity *se)
+{
+	rq->sdrq_data.idle_se = se;
+	return &idle_sched_class.pick_next_task(rq, NULL, NULL)->se;
+}
+#else /* !CONFIG_COSCHEDULING */
+static inline bool cosched_is_idle(struct rq *rq, struct task_struct *p)
+{
+	return false;
+}
+
+static inline struct sched_entity *cosched_get_idle_se(struct rq *rq)
+{
+	BUILD_BUG();
+	return NULL;
+}
+
+static inline struct sched_entity *cosched_get_and_clear_idle_se(struct rq *rq)
+{
+	BUILD_BUG();
+	return NULL;
+}
+
+static inline struct sched_entity *cosched_set_idle(struct rq *rq,
+						    struct sched_entity *se)
+{
+	BUILD_BUG();
+	return NULL;
+}
+#endif /* !CONFIG_COSCHEDULING */
 
 #ifdef CONFIG_SMP
 
-- 
2.9.3.1.gcba166c.dirty

