Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BB82085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6trI+TC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BB82085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeKHBqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:46:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43909 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeKHBqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:46:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so7497563pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/4Hktkv3BFdVeJzFNAtvQDg/UDXc2wDGcHAiu9SLUl4=;
        b=n6trI+TCIUWzQXG7Ik4hPkG5lS7APvqYTc2Q78yYy2H53NaM8gK4WkB99iYtfvW2Xu
         K3M5XtvNSuwqsUDA4pWhE9qyeedtpvWnl/e5oNxrlV0vnbeJNd7cAVl7Pkf4084cq6QX
         nUY1i93MTWwG82V9p2rKiRcfjEtSiZ7nHDAm470+wAAX3UPdxwmCIMq9TRp74cYXCzp4
         tSHZHx6Yg70hw33sAHhHctxguAk8z3NbovbTBnJTzdSeyYN4BNs2C7of/N7A5hb9mawM
         CMvfpU2MOQlWGkx7OUsPJ9ttGav3Mxjk9+eaBLnr+Jq3hKywGLdUdaT6NbsjRk7Uu1J+
         JsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/4Hktkv3BFdVeJzFNAtvQDg/UDXc2wDGcHAiu9SLUl4=;
        b=XRJTHlkwEOdQIq4PxwOqOA7iUCaNEhApoENG+ziYHz8Z9bcMXjMmuvPcj/RCdCHjiG
         3bJROFih8v5oxbQIqCjg3PEJL46BLYAfXEO4TTsiM7rtR7tGukV08AzlaJhaKo1M8W+t
         YJ0AyMNbiphASTs8r0zc6NdSlYi5tW95+FJ7/xR4y2rwoeC+4a0oRrkRuFdmzE3U9iMY
         AsD3q5+dI86ZF294RLVgvbW/2filUuZFSpHO0pZ1sOELW4djt/JcV3z1LsvTjJNFgXnR
         n6eLCsMDWM2NKnzBDyZzsjVeuIl8e2mrJW5x20dSpiw5fYlQ98nyDMLOXVYG1yMF/woj
         Xycw==
X-Gm-Message-State: AGRZ1gIXcKtiGUr0rT1ebTUXZ3efK7foewrEjS54ZeZvEs2TbatoNTpH
        vbQX345MZFgg8dK8YLh+ktVU+LCS
X-Google-Smtp-Source: AJdET5c7XuJW3u3ZP3Hds0OC7NLBRlz88jZMfH83K1CnvnUkiEcO/xM3ol3U3I5wlTJX09rfQboZAA==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr685142pgj.341.1541607328176;
        Wed, 07 Nov 2018 08:15:28 -0800 (PST)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id k129sm993067pgk.29.2018.11.07.08.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 08:15:27 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: Introduce prio_{higher,lower}() helper for comparing RT task prority
Date:   Thu,  8 Nov 2018 00:15:05 +0800
Message-Id: <20181107161505.42769-1-smuchun@gmail.com>
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
logic when read those code. So we introduce prio_{higher,lower}() helper
for comparing RT task prority, which can make code more readable.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/rt.c | 68 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9aa3287ce301..adf0f653c963 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -101,6 +101,28 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
 }
 
+/**
+ * prio_higher(a, b) returns true if the priority a
+ * is higher than the priority b.
+ */
+static inline bool prio_higher(int a, int b)
+{
+	return a < b;
+}
+
+#define prio_lower(a, b)	prio_higher(b, a)
+
+/**
+ * prio_higher_eq(a, b) returns true if the priority a
+ * is higher than or equal to the priority b.
+ */
+static inline bool prio_higher_eq(int a, int b)
+{
+	return a <= b;
+}
+
+#define prio_lower_eq(a, b)	prio_higher_eq(b, a)
+
 #ifdef CONFIG_RT_GROUP_SCHED
 static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 {
@@ -262,7 +284,7 @@ static void pull_rt_task(struct rq *this_rq);
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
-	return rq->rt.highest_prio.curr > prev->prio;
+	return prio_lower(rq->rt.highest_prio.curr, prev->prio);
 }
 
 static inline int rt_overloaded(struct rq *rq)
@@ -377,7 +399,7 @@ static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
 	plist_add(&p->pushable_tasks, &rq->rt.pushable_tasks);
 
 	/* Update the highest prio pushable task */
-	if (p->prio < rq->rt.highest_prio.next)
+	if (prio_higher(p->prio, rq->rt.highest_prio.next))
 		rq->rt.highest_prio.next = p->prio;
 }
 
@@ -498,7 +520,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 		else if (!on_rt_rq(rt_se))
 			enqueue_rt_entity(rt_se, 0);
 
-		if (rt_rq->highest_prio.curr < curr->prio)
+		if (prio_higher(rt_rq->highest_prio.curr, curr->prio))
 			resched_curr(rq);
 	}
 }
@@ -1044,7 +1066,7 @@ inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 	if (&rq->rt != rt_rq)
 		return;
 #endif
-	if (rq->online && prio < prev_prio)
+	if (rq->online && prio_higher(prio, prev_prio))
 		cpupri_set(&rq->rd->cpupri, rq->cpu, prio);
 }
 
@@ -1079,7 +1101,7 @@ inc_rt_prio(struct rt_rq *rt_rq, int prio)
 {
 	int prev_prio = rt_rq->highest_prio.curr;
 
-	if (prio < prev_prio)
+	if (prio_higher(prio, prev_prio))
 		rt_rq->highest_prio.curr = prio;
 
 	inc_rt_prio_smp(rt_rq, prio, prev_prio);
@@ -1092,7 +1114,7 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 
 	if (rt_rq->rt_nr_running) {
 
-		WARN_ON(prio < prev_prio);
+		WARN_ON(prio_higher(prio, prev_prio));
 
 		/*
 		 * This may have been our highest task, and therefore
@@ -1424,7 +1446,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	 */
 	if (curr && unlikely(rt_task(curr)) &&
 	    (curr->nr_cpus_allowed < 2 ||
-	     curr->prio <= p->prio)) {
+	     prio_higher_eq(curr->prio, p->prio))) {
 		int target = find_lowest_rq(p);
 
 		/*
@@ -1432,7 +1454,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 		 * not running a lower priority task.
 		 */
 		if (target != -1 &&
-		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
+		    prio_higher(p->prio, cpu_rq(target)->rt.highest_prio.curr))
 			cpu = target;
 	}
 	rcu_read_unlock();
@@ -1475,7 +1497,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
  */
 static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq->curr->prio) {
+	if (prio_higher(p->prio, rq->curr->prio)) {
 		resched_curr(rq);
 		return;
 	}
@@ -1732,7 +1754,8 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 
 		lowest_rq = cpu_rq(cpu);
 
-		if (lowest_rq->rt.highest_prio.curr <= task->prio) {
+		if (prio_higher_eq(lowest_rq->rt.highest_prio.curr,
+				   task->prio)) {
 			/*
 			 * Target rq has tasks of equal or higher priority,
 			 * retrying does not release any lock and is unlikely
@@ -1763,7 +1786,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 		}
 
 		/* If this rq is still suitable use it. */
-		if (lowest_rq->rt.highest_prio.curr > task->prio)
+		if (prio_lower(lowest_rq->rt.highest_prio.curr, task->prio))
 			break;
 
 		/* try again */
@@ -1823,7 +1846,7 @@ static int push_rt_task(struct rq *rq)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(prio_higher(next_task->prio, rq->curr->prio))) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2100,8 +2123,8 @@ static void pull_rt_task(struct rq *this_rq)
 		 * logically higher, the src_rq will push this task away.
 		 * And if its going logically lower, we do not care
 		 */
-		if (src_rq->rt.highest_prio.next >=
-		    this_rq->rt.highest_prio.curr)
+		if (prio_lower_eq(src_rq->rt.highest_prio.next,
+				  this_rq->rt.highest_prio.curr))
 			continue;
 
 		/*
@@ -2121,7 +2144,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * Do we have an RT task that preempts
 		 * the to-be-scheduled task?
 		 */
-		if (p && (p->prio < this_rq->rt.highest_prio.curr)) {
+		if (p && prio_higher(p->prio, this_rq->rt.highest_prio.curr)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!task_on_rq_queued(p));
 
@@ -2133,7 +2156,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (prio_higher(p->prio, src_rq->curr->prio))
 				goto skip;
 
 			resched = true;
@@ -2167,7 +2190,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	    p->nr_cpus_allowed > 1 &&
 	    (dl_task(rq->curr) || rt_task(rq->curr)) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
-	     rq->curr->prio <= p->prio))
+	     prio_higher_eq(rq->curr->prio, p->prio)))
 		push_rt_tasks(rq);
 }
 
@@ -2242,7 +2265,8 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (prio_higher(p->prio, rq->curr->prio) &&
+		    cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2263,18 +2287,18 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * If our priority decreases while running, we
 		 * may need to pull tasks to this runqueue.
 		 */
-		if (oldprio < p->prio)
+		if (prio_higher(oldprio, p->prio))
 			rt_queue_pull_task(rq);
 
 		/*
 		 * If there's a higher priority task waiting to run
 		 * then reschedule.
 		 */
-		if (p->prio > rq->rt.highest_prio.curr)
+		if (prio_lower(p->prio, rq->rt.highest_prio.curr))
 			resched_curr(rq);
 #else
 		/* For UP simply resched on drop of prio */
-		if (oldprio < p->prio)
+		if (prio_higher(oldprio, p->prio))
 			resched_curr(rq);
 #endif /* CONFIG_SMP */
 	} else {
@@ -2283,7 +2307,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (prio_higher(p->prio, rq->curr->prio))
 			resched_curr(rq);
 	}
 }
-- 
2.17.1

