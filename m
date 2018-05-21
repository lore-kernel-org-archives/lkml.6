Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeEUOZu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:25:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50994 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752869AbeEUOZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:25:45 -0400
From: Quentin Perret <quentin.perret@arm.com>
To: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com,
        joelaf@google.com, smuckle@google.com, adharmap@quicinc.com,
        skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model of CPUs when available
Date: Mon, 21 May 2018 15:25:00 +0100
Message-Id: <20180521142505.6522-6-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use EAS, the task scheduler has to know about the Energy
Model (EM) of the platform. This commit extends the scheduler topology
code to take references on the frequency domains objects of the EM
framework for all online CPUs. Hence, the availability of the EM for
those CPUs is guaranteed to the scheduler at runtime without further
checks in latency sensitive code paths (i.e. task wake-up).

A (RCU-protected) private list of online frequency domains is maintained
by the scheduler to enable fast iterations. Furthermore, the availability
of an EM is notified to the rest of the scheduler with a static key,
which ensures a low impact on non-EAS systems.

Energy Aware Scheduling can be started if and only if:
   1. all online CPUs are covered by the EM;
   2. the EM complexity is low enough to keep scheduling overheads low;
   3. the platform has an asymmetric CPU capacity topology (detected by
      looking for the SD_ASYM_CPUCAPACITY flag in the sched_domain
      hierarchy).

The sched_energy_enabled() function which returns the status of the
static key is stubbed to false when CONFIG_ENERGY_MODEL=n, hence making
sure that all the code behind it can be compiled out by constant
propagation.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/sched.h    |  27 ++++++++++
 kernel/sched/topology.c | 113 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ce562d3b7526..7c517076a74a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -63,6 +63,7 @@
 #include <linux/syscalls.h>
 #include <linux/task_work.h>
 #include <linux/tsacct_kern.h>
+#include <linux/energy_model.h>
 
 #include <asm/tlb.h>
 
@@ -2162,3 +2163,29 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
 	return util;
 }
 #endif
+
+struct sched_energy_fd {
+	struct em_freq_domain *fd;
+	struct list_head next;
+	struct rcu_head rcu;
+};
+
+#ifdef CONFIG_ENERGY_MODEL
+extern struct static_key_false sched_energy_present;
+static inline bool sched_energy_enabled(void)
+{
+	return static_branch_unlikely(&sched_energy_present);
+}
+
+extern struct list_head sched_energy_fd_list;
+#define for_each_freq_domain(sfd) \
+		list_for_each_entry_rcu(sfd, &sched_energy_fd_list, next)
+#define freq_domain_span(sfd) (&((sfd)->fd->cpus))
+#else
+static inline bool sched_energy_enabled(void)
+{
+	return false;
+}
+#define for_each_freq_domain(sfd) for (sfd = NULL; sfd;)
+#define freq_domain_span(sfd) NULL
+#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64cc564f5255..3e22c798f18d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1500,6 +1500,116 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
 
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_ENERGY_MODEL
+
+/*
+ * The complexity of the Energy Model is defined as the product of the number
+ * of frequency domains with the sum of the number of CPUs and the total
+ * number of OPPs in all frequency domains. It is generally not a good idea
+ * to use such a model on very complex platform because of the associated
+ * scheduling overheads. The arbitrary constraint below prevents that. It
+ * makes EAS usable up to 16 CPUs with per-CPU DVFS and less than 8 OPPs each,
+ * for example.
+ */
+#define EM_MAX_COMPLEXITY 2048
+
+DEFINE_STATIC_KEY_FALSE(sched_energy_present);
+LIST_HEAD(sched_energy_fd_list);
+
+static struct sched_energy_fd *find_sched_energy_fd(int cpu)
+{
+	struct sched_energy_fd *sfd;
+
+	for_each_freq_domain(sfd) {
+		if (cpumask_test_cpu(cpu, freq_domain_span(sfd)))
+			return sfd;
+	}
+
+	return NULL;
+}
+
+static void free_sched_energy_fd(struct rcu_head *rp)
+{
+	struct sched_energy_fd *sfd;
+
+	sfd = container_of(rp, struct sched_energy_fd, rcu);
+	kfree(sfd);
+}
+
+static void build_sched_energy(void)
+{
+	struct sched_energy_fd *sfd, *tmp;
+	struct em_freq_domain *fd;
+	struct sched_domain *sd;
+	int cpu, nr_fd = 0, nr_opp = 0;
+
+	rcu_read_lock();
+
+	/* Disable EAS entirely whenever the system isn't asymmetric. */
+	cpu = cpumask_first(cpu_online_mask);
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	if (!sd) {
+		pr_debug("%s: no SD_ASYM_CPUCAPACITY\n", __func__);
+		goto disable;
+	}
+
+	/* Make sure to have an energy model for all CPUs. */
+	for_each_online_cpu(cpu) {
+		/* Skip CPUs with a known energy model. */
+		sfd = find_sched_energy_fd(cpu);
+		if (sfd)
+			continue;
+
+		/* Add the energy model of others. */
+		fd = em_cpu_get(cpu);
+		if (!fd)
+			goto disable;
+		sfd = kzalloc(sizeof(*sfd), GFP_NOWAIT);
+		if (!sfd)
+			goto disable;
+		sfd->fd = fd;
+		list_add_rcu(&sfd->next, &sched_energy_fd_list);
+	}
+
+	list_for_each_entry_safe(sfd, tmp, &sched_energy_fd_list, next) {
+		if (cpumask_intersects(freq_domain_span(sfd),
+							cpu_online_mask)) {
+			nr_opp += em_fd_nr_cap_states(sfd->fd);
+			nr_fd++;
+			continue;
+		}
+
+		/* Remove the unused frequency domains */
+		list_del_rcu(&sfd->next);
+		call_rcu(&sfd->rcu, free_sched_energy_fd);
+	}
+
+	/* Bail out if the Energy Model complexity is too high. */
+	if (nr_fd * (nr_opp + num_online_cpus()) > EM_MAX_COMPLEXITY) {
+		pr_warn("%s: EM complexity too high, stopping EAS", __func__);
+		goto disable;
+	}
+
+	rcu_read_unlock();
+	static_branch_enable_cpuslocked(&sched_energy_present);
+	pr_debug("%s: EAS started\n", __func__);
+	return;
+
+disable:
+	rcu_read_unlock();
+	static_branch_disable_cpuslocked(&sched_energy_present);
+
+	/* Destroy the list */
+	list_for_each_entry_safe(sfd, tmp, &sched_energy_fd_list, next) {
+		list_del_rcu(&sfd->next);
+		call_rcu(&sfd->rcu, free_sched_energy_fd);
+	}
+	pr_debug("%s: EAS stopped\n", __func__);
+}
+#else
+static void build_sched_energy(void) { }
+#endif
+
 static int __sdt_alloc(const struct cpumask *cpu_map)
 {
 	struct sched_domain_topology_level *tl;
@@ -1913,6 +2023,9 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 		;
 	}
 
+	/* Try to start sched energy. */
+	build_sched_energy();
+
 	/* Remember the new sched domains: */
 	if (doms_cur != &fallback_doms)
 		free_sched_domains(doms_cur, ndoms_cur);
-- 
2.17.0
