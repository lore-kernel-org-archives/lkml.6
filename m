Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF49C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142732084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NC0AP8En"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142732084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeH2RQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:16:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46069 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2RQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:16:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so4789138wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9N1/i8eovTJISBwV2wd17v34QcoNXObPuHXlaPcTSyg=;
        b=NC0AP8EnJ6ul6iBXPE55fPtpxUCiptEqrpYGXRoBJYjP9vYV5VmPiTwrbd+2XgIPsF
         eXdbAGH7zMdyZf/95idDMZKkggfcmjilAuoNeZhZACjWR2gkz4KKhfh1ycvNXe99oY0O
         XvN2IYRgC8e8D9c4wFOp9BRv6JRf4Pu7bcl7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9N1/i8eovTJISBwV2wd17v34QcoNXObPuHXlaPcTSyg=;
        b=pxVe/bPTaXV1dFLjr1MECDRTUhs6hf0gvi59KIxfBGXflna0ybgLPLXlx2VR5eqL0w
         B4VJ38xrq1UP26/JzY95nwE7sK4GOquWy+FJ76Ks+vnnxielnK55/1fUgdGnf7nVkULv
         it/Tu9OWWVHBxbPYOPO8IiJdEEyNguD0FCecbmjcb6ecEF8OA+AUPeJHvH9D8LH4zF+M
         ViWv1TW7jVOdmaQZEAn0BJp6BAMk6AwgKA+2hgEH1HZethpZG4hapyMmLP8CLQCNNZQU
         3Q7L+gNBCF7l/TZwXAkOAb4/X+0u7wip6X4+R6AFe3X44FMju1BbvLM2WB/ilaFFQeug
         m+1Q==
X-Gm-Message-State: APzg51BXJxzXbKnX+GKXChk5jr5JyDIT3XDggAd/AUwIBYZ5KK4aUBnP
        Y7NYkgz11ku8yyT9W3/Z5QbBlQ==
X-Google-Smtp-Source: ANB0VdaOMAEECUOonjDXp3QRO3Q8oNsXosXMlrJjQcueH+53/jQcB6UmdPxuJbdVdHOt8r5q2TwvcA==
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr4095439wrl.26.1535548763558;
        Wed, 29 Aug 2018 06:19:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:4c23:4749:7ea6:c5af])
        by smtp.gmail.com with ESMTPSA id a37-v6sm9532723wrc.21.2018.08.29.06.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 06:19:22 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 4/4] sched/topology: remove unused sd param from arch_scale_cpu_capacity()
Date:   Wed, 29 Aug 2018 15:19:12 +0200
Message-Id: <1535548752-4434-5-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct sched_domain *sd parameter is no more used in arch_scale_cpu_capacity()
so we can remote it.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

---
 arch/arm/kernel/topology.c       | 2 +-
 drivers/base/arch_topology.c     | 6 +++---
 include/linux/arch_topology.h    | 2 +-
 kernel/sched/cpufreq_schedutil.c | 2 +-
 kernel/sched/deadline.c          | 2 +-
 kernel/sched/fair.c              | 8 ++++----
 kernel/sched/pelt.c              | 2 +-
 kernel/sched/sched.h             | 4 ++--
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 24ac3ca..d3d75c5 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -175,7 +175,7 @@ static void update_cpu_capacity(unsigned int cpu)
 	topology_set_cpu_scale(cpu, cpu_capacity(cpu) / middle_capacity);
 
 	pr_info("CPU%u: update cpu_capacity %lu\n",
-		cpu, topology_get_cpu_scale(NULL, cpu));
+		cpu, topology_get_cpu_scale(cpu));
 }
 
 #else
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6..6dc9339 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -44,7 +44,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
+	return sprintf(buf, "%lu\n", topology_get_cpu_scale(cpu->dev.id));
 }
 
 static ssize_t cpu_capacity_store(struct device *dev,
@@ -124,7 +124,7 @@ void topology_normalize_cpu_scale(void)
 			/ capacity_scale;
 		topology_set_cpu_scale(cpu, capacity);
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
-			cpu, topology_get_cpu_scale(NULL, cpu));
+			cpu, topology_get_cpu_scale(cpu));
 	}
 	mutex_unlock(&cpu_scale_mutex);
 }
@@ -194,7 +194,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
-		raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
+		raw_capacity[cpu] = topology_get_cpu_scale(cpu) *
 				    policy->cpuinfo.max_freq / 1000UL;
 		capacity_scale = max(raw_capacity[cpu], capacity_scale);
 	}
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 2b70941..5df6773 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -17,7 +17,7 @@ DECLARE_PER_CPU(unsigned long, cpu_scale);
 
 struct sched_domain;
 static inline
-unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
+unsigned long topology_get_cpu_scale(int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3fffad3..01b95057 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -202,7 +202,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 	unsigned long util, irq, max;
 
-	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
+	sg_cpu->max = max = arch_scale_cpu_capacity(sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
 	if (rt_rq_is_runnable(&rq->rt))
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 997ea7b..5f763b1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1196,7 +1196,7 @@ static void update_curr_dl(struct rq *rq)
 						 &curr->dl);
 	} else {
 		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
-		unsigned long scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+		unsigned long scale_cpu = arch_scale_cpu_capacity(cpu);
 
 		scaled_delta_exec = cap_scale(delta_exec, scale_freq);
 		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cff1682..2eeac7c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -748,7 +748,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct sched_avg *sa = &se->avg;
-	long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
+	long cpu_scale = arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)));
 	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
 
 	if (cap > 0) {
@@ -3175,7 +3175,7 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 	 * is not we rescale running_sum 1st
 	 */
 	running_sum = se->avg.util_sum /
-		arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
+		arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)));
 	runnable_sum = max(runnable_sum, running_sum);
 
 	load_sum = (s64)se_weight(se) * runnable_sum;
@@ -7462,7 +7462,7 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long max = arch_scale_cpu_capacity(cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -7487,7 +7487,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
 
-	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(sd, cpu);
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
 
 	if (!capacity)
 		capacity = 1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 35475c0..5efa152 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -114,7 +114,7 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
 	u64 periods;
 
 	scale_freq = arch_scale_freq_capacity(cpu);
-	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+	scale_cpu = arch_scale_cpu_capacity(cpu);
 
 	delta += sa->period_contrib;
 	periods = delta / 1024; /* A period is 1024us (~1ms) */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1715b8..8b306ce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1756,7 +1756,7 @@ unsigned long arch_scale_freq_capacity(int cpu)
 #ifdef CONFIG_SMP
 #ifndef arch_scale_cpu_capacity
 static __always_inline
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+unsigned long arch_scale_cpu_capacity(int cpu)
 {
 	return SCHED_CAPACITY_SCALE;
 }
@@ -1764,7 +1764,7 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 #else
 #ifndef arch_scale_cpu_capacity
 static __always_inline
-unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
+unsigned long arch_scale_cpu_capacity(int cpu)
 {
 	return SCHED_CAPACITY_SCALE;
 }
-- 
2.7.4

