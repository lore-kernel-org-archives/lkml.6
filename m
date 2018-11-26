Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E77FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B73220862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHDqpwN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B73220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeKZWO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:14:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45198 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeKZWOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:14:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so13707630plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 03:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGAn6Dmctb3M6Js+r6sAQXS0roAHSwBAADu8U/GYcmU=;
        b=gHDqpwN8gfy+sg2OO6B8R2/87Nf70jXbqV44Tu0hDF8DYqUwWDFDOpGRO3eoeWKN8I
         WFffhwH06yIZc7nqlD9E3zZ0u/54PKd1gFZtfhrtva5PgOpdVAWgbrtOnwOADWzkY2/K
         z/KoOSpvz6sByaWf72FpqSETJilulwenM9swY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGAn6Dmctb3M6Js+r6sAQXS0roAHSwBAADu8U/GYcmU=;
        b=q3+ivKb0rO7gKFSoOgEqK2mggSubxxjkYUdBfLvgLWpuVLLOmKjOsT8RozxcQ9fb9v
         AYdQY7qikQFzmcWuKpC+AyxpJ/xLT4qL3A9s1J54Y0TFI3ISRf3xRkN59hSwhBqWZ06o
         dN7Tz2sSSYYgBEh51/k/C5qB6ca1v61ARjFG+wqbeELAB+iEF0EqTQqR6z31TIfruxKQ
         Sea9XN+6KFniPnIu/XPyYkCLHcw6eOyiuj8Y2P6cgzl9dqgVh4GCHkE2TxLJWebMqCEv
         Fd+2/kSrEWMZ92+sOy2jt7s5UceS0MBqesvFM3C0yJpvu6t6tA31veLAHZ9QrX2kTLil
         dDQw==
X-Gm-Message-State: AA+aEWbXz18TpFd81hYWn7GqJJLJdP7EgmWcPjtzk+TO9cgT8OQ7X956
        EylDwztnqTopx9VczcXEOKhXVA==
X-Google-Smtp-Source: AFSGD/X4HvO4gSXFm0nn0W/N09/to2jf9LQSAloN25/20iPws7oTW+6RZcWO3VPzAJwGJqHyqRFkSw==
X-Received: by 2002:a17:902:481:: with SMTP id e1-v6mr27043023ple.132.1543231266326;
        Mon, 26 Nov 2018 03:21:06 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id c4sm46780551pfm.151.2018.11.26.03.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 03:21:05 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com
Subject: [RFC][PATCH 1/2] sched: Start tracking SCHED_IDLE tasks count in cfs_rq
Date:   Mon, 26 Nov 2018 16:50:23 +0530
Message-Id: <e8f07d28d34072e4e2df8d64766150a8916a8308.1543229820.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1543229820.git.viresh.kumar@linaro.org>
References: <cover.1543229820.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start tracking how many tasks with SCHED_IDLE policy are present in each
cfs_rq. This will be used by later commits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c  | 14 ++++++++++++--
 kernel/sched/sched.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e30dea59d215..ad0b09ddddc0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4453,7 +4453,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, dequeue = 1;
 	bool empty;
 
 	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
@@ -4464,6 +4464,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	rcu_read_unlock();
 
 	task_delta = cfs_rq->h_nr_running;
+	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
@@ -4473,6 +4474,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (dequeue)
 			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
 		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
 		if (qcfs_rq->load.weight)
 			dequeue = 0;
@@ -4512,7 +4514,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	int enqueue = 1;
-	long task_delta;
+	long task_delta, idle_task_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -4532,6 +4534,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		return;
 
 	task_delta = cfs_rq->h_nr_running;
+	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			enqueue = 0;
@@ -4540,6 +4543,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (enqueue)
 			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
 		cfs_rq->h_nr_running += task_delta;
+		cfs_rq->idle_h_nr_running += idle_task_delta;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5092,6 +5096,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int idle_h_nr_running = unlikely(task_has_idle_policy(p)) ? 1 : 0;
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5124,6 +5129,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		flags = ENQUEUE_WAKEUP;
 	}
@@ -5131,6 +5137,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5157,6 +5164,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
+	int idle_h_nr_running = unlikely(task_has_idle_policy(p)) ? 1 : 0;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -5171,6 +5179,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -5190,6 +5199,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e0e052a50fcd..86a388c506ac 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -488,6 +488,8 @@ struct cfs_rq {
 	unsigned long		runnable_weight;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;
+	/* h_nr_running for SCHED_IDLE tasks */
+	unsigned int		idle_h_nr_running;
 
 	u64			exec_clock;
 	u64			min_vruntime;
-- 
2.19.1.568.g152ad8e3369a

