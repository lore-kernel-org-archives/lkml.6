Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58E0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E29272BE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E29272BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbeF1LnJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:43:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45790 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965588AbeF1LlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:41:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E70E1993;
        Thu, 28 Jun 2018 04:41:22 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 365C83F266;
        Thu, 28 Jun 2018 04:41:18 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v4 05/12] sched/topology: Reference the Energy Model of CPUs when available
Date:   Thu, 28 Jun 2018 12:40:36 +0100
Message-Id: <20180628114043.24724-6-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628114043.24724-1-quentin.perret@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing scheduling domain hierarchy is defined to map to the cache
topology of the system. However, Energy Aware Scheduling (EAS) requires
more knowledge about the platform, and specifically needs to know about
the span of Frequency Domains (FD), which do not always align with
caches.

To address this issue, use the Energy Model (EM) of the system to extend
the scheduler topology code with a representation of the FDs, alongside
the scheduling domains. More specifically, a linked list of FDs is
attached to each root domain. When multiple root domains are in use,
each list contains only the FDs covering the CPUs of its root domain. If
a FD spans over CPUs of two different root domains, it will be
duplicated in both lists.

The lists are fully maintained by the scheduler from
partition_sched_domains() in order to cope with hotplug and cpuset
changes. As for scheduling domains, the list are protected by RCU to
ensure safe concurrent updates.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/sched.h    |  23 +++++++
 kernel/sched/topology.c | 129 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 34549bca487d..7038df9fb713 100644
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
@@ -673,6 +674,12 @@ static inline bool sched_asym_prefer(int a, int b)
 	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
 }
 
+struct freq_domain {
+	struct em_freq_domain *obj;
+	struct freq_domain *next;
+	struct rcu_head rcu;
+};
+
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
@@ -721,6 +728,14 @@ struct root_domain {
 	struct cpupri		cpupri;
 
 	unsigned long		max_cpu_capacity;
+
+#ifdef CONFIG_ENERGY_MODEL
+	/*
+	 * NULL-terminated list of frequency domains intersecting with the
+	 * CPUs of the rd. Protected by RCU.
+	 */
+	struct freq_domain *fd;
+#endif
 };
 
 extern struct root_domain def_root_domain;
@@ -2169,3 +2184,11 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
 	return util;
 }
 #endif
+
+#ifdef CONFIG_SMP
+#ifdef CONFIG_ENERGY_MODEL
+#define freq_domain_span(fd) (to_cpumask(((fd)->obj->cpus)))
+#else
+#define freq_domain_span(fd) NULL
+#endif
+#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 61a1125c1ae4..357eff55c1a7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,6 +201,19 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
+#ifdef CONFIG_ENERGY_MODEL
+static void free_fd(struct freq_domain *fd)
+{
+	struct freq_domain *tmp;
+
+	while (fd) {
+		tmp = fd->next;
+		kfree(fd);
+		fd = tmp;
+	}
+}
+#endif
+
 static void free_rootdomain(struct rcu_head *rcu)
 {
 	struct root_domain *rd = container_of(rcu, struct root_domain, rcu);
@@ -211,6 +224,9 @@ static void free_rootdomain(struct rcu_head *rcu)
 	free_cpumask_var(rd->rto_mask);
 	free_cpumask_var(rd->online);
 	free_cpumask_var(rd->span);
+#ifdef CONFIG_ENERGY_MODEL
+	free_fd(rd->fd);
+#endif
 	kfree(rd);
 }
 
@@ -1635,6 +1651,104 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 	return sd;
 }
 
+#ifdef CONFIG_ENERGY_MODEL
+static struct freq_domain *find_fd(struct freq_domain *fd, int cpu)
+{
+	while (fd) {
+		if (cpumask_test_cpu(cpu, freq_domain_span(fd)))
+			return fd;
+		fd = fd->next;
+	}
+
+	return NULL;
+}
+
+static struct freq_domain *fd_init(int cpu)
+{
+	struct em_freq_domain *obj = em_cpu_get(cpu);
+	struct freq_domain *fd;
+
+	if (!obj) {
+		if (sched_debug())
+			pr_info("%s: no EM found for CPU%d\n", __func__, cpu);
+		return NULL;
+	}
+
+	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
+	if (!fd)
+		return NULL;
+	fd->obj = obj;
+
+	return fd;
+}
+
+static void sched_energy_fd_debug(const struct cpumask * cpu_map,
+						struct freq_domain *fd)
+{
+	if (!sched_debug() || !fd)
+		return;
+
+	printk(KERN_DEBUG "root_domain %*pbl: fd:", cpumask_pr_args(cpu_map));
+
+	while (fd) {
+		printk(KERN_CONT " { fd%d cpus=%*pbl nr_cstate=%d }",
+				cpumask_first(freq_domain_span(fd)),
+				cpumask_pr_args(freq_domain_span(fd)),
+				em_fd_nr_cap_states(fd->obj));
+		fd = fd->next;
+	}
+
+	printk(KERN_CONT "\n");
+}
+
+static void destroy_freq_domain_rcu(struct rcu_head *rp)
+{
+	struct freq_domain *fd;
+
+	fd = container_of(rp, struct freq_domain, rcu);
+	free_fd(fd);
+}
+
+static void build_freq_domains(const struct cpumask *cpu_map)
+{
+	struct freq_domain *fd = NULL, *tmp;
+	int cpu = cpumask_first(cpu_map);
+	struct root_domain *rd = cpu_rq(cpu)->rd;
+	int i;
+
+	for_each_cpu(i, cpu_map) {
+		/* Skip already covered CPUs. */
+		if (find_fd(fd, i))
+			continue;
+
+		/* Create the new fd and add it to the local list. */
+		tmp = fd_init(i);
+		if (!tmp)
+			goto free;
+		tmp->next = fd;
+		fd = tmp;
+	}
+
+	sched_energy_fd_debug(cpu_map, fd);
+
+	/* Attach the new list of frequency domains to the root domain. */
+	tmp = rd->fd;
+	rcu_assign_pointer(rd->fd, fd);
+	if (tmp)
+		call_rcu(&tmp->rcu, destroy_freq_domain_rcu);
+
+	return;
+
+free:
+	free_fd(fd);
+	tmp = rd->fd;
+	rcu_assign_pointer(rd->fd, NULL);
+	if (tmp)
+		call_rcu(&tmp->rcu, destroy_freq_domain_rcu);
+}
+#endif
+
+
 /*
  * Build sched domains for a given set of CPUs and attach the sched domains
  * to the individual CPUs
@@ -1913,6 +2027,21 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 		;
 	}
 
+#ifdef CONFIG_ENERGY_MODEL
+	/* Build freq domains: */
+	for (i = 0; i < ndoms_new; i++) {
+		for (j = 0; j < n; j++) {
+			if (cpumask_equal(doms_new[i], doms_cur[j])
+			    && cpu_rq(cpumask_first(doms_cur[j]))->rd->fd)
+			       goto match3;
+		}
+		/* No match - add freq domains for a new rd */
+		build_freq_domains(doms_new[i]);
+match3:
+		;
+	}
+#endif
+
 	/* Remember the new sched domains: */
 	if (doms_cur != &fallback_doms)
 		free_sched_domains(doms_cur, ndoms_cur);
-- 
2.17.1

