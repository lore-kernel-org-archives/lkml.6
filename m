Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C024ECDE47
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC982085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJZCDA/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC982085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeKEUlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:41:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34472 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeKEUlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:41:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id y18-v6so1900326pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 03:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sz6GE8no3HqnxxiFUe84AvjpuQ0crmNaPDcLmfEYLYg=;
        b=iJZCDA/sjLneeTVpDEMU2IZiLyBgXQJxY0589AftLh4/s/SGEjVLm1XqGirT4JA6rN
         hhOalc+HdUt5d50Rrorn9JAW8OJouayLClQldDxYVGAQMBsXoL8L2VjspjG7nzvGUUDQ
         zFR2u6/7wgEShuvukFZaIAWbnTKTt3YsFZpqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sz6GE8no3HqnxxiFUe84AvjpuQ0crmNaPDcLmfEYLYg=;
        b=cOAAMSGWQWzWZgPvbAGGk4+io9/Hf5Nf8oDq0+yTWNSPxG68FePgXfiZ0NY61Dg2SM
         wN/6dAphob99rF/XQExYHHnQtEP2KFzd9J9C2G+rdY8KHZ1WmYGvXc4DjBq9FbA/WWSe
         LmUNk0ds8eY7DWE8mdQK0RjYzW7IhhDSHaZU6pOxquF4B7uYauu8XA9t0EjI8ZK9TK8C
         SMq2ShS81vZdmYRuZojUaZ/Qzg5XE2OHWHiJd38sXDAyF5dNCqOUsfhhB2b9n+S85QfC
         bMBpeGjWBNwM0x0juibPl/cGJARgnnWwGontYDZ8JCww8SxDyJM+fz4w3pjMSW+7i/Fg
         rJzg==
X-Gm-Message-State: AGRZ1gKo6Ecdfi+HQH7g+Ogh9CMf0PrTef0tLM1drGJR5cJuHs9E5yF/
        FdlNivAH4Roh/Z7J6024sGwCeA==
X-Google-Smtp-Source: AJdET5cutKqFOdnH3w6Llk1Mswyo9jJPA36Dsy18xx/+zak9KX0NRjW7LuuVFVGwmSyGsPpzua+1Ow==
X-Received: by 2002:aa7:8603:: with SMTP id p3-v6mr21688654pfn.247.1541416925686;
        Mon, 05 Nov 2018 03:22:05 -0800 (PST)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id t78-v6sm13240101pfk.59.2018.11.05.03.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 03:22:04 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Create task_has_idle_policy() helper
Date:   Mon,  5 Nov 2018 16:51:55 +0530
Message-Id: <ce3915d5b490fc81af926a3b6bfb775e7188e005.1541416894.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have task_has_rt_policy() and task_has_dl_policy() helpers,
create task_has_idle_policy() as well and update sched core to start
using it.

While at it, use task_has_dl_policy() at one more place.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 10 +++++-----
 kernel/sched/sched.h |  5 +++++
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f12225f26b70..841f4e16c157 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -697,7 +697,7 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	/*
 	 * SCHED_IDLE tasks get minimal weight:
 	 */
-	if (idle_policy(p->policy)) {
+	if (task_has_idle_policy(p)) {
 		load->weight = scale_load(WEIGHT_IDLEPRIO);
 		load->inv_weight = WMULT_IDLEPRIO;
 		p->se.runnable_weight = load->weight;
@@ -4191,7 +4191,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		 * Treat SCHED_IDLE as nice 20. Only allow a switch to
 		 * SCHED_NORMAL if the RLIMIT_NICE would normally permit it.
 		 */
-		if (idle_policy(p->policy) && !idle_policy(policy)) {
+		if (task_has_idle_policy(p) && !idle_policy(policy)) {
 			if (!can_nice(p, task_nice(p)))
 				return -EPERM;
 		}
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 6383aa6a60ca..02bd5f969b21 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -974,7 +974,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
-	if (p->policy == SCHED_DEADLINE) {
+	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee271bb661cc..1c8776175235 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6486,7 +6486,7 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 
 static void set_last_buddy(struct sched_entity *se)
 {
-	if (entity_is_task(se) && unlikely(task_of(se)->policy == SCHED_IDLE))
+	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
 		return;
 
 	for_each_sched_entity(se) {
@@ -6498,7 +6498,7 @@ static void set_last_buddy(struct sched_entity *se)
 
 static void set_next_buddy(struct sched_entity *se)
 {
-	if (entity_is_task(se) && unlikely(task_of(se)->policy == SCHED_IDLE))
+	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
 		return;
 
 	for_each_sched_entity(se) {
@@ -6556,8 +6556,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
-	if (unlikely(curr->policy == SCHED_IDLE) &&
-	    likely(p->policy != SCHED_IDLE))
+	if (unlikely(task_has_idle_policy(curr)) &&
+	    likely(!task_has_idle_policy(p)))
 		goto preempt;
 
 	/*
@@ -6978,7 +6978,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (p->sched_class != &fair_sched_class)
 		return 0;
 
-	if (unlikely(p->policy == SCHED_IDLE))
+	if (unlikely(task_has_idle_policy(p)))
 		return 0;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 618577fc9aa8..b7a3147874e3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -176,6 +176,11 @@ static inline bool valid_policy(int policy)
 		rt_policy(policy) || dl_policy(policy);
 }
 
+static inline int task_has_idle_policy(struct task_struct *p)
+{
+	return idle_policy(p->policy);
+}
+
 static inline int task_has_rt_policy(struct task_struct *p)
 {
 	return rt_policy(p->policy);
-- 
2.19.1.568.g152ad8e3369a

