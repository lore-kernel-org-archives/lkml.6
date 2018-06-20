Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59967C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1745A20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1745A20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbeFTJGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:06:43 -0400
Received: from foss.arm.com ([217.140.101.70]:33954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbeFTJGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:06:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C0A215AB;
        Wed, 20 Jun 2018 02:06:40 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B98313F246;
        Wed, 20 Jun 2018 02:06:38 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv3 1/9] sched: Add static_key for asymmetric cpu capacity optimizations
Date:   Wed, 20 Jun 2018 10:05:41 +0100
Message-Id: <1529485549-5191-2-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing asymmetric cpu capacity code should cause minimal overhead
for others. Putting it behind a static_key, it has been done for SMT
optimizations, would make it easier to extend and improve without
causing harm to others moving forward.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c     |  3 +++
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e497c05aab7f..6116d1b7e441 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6585,6 +6585,9 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 {
 	long min_cap, max_cap;
 
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return 0;
+
 	min_cap = min(capacity_orig_of(prev_cpu), capacity_orig_of(cpu));
 	max_cap = cpu_rq(cpu)->rd->max_cpu_capacity;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 67702b4d9ac7..0fbfbcf5c551 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1153,6 +1153,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
 	atomic_t		ref;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 61a1125c1ae4..edc87e35fc75 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -398,6 +398,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -425,6 +426,21 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
 }
 
+static void update_asym_cpucapacity(int cpu)
+{
+	int enable = false;
+
+	rcu_read_lock();
+	if (lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
+		enable = true;
+	rcu_read_unlock();
+
+	if (enable) {
+		/* This expects to be hotplug-safe */
+		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
+	}
+}
+
 /*
  * Attach the domain 'sd' to 'cpu' as its base domain. Callers must
  * hold the hotplug lock.
@@ -1707,6 +1723,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	}
 	rcu_read_unlock();
 
+	update_asym_cpucapacity(cpumask_first(cpu_map));
+
 	if (rq && sched_debug_enabled) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
-- 
2.7.4

