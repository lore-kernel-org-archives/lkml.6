Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A1C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771CC2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBG6moWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfAWP1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:27:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40948 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:27:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so2941070wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47RagOthpiQeiOYWnjegSBd4696NQ+py1cx66QJ0Pp4=;
        b=hBG6moWP86hsWSE1cXP8aTZsfEg1gG1D6/H2Er1xHE0339O/Uw/CRh3s7nmv7H3xEX
         1ScsFq6ZwpklaK1Qmz9Git57ockm7VqItlkozkXfuwAY4nQvze0iOf9fEBMdSh3xXEY1
         5lE2f6TMQo8Z7Bo/Hx0TilHhf5AnsZ9iVT6j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47RagOthpiQeiOYWnjegSBd4696NQ+py1cx66QJ0Pp4=;
        b=uIQppo7CKCMV4oMaReH/7QpcWdWENHLqrVcyTqeTJOW5g3tzLwzL6I9VsQ/DWavTdP
         sTPFatSPoypOJCt2fU1jxrnWWutN2CtHXeOb+XF+5Sqb32pTYYWpv+UZt12t1hWB0xLT
         n7pJhVRX0glgxo9/vm4aM9nGX2DFLgazmHD6QFTZ1BeAlvxCzdKzPTHkTI124fhSdfQD
         IipciQ2zOMYq3TOA/02oyQgTvu+5h+e9wyXvQLmsbEde36bRSm9OWfYQSF5cvrygyRFz
         fAJd3oCaaSK216ZU8cPSFdZ02ogGuXN+04YXzscpm2/w6F6Pi34qlB6ST7J3yEefFFzK
         GHsA==
X-Gm-Message-State: AJcUukdgN2AO11QzAmSXMCgiTyqnwq9BOj21YDARd9H5FWZqd64KnkYV
        dqtdJa7jm1DsoagXrKOprWzRsA==
X-Google-Smtp-Source: ALg8bN7zNnl33SpRB/ob9le29s3lYPtuV9d2I9+BQ6JV+fJW+kIOp4T4lABg9nOr25ehu+rr3v4N1A==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr3237888wrq.260.1548257225394;
        Wed, 23 Jan 2019 07:27:05 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5ca6:2921:648b:56b6])
        by smtp.gmail.com with ESMTPSA id b13sm92938536wrn.28.2019.01.23.07.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 07:27:04 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v9 3/3] sched/pelt: skip updating util_est when utilization is higher than cpu's capacity
Date:   Wed, 23 Jan 2019 16:26:54 +0100
Message-Id: <1548257214-13745-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548257214-13745-1-git-send-email-vincent.guittot@linaro.org>
References: <1548257214-13745-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

util_est is mainly meant to be a lower-bound for tasks utilization.
That's why task_util_est() returns the actual util_avg when it's higher
than the estimated utilization.

With new invaraince signal and without any special check on samples
collection, if a task is limited because of thermal capping for
example, we could end up overestimating its utilization and thus
perhaps generating an unwanted frequency spike when the capping is
relaxed... and (even worst) it will take some more activations for the
estimated utilization to converge back to the actual utilization.

Since we cannot easily know if there is idle time in a CPU when a task
completes an activation with a utilization higher then the CPU capacity,
we skip the sampling when utilization is higher than cpu's capacity.

Suggested-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 14 +++++++++-----
 kernel/sched/sched.h |  7 +++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a9cee4e..47e63441 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3638,6 +3638,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 {
 	long last_ewma_diff;
 	struct util_est ue;
+	int cpu;
 
 	if (!sched_feat(UTIL_EST))
 		return;
@@ -3672,6 +3673,14 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 		return;
 
 	/*
+	 * To avoid overestimation of actual task utilization, skip updates if
+	 * we cannot grant there is idle time in this CPU.
+	 */
+	cpu = cpu_of(rq_of(cfs_rq));
+	if (task_util(p) > capacity_orig_of(cpu))
+		return;
+
+	/*
 	 * Update Task's estimated utilization
 	 *
 	 * When *p completes an activation we can consolidate another sample
@@ -5542,11 +5551,6 @@ static unsigned long capacity_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity;
 }
 
-static unsigned long capacity_orig_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_orig;
-}
-
 static unsigned long cpu_avg_load_per_task(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24007af..957c3f3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2230,6 +2230,13 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()	false
 #endif
 
+#ifdef CONFIG_SMP
+static inline unsigned long capacity_orig_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig;
+}
+#endif
+
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 /**
  * enum schedutil_type - CPU utilization type
-- 
2.7.4

