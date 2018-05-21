Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeEUOZm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:25:42 -0400
Received: from foss.arm.com ([217.140.101.70]:50934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752536AbeEUOZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:25:36 -0400
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
Subject: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management framework
Date: Mon, 21 May 2018 15:24:58 +0100
Message-Id: <20180521142505.6522-4-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several subsystems in the kernel (scheduler and/or thermal at the time
of writing) can benefit from knowing about the energy consumed by CPUs.
Yet, this information can come from different sources (DT or firmware for
example), in different formats, hence making it hard to exploit without
a standard API.

This patch attempts to solve this issue by introducing a centralized
Energy Model (EM) framework which can be used to interface the data
providers with the client subsystems. This framework standardizes the
API to expose power costs, and to access them from multiple locations.

The current design assumes that all CPUs in a frequency domain share the
same micro-architecture. As such, the EM data is structured in a
per-frequency-domain fashion. Drivers aware of frequency domains
(typically, but not limited to, CPUFreq drivers) are expected to register
data in the EM framework using the em_register_freq_domain() API. To do
so, the drivers must provide a callback function that will be called by
the EM framework to populate the tables. As of today, only the active
power of the CPUs is considered. For each frequency domain, the EM
includes a list of <frequency, power, capacity> tuples for the capacity
states of the domain alongside a cpumask covering the involved CPUs.

The EM framework also provides an API to re-scale the capacity values
of the model asynchronously, after it has been created. This is required
for architectures where the capacity scale factor of CPUs can change at
run-time. This is the case for Arm/Arm64 for example where the
arch_topology driver recomputes the capacity scale factors of the CPUs
after the maximum frequency of all CPUs has been discovered. Although
complex, the process of creating and re-scaling the EM has to be kept in
two separate steps to fulfill the needs of the different users. The thermal
subsystem doesn't use the capacity values and shouldn't have dependencies
on subsystems providing them. On the other hand, the task scheduler needs
the capacity values, and it will benefit from seeing them up-to-date when
applicable.

Because of this need for asynchronous update, the capacity state table
of each frequency domain is protected by RCU, hence guaranteeing a safe
modification of the table and a fast access to readers in latency-sensitive
code paths.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/energy_model.h | 122 +++++++++++++++++
 kernel/power/Kconfig         |  15 +++
 kernel/power/Makefile        |   2 +
 kernel/power/energy_model.c  | 249 +++++++++++++++++++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 include/linux/energy_model.h
 create mode 100644 kernel/power/energy_model.c

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
new file mode 100644
index 000000000000..edde888852ba
--- /dev/null
+++ b/include/linux/energy_model.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ENERGY_MODEL_H
+#define _LINUX_ENERGY_MODEL_H
+#include <linux/types.h>
+#include <linux/cpumask.h>
+#include <linux/jump_label.h>
+#include <linux/rcupdate.h>
+#include <linux/kobject.h>
+#include <linux/sched/cpufreq.h>
+
+#ifdef CONFIG_ENERGY_MODEL
+struct em_cap_state {
+	unsigned long capacity;
+	unsigned long frequency;
+	unsigned long power;
+};
+
+struct em_cs_table {
+	struct em_cap_state *state;
+	int nr_cap_states;
+	struct rcu_head rcu;
+};
+
+struct em_freq_domain {
+	struct em_cs_table *cs_table;
+	cpumask_t cpus;
+};
+
+struct em_data_callback {
+	/**
+	 * active_power() - Provide power at the next capacity state of a CPU
+	 * @power	: Active power at the capacity state (modified)
+	 * @freq	: Frequency at the capacity state (modified)
+	 * @cpu		: CPU for which we do this operation
+	 *
+	 * active_power() must find the lowest capacity state of 'cpu' above
+	 * 'freq' and update 'power' and 'freq' to the matching active power
+	 * and frequency.
+	 *
+	 * Return 0 on success.
+	 */
+	int (*active_power) (unsigned long *power, unsigned long *freq, int cpu);
+};
+
+int em_register_freq_domain(cpumask_t *span, unsigned int nr_states,
+						struct em_data_callback *cb);
+void em_rescale_cpu_capacity(void);
+struct em_freq_domain *em_cpu_get(int cpu);
+
+/**
+ * em_fd_energy() - Estimates the energy consumed by the CPUs of a freq. domain
+ * @fd		: frequency domain for which energy has to be estimated
+ * @max_util	: highest utilization among CPUs of the domain
+ * @sum_util	: sum of the utilization of all CPUs in the domain
+ *
+ * Return: the sum of the energy consumed by the CPUs of the domain assuming
+ * a capacity state satisfying the max utilization of the domain.
+ */
+static inline unsigned long em_fd_energy(struct em_freq_domain *fd,
+				unsigned long max_util, unsigned long sum_util)
+{
+	struct em_cs_table *cs_table;
+	struct em_cap_state *cs;
+	unsigned long freq;
+	int i;
+
+	cs_table = rcu_dereference(fd->cs_table);
+	if (!cs_table)
+		return 0;
+
+	/* Map the utilization value to a frequency */
+	cs = &cs_table->state[cs_table->nr_cap_states - 1];
+	freq = map_util_freq(max_util, cs->frequency, cs->capacity);
+
+	/* Find the lowest capacity state above this frequency */
+	for (i = 0; i < cs_table->nr_cap_states; i++) {
+		cs = &cs_table->state[i];
+		if (cs->frequency >= freq)
+			break;
+	}
+
+	return cs->power * sum_util / cs->capacity;
+}
+
+/**
+ * em_fd_nr_cap_states() - Get the number of capacity states of a freq. domain
+ * @fd		: frequency domain for which want to do this
+ *
+ * Return: the number of capacity state in the frequency domain table
+ */
+static inline int em_fd_nr_cap_states(struct em_freq_domain *fd)
+{
+	struct em_cs_table *table = rcu_dereference(fd->cs_table);
+
+	return table->nr_cap_states;
+}
+
+#else
+struct em_freq_domain;
+struct em_data_callback;
+static inline int em_register_freq_domain(cpumask_t *span,
+			unsigned int nr_states, struct em_data_callback *cb)
+{
+	return -ENOTSUPP;
+}
+static inline struct em_freq_domain *em_cpu_get(int cpu)
+{
+	return NULL;
+}
+static inline unsigned long em_fd_energy(struct em_freq_domain *fd,
+			unsigned long max_util, unsigned long sum_util)
+{
+	return 0;
+}
+static inline int em_fd_nr_cap_states(struct em_freq_domain *fd)
+{
+	return 0;
+}
+static inline void em_rescale_cpu_capacity(void) { }
+#endif
+
+#endif
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index e880ca22c5a5..b9e2b92e3be1 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -297,3 +297,18 @@ config PM_GENERIC_DOMAINS_OF
 
 config CPU_PM
 	bool
+
+config ENERGY_MODEL
+	bool "Energy Model for CPUs"
+	depends on SMP
+	depends on CPU_FREQ
+	default n
+	help
+	  Several subsystems (thermal and/or the task scheduler for example)
+	  can leverage information about the energy consumed by CPUs to make
+	  smarter decisions. This config option enables the framework from
+	  which a user can access the energy models.
+
+	  The exact usage of the energy model is subsystem-dependent.
+
+	  If in doubt, say N.
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index a3f79f0eef36..e7e47d9be1e5 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_PM_AUTOSLEEP)	+= autosleep.o
 obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
+
+obj-$(CONFIG_ENERGY_MODEL)	+= energy_model.o
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
new file mode 100644
index 000000000000..a2eece7007a8
--- /dev/null
+++ b/kernel/power/energy_model.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Energy Model of CPUs
+ *
+ * Copyright (c) 2018, Arm ltd.
+ * Written by: Quentin Perret, Arm ltd.
+ */
+
+#define pr_fmt(fmt) "energy_model: " fmt
+
+#include <linux/cpu.h>
+#include <linux/slab.h>
+#include <linux/cpumask.h>
+#include <linux/energy_model.h>
+#include <linux/sched/topology.h>
+
+/* Mapping of each CPU to the frequency domain to which it belongs. */
+static DEFINE_PER_CPU(struct em_freq_domain *, em_data);
+
+/*
+ * Protects the access to em_data. Readers of em_data can be in RCU-critical
+ * sections, and can't afford to sleep.
+ */
+static DEFINE_RWLOCK(em_data_lock);
+
+/*
+ * Mutex serializing the registrations of frequency domains. It allows the
+ * callbacks defined by drivers to sleep.
+ */
+static DEFINE_MUTEX(em_fd_mutex);
+
+static struct em_cs_table *alloc_cs_table(int nr_states)
+{
+	struct em_cs_table *cs_table;
+
+	cs_table = kzalloc(sizeof(*cs_table), GFP_NOWAIT);
+	if (!cs_table)
+		return NULL;
+
+	cs_table->state = kcalloc(nr_states, sizeof(*cs_table->state),
+								GFP_NOWAIT);
+	if (!cs_table->state) {
+		kfree(cs_table);
+		return NULL;
+	}
+
+	cs_table->nr_cap_states = nr_states;
+
+	return cs_table;
+}
+
+static void free_cs_table(struct em_cs_table *table)
+{
+	if (table) {
+		kfree(table->state);
+		kfree(table);
+	}
+}
+
+static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
+{
+	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
+	int max_cap_state = cs_table->nr_cap_states - 1;
+	unsigned long fmax = cs_table->state[max_cap_state].frequency;
+	int i;
+
+	for (i = 0; i < cs_table->nr_cap_states; i++)
+		cs_table->state[i].capacity = cmax *
+					cs_table->state[i].frequency / fmax;
+}
+
+static struct em_freq_domain *em_create_fd(cpumask_t *span, int nr_states,
+						struct em_data_callback *cb)
+{
+	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
+	int i, ret, cpu = cpumask_first(span);
+	struct em_freq_domain *fd;
+	unsigned long power, freq;
+
+	if (!cb->active_power)
+		return NULL;
+
+	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
+	if (!fd)
+		return NULL;
+
+	fd->cs_table = alloc_cs_table(nr_states);
+	if (!fd->cs_table)
+		goto free_fd;
+
+	/* Copy the span of the frequency domain */
+	cpumask_copy(&fd->cpus, span);
+
+	/* Build the list of capacity states for this freq domain */
+	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
+		ret = cb->active_power(&power, &freq, cpu);
+		if (ret)
+			goto free_cs_table;
+
+		fd->cs_table->state[i].power = power;
+		fd->cs_table->state[i].frequency = freq;
+
+		/*
+		 * The hertz/watts efficiency ratio should decrease as the
+		 * frequency grows on sane platforms. If not, warn the user
+		 * that some high OPPs are more power efficient than some
+		 * of the lower ones.
+		 */
+		opp_eff = freq / power;
+		if (opp_eff >= prev_opp_eff)
+			pr_warn("%*pbl: hz/watt efficiency: OPP %d >= OPP%d\n",
+					cpumask_pr_args(span), i, i - 1);
+		prev_opp_eff = opp_eff;
+	}
+	fd_update_cs_table(fd->cs_table, cpu);
+
+	return fd;
+
+free_cs_table:
+	free_cs_table(fd->cs_table);
+free_fd:
+	kfree(fd);
+
+	return NULL;
+}
+
+static void rcu_free_cs_table(struct rcu_head *rp)
+{
+	struct em_cs_table *table;
+
+	table = container_of(rp, struct em_cs_table, rcu);
+	free_cs_table(table);
+}
+
+/**
+ * em_rescale_cpu_capacity() - Re-scale capacity values of the Energy Model
+ *
+ * This re-scales the capacity values for all capacity states of all frequency
+ * domains of the Energy Model. This should be used when the capacity values
+ * of the CPUs are updated at run-time, after the EM was registered.
+ */
+void em_rescale_cpu_capacity(void)
+{
+	struct em_cs_table *old_table, *new_table;
+	struct em_freq_domain *fd;
+	unsigned long flags;
+	int nr_states, cpu;
+
+	read_lock_irqsave(&em_data_lock, flags);
+	for_each_cpu(cpu, cpu_possible_mask) {
+		fd = per_cpu(em_data, cpu);
+		if (!fd || cpu != cpumask_first(&fd->cpus))
+			continue;
+
+		/* Copy the existing table. */
+		old_table = rcu_dereference(fd->cs_table);
+		nr_states = old_table->nr_cap_states;
+		new_table = alloc_cs_table(nr_states);
+		if (!new_table) {
+			read_unlock_irqrestore(&em_data_lock, flags);
+			return;
+		}
+		memcpy(new_table->state, old_table->state,
+					nr_states * sizeof(*new_table->state));
+
+		/* Re-scale the capacity values on the copy. */
+		fd_update_cs_table(new_table, cpumask_first(&fd->cpus));
+
+		/* Replace the table with the rescaled version. */
+		rcu_assign_pointer(fd->cs_table, new_table);
+		call_rcu(&old_table->rcu, rcu_free_cs_table);
+	}
+	read_unlock_irqrestore(&em_data_lock, flags);
+	pr_debug("Re-scaled CPU capacities\n");
+}
+EXPORT_SYMBOL_GPL(em_rescale_cpu_capacity);
+
+/**
+ * em_cpu_get() - Return the frequency domain for a CPU
+ * @cpu : CPU to find the frequency domain for
+ *
+ * Return: the frequency domain to which 'cpu' belongs, or NULL if it doesn't
+ * exist.
+ */
+struct em_freq_domain *em_cpu_get(int cpu)
+{
+	struct em_freq_domain *fd;
+	unsigned long flags;
+
+	read_lock_irqsave(&em_data_lock, flags);
+	fd = per_cpu(em_data, cpu);
+	read_unlock_irqrestore(&em_data_lock, flags);
+
+	return fd;
+}
+EXPORT_SYMBOL_GPL(em_cpu_get);
+
+/**
+ * em_register_freq_domain() - Register the Energy Model of a frequency domain
+ * @span	: Mask of CPUs in the frequency domain
+ * @nr_states	: Number of capacity states to register
+ * @cb		: Callback functions providing the data of the Energy Model
+ *
+ * Create Energy Model tables for a frequency domain using the callbacks
+ * defined in cb.
+ *
+ * If multiple clients register the same frequency domain, all but the first
+ * registration will be ignored.
+ *
+ * Return 0 on success
+ */
+int em_register_freq_domain(cpumask_t *span, unsigned int nr_states,
+						struct em_data_callback *cb)
+{
+	struct em_freq_domain *fd;
+	unsigned long flags;
+	int cpu, ret = 0;
+
+	if (!span || !nr_states || !cb)
+		return -EINVAL;
+
+	mutex_lock(&em_fd_mutex);
+
+	/* Make sure we don't register again an existing domain. */
+	for_each_cpu(cpu, span) {
+		if (per_cpu(em_data, cpu)) {
+			ret = -EEXIST;
+			goto unlock;
+		}
+	}
+
+	/* Create the frequency domain and add it to the Energy Model. */
+	fd = em_create_fd(span, nr_states, cb);
+	if (!fd) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	write_lock_irqsave(&em_data_lock, flags);
+	for_each_cpu(cpu, span)
+		per_cpu(em_data, cpu) = fd;
+	write_unlock_irqrestore(&em_data_lock, flags);
+
+	pr_debug("Created freq domain %*pbl\n", cpumask_pr_args(span));
+unlock:
+	mutex_unlock(&em_fd_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(em_register_freq_domain);
-- 
2.17.0
