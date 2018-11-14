Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71090C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2540A2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk4ccZ3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2540A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbeKOAkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:40:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41498 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeKOAkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:40:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so7451956pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s2/owihrhX8Ds9+oNUcEcQtQy7kzAHAObaBtfpKwRWo=;
        b=Gk4ccZ3ain3+y6gmjMYN8RtQFswhzkss12hYhzlujIeCi6v+SDeEzeaHfObZJRkb5E
         SHhRHQb1rHB0+XfeG9sFKSY00QFSOQsEgA+nVuNx87SKkDYKFdQJyVYcOkdfgelTG7zQ
         MD/LiCGgsz1uJN/oroaVjpzcv67Ygd17+gxa34zUpNMn/knadbp6Ye5ztnoAijsxN765
         2AfjMUUlk7G4fczyLyYrFCbTBLFQeCo2mJzaSYH28E5tc+J8RiiXpAQUcp3pUcRuX4EG
         eruhGOd278zwR4HWzrJy1nl+BK8Gnw7l77NQW2lzirMdMpDIurjlmLPeZZ5HXelkw/7L
         1cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s2/owihrhX8Ds9+oNUcEcQtQy7kzAHAObaBtfpKwRWo=;
        b=qc92BsDzozsPXh0NxyjJQ/MSv8S+hvkvitw+fLhKQFQGo1+hdeJALhqvRJIN7BVnmg
         GiFbePiuVNsvIVtI9YPmI+Xkzl0SdGpL/bgbGhoaSjsCIFFcuYeLKjNY2p2ebgz3Bo3d
         6ub/zWiTkOZIi2U2JSKPOxG/R4BH/XKF0iaegjV1zYQupeqrL2puC0BxFdv9iSrucD8e
         1s+tSOOJM86vqGMQpqULzMLQiYtc7I/GF72xp/pOpLX7GpJ3ciICI7WQSEOk0X+JcmkZ
         +z2Y+3PU0NzJmnn0nNM6pR1hBnU7g0VnRwZIVEdphukyNd3Hw1gJxL0xB798q3NJwm5s
         iuHQ==
X-Gm-Message-State: AGRZ1gIhGnvKwWhKMrggMjjCbW7u+/Xscf7jGZtmfV7uXX7PpqJqJO32
        HrFjg5DIYAoWQXW5SHsMA8k=
X-Google-Smtp-Source: AJdET5fVbmT/D37OOnl5QiMcZbtQfHfjvePv5ylxoIZ9oTtTgwrofQyqB4eWn91XbmWW/bAsuwrfkA==
X-Received: by 2002:a63:9306:: with SMTP id b6mr1921339pge.36.1542206190658;
        Wed, 14 Nov 2018 06:36:30 -0800 (PST)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id 196-v6sm75409350pfc.71.2018.11.14.06.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 06:36:30 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] sched/rt: Introduce rt_prio_lower() helper for comparing RT task prority
Date:   Wed, 14 Nov 2018 22:36:13 +0800
Message-Id: <20181114143613.99955-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use a value to represent the priority of the RT task. But a smaller
value corresponds to a higher priority. If there are two RT task A and B,
their priorities are prio_a and prio_b, respectively. If prio_a is larger
than prio_b, which means that the priority of RT task A is lower than RT
task B. It may seem a bit strange.

In rt.c, there are many if condition of priority comparison. We need to
think carefully about which priority is higher because of this opposite
logic when read those code. So we introduce rt_prio_lower() helper for
comparing RT task prority, which can make code more readable.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/rt.c | 57 +++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9aa3287ce301..f28157c8212b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -101,6 +101,15 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
 }
 
+/**
+ * rt_prio_lower(a, b) returns true if the priority a is
+ * lower than the priority b, otherwise return false.
+ */
+static inline bool rt_prio_lower(int a, int b)
+{
+	return a > b;
+}
+
 #ifdef CONFIG_RT_GROUP_SCHED
 static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 {
@@ -262,7 +271,7 @@ static void pull_rt_task(struct rq *this_rq);
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
-	return rq->rt.highest_prio.curr > prev->prio;
+	return rt_prio_lower(rq->rt.highest_prio.curr, prev->prio);
 }
 
 static inline int rt_overloaded(struct rq *rq)
@@ -377,7 +386,7 @@ static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
 	plist_add(&p->pushable_tasks, &rq->rt.pushable_tasks);
 
 	/* Update the highest prio pushable task */
-	if (p->prio < rq->rt.highest_prio.next)
+	if (rt_prio_lower(rq->rt.highest_prio.next, p->prio))
 		rq->rt.highest_prio.next = p->prio;
 }
 
@@ -498,7 +507,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 		else if (!on_rt_rq(rt_se))
 			enqueue_rt_entity(rt_se, 0);
 
-		if (rt_rq->highest_prio.curr < curr->prio)
+		if (rt_prio_lower(curr->prio, rt_rq->highest_prio.curr))
 			resched_curr(rq);
 	}
 }
@@ -1044,7 +1053,7 @@ inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 	if (&rq->rt != rt_rq)
 		return;
 #endif
-	if (rq->online && prio < prev_prio)
+	if (rq->online && rt_prio_lower(prev_prio, prio))
 		cpupri_set(&rq->rd->cpupri, rq->cpu, prio);
 }
 
@@ -1079,7 +1088,7 @@ inc_rt_prio(struct rt_rq *rt_rq, int prio)
 {
 	int prev_prio = rt_rq->highest_prio.curr;
 
-	if (prio < prev_prio)
+	if (rt_prio_lower(prev_prio, prio))
 		rt_rq->highest_prio.curr = prio;
 
 	inc_rt_prio_smp(rt_rq, prio, prev_prio);
@@ -1092,7 +1101,7 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 
 	if (rt_rq->rt_nr_running) {
 
-		WARN_ON(prio < prev_prio);
+		WARN_ON(rt_prio_lower(prev_prio, prio));
 
 		/*
 		 * This may have been our highest task, and therefore
@@ -1424,7 +1433,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	 */
 	if (curr && unlikely(rt_task(curr)) &&
 	    (curr->nr_cpus_allowed < 2 ||
-	     curr->prio <= p->prio)) {
+	     !rt_prio_lower(curr->prio, p->prio))) {
 		int target = find_lowest_rq(p);
 
 		/*
@@ -1432,7 +1441,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 		 * not running a lower priority task.
 		 */
 		if (target != -1 &&
-		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
+		    rt_prio_lower(cpu_rq(target)->rt.highest_prio.curr,
+				  p->prio))
 			cpu = target;
 	}
 	rcu_read_unlock();
@@ -1475,7 +1485,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
  */
 static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq->curr->prio) {
+	if (rt_prio_lower(rq->curr->prio, p->prio)) {
 		resched_curr(rq);
 		return;
 	}
@@ -1732,7 +1742,8 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 
 		lowest_rq = cpu_rq(cpu);
 
-		if (lowest_rq->rt.highest_prio.curr <= task->prio) {
+		if (!rt_prio_lower(lowest_rq->rt.highest_prio.curr,
+				   task->prio)) {
 			/*
 			 * Target rq has tasks of equal or higher priority,
 			 * retrying does not release any lock and is unlikely
@@ -1763,7 +1774,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 		}
 
 		/* If this rq is still suitable use it. */
-		if (lowest_rq->rt.highest_prio.curr > task->prio)
+		if (rt_prio_lower(lowest_rq->rt.highest_prio.curr, task->prio))
 			break;
 
 		/* try again */
@@ -1823,7 +1834,7 @@ static int push_rt_task(struct rq *rq)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(rt_prio_lower(rq->curr->prio, next_task->prio))) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2100,8 +2111,8 @@ static void pull_rt_task(struct rq *this_rq)
 		 * logically higher, the src_rq will push this task away.
 		 * And if its going logically lower, we do not care
 		 */
-		if (src_rq->rt.highest_prio.next >=
-		    this_rq->rt.highest_prio.curr)
+		if (!rt_prio_lower(this_rq->rt.highest_prio.curr,
+				src_rq->rt.highest_prio.next))
 			continue;
 
 		/*
@@ -2121,7 +2132,8 @@ static void pull_rt_task(struct rq *this_rq)
 		 * Do we have an RT task that preempts
 		 * the to-be-scheduled task?
 		 */
-		if (p && (p->prio < this_rq->rt.highest_prio.curr)) {
+		if (p && rt_prio_lower(this_rq->rt.highest_prio.curr,
+				       p->prio)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!task_on_rq_queued(p));
 
@@ -2133,7 +2145,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (rt_prio_lower(src_rq->curr->prio, p->prio))
 				goto skip;
 
 			resched = true;
@@ -2167,7 +2179,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	    p->nr_cpus_allowed > 1 &&
 	    (dl_task(rq->curr) || rt_task(rq->curr)) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
-	     rq->curr->prio <= p->prio))
+	     !rt_prio_lower(rq->curr->prio, p->prio)))
 		push_rt_tasks(rq);
 }
 
@@ -2242,7 +2254,8 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (rt_prio_lower(rq->curr->prio, p->prio) &&
+		    cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2263,18 +2276,18 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * If our priority decreases while running, we
 		 * may need to pull tasks to this runqueue.
 		 */
-		if (oldprio < p->prio)
+		if (rt_prio_lower(p->prio, oldprio))
 			rt_queue_pull_task(rq);
 
 		/*
 		 * If there's a higher priority task waiting to run
 		 * then reschedule.
 		 */
-		if (p->prio > rq->rt.highest_prio.curr)
+		if (rt_prio_lower(p->prio, rq->rt.highest_prio.curr))
 			resched_curr(rq);
 #else
 		/* For UP simply resched on drop of prio */
-		if (oldprio < p->prio)
+		if (rt_prio_lower(p->prio, oldprio))
 			resched_curr(rq);
 #endif /* CONFIG_SMP */
 	} else {
@@ -2283,7 +2296,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (rt_prio_lower(rq->curr->prio, p->prio))
 			resched_curr(rq);
 	}
 }
-- 
2.17.1

