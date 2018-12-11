Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930DEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F57E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F57E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeLKPjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:39:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeLKPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:39:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFd4tE4043565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:39:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFd47E4043562;
        Tue, 11 Dec 2018 07:39:04 -0800
Date:   Tue, 11 Dec 2018 07:39:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-732cd75b8c920d3727e69957b14faa7c2d7c3b75@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        quentin.perret@arm.com, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org, efault@gmx.de
Reply-To: quentin.perret@arm.com, hpa@zytor.com,
          torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, efault@gmx.de, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181203095628.11858-15-quentin.perret@arm.com>
References: <20181203095628.11858-15-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Select an energy-efficient CPU on task
 wake-up
Git-Commit-ID: 732cd75b8c920d3727e69957b14faa7c2d7c3b75
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

Commit-ID:  732cd75b8c920d3727e69957b14faa7c2d7c3b75
Gitweb:     https://git.kernel.org/tip/732cd75b8c920d3727e69957b14faa7c2d7c3b75
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:27 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:17:02 +0100

sched/fair: Select an energy-efficient CPU on task wake-up

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
Link: https://lkml.kernel.org/r/20181203095628.11858-15-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3c94584d947..ca469646ebe1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6453,6 +6453,137 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
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
+ *
+ * NOTE: Forkees are not accepted in the energy-aware wake-up path because
+ * they don't have any useful utilization data yet and it's not possible to
+ * forecast their impact on energy consumption. Consequently, they will be
+ * placed by find_idlest_cpu() on the least loaded CPU, which might turn out
+ * to be energy-inefficient in some use-cases. The alternative would be to
+ * bias new tasks towards specific types of CPUs first, or to try to infer
+ * their util_avg from the parent task, but those heuristics could hurt
+ * other use-cases too. So, until someone finds a better way to solve this,
+ * let's keep things simple by re-using the existing slow path.
+ */
+
+static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
+{
+	unsigned long prev_energy = ULONG_MAX, best_energy = ULONG_MAX;
+	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
+	int cpu, best_energy_cpu = prev_cpu;
+	struct perf_domain *head, *pd;
+	unsigned long cpu_cap, util;
+	struct sched_domain *sd;
+
+	rcu_read_lock();
+	pd = rcu_dereference(rd->pd);
+	if (!pd || READ_ONCE(rd->overutilized))
+		goto fail;
+	head = pd;
+
+	/*
+	 * Energy-aware wake-up happens on the lowest sched_domain starting
+	 * from sd_asym_cpucapacity spanning over this_cpu and prev_cpu.
+	 */
+	sd = rcu_dereference(*this_cpu_ptr(&sd_asym_cpucapacity));
+	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
+		sd = sd->parent;
+	if (!sd)
+		goto fail;
+
+	sync_entity_load_avg(&p->se);
+	if (!task_util_est(p))
+		goto unlock;
+
+	for (; pd; pd = pd->next) {
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
+				best_energy = min(best_energy, prev_energy);
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
+	}
+unlock:
+	rcu_read_unlock();
+
+	/*
+	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
+	 * least 6% of the energy used by prev_cpu.
+	 */
+	if (prev_energy == ULONG_MAX)
+		return best_energy_cpu;
+
+	if ((prev_energy - best_energy) > (prev_energy >> 4))
+		return best_energy_cpu;
+
+	return prev_cpu;
+
+fail:
+	rcu_read_unlock();
+
+	return -1;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
@@ -6476,8 +6607,16 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
-		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
-			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
+
+		if (static_branch_unlikely(&sched_energy_present)) {
+			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
+			if (new_cpu >= 0)
+				return new_cpu;
+			new_cpu = prev_cpu;
+		}
+
+		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
+			      cpumask_test_cpu(cpu, &p->cpus_allowed);
 	}
 
 	rcu_read_lock();
