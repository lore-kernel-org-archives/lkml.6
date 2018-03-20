Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AG47ELuNB3G0MXsp4EHzIER4pMMX1FVLvNL5oogz4Zx1RPecW8nEn0m6PLMIDlsUbpYZMA7v4jlM
ARC-Seal: i=1; a=rsa-sha256; t=1521539052; cv=none;
        d=google.com; s=arc-20160816;
        b=n9VzNyx1Lf5wp7vTBUBD9KgZbLs1p4g0SZVW2SX2a1YXb/e68jhy8u/1kgEdooKo8F
         IUts5/rCFyd9YeQx+UGj5ypZsnX1mVvmUdIsU7NQhsPoMdRpVyuW7UfYRNjODXW9RmlH
         sMb1pj/UnmLcoXgj1QtDi0y0y1eJFXb24YqI1aXPVRS9rpTs3nnkthYxvjdNL3REaSJt
         HrPe7cQPlpY+wD+sBz696ROEPGiIGMTZNqV02zWMWSMJR32y/wy76aNhYjSaVIwnOd3f
         AfP2Ppywgg75/Me12fGlqY0kcc2M59JMF58voa/xcHsJdyAQiZLlhimBP3Ibzv0uDcr7
         a8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0v9atM0N8QITDBdWv4vQWhjuy5CIlb1pbiV5JPK0SMc=;
        b=dBZr9FLuo0ywWp7sYe0b8+LoqojEN3sHdhU45vLnAZ8AFpo58qFSvt1mvmKUu+1FFl
         Af8zvGzNzAGbDYcCys5LhkSOn2sN4kgSYYsuVXpCicUxmekE0i3SlZxynWt4ia7FnG3Z
         lGWENOQh6Oy258eoIRzodLC99Bv0KrFxiBTlpzqkmn/cVO8QYwYfiZuBfuA7PjYQ8MOw
         x0CXy7Ef0JStEst+BXKIjAnR2dT3K7txk9+XbSRWJ1379A8JfnY4vwAlPB2g6VfJ5h7f
         S8j6lNcm26p7LKdKAsEzDs7Y4mbqvNSV8fQmM1JxT/KLvhcJ9eV1+7E1xWMr8L7rvoCZ
         693Q==
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
	Joel Fernandes <joelaf@google.com>
Subject: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Date: Tue, 20 Mar 2018 09:43:08 +0000
Message-Id: <20180320094312.24081-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180320094312.24081-1-dietmar.eggemann@arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449333969249680?=
X-GMAIL-MSGID: =?utf-8?q?1595449333969249680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Quentin Perret <quentin.perret@arm.com>

The energy consumption of each CPU in the system is modeled with a list
of values representing its dissipated power and compute capacity at each
available Operating Performance Point (OPP). These values are derived
from existing information in the kernel (currently used by the thermal
subsystem) and don't require the introduction of new platform-specific
tunables. The energy model is also provided with a simple representation
of all frequency domains as cpumasks, hence enabling the scheduler to be
aware of dependencies between CPUs. The data required to build the energy
model is provided by the OPP library which enables an abstract view of
the platform from the scheduler. The new data structures holding these
models and the routines to populate them are stored in
kernel/sched/energy.c.

For the sake of simplicity, it is assumed in the energy model that all
CPUs in a frequency domain share the same micro-architecture. As long as
this assumption is correct, the energy models of different CPUs belonging
to the same frequency domain are equal. Hence, this commit builds only one
energy model per frequency domain, and links all relevant CPUs to it in
order to save time and memory. If needed for future hardware platforms,
relaxing this assumption should imply relatively simple modifications in
the code but a significantly higher algorithmic complexity.

As it appears that energy-aware scheduling really makes a difference on
heterogeneous systems (e.g. big.LITTLE platforms), it is restricted to
systems having:

   1. SD_ASYM_CPUCAPACITY flag set
   2. Dynamic Voltage and Frequency Scaling (DVFS) is enabled
   3. Available power estimates for the OPPs of all possible CPUs

Moreover, the scheduler is notified of the energy model availability
using a static key in order to minimize the overhead on non-energy-aware
systems.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

---
This patch depends on additional infrastructure being merged in the OPP
core. As this infrastructure can also be useful for other clients, the
related patches have been posted separately [1].

[1] https://marc.info/?l=linux-pm&m=151635516419249&w=2
---
 include/linux/sched/energy.h |  31 +++++++
 kernel/sched/Makefile        |   2 +-
 kernel/sched/energy.c        | 190 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sched/energy.h
 create mode 100644 kernel/sched/energy.c

diff --git a/include/linux/sched/energy.h b/include/linux/sched/energy.h
new file mode 100644
index 000000000000..b4f43564ffe4
--- /dev/null
+++ b/include/linux/sched/energy.h
@@ -0,0 +1,31 @@
+#ifndef _LINUX_SCHED_ENERGY_H
+#define _LINUX_SCHED_ENERGY_H
+
+#ifdef CONFIG_SMP
+struct capacity_state {
+	unsigned long cap;	/* compute capacity */
+	unsigned long power;	/* power consumption at this compute capacity */
+};
+
+struct sched_energy_model {
+	int nr_cap_states;
+	struct capacity_state *cap_states;
+};
+
+struct freq_domain {
+	struct list_head next;
+	cpumask_t span;
+};
+
+extern struct sched_energy_model ** __percpu energy_model;
+extern struct static_key_false sched_energy_present;
+extern struct list_head freq_domains;
+#define for_each_freq_domain(fdom) \
+			list_for_each_entry(fdom, &freq_domains, next)
+
+void init_sched_energy(void);
+#else
+static inline void init_sched_energy(void) { }
+#endif
+
+#endif
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index d9a02b318108..912972ad4dbc 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -20,7 +20,7 @@ obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
 obj-y += wait.o wait_bit.o swait.o completion.o
 
-obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o
+obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o energy.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
diff --git a/kernel/sched/energy.c b/kernel/sched/energy.c
new file mode 100644
index 000000000000..4662c993e096
--- /dev/null
+++ b/kernel/sched/energy.c
@@ -0,0 +1,190 @@
+/*
+ * Released under the GPLv2 only.
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Energy-aware scheduling models
+ *
+ * Copyright (C) 2018, Arm Ltd.
+ * Written by: Quentin Perret, Arm Ltd.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#define pr_fmt(fmt) "sched-energy: " fmt
+
+#include <linux/sched/topology.h>
+#include <linux/sched/energy.h>
+#include <linux/pm_opp.h>
+
+#include "sched.h"
+
+DEFINE_STATIC_KEY_FALSE(sched_energy_present);
+struct sched_energy_model ** __percpu energy_model;
+
+/*
+ * A copy of the cpumasks representing the frequency domains is kept private
+ * to the scheduler. They are stacked in a dynamically allocated linked list
+ * as we don't know how many frequency domains the system has.
+ */
+LIST_HEAD(freq_domains);
+
+#ifdef CONFIG_PM_OPP
+static struct sched_energy_model *build_energy_model(int cpu)
+{
+	unsigned long cap_scale = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long cap, freq, power, max_freq = ULONG_MAX;
+	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
+	struct sched_energy_model *em = NULL;
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	int opp_cnt, i;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev) {
+		pr_err("CPU%d: Failed to get device\n", cpu);
+		return NULL;
+	}
+
+	opp_cnt = dev_pm_opp_get_opp_count(cpu_dev);
+	if (opp_cnt <= 0) {
+		pr_err("CPU%d: Failed to get # of available OPPs.\n", cpu);
+		return NULL;
+	}
+
+	opp = dev_pm_opp_find_freq_floor(cpu_dev, &max_freq);
+	if (IS_ERR(opp)) {
+		pr_err("CPU%d: Failed to get max frequency.\n", cpu);
+		return NULL;
+	}
+
+	dev_pm_opp_put(opp);
+	if (!max_freq) {
+		pr_err("CPU%d: Found null max frequency.\n", cpu);
+		return NULL;
+	}
+
+	em = kzalloc(sizeof(*em), GFP_KERNEL);
+	if (!em)
+		return NULL;
+
+	em->cap_states = kcalloc(opp_cnt, sizeof(*em->cap_states), GFP_KERNEL);
+	if (!em->cap_states)
+		goto free_em;
+
+	for (i = 0, freq = 0; i < opp_cnt; i++, freq++) {
+		opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq);
+		if (IS_ERR(opp)) {
+			pr_err("CPU%d: Failed to get OPP %d.\n", cpu, i+1);
+			goto free_cs;
+		}
+
+		power = dev_pm_opp_get_power(opp);
+		dev_pm_opp_put(opp);
+		if (!power || !freq)
+			goto free_cs;
+
+		cap = freq * cap_scale / max_freq;
+		em->cap_states[i].power = power;
+		em->cap_states[i].cap = cap;
+
+		/*
+		 * The capacity/watts efficiency ratio should decrease as the
+		 * frequency grows on sane platforms. If not, warn the user
+		 * that some high OPPs are more power efficient than some
+		 * of the lower ones.
+		 */
+		opp_eff = (cap << 20) / power;
+		if (opp_eff >= prev_opp_eff)
+			pr_warn("CPU%d: cap/pwr: OPP%d > OPP%d\n", cpu, i, i-1);
+		prev_opp_eff = opp_eff;
+	}
+
+	em->nr_cap_states = opp_cnt;
+	return em;
+
+free_cs:
+	kfree(em->cap_states);
+free_em:
+	kfree(em);
+	return NULL;
+}
+
+static void free_energy_model(void)
+{
+	struct sched_energy_model *em;
+	struct freq_domain *tmp, *pos;
+	int cpu;
+
+	list_for_each_entry_safe(pos, tmp, &freq_domains, next) {
+		cpu = cpumask_first(&(pos->span));
+		em = *per_cpu_ptr(energy_model, cpu);
+		if (em) {
+			kfree(em->cap_states);
+			kfree(em);
+		}
+
+		list_del(&(pos->next));
+		kfree(pos);
+	}
+
+	free_percpu(energy_model);
+}
+
+void init_sched_energy(void)
+{
+	struct freq_domain *fdom;
+	struct sched_energy_model *em;
+	struct device *cpu_dev;
+	int cpu, ret, fdom_cpu;
+
+	/* Energy Aware Scheduling is used for asymmetric systems only. */
+	if (!lowest_flag_domain(smp_processor_id(), SD_ASYM_CPUCAPACITY))
+		return;
+
+	energy_model = alloc_percpu(struct sched_energy_model *);
+	if (!energy_model)
+		goto exit_fail;
+
+	for_each_possible_cpu(cpu) {
+		if (*per_cpu_ptr(energy_model, cpu))
+			continue;
+
+		/* Keep a copy of the sharing_cpus mask */
+		fdom = kzalloc(sizeof(struct freq_domain), GFP_KERNEL);
+		if (!fdom)
+			goto free_em;
+
+		cpu_dev = get_cpu_device(cpu);
+		ret = dev_pm_opp_get_sharing_cpus(cpu_dev, &(fdom->span));
+		if (ret)
+			goto free_em;
+		list_add(&(fdom->next), &freq_domains);
+
+		/*
+		 * Build the energy model of one CPU, and link it to all CPUs
+		 * in its frequency domain. This should be correct as long as
+		 * they share the same micro-architecture.
+		 */
+		fdom_cpu = cpumask_first(&(fdom->span));
+		em = build_energy_model(fdom_cpu);
+		if (!em)
+			goto free_em;
+
+		for_each_cpu(fdom_cpu, &(fdom->span))
+			*per_cpu_ptr(energy_model, fdom_cpu) = em;
+	}
+
+	static_branch_enable(&sched_energy_present);
+
+	pr_info("Energy Aware Scheduling started.\n");
+	return;
+free_em:
+	free_energy_model();
+exit_fail:
+	pr_err("Energy Aware Scheduling initialization failed.\n");
+}
+#else
+void init_sched_energy(void) {}
+#endif
-- 
2.11.0
