Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30034C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E108E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CnWJzWkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E108E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeKZWO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:14:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41602 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeKZWO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:14:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so6420961pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 03:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cXjCpnaegYAXM+GZRUdmlkOBI/edddeoKcnlEDVaygI=;
        b=CnWJzWkqXjXQgN1QMfMyd331KGRYduvoL4211649yMNrd/dK5H/zOvmt17dYi5mkDN
         PkpZcwhLV+mqBgZ2MiOnFDMYAp/dTKnYmN7MpkZR9R6BjFg4r1sUcdjnBiPsubdI8kyq
         HzbNYKy29QEL/YYhnmu57/r7moNW30Dw4W9c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cXjCpnaegYAXM+GZRUdmlkOBI/edddeoKcnlEDVaygI=;
        b=Zzo0nzKpV5K2VG1x1GqyncbwA9prNh61mdZ3KheBctd30xz0T19e4zJaAqAeEBU2ba
         mgAzCs0Aqp4xha/QWshzcttswB4eu/oV8Px4iY/0G5XtvTCtKsOzv39g4/9H9XfC9Jpt
         JCA8rp4Of9a7fp5/WO9YyOjeuVRsjhkf+FTR5H55T/n7V0FYOCGlflES+G9/y/AOjULn
         wSpU2Ck25Ve7k8Q0qT7hmA4RBOAlpZqiyYSU9DwEXzFvH9OBCZJyKwivA0Dr9aQCp4cT
         EfuAtlMg9VX5YhWy7hdINphHTVadKVl73XLqa8Xs/eTYA0iJq7BNTkp2cP72fqmsgtu9
         TVig==
X-Gm-Message-State: AA+aEWZVOaU/OhpJuBwuQXG/DykLf0FG1q05ujIvqC5LaZHIBizu309z
        A346Kzf6QUpUbzw07ovqwYzuuw==
X-Google-Smtp-Source: AFSGD/U0krj2A20fnvJlPAZSZz+zjL0zt+TGUb2KxnnheFUnM6RFBt0QfisnYqQuDMhzOK0BxOnOyw==
X-Received: by 2002:a63:5a08:: with SMTP id o8mr24314999pgb.185.1543231269682;
        Mon, 26 Nov 2018 03:21:09 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id a73sm51209pfa.7.2018.11.26.03.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 03:21:08 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com
Subject: [RFC][PATCH 2/2] sched: Enqueue tasks on a cpu with only SCHED_IDLE tasks
Date:   Mon, 26 Nov 2018 16:50:24 +0530
Message-Id: <71a578a0c5b39169fe74ad378ee41eaf546844ac.1543229820.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1543229820.git.viresh.kumar@linaro.org>
References: <cover.1543229820.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler tries to schedule a newly wakeup task on an idle CPU to
make sure the new task gets chance to run as soon as possible, for
performance reasons.

The SCHED_IDLE scheduling policy is used for tasks which have the lowest
priority and there is no hurry in running them. If all the tasks
currently enqueued on a CPU have their policy set to SCHED_IDLE, then
any new task (non SCHED_IDLE) enqueued on that CPU should normally get a
chance to run immediately. This patch takes advantage of this to save
power in some cases by avoiding waking up an idle CPU (which may be in
some deep idle state) and enqueuing the new task on a CPU which only has
SCHED_IDLE tasks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/core.c  | 23 ++++++++++++++++++++
 kernel/sched/fair.c  | 50 +++++++++++++++++++++++++++++++-------------
 kernel/sched/sched.h |  3 +++
 3 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d87a28da378..176eed77b18e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4020,6 +4020,29 @@ int available_idle_cpu(int cpu)
 	return 1;
 }
 
+/* CPU only has SCHED_IDLE tasks enqueued */
+int cpu_only_has_sched_idle_tasks(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	return unlikely(rq->nr_running &&
+			rq->nr_running == rq->cfs.idle_h_nr_running);
+}
+
+int available_sched_idle_cpu(int cpu)
+{
+	if (vcpu_is_preempted(cpu))
+		return 0;
+
+	if (idle_cpu(cpu))
+		return 1;
+
+	if (cpu_only_has_sched_idle_tasks(cpu))
+		return 1;
+
+	return 0;
+}
+
 /**
  * idle_task - return the idle task for a given CPU.
  * @cpu: the processor in question.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad0b09ddddc0..3a029c740d51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5623,9 +5623,10 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	 * on one CPU.
 	 */
 	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
+		return available_sched_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
-	if (sync && cpu_rq(this_cpu)->nr_running == 1)
+	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
+	    cpu_only_has_sched_idle_tasks(this_cpu))
 		return this_cpu;
 
 	return nr_cpumask_bits;
@@ -5888,6 +5889,9 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
 			}
+		} else if (cpu_only_has_sched_idle_tasks(i) && !vcpu_is_preempted(i)) {
+			/* Prefer CPU with only SCHED_IDLE tasks */
+			return i;
 		} else if (shallowest_idle_cpu == -1) {
 			load = weighted_cpuload(cpu_rq(i));
 			if (load < min_load) {
@@ -6049,7 +6053,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
  */
 static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
-	int cpu;
+	int cpu, last_idle_cpu = -1;
 
 	if (!static_branch_likely(&sched_smt_present))
 		return -1;
@@ -6057,11 +6061,18 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
 			continue;
-		if (available_idle_cpu(cpu))
-			return cpu;
+		if (!vcpu_is_preempted(cpu)) {
+			if (idle_cpu(cpu)) {
+				/* Prefer CPU with only SCHED_IDLE tasks */
+				last_idle_cpu = cpu;
+				continue;
+			}
+			if (cpu_only_has_sched_idle_tasks(cpu))
+				return cpu;
+		}
 	}
 
-	return -1;
+	return last_idle_cpu;
 }
 
 #else /* CONFIG_SCHED_SMT */
@@ -6089,7 +6100,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
+	int cpu, nr = INT_MAX, last_idle_cpu = -1;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6116,12 +6127,23 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	time = local_clock();
 
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
-		if (!--nr)
-			return -1;
+		if (!--nr) {
+			if (last_idle_cpu == -1)
+				return -1;
+			cpu = last_idle_cpu;
+			break;
+		}
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
 			continue;
-		if (available_idle_cpu(cpu))
-			break;
+		if (!vcpu_is_preempted(cpu)) {
+			if (idle_cpu(cpu)) {
+				/* Prefer CPU with only SCHED_IDLE tasks */
+				last_idle_cpu = cpu;
+				continue;
+			}
+			if (cpu_only_has_sched_idle_tasks(cpu))
+				break;
+		}
 	}
 
 	time = local_clock() - time;
@@ -6140,13 +6162,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
-	if (available_idle_cpu(target))
+	if (available_sched_idle_cpu(target))
 		return target;
 
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) && available_idle_cpu(prev))
+	if (prev != target && cpus_share_cache(prev, target) && available_sched_idle_cpu(prev))
 		return prev;
 
 	/* Check a recently used CPU as a potential idle candidate: */
@@ -6154,7 +6176,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    available_idle_cpu(recent_used_cpu) &&
+	    available_sched_idle_cpu(recent_used_cpu) &&
 	    cpumask_test_cpu(p->recent_used_cpu, &p->cpus_allowed)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 86a388c506ac..ecd016c64ee2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1828,6 +1828,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
+extern int cpu_only_has_sched_idle_tasks(int cpu);
+extern int available_sched_idle_cpu(int cpu);
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
-- 
2.19.1.568.g152ad8e3369a

