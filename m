Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA17C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6FA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="LouRQb7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6FA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeIHCac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:30:32 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27029 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeIHCab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356854; x=1567892854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FpZ0/MfL21vL2c1L8np9yXoUjyIFjQlrDZOyOtX+O6k=;
  b=LouRQb7upUF8DoCp7DjmSbmvpiXIKtVXnHip1ZkYbirTec41aKl5WhCX
   GnI0B/davkdGx56m4MOrKeQCCvvPW6pVYxxJIa2LAonNi8lNU0KbeQfGU
   3cWrVkE48P9PjQ8pBGR/am8+D4DebrlEZM7tY6jhrErxWDjrc4/0Ov5ph
   s=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="752286893"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:45:04 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgDE4005924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:16 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgB6S027470
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:12 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgBER027468;
        Fri, 7 Sep 2018 23:42:11 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 29/60] cosched: Adjust code reflecting on the total number of CFS tasks on a CPU
Date:   Fri,  7 Sep 2018 23:40:16 +0200
Message-Id: <20180907214047.26914-30-jschoenh@amazon.de>
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

There are a few places that make decisions based on the total number
of CFS tasks on a certain CPU. With coscheduling, the inspected value
rq->cfs.h_nr_running does not contain all tasks anymore, as some are
accounted on higher hierarchy levels instead. This would lead to
incorrect conclusions as the system seems more idle than it actually is.

Adjust these code paths to use an alternative way of deriving the same
value: take the total amount of tasks on the runqueue and subtract all
running tasks of other scheduling classes. What remains are all CFS tasks
on a certain CPU.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c  |  5 ++---
 kernel/sched/fair.c  | 11 +++++------
 kernel/sched/sched.h | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5350cab7ac4a..337bae6fa836 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3326,12 +3326,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
-	 * higher scheduling class, because otherwise those loose the
+	 * higher scheduling class, because otherwise those lose the
 	 * opportunity to pull in more work from other CPUs.
 	 */
 	if (likely((prev->sched_class == &idle_sched_class ||
 		    prev->sched_class == &fair_sched_class) &&
-		   rq->nr_running == rq->cfs.h_nr_running)) {
+		   rq->nr_running == nr_cfs_tasks(rq))) {
 
 		p = fair_sched_class.pick_next_task(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
@@ -3343,7 +3343,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		return p;
 	}
-
 again:
 	for_each_class(class) {
 		p = class->pick_next_task(rq, prev, rf);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9cbdd027d449..30e5ff30f442 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4460,7 +4460,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		add_nr_running(rq, task_delta);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
-	if (rq->curr == rq->idle && rq->cfs.nr_running)
+	if (rq->curr == rq->idle && nr_cfs_tasks(rq))
 		resched_curr(rq);
 }
 
@@ -4937,7 +4937,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
-	if (rq->cfs.h_nr_running > 1) {
+	if (nr_cfs_tasks(rq) > 1) {
 		u64 slice = sched_slice(cfs_rq, se);
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
 		s64 delta = slice - ran;
@@ -9067,8 +9067,7 @@ static void nohz_balancer_kick(struct rq *rq)
 
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
-		if ((rq->cfs.h_nr_running >= 1) &&
-				check_cpu_capacity(rq, sd)) {
+		if ((nr_cfs_tasks(rq) >= 1) && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
@@ -9479,7 +9478,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 * have been enqueued in the meantime. Since we're not going idle,
 	 * pretend we pulled a task.
 	 */
-	if (this_rq->cfs.h_nr_running && !pulled_task)
+	if (nr_cfs_tasks(this_rq) && !pulled_task)
 		pulled_task = 1;
 
 	/* Move the next balance forward */
@@ -9487,7 +9486,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 		this_rq->next_balance = next_balance;
 
 	/* Is there a task of a high priority class? */
-	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
+	if (this_rq->nr_running != nr_cfs_tasks(this_rq))
 		pulled_task = -1;
 
 	if (pulled_task)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5e2d231b1dbf..594eb9489f3d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1691,6 +1691,27 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 	return p->on_rq == TASK_ON_RQ_MIGRATING;
 }
 
+#ifdef CONFIG_COSCHEDULING
+static inline unsigned int nr_cfs_tasks(struct rq *rq)
+{
+	unsigned int total = rq->nr_running;
+
+	/* Deadline and real time tasks */
+	total -= rq->dl.dl_nr_running + rq->rt.rt_nr_running;
+
+	/* Stop task */
+	if (rq->stop && task_on_rq_queued(rq->stop))
+		total--;
+
+	return total;
+}
+#else
+static inline unsigned int nr_cfs_tasks(struct rq *rq)
+{
+	return rq->cfs.h_nr_running;
+}
+#endif
+
 /*
  * wake flags
  */
-- 
2.9.3.1.gcba166c.dirty

