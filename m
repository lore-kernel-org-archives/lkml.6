Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73CCC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA14623BFB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA14623BFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934448AbeGDKSR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:18:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34992 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934329AbeGDKSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 989F480D;
        Wed,  4 Jul 2018 03:18:12 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2163B3F5AD;
        Wed,  4 Jul 2018 03:18:10 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 01/12] sched: Add static_key for asymmetric cpu capacity optimizations
Date:   Wed,  4 Jul 2018 11:17:39 +0100
Message-Id: <1530699470-29808-2-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
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
 kernel/sched/topology.c | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 321cd5dcf2e8..85fb7e8ff5c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6583,6 +6583,9 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 {
 	long min_cap, max_cap;
 
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return 0;
+
 	min_cap = min(capacity_orig_of(prev_cpu), capacity_orig_of(cpu));
 	max_cap = cpu_rq(cpu)->rd->max_cpu_capacity;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c7742dcc136c..35ce218f0157 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1160,6 +1160,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
 	atomic_t		ref;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a831427bc7..0cfdeff669fe 100644
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
@@ -1707,6 +1723,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	}
 	rcu_read_unlock();
 
+	if (!cpumask_empty(cpu_map))
+		update_asym_cpucapacity(cpumask_first(cpu_map));
+
 	if (rq && sched_debug_enabled) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
-- 
2.7.4

