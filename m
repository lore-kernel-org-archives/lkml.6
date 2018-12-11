Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA05C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600A320851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600A320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeLKPet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:34:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLKPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:34:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFYMma4042626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:34:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFYLxB4042623;
        Tue, 11 Dec 2018 07:34:21 -0800
Date:   Tue, 11 Dec 2018 07:34:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-6aa140fa4508933a6ac6717d65a403eb904d6c02@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        hpa@zytor.com, torvalds@linux-foundation.org,
        quentin.perret@arm.com, linux-kernel@vger.kernel.org, efault@gmx.de
Reply-To: mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, efault@gmx.de,
          quentin.perret@arm.com
In-Reply-To: <20181203095628.11858-6-quentin.perret@arm.com>
References: <20181203095628.11858-6-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Reference the Energy Model of CPUs
 when available
Git-Commit-ID: 6aa140fa4508933a6ac6717d65a403eb904d6c02
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

Commit-ID:  6aa140fa4508933a6ac6717d65a403eb904d6c02
Gitweb:     https://git.kernel.org/tip/6aa140fa4508933a6ac6717d65a403eb904d6c02
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:18 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:16:59 +0100

sched/topology: Reference the Energy Model of CPUs when available

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

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: adharmap@codeaurora.org
Cc: chris.redpath@arm.com
Cc: currojerez@riseup.net
Cc: dietmar.eggemann@arm.com
Cc: edubezval@gmail.com
Cc: gregkh@linuxfoundation.org
Cc: javi.merino@kernel.org
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: morten.rasmussen@arm.com
Cc: patrick.bellasi@arm.com
Cc: pkondeti@codeaurora.org
Cc: rjw@rjwysocki.net
Cc: skannan@codeaurora.org
Cc: smuckle@google.com
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Cc: tkjos@google.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Cc: viresh.kumar@linaro.org
Link: https://lkml.kernel.org/r/20181203095628.11858-6-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/sched.h    |  21 ++++++++
 kernel/sched/topology.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2eafa228aebf..808a565187b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -45,6 +45,7 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/delayacct.h>
+#include <linux/energy_model.h>
 #include <linux/init_task.h>
 #include <linux/kprobes.h>
 #include <linux/kthread.h>
@@ -709,6 +710,12 @@ static inline bool sched_asym_prefer(int a, int b)
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
@@ -761,6 +768,12 @@ struct root_domain {
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
@@ -2276,3 +2289,11 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
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
index 7364e0b427b7..169d25cafab5 100644
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
+	printk(KERN_DEBUG "root_domain %*pbl:", cpumask_pr_args(cpu_map));
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
 
@@ -1959,8 +2070,8 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
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
@@ -1980,8 +2091,8 @@ match1:
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
@@ -1990,6 +2101,21 @@ match2:
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
