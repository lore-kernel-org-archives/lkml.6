Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx48UxAnG9KY6vgenMcFd1Z6E96LmPPbXGJ8eZh1SJMAWib7gggwevtmHLcCwzHFY+qoqZYlo
ARC-Seal: i=1; a=rsa-sha256; t=1523029030; cv=none;
        d=google.com; s=arc-20160816;
        b=ZXLNGByBHMEHhHglkfFvZOXRIUM/U7an/74urxoggoLVSk4Yjf2GjsIfcPMG4U8nYD
         cVyaZ8VP2DSNxQGF3/tnAffHhcFqT2lPj4rii9QBjORPnW/M8LQT0VwdKU5C8MMsSACk
         fnzQyNWJObGy82DvV7zbd6dN3v00B8Php8q6Ylf1yrxnUcDcWSpfT45tfgeoDS/URk0N
         Wo8JCd5U6OLfp5SEfdUYS7RXpGeGEF/eEe166nbP+kWfn3HGxyKGn3TOexMj4TTRNQhV
         EMKGCZlfD54DV+Jg5NJNPXs8zs+xVlV63Tq2jDgyb2GxkN02EDf77+1bvgoRyXd+Qtl0
         SjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=u5p8oenYB59/ngPsj0LmGt1hCbK2BWPy+7JvoTtA20s=;
        b=M7qxecLZVqLiqOA7V5wkaubY4yvoYFy7/IX+5T4Gm0lFXI/kLVAE2dIwLyvOjm82a9
         LpScq7BVDFsix/+MC4/oTDcYW3+ewTBdf4gvIyxbd5YiBKniRfPbj1tw35foYiwzUUZA
         exM5ob2K8mZxjHPZlr3lMUXoNA1zRypC0ZMpb66OLCNaUV6Rvqk/aNUzYMOqqtLlyvr3
         bMzGyl0inmn1JUdhZnLLQfl+E2GCCWd0iTxKnH1p4xMDk3ySchGFNyq1qeHLu/v7N4Tp
         Y1Qh9+2F5944tum9exbAmWBVERBiIHKPNfSqcUarS1UOO6gZBZBqztDvqj7Cjwu2qNvT
         h5ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>,
	Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation helper function
Date: Fri,  6 Apr 2018 16:36:05 +0100
Message-Id: <20180406153607.17815-5-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180406153607.17815-1-dietmar.eggemann@arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1597011688129622279?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Quentin Perret <quentin.perret@arm.com>

In preparation for the definition of an energy-aware wakeup path, a
helper function is provided to estimate the consequence on system energy
when a specific task wakes-up on a specific CPU. compute_energy()
estimates the OPPs to be reached by all frequency domains and estimates
the consumption of each online CPU according to its energy model and its
percentage of busy time.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched/energy.h | 20 +++++++++++++
 kernel/sched/fair.c          | 68 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h         |  2 +-
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/energy.h b/include/linux/sched/energy.h
index 941071eec013..b4110b145228 100644
--- a/include/linux/sched/energy.h
+++ b/include/linux/sched/energy.h
@@ -27,6 +27,24 @@ static inline bool sched_energy_enabled(void)
 	return static_branch_unlikely(&sched_energy_present);
 }
 
+static inline
+struct capacity_state *find_cap_state(int cpu, unsigned long util)
+{
+	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
+	struct capacity_state *cs = NULL;
+	int i;
+
+	util += util >> 2;
+
+	for (i = 0; i < em->nr_cap_states; i++) {
+		cs = &em->cap_states[i];
+		if (cs->cap >= util)
+			break;
+	}
+
+	return cs;
+}
+
 static inline struct cpumask *freq_domain_span(struct freq_domain *fd)
 {
 	return &fd->span;
@@ -42,6 +60,8 @@ struct freq_domain;
 static inline bool sched_energy_enabled(void) { return false; }
 static inline struct cpumask
 *freq_domain_span(struct freq_domain *fd) { return NULL; }
+static inline struct capacity_state
+*find_cap_state(int cpu, unsigned long util) { return NULL; }
 static inline void init_sched_energy(void) { }
 #define for_each_freq_domain(fdom) for (; fdom; fdom = NULL)
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6960e5ef3c14..8cb9fb04fff2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6633,6 +6633,74 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 }
 
 /*
+ * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
+ */
+static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
+{
+	unsigned long util, util_est;
+	struct cfs_rq *cfs_rq;
+
+	/* Task is where it should be, or has no impact on cpu */
+	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
+		return cpu_util(cpu);
+
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	util = READ_ONCE(cfs_rq->avg.util_avg);
+
+	if (dst_cpu == cpu)
+		util += task_util(p);
+	else
+		util = max_t(long, util - task_util(p), 0);
+
+	if (sched_feat(UTIL_EST)) {
+		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+		if (dst_cpu == cpu)
+			util_est += _task_util_est(p);
+		else
+			util_est = max_t(long, util_est - _task_util_est(p), 0);
+		util = max(util, util_est);
+	}
+
+	return min_t(unsigned long, util, capacity_orig_of(cpu));
+}
+
+/*
+ * Estimates the system level energy assuming that p wakes-up on dst_cpu.
+ *
+ * compute_energy() is safe to call only if an energy model is available for
+ * the platform, which is when sched_energy_enabled() is true.
+ */
+static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
+{
+	unsigned long util, max_util, sum_util;
+	struct capacity_state *cs;
+	unsigned long energy = 0;
+	struct freq_domain *fd;
+	int cpu;
+
+	for_each_freq_domain(fd) {
+		max_util = sum_util = 0;
+		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			util += cpu_util_dl(cpu_rq(cpu));
+			max_util = max(util, max_util);
+			sum_util += util;
+		}
+
+		/*
+		 * Here we assume that the capacity states of CPUs belonging to
+		 * the same frequency domains are shared. Hence, we look at the
+		 * capacity state of the first CPU and re-use it for all.
+		 */
+		cpu = cpumask_first(freq_domain_span(fd));
+		cs = find_cap_state(cpu, max_util);
+		energy += cs->power * sum_util / cs->cap;
+	}
+
+	return energy;
+}
+
+/*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
  * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5d552c0d7109..6eb38f41d5d9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2156,7 +2156,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()	false
 #endif
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+#ifdef CONFIG_SMP
 static inline unsigned long cpu_util_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
-- 
2.11.0
