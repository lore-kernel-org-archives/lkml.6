Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31C3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B8820880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B8820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbeGXNcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:32:01 -0400
Received: from foss.arm.com ([217.140.101.70]:49924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388264AbeGXNcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:32:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 249C315B2;
        Tue, 24 Jul 2018 05:25:46 -0700 (PDT)
Received: from e108498-lin.Emea.Arm.com (e108498-lin.emea.arm.com [10.4.13.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCB523F6A8;
        Tue, 24 Jul 2018 05:25:41 -0700 (PDT)
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
Subject: [PATCH v5 03/14] PM: Introduce an Energy Model management framework
Date:   Tue, 24 Jul 2018 13:25:10 +0100
Message-Id: <20180724122521.22109-4-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724122521.22109-1-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several subsystems in the kernel (task scheduler and/or thermal at the
time of writing) can benefit from knowing about the energy consumed by
CPUs. Yet, this information can come from different sources (DT or
firmware for example), in different formats, hence making it hard to
exploit without a standard API.

As an attempt to address this, introduce a centralized Energy Model
(EM) management framework which aggregates the power values provided
by drivers into a table for each frequency domain in the system. The
power cost tables are made available to interested clients (e.g. task
scheduler or thermal) via platform-agnostic APIs. The overall design
is represented by the diagram below (focused on Arm-related drivers as
an example, but applicable to any architecture):

     +---------------+  +-----------------+  +-------------+
     | Thermal (IPA) |  | Scheduler (EAS) |  |    Other    |
     +---------------+  +-----------------+  +-------------+
             |                 | em_fd_energy()     |
             |                 | em_cpu_get()       |
             +-----------+     |         +----------+
                         |     |         |
                         v     v         v
                      +---------------------+
                      |                     |
                      |    Energy Model     |
                      |                     |
                      |     Framework       |
                      |                     |
                      +---------------------+
                         ^       ^       ^
                         |       |       | em_register_freq_domain()
              +----------+       |       +---------+
              |                  |                 |
      +---------------+  +---------------+  +--------------+
      |  cpufreq-dt   |  |   arm_scmi    |  |    Other     |
      +---------------+  +---------------+  +--------------+
              ^                  ^                 ^
              |                  |                 |
      +--------------+   +---------------+  +--------------+
      | Device Tree  |   |   Firmware    |  |      ?       |
      +--------------+   +---------------+  +--------------+

Drivers (typically, but not limited to, CPUFreq drivers) can register
data in the EM framework using the em_register_freq_domain() API. The
calling driver must provide a callback function with a standardized
signature that will be used by the EM framework to build the power
cost tables of the frequency domain. This design should offer a lot of
flexibility to calling drivers which are free of reading information
from any location and to use any technique to compute power costs.
Moreover, the capacity states registered by drivers in the EM framework
are not required to match real performance states of the target. This
is particularly important on targets where the performance states are
not known by the OS.

On the client side, the EM framework offers APIs to access the power
cost tables of a CPU (em_cpu_get()), and to estimate the energy
consumed by the CPUs of a frequency domain (em_fd_energy()). Clients
such as the task scheduler can then use these APIs to access the shared
data structures holding the Energy Model of CPUs.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/energy_model.h | 161 ++++++++++++++++++++++++++++
 kernel/power/Kconfig         |  15 +++
 kernel/power/Makefile        |   2 +
 kernel/power/energy_model.c  | 199 +++++++++++++++++++++++++++++++++++
 4 files changed, 377 insertions(+)
 create mode 100644 include/linux/energy_model.h
 create mode 100644 kernel/power/energy_model.c

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
new file mode 100644
index 000000000000..be822ce05c17
--- /dev/null
+++ b/include/linux/energy_model.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ENERGY_MODEL_H
+#define _LINUX_ENERGY_MODEL_H
+#include <linux/cpumask.h>
+#include <linux/jump_label.h>
+#include <linux/kobject.h>
+#include <linux/rcupdate.h>
+#include <linux/sched/cpufreq.h>
+#include <linux/sched/topology.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_ENERGY_MODEL
+struct em_cap_state {
+	unsigned long frequency; /* Kilo-hertz */
+	unsigned long power; /* Milli-watts */
+	unsigned long cost; /* power * max_frequency / frequency */
+};
+
+struct em_freq_domain {
+	struct em_cap_state *table; /* Capacity states, in ascending order. */
+	int nr_cap_states;
+	unsigned long cpus[0]; /* CPUs of the frequency domain. */
+};
+
+#define EM_CPU_MAX_POWER 0xFFFF
+
+struct em_data_callback {
+	/**
+	 * active_power() - Provide power at the next capacity state of a CPU
+	 * @power	: Active power at the capacity state in mW (modified)
+	 * @freq	: Frequency at the capacity state in kHz (modified)
+	 * @cpu		: CPU for which we do this operation
+	 *
+	 * active_power() must find the lowest capacity state of 'cpu' above
+	 * 'freq' and update 'power' and 'freq' to the matching active power
+	 * and frequency.
+	 *
+	 * The power is the one of a single CPU in the domain, expressed in
+	 * milli-watts. It is expected to fit in the [0, EM_CPU_MAX_POWER]
+	 * range.
+	 *
+	 * Return 0 on success.
+	 */
+	int (*active_power)(unsigned long *power, unsigned long *freq, int cpu);
+};
+#define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
+
+struct em_freq_domain *em_cpu_get(int cpu);
+int em_register_freq_domain(cpumask_t *span, unsigned int nr_states,
+						struct em_data_callback *cb);
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
+	unsigned long freq, scale_cpu;
+	struct em_cap_state *cs;
+	int i, cpu;
+
+	/*
+	 * In order to predict the capacity state, map the utilization of the
+	 * most utilized CPU of the frequency domain to a requested frequency,
+	 * like schedutil.
+	 */
+	cpu = cpumask_first(to_cpumask(fd->cpus));
+	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+	cs = &fd->table[fd->nr_cap_states - 1];
+	freq = map_util_freq(max_util, cs->frequency, scale_cpu);
+
+	/*
+	 * Find the lowest capacity state of the Energy Model above the
+	 * requested frequency.
+	 */
+	for (i = 0; i < fd->nr_cap_states; i++) {
+		cs = &fd->table[i];
+		if (cs->frequency >= freq)
+			break;
+	}
+
+	/*
+	 * The capacity of a CPU in the domain at that capacity state (cs)
+	 * can be computed as:
+	 *
+	 *             cs->freq * scale_cpu
+	 *   cs->cap = --------------------                          (1)
+	 *                 cpu_max_freq
+	 *
+	 * So, the energy consumed by this CPU at that capacity state is:
+	 *
+	 *             cs->power * cpu_util
+	 *   cpu_nrg = --------------------                          (2)
+	 *                   cs->cap
+	 *
+	 * since 'cpu_util / cs->cap' represents its percentage of busy time.
+	 * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
+	 * of two terms:
+	 *
+	 *             cs->power * cpu_max_freq   cpu_util
+	 *   cpu_nrg = ------------------------ * ---------          (3)
+	 *                    cs->freq            scale_cpu
+	 *
+	 * The first term is static, and is stored in the em_cap_state struct
+	 * as 'cs->cost'.
+	 *
+	 * Since all CPUs of the domain have the same micro-architecture, they
+	 * share the same 'cs->cost', and the same CPU capacity. Hence, the
+	 * total energy of the domain (which is the simple sum of the energy of
+	 * all of its CPUs) can be factorized as:
+	 *
+	 *            cs->cost * \Sum cpu_util
+	 *   fd_nrg = ------------------------                       (4)
+	 *                  scale_cpu
+	 */
+	return cs->cost * sum_util / scale_cpu;
+}
+
+/**
+ * em_fd_nr_cap_states() - Get the number of capacity states of a freq. domain
+ * @fd		: frequency domain for which this must be done
+ *
+ * Return: the number of capacity states in the frequency domain table
+ */
+static inline int em_fd_nr_cap_states(struct em_freq_domain *fd)
+{
+	return fd->nr_cap_states;
+}
+
+#else
+struct em_freq_domain {};
+struct em_data_callback {};
+#define EM_DATA_CB(_active_power_cb) { }
+
+static inline int em_register_freq_domain(cpumask_t *span,
+			unsigned int nr_states, struct em_data_callback *cb)
+{
+	return -EINVAL;
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
+#endif
+
+#endif
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index e880ca22c5a5..6f6db452dc7d 100644
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
+	  which subsystems can access the energy models.
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
index 000000000000..39740fe728ea
--- /dev/null
+++ b/kernel/power/energy_model.c
@@ -0,0 +1,199 @@
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
+#include <linux/cpumask.h>
+#include <linux/energy_model.h>
+#include <linux/sched/topology.h>
+#include <linux/slab.h>
+
+/* Mapping of each CPU to the frequency domain to which it belongs. */
+static DEFINE_PER_CPU(struct em_freq_domain *, em_data);
+
+/*
+ * Mutex serializing the registrations of frequency domains and letting
+ * callbacks defined by drivers sleep.
+ */
+static DEFINE_MUTEX(em_fd_mutex);
+
+static struct em_freq_domain *em_create_fd(cpumask_t *span, int nr_states,
+						struct em_data_callback *cb)
+{
+	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
+	unsigned long power, freq, prev_freq = 0;
+	int i, ret, cpu = cpumask_first(span);
+	struct em_cap_state *table;
+	struct em_freq_domain *fd;
+	u64 fmax;
+
+	if (!cb->active_power)
+		return NULL;
+
+	fd = kzalloc(sizeof(*fd) + cpumask_size(), GFP_KERNEL);
+	if (!fd)
+		return NULL;
+
+	table = kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
+	if (!table)
+		goto free_fd;
+
+	/* Build the list of capacity states for this frequency domain */
+	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
+		/*
+		 * active_power() is a driver callback which ceils 'freq' to
+		 * lowest capacity state of 'cpu' above 'freq' and updates
+		 * 'power' and 'freq' accordingly.
+		 */
+		ret = cb->active_power(&power, &freq, cpu);
+		if (ret) {
+			pr_err("fd%d: invalid cap. state: %d\n", cpu, ret);
+			goto free_cs_table;
+		}
+
+		/*
+		 * We expect the driver callback to increase the frequency for
+		 * higher capacity states.
+		 */
+		if (freq <= prev_freq) {
+			pr_err("fd%d: non-increasing freq: %lu\n", cpu, freq);
+			goto free_cs_table;
+		}
+
+		/*
+		 * The power returned by active_state() is expected to be in
+		 * milli-watts and to fit into 16 bits.
+		 */
+		if (power > EM_CPU_MAX_POWER) {
+			pr_err("fd%d: power out of scale: %lu\n", cpu, power);
+			goto free_cs_table;
+		}
+
+		table[i].power = power;
+		table[i].frequency = prev_freq = freq;
+
+		/*
+		 * The hertz/watts efficiency ratio should decrease as the
+		 * frequency grows on sane platforms. But this isn't always
+		 * true in practice so warn the user if a higher OPP is more
+		 * power efficient than a lower one.
+		 */
+		opp_eff = freq / power;
+		if (opp_eff >= prev_opp_eff)
+			pr_warn("fd%d: hertz/watts ratio non-monotonically decreasing: OPP%d >= OPP%d\n",
+					cpu, i, i - 1);
+		prev_opp_eff = opp_eff;
+	}
+
+	/* Compute the cost of each capacity_state. */
+	fmax = (u64) table[nr_states - 1].frequency;
+	for (i = 0; i < nr_states; i++) {
+		table[i].cost = div64_u64(fmax * table[i].power,
+					  table[i].frequency);
+	}
+
+	fd->table = table;
+	fd->nr_cap_states = nr_states;
+	cpumask_copy(to_cpumask(fd->cpus), span);
+
+	return fd;
+
+free_cs_table:
+	kfree(table);
+free_fd:
+	kfree(fd);
+
+	return NULL;
+}
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
+	return READ_ONCE(per_cpu(em_data, cpu));
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
+	unsigned long cap, prev_cap = 0;
+	struct em_freq_domain *fd;
+	int cpu, ret = 0;
+
+	if (!span || !nr_states || !cb)
+		return -EINVAL;
+
+	/*
+	 * Use a mutex to serialize the registration of frequency domains and
+	 * let the driver-defined callback functions sleep.
+	 */
+	mutex_lock(&em_fd_mutex);
+
+	for_each_cpu(cpu, span) {
+		/* Make sure we don't register again an existing domain. */
+		if (READ_ONCE(per_cpu(em_data, cpu))) {
+			ret = -EEXIST;
+			goto unlock;
+		}
+
+		/*
+		 * All CPUs of a domain must have the same micro-architecture
+		 * since they all share the same table.
+		 */
+		cap = arch_scale_cpu_capacity(NULL, cpu);
+		if (prev_cap && prev_cap != cap) {
+			pr_err("CPUs of %*pbl must have the same capacity\n",
+							cpumask_pr_args(span));
+			ret = -EINVAL;
+			goto unlock;
+		}
+		prev_cap = cap;
+	}
+
+	/* Create the frequency domain and add it to the Energy Model. */
+	fd = em_create_fd(span, nr_states, cb);
+	if (!fd) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	for_each_cpu(cpu, span) {
+		/*
+		 * The per-cpu array can be concurrently accessed from
+		 * em_cpu_get().
+		 */
+		smp_store_release(per_cpu_ptr(&em_data, cpu), fd);
+	}
+
+	pr_debug("Created freq domain %*pbl\n", cpumask_pr_args(span));
+unlock:
+	mutex_unlock(&em_fd_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(em_register_freq_domain);
-- 
2.18.0

