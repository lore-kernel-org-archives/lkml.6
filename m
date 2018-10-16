Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2DBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958AE2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958AE2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeJPSF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:05:29 -0400
Received: from foss.arm.com ([217.140.101.70]:33838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJPSF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F72280D;
        Tue, 16 Oct 2018 03:15:46 -0700 (PDT)
Received: from queper01-lin.local (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F26453F59C;
        Tue, 16 Oct 2018 03:15:41 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        quentin.perret@arm.com
Subject: [PATCH v8 05/15] sched/topology: Reference the Energy Model of CPUs when available
Date:   Tue, 16 Oct 2018 11:15:03 +0100
Message-Id: <20181016101513.26919-6-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016101513.26919-1-quentin.perret@arm.com>
References: <20181016101513.26919-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing scheduling domain hierarchy is defined to map to the cache
topology of the system. However, Energy Aware Scheduling (EAS) requires
more knowledge about the platform, and specifically needs to know about
the span of Performance Domains (PD), which do not always align with
caches.

To address this issue, use the Energy Model (EM) of the system to extend
the scheduler topology code with a representation of the PDs, alongside
the scheduling domains. More specifically, a linked list of PDs is
attached to each root domain. When multiple root domains are in use,
each list contains only the PDs covering the CPUs of its root domain. If
a PD spans over CPUs of multiple different root domains, it will be
duplicated in all lists.

The lists are fully maintained by the scheduler from
partition_sched_domains() in order to cope with hotplug and cpuset
changes. As for scheduling domains, the list are protected by RCU to
ensure safe concurrent updates.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/sched.h    |  21 +++++++
 kernel/sched/topology.c | 134 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 440009115c64..e82c7d464dc1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -44,6 +44,7 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/delayacct.h>
+#include <linux/energy_model.h>
 #include <linux/init_task.h>
 #include <linux/kprobes.h>
 #include <linux/kthread.h>
@@ -700,6 +701,12 @@ static inline bool sched_asym_prefer(int a, int b)
 	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
 }
 
+struct perf_domain {
+	struct em_perf_domain *em_pd;
+	struct perf_domain *next;
+	struct rcu_head rcu;
+};
+
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
@@ -752,6 +759,12 @@ struct root_domain {
 	struct cpupri		cpupri;
 
 	unsigned long		max_cpu_capacity;
+
+	/*
+	 * NULL-terminated list of performance domains intersecting with the
+	 * CPUs of the rd. Protected by RCU.
+	 */
+	struct perf_domain	*pd;
 };
 
 extern struct root_domain def_root_domain;
@@ -2258,3 +2271,11 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 	return util;
 }
 #endif
+
+#ifdef CONFIG_SMP
+#ifdef CONFIG_ENERGY_MODEL
+#define perf_domain_span(pd) (to_cpumask(((pd)->em_pd->cpus)))
+#else
+#define perf_domain_span(pd) NULL
+#endif
+#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9d74371e4aad..9d17d0989e48 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,6 +201,116 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
+#ifdef CONFIG_ENERGY_MODEL
+static void free_pd(struct perf_domain *pd)
+{
+	struct perf_domain *tmp;
+
+	while (pd) {
+		tmp = pd->next;
+		kfree(pd);
+		pd = tmp;
+	}
+}
+
+static struct perf_domain *find_pd(struct perf_domain *pd, int cpu)
+{
+	while (pd) {
+		if (cpumask_test_cpu(cpu, perf_domain_span(pd)))
+			return pd;
+		pd = pd->next;
+	}
+
+	return NULL;
+}
+
+static struct perf_domain *pd_init(int cpu)
+{
+	struct em_perf_domain *obj = em_cpu_get(cpu);
+	struct perf_domain *pd;
+
+	if (!obj) {
+		if (sched_debug())
+			pr_info("%s: no EM found for CPU%d\n", __func__, cpu);
+		return NULL;
+	}
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return NULL;
+	pd->em_pd = obj;
+
+	return pd;
+}
+
+static void perf_domain_debug(const struct cpumask *cpu_map,
+						struct perf_domain *pd)
+{
+	if (!sched_debug() || !pd)
+		return;
+
+	printk(KERN_DEBUG "root_domain %*pbl: ", cpumask_pr_args(cpu_map));
+
+	while (pd) {
+		printk(KERN_CONT " pd%d:{ cpus=%*pbl nr_cstate=%d }",
+				cpumask_first(perf_domain_span(pd)),
+				cpumask_pr_args(perf_domain_span(pd)),
+				em_pd_nr_cap_states(pd->em_pd));
+		pd = pd->next;
+	}
+
+	printk(KERN_CONT "\n");
+}
+
+static void destroy_perf_domain_rcu(struct rcu_head *rp)
+{
+	struct perf_domain *pd;
+
+	pd = container_of(rp, struct perf_domain, rcu);
+	free_pd(pd);
+}
+
+static void build_perf_domains(const struct cpumask *cpu_map)
+{
+	struct perf_domain *pd = NULL, *tmp;
+	int cpu = cpumask_first(cpu_map);
+	struct root_domain *rd = cpu_rq(cpu)->rd;
+	int i;
+
+	for_each_cpu(i, cpu_map) {
+		/* Skip already covered CPUs. */
+		if (find_pd(pd, i))
+			continue;
+
+		/* Create the new pd and add it to the local list. */
+		tmp = pd_init(i);
+		if (!tmp)
+			goto free;
+		tmp->next = pd;
+		pd = tmp;
+	}
+
+	perf_domain_debug(cpu_map, pd);
+
+	/* Attach the new list of performance domains to the root domain. */
+	tmp = rd->pd;
+	rcu_assign_pointer(rd->pd, pd);
+	if (tmp)
+		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
+
+	return;
+
+free:
+	free_pd(pd);
+	tmp = rd->pd;
+	rcu_assign_pointer(rd->pd, NULL);
+	if (tmp)
+		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
+}
+#else
+static void free_pd(struct perf_domain *pd) { }
+#endif /* CONFIG_ENERGY_MODEL */
+
 static void free_rootdomain(struct rcu_head *rcu)
 {
 	struct root_domain *rd = container_of(rcu, struct root_domain, rcu);
@@ -211,6 +321,7 @@ static void free_rootdomain(struct rcu_head *rcu)
 	free_cpumask_var(rd->rto_mask);
 	free_cpumask_var(rd->online);
 	free_cpumask_var(rd->span);
+	free_pd(rd->pd);
 	kfree(rd);
 }
 
@@ -1961,8 +2072,8 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	/* Destroy deleted domains: */
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
-			if (cpumask_equal(doms_cur[i], doms_new[j])
-			    && dattrs_equal(dattr_cur, i, dattr_new, j))
+			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
+			    dattrs_equal(dattr_cur, i, dattr_new, j))
 				goto match1;
 		}
 		/* No match - a current sched domain not in new doms_new[] */
@@ -1982,8 +2093,8 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	/* Build new domains: */
 	for (i = 0; i < ndoms_new; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
-			if (cpumask_equal(doms_new[i], doms_cur[j])
-			    && dattrs_equal(dattr_new, i, dattr_cur, j))
+			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
+			    dattrs_equal(dattr_new, i, dattr_cur, j))
 				goto match2;
 		}
 		/* No match - add a new doms_new */
@@ -1992,6 +2103,21 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 		;
 	}
 
+#ifdef CONFIG_ENERGY_MODEL
+	/* Build perf. domains: */
+	for (i = 0; i < ndoms_new; i++) {
+		for (j = 0; j < n; j++) {
+			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
+			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd)
+				goto match3;
+		}
+		/* No match - add perf. domains for a new rd */
+		build_perf_domains(doms_new[i]);
+match3:
+		;
+	}
+#endif
+
 	/* Remember the new sched domains: */
 	if (doms_cur != &fallback_doms)
 		free_sched_domains(doms_cur, ndoms_cur);
-- 
2.19.1

