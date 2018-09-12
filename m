Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8146FC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3337220866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3337220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeILORv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:17:51 -0400
Received: from foss.arm.com ([217.140.101.70]:56068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbeILORv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:17:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0AB21684;
        Wed, 12 Sep 2018 02:14:13 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 991343F703;
        Wed, 12 Sep 2018 02:14:09 -0700 (PDT)
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
Subject: [PATCH v7 12/14] sched/fair: Select an energy-efficient CPU on task wake-up
Date:   Wed, 12 Sep 2018 10:13:07 +0100
Message-Id: <20180912091309.7551-13-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912091309.7551-1-quentin.perret@arm.com>
References: <20180912091309.7551-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an Energy Model (EM) is available and if the system isn't
overutilized, re-route waking tasks into an energy-aware placement
algorithm. The selection of an energy-efficient CPU for a task
is achieved by estimating the impact on system-level active energy
resulting from the placement of the task on the CPU with the highest
spare capacity in each performance domain. This strategy spreads tasks
in a performance domain and avoids overly aggressive task packing. The
best CPU energy-wise is then selected if it saves a large enough amount
of energy with respect to prev_cpu.

Although it has already shown significant benefits on some existing
targets, this approach cannot scale to platforms with numerous CPUs.
This is an attempt to do something useful as writing a fast heuristic
that performs reasonably well on a broad spectrum of architectures isn't
an easy task. As such, the scope of usability of the energy-aware
wake-up path is restricted to systems with the SD_ASYM_CPUCAPACITY flag
set, and where the EM isn't too complex.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c | 139 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7ee3e43cdaf2..6e988a01011c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6339,6 +6339,114 @@ static long compute_energy(struct task_struct *p, int dst_cpu,
 	return energy;
 }
 
+/*
+ * find_energy_efficient_cpu(): Find most energy-efficient target CPU for the
+ * waking task. find_energy_efficient_cpu() looks for the CPU with maximum
+ * spare capacity in each performance domain and uses it as a potential
+ * candidate to execute the task. Then, it uses the Energy Model to figure
+ * out which of the CPU candidates is the most energy-efficient.
+ *
+ * The rationale for this heuristic is as follows. In a performance domain,
+ * all the most energy efficient CPU candidates (according to the Energy
+ * Model) are those for which we'll request a low frequency. When there are
+ * several CPUs for which the frequency request will be the same, we don't
+ * have enough data to break the tie between them, because the Energy Model
+ * only includes active power costs. With this model, if we assume that
+ * frequency requests follow utilization (e.g. using schedutil), the CPU with
+ * the maximum spare capacity in a performance domain is guaranteed to be among
+ * the best candidates of the performance domain.
+ *
+ * In practice, it could be preferable from an energy standpoint to pack
+ * small tasks on a CPU in order to let other CPUs go in deeper idle states,
+ * but that could also hurt our chances to go cluster idle, and we have no
+ * ways to tell with the current Energy Model if this is actually a good
+ * idea or not. So, find_energy_efficient_cpu() basically favors
+ * cluster-packing, and spreading inside a cluster. That should at least be
+ * a good thing for latency, and this is consistent with the idea that most
+ * of the energy savings of EAS come from the asymmetry of the system, and
+ * not so much from breaking the tie between identical CPUs. That's also the
+ * reason why EAS is enabled in the topology code only for systems where
+ * SD_ASYM_CPUCAPACITY is set.
+ */
+static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu,
+							struct perf_domain *pd)
+{
+	unsigned long prev_energy = ULONG_MAX, best_energy = ULONG_MAX;
+	int cpu, best_energy_cpu = prev_cpu;
+	struct perf_domain *head = pd;
+	unsigned long cpu_cap, util;
+	struct sched_domain *sd;
+
+	sync_entity_load_avg(&p->se);
+
+	if (!task_util_est(p))
+		return prev_cpu;
+
+	/*
+	 * Energy-aware wake-up happens on the lowest sched_domain starting
+	 * from sd_asym_cpucapacity spanning over this_cpu and prev_cpu.
+	 */
+	sd = rcu_dereference(*this_cpu_ptr(&sd_asym_cpucapacity));
+	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
+		sd = sd->parent;
+	if (!sd)
+		return prev_cpu;
+
+	while (pd) {
+		unsigned long cur_energy, spare_cap, max_spare_cap = 0;
+		int max_spare_cap_cpu = -1;
+
+		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
+			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+				continue;
+
+			/* Skip CPUs that will be overutilized. */
+			util = cpu_util_next(cpu, p, cpu);
+			cpu_cap = capacity_of(cpu);
+			if (cpu_cap * 1024 < util * capacity_margin)
+				continue;
+
+			/* Always use prev_cpu as a candidate. */
+			if (cpu == prev_cpu) {
+				prev_energy = compute_energy(p, prev_cpu, head);
+				if (prev_energy < best_energy)
+					best_energy = prev_energy;
+				continue;
+			}
+
+			/*
+			 * Find the CPU with the maximum spare capacity in
+			 * the performance domain
+			 */
+			spare_cap = cpu_cap - util;
+			if (spare_cap > max_spare_cap) {
+				max_spare_cap = spare_cap;
+				max_spare_cap_cpu = cpu;
+			}
+		}
+
+		/* Evaluate the energy impact of using this CPU. */
+		if (max_spare_cap_cpu >= 0) {
+			cur_energy = compute_energy(p, max_spare_cap_cpu, head);
+			if (cur_energy < best_energy) {
+				best_energy = cur_energy;
+				best_energy_cpu = max_spare_cap_cpu;
+			}
+		}
+		pd = pd->next;
+	}
+
+	/*
+	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
+	 * least 6% of the energy used by prev_cpu.
+	 */
+	if (prev_energy == ULONG_MAX ||
+			(prev_energy - best_energy) > (prev_energy >> 4))
+		return best_energy_cpu;
+
+	return prev_cpu;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
@@ -6360,13 +6468,37 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
+	rcu_read_lock();
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
-		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
-			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
+
+		/*
+		 * Forkees are not accepted in the energy-aware wake-up path
+		 * because they don't have any useful utilization data yet and
+		 * it's not possible to forecast their impact on energy
+		 * consumption. Consequently, they will be placed by
+		 * find_idlest_cpu() on the least loaded CPU, which might turn
+		 * out to be energy-inefficient in some use-cases. The
+		 * alternative would be to bias new tasks towards specific types
+		 * of CPUs first, or to try to infer their util_avg from the
+		 * parent task, but those heuristics could hurt other use-cases
+		 * too. So, until someone finds a better way to solve this,
+		 * let's keep things simple by re-using the existing slow path.
+		 */
+		if (sched_feat(ENERGY_AWARE)) {
+			struct root_domain *rd = cpu_rq(cpu)->rd;
+			struct perf_domain *pd = rcu_dereference(rd->pd);
+
+			if (pd && !READ_ONCE(rd->overutilized)) {
+				new_cpu = find_energy_efficient_cpu(p, prev_cpu, pd);
+				goto unlock;
+			}
+		}
+
+		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
+			      cpumask_test_cpu(cpu, &p->cpus_allowed);
 	}
 
-	rcu_read_lock();
 	for_each_domain(cpu, tmp) {
 		if (!(tmp->flags & SD_LOAD_BALANCE))
 			break;
@@ -6401,6 +6533,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		if (want_affine)
 			current->recent_used_cpu = cpu;
 	}
+unlock:
 	rcu_read_unlock();
 
 	return new_cpu;
-- 
2.18.0

