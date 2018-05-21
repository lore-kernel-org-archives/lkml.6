Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeEUO0H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:26:07 -0400
Received: from foss.arm.com ([217.140.101.70]:51120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752722AbeEUO0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:26:02 -0400
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
Subject: [RFC PATCH v3 09/10] sched/fair: Select an energy-efficient CPU on task wake-up
Date: Mon, 21 May 2018 15:25:04 +0100
Message-Id: <20180521142505.6522-10-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an energy model is available, and if the system isn't overutilized,
waking tasks are re-routed into a new energy-aware placement algorithm.
The selection of an energy-efficient CPU for a task is achieved by
estimating the impact on system-level active energy resulting from the
placement of the task on the CPU with the highest spare capacity in each
frequency domain. This strategy spreads tasks in a frequency domain and
avoids overly aggressive task packing. The best CPU energy-wise is then
selected if it saves a large enough amount of energy with respect to
prev_cpu.

Although it has already shown significant benefits on some existing
targets, this approach cannot scale to platforms with numerous CPUs.
This patch is an attempt to do something useful as writing a fast
heuristic that performs reasonably well on a broad spectrum of
architectures isn't an easy task. As such, the scope of usability of the
energy-aware wake-up path is restricted to systems with the
SD_ASYM_CPUCAPACITY flag set, and where the EM isn't too complex.

In addition, the energy-aware wake-up path is accessible only if
sched_energy_enabled() is true. For systems which don't meet all
dependencies for EAS (CONFIG_ENERGY_MODEL for ex.) at compile time,
sched_enegy_enabled() defaults to a constant "false" value, hence
letting the compiler remove the unused EAS code entirely.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c | 84 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1f7029258df2..eb44829be17f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6683,6 +6683,80 @@ static long compute_energy(struct task_struct *p, int dst_cpu)
 	return energy;
 }
 
+static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
+{
+	unsigned long cur_energy, prev_energy, best_energy, cpu_cap, task_util;
+	int cpu, best_energy_cpu = prev_cpu;
+	struct sched_energy_fd *sfd;
+	struct sched_domain *sd;
+
+	sync_entity_load_avg(&p->se);
+
+	task_util = task_util_est(p);
+	if (!task_util)
+		return prev_cpu;
+
+	/*
+	 * Energy-aware wake-up happens on the lowest sched_domain starting
+	 * from sd_ea spanning over this_cpu and prev_cpu.
+	 */
+	sd = rcu_dereference(*this_cpu_ptr(&sd_ea));
+	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
+		sd = sd->parent;
+	if (!sd)
+		return -1;
+
+	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
+		prev_energy = best_energy = compute_energy(p, prev_cpu);
+	else
+		prev_energy = best_energy = ULONG_MAX;
+
+	for_each_freq_domain(sfd) {
+		unsigned long spare_cap, max_spare_cap = 0;
+		int max_spare_cap_cpu = -1;
+		unsigned long util;
+
+		/* Find the CPU with the max spare cap in the freq. dom. */
+		for_each_cpu_and(cpu, freq_domain_span(sfd), sched_domain_span(sd)) {
+			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+				continue;
+
+			if (cpu == prev_cpu)
+				continue;
+
+			/* Skip CPUs that will be overutilized */
+			util = cpu_util_wake(cpu, p) + task_util;
+			cpu_cap = capacity_of(cpu);
+			if (cpu_cap * 1024 < util * capacity_margin)
+				continue;
+
+			spare_cap = cpu_cap - util;
+			if (spare_cap > max_spare_cap) {
+				max_spare_cap = spare_cap;
+				max_spare_cap_cpu = cpu;
+			}
+		}
+
+		/* Evaluate the energy impact of using this CPU. */
+		if (max_spare_cap_cpu >= 0) {
+			cur_energy = compute_energy(p, max_spare_cap_cpu);
+			if (cur_energy < best_energy) {
+				best_energy = cur_energy;
+				best_energy_cpu = max_spare_cap_cpu;
+			}
+		}
+	}
+
+	/*
+	 * We pick the best CPU only if it saves at least 1.5% of the
+	 * energy used by prev_cpu.
+	 */
+	if ((prev_energy - best_energy) > (prev_energy >> 6))
+		return best_energy_cpu;
+
+	return prev_cpu;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
@@ -6701,16 +6775,23 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
-	int want_affine = 0;
+	int want_affine = 0, want_energy = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
+		want_energy = sched_energy_enabled() &&
+			      !READ_ONCE(cpu_rq(cpu)->rd->overutilized);
 		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
 			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
 	}
 
 	rcu_read_lock();
+	if (want_energy) {
+		new_cpu = find_energy_efficient_cpu(p, prev_cpu);
+		goto unlock;
+	}
+
 	for_each_domain(cpu, tmp) {
 		if (!(tmp->flags & SD_LOAD_BALANCE))
 			break;
@@ -6745,6 +6826,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		if (want_affine)
 			current->recent_used_cpu = cpu;
 	}
+unlock:
 	rcu_read_unlock();
 
 	return new_cpu;
-- 
2.17.0
