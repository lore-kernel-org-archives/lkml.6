Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB731C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C5120865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C5120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeIJPG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:06:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44911 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJPG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:06:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AADJWD1807810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:13:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AADJEO1807807;
        Mon, 10 Sep 2018 03:13:19 -0700
Date:   Mon, 10 Sep 2018 03:13:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Morten Rasmussen <tipbot@zytor.com>
Message-ID: <tip-df054e8445a4011e3d693c2268129c0456108663@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, morten.rasmussen@arm.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          morten.rasmussen@arm.com, peterz@infradead.org,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <1530699470-29808-2-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-2-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Add static_key for asymmetric CPU
 capacity optimizations
Git-Commit-ID: df054e8445a4011e3d693c2268129c0456108663
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  df054e8445a4011e3d693c2268129c0456108663
Gitweb:     https://git.kernel.org/tip/df054e8445a4011e3d693c2268129c0456108663
Author:     Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:39 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:48 +0200

sched/topology: Add static_key for asymmetric CPU capacity optimizations

The existing asymmetric CPU capacity code should cause minimal overhead
for others. Putting it behind a static_key, it has been done for SMT
optimizations, would make it easier to extend and improve without
causing harm to others moving forward.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-2-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c     | 3 +++
 kernel/sched/sched.h    | 1 +
 kernel/sched/topology.c | 9 ++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f808ddf2a868..3e5071aeb117 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6188,6 +6188,9 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 {
 	long min_cap, max_cap;
 
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return 0;
+
 	min_cap = min(capacity_orig_of(prev_cpu), capacity_orig_of(cpu));
 	max_cap = cpu_rq(cpu)->rd->max_cpu_capacity;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8cae63c4..0f36adc31ba5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1185,6 +1185,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
 	atomic_t		ref;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5c4d583d53ee..b0cdf5e95bda 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -398,6 +398,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -1705,6 +1706,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
 	struct sched_domain_topology_level *tl_asym;
+	bool has_asym = false;
 
 	alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
 	if (alloc_state != sa_rootdomain)
@@ -1720,8 +1722,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		for_each_sd_topology(tl) {
 			int dflags = 0;
 
-			if (tl == tl_asym)
+			if (tl == tl_asym) {
 				dflags |= SD_ASYM_CPUCAPACITY;
+				has_asym = true;
+			}
 
 			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
 
@@ -1773,6 +1777,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	}
 	rcu_read_unlock();
 
+	if (has_asym)
+		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
+
 	if (rq && sched_debug_enabled) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
