Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeFEJVk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:21:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38926 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbeFEJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:21:37 -0400
X-Google-Smtp-Source: ADUXVKKlfpf5JeirZ8VxeP9LvwladZYdvrj6/GLKpxegpVGq7aUj3hOWnMVzhpvVsDpDp3KTBImRow==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE)
Subject: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection framework
Date: Tue,  5 Jun 2018 11:16:40 +0200
Message-Id: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially, the cpu_cooling device for ARM was changed by adding a new
policy inserting idle cycles. The intel_powerclamp driver does a
similar action.

Instead of implementing idle injections privately in the cpu_cooling
device, move the idle injection code in a dedicated framework and give
the opportunity to other frameworks to make use of it.

The framework relies on the smpboot kthreads which handles via its
main loop the common code for hotplugging and [un]parking.

This code was previously tested with the cpu cooling device and went
through several iterations. It results now in split code and API
exported in the header file. It was tested with the cpu cooling device
with success.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Javi Merino <javi.merino@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rui Zhang <rui.zhang@intel.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
---
V5:
   - Move init_completion in the init function (Viresh Kumar)
   - Increment task count in the wakeup function (Viresh Kumar)
   - Remove rollback at init time (Viresh Kumar)

V4:
   - Wait for completion when stopping (Viresh Kumar)
   - Check init already done and rollback (Viresh Kumar)

V3:
   - Fixed typos (Viresh Kumar)
   - Removed extra blank line (Viresh Kumar)
   - Added full stop (Viresh Kumar)
   - Fixed Return kerneldoc format (Viresh Kumar)
   - Fixed multiple kthreads initialization (Viresh Kumar)
   - Fixed rollbacking the actions in the unregister function (Viresh Kumar)
   - Make idle injection kthreads name hardcoded
   - Kthreads are created in the initcall process

 V2: Fixed checkpatch warnings
---
 drivers/powercap/Kconfig          |  10 ++
 drivers/powercap/Makefile         |   1 +
 drivers/powercap/idle_injection.c | 358 ++++++++++++++++++++++++++++++++++++++
 include/linux/idle_injection.h    |  29 +++
 4 files changed, 398 insertions(+)
 create mode 100644 drivers/powercap/idle_injection.c
 create mode 100644 include/linux/idle_injection.h

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 85727ef..a767ef2 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -29,4 +29,14 @@ config INTEL_RAPL
 	  controller, CPU core (Power Plance 0), graphics uncore (Power Plane
 	  1), etc.
 
+config IDLE_INJECTION
+	bool "Idle injection framework"
+	depends on CPU_IDLE
+	default n
+	help
+	  This enables support for the idle injection framework. It
+	  provides a way to force idle periods on a set of specified
+	  CPUs for power capping. Idle period can be injected
+	  synchronously on a set of specified CPUs or alternatively
+	  on a per CPU basis.
 endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index 0a21ef3..c3bbfee 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl.o
+obj-$(CONFIG_IDLE_INJECTION) += idle_injection.o
diff --git a/drivers/powercap/idle_injection.c b/drivers/powercap/idle_injection.c
new file mode 100644
index 0000000..37c7b61
--- /dev/null
+++ b/drivers/powercap/idle_injection.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The idle injection framework proposes a way to force a cpu to enter
+ * an idle state during a specified amount of time for a specified
+ * period.
+ *
+ * It relies on the smpboot kthreads which handles, via its main loop,
+ * the common code for hotplugging and [un]parking.
+ *
+ * At init time, all the kthreads are created and parked.
+ *
+ * A cpumask is specified as parameter for the idle injection
+ * registering function. The kthreads will be synchronized regarding
+ * this cpumask.
+ *
+ * The idle + run duration is specified via the helpers and then the
+ * idle injection can be started at this point.
+ *
+ * A kthread will call play_idle() with the specified idle duration
+ * from above and then will schedule itself. The latest CPU belonging
+ * to the group is in charge of setting the timer for the next idle
+ * injection deadline.
+ *
+ * The task handling the timer interrupt will wakeup all the kthreads
+ * belonging to the cpumask.
+ */
+#define pr_fmt(fmt) "ii_dev: " fmt
+
+#include <linux/cpu.h>
+#include <linux/freezer.h>
+#include <linux/hrtimer.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smpboot.h>
+
+#include <uapi/linux/sched/types.h>
+
+/**
+ * struct idle_injection_thread - task on/off switch structure
+ * @tsk: a pointer to a task_struct injecting the idle cycles
+ * @should_run: a integer used as a boolean by the smpboot kthread API
+ */
+struct idle_injection_thread {
+	struct task_struct *tsk;
+	int should_run;
+};
+
+/**
+ * struct idle_injection_device - data for the idle injection
+ * @cpumask: a cpumask containing the list of CPUs managed by the device
+ * @timer: a hrtimer giving the tempo for the idle injection
+ * @count: an atomic to keep track of the last task exiting the idle cycle
+ * @idle_duration_ms: an atomic specifying the idle duration
+ * @run_duration_ms: an atomic specifying the running duration
+ */
+struct idle_injection_device {
+	cpumask_var_t cpumask;
+	struct hrtimer timer;
+	struct completion stop_complete;
+	atomic_t count;
+	atomic_t idle_duration_ms;
+	atomic_t run_duration_ms;
+};
+
+static DEFINE_PER_CPU(struct idle_injection_thread, idle_injection_thread);
+static DEFINE_PER_CPU(struct idle_injection_device *, idle_injection_device);
+
+/**
+ * idle_injection_wakeup - Wake up all idle injection threads
+ * @ii_dev: the idle injection device
+ *
+ * Every idle injection task belonging to the idle injection device
+ * and running on an online CPU will be wake up by this call.
+ */
+static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
+{
+	struct idle_injection_thread *iit;
+	int cpu;
+
+	for_each_cpu_and(cpu, ii_dev->cpumask, cpu_online_mask) {
+		atomic_inc(&ii_dev->count);
+		iit = per_cpu_ptr(&idle_injection_thread, cpu);
+		iit->should_run = 1;
+		wake_up_process(iit->tsk);
+	}
+}
+
+/**
+ * idle_injection_wakeup_fn - idle injection timer callback
+ * @timer: a hrtimer structure
+ *
+ * This function is called when the idle injection timer expires which
+ * will wake up the idle injection tasks and these ones, in turn, play
+ * idle a specified amount of time.
+ *
+ * Return: HRTIMER_NORESTART.
+ */
+static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer *timer)
+{
+	struct idle_injection_device *ii_dev =
+		container_of(timer, struct idle_injection_device, timer);
+
+	idle_injection_wakeup(ii_dev);
+
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * idle_injection_fn - idle injection routine
+ * @cpu: the CPU number the tasks belongs to
+ *
+ * The idle injection routine will stay idle the specified amount of
+ * time
+ */
+static void idle_injection_fn(unsigned int cpu)
+{
+	struct idle_injection_device *ii_dev;
+	struct idle_injection_thread *iit;
+	int run_duration_ms, idle_duration_ms;
+
+	ii_dev = per_cpu(idle_injection_device, cpu);
+	iit = per_cpu_ptr(&idle_injection_thread, cpu);
+
+	/*
+	 * Boolean used by the smpboot main loop and used as a
+	 * flip-flop in this function
+	 */
+	iit->should_run = 0;
+
+	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
+	if (idle_duration_ms)
+		play_idle(idle_duration_ms);
+
+	/*
+	 * The last CPU waking up is in charge of setting the timer. If
+	 * the CPU is hotplugged, the timer will move to another CPU
+	 * (which may not belong to the same cluster) but that is not a
+	 * problem as the timer will be set again by another CPU
+	 * belonging to the cluster. This mechanism is self adaptive.
+	 */
+	if (!atomic_dec_and_test(&ii_dev->count))
+		return;
+
+	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
+	if (run_duration_ms) {
+		hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
+			      HRTIMER_MODE_REL_PINNED);
+		return;
+	}
+
+	complete(&ii_dev->stop_complete);
+}
+
+/**
+ * idle_injection_set_duration - idle and run duration helper
+ * @run_duration_ms: an unsigned int giving the running time in milliseconds
+ * @idle_duration_ms: an unsigned int giving the idle time in milliseconds
+ */
+void idle_injection_set_duration(struct idle_injection_device *ii_dev,
+				 unsigned int run_duration_ms,
+				 unsigned int idle_duration_ms)
+{
+	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
+	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);
+}
+
+/**
+ * idle_injection_get_duration - idle and run duration helper
+ * @run_duration_ms: a pointer to an unsigned int to store the running time
+ * @idle_duration_ms: a pointer to an unsigned int to store the idle time
+ */
+void idle_injection_get_duration(struct idle_injection_device *ii_dev,
+				 unsigned int *run_duration_ms,
+				 unsigned int *idle_duration_ms)
+{
+	*run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
+	*idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
+}
+
+/**
+ * idle_injection_start - starts the idle injections
+ * @ii_dev: a pointer to an idle_injection_device structure
+ *
+ * The function starts the idle injection cycles by first waking up
+ * all the tasks the ii_dev is attached to and let them handle the
+ * idle-run periods.
+ *
+ * Return: -EINVAL if the idle or the running durations are not set.
+ */
+int idle_injection_start(struct idle_injection_device *ii_dev)
+{
+	if (!atomic_read(&ii_dev->idle_duration_ms))
+		return -EINVAL;
+
+	if (!atomic_read(&ii_dev->run_duration_ms))
+		return -EINVAL;
+
+	pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
+		 cpumask_pr_args(ii_dev->cpumask));
+
+	idle_injection_wakeup(ii_dev);
+
+	return 0;
+}
+
+/**
+ * idle_injection_stop - stops the idle injections
+ * @ii_dev: a pointer to an idle injection_device structure
+ *
+ * The function stops the idle injection by resetting the idle and
+ * running durations and wait for the threads to complete. If we are
+ * in the process of injecting an idle cycle, then this will wait the
+ * end of the cycle.
+ */
+void idle_injection_stop(struct idle_injection_device *ii_dev)
+{
+	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
+		 cpumask_pr_args(ii_dev->cpumask));
+
+	idle_injection_set_duration(ii_dev, 0, 0);
+
+	wait_for_completion_interruptible(&ii_dev->stop_complete);
+}
+
+/**
+ * idle_injection_setup - initialize the current task as a RT task
+ * @cpu: the CPU number where the kthread is running on (not used)
+ *
+ * Called one time, this function is in charge of setting the task
+ * scheduler parameters.
+ */
+static void idle_injection_setup(unsigned int cpu)
+{
+	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
+
+	set_freezable();
+
+	sched_setscheduler(current, SCHED_FIFO, &param);
+}
+
+/**
+ * idle_injection_should_run - function helper for the smpboot API
+ * @cpu: the CPU number where the kthread is running on
+ *
+ * Return: a boolean telling if the thread can run.
+ */
+static int idle_injection_should_run(unsigned int cpu)
+{
+	struct idle_injection_thread *iit =
+		per_cpu_ptr(&idle_injection_thread, cpu);
+
+	return iit->should_run;
+}
+
+static struct idle_injection_device *ii_dev_alloc(void)
+{
+	struct idle_injection_device *ii_dev;
+
+	ii_dev = kzalloc(sizeof(*ii_dev), GFP_KERNEL);
+	if (!ii_dev)
+		return NULL;
+
+	if (!alloc_cpumask_var(&ii_dev->cpumask, GFP_KERNEL)) {
+		kfree(ii_dev);
+		return NULL;
+	}
+
+	return ii_dev;
+}
+
+static void ii_dev_free(struct idle_injection_device *ii_dev)
+{
+	free_cpumask_var(ii_dev->cpumask);
+	kfree(ii_dev);
+}
+
+/**
+ * idle_injection_register - idle injection init routine
+ * @cpumask: the list of CPUs managed by the idle injection device
+ *
+ * This is the initialization function in charge of creating the
+ * initializing of the timer and allocate the structures. It does not
+ * starts the idle injection cycles.
+ *
+ * Return: NULL if an allocation fails.
+ */
+struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
+{
+	struct idle_injection_device *ii_dev;
+	int cpu;
+
+	ii_dev = ii_dev_alloc();
+	if (!ii_dev)
+		return NULL;
+
+	cpumask_copy(ii_dev->cpumask, cpumask);
+	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ii_dev->timer.function = idle_injection_wakeup_fn;
+	init_completion(&ii_dev->stop_complete);
+
+	for_each_cpu(cpu, ii_dev->cpumask) {
+
+		if (per_cpu(idle_injection_device, cpu)) {
+			pr_err("cpu%d is already registered\n", cpu);
+			goto out_rollback_per_cpu;
+		}
+
+		per_cpu(idle_injection_device, cpu) = ii_dev;
+	}
+
+	return ii_dev;
+
+out_rollback_per_cpu:
+	for_each_cpu(cpu, ii_dev->cpumask)
+		per_cpu(idle_injection_device, cpu) = NULL;
+
+	ii_dev_free(ii_dev);
+
+	return NULL;
+}
+
+/**
+ * idle_injection_unregister - Unregister the idle injection device
+ * @ii_dev: a pointer to an idle injection device
+ *
+ * The function is in charge of stopping the idle injections,
+ * unregister the kthreads and free the allocated memory in the
+ * register function.
+ */
+void idle_injection_unregister(struct idle_injection_device *ii_dev)
+{
+	int cpu;
+
+	idle_injection_stop(ii_dev);
+
+	for_each_cpu(cpu, ii_dev->cpumask)
+		per_cpu(idle_injection_device, cpu) = NULL;
+
+	ii_dev_free(ii_dev);
+}
+
+static struct smp_hotplug_thread idle_injection_threads = {
+	.store = &idle_injection_thread.tsk,
+	.setup = idle_injection_setup,
+	.thread_fn = idle_injection_fn,
+	.thread_comm = "idle_inject/%u",
+	.thread_should_run = idle_injection_should_run,
+};
+
+static int __init idle_injection_init(void)
+{
+	return smpboot_register_percpu_thread(&idle_injection_threads);
+}
+early_initcall(idle_injection_init);
diff --git a/include/linux/idle_injection.h b/include/linux/idle_injection.h
new file mode 100644
index 0000000..ffd20d7
--- /dev/null
+++ b/include/linux/idle_injection.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#ifndef __IDLE_INJECTION_H__
+#define __IDLE_INJECTION_H__
+
+/* private idle injection device structure */
+struct idle_injection_device;
+
+struct idle_injection_device *idle_injection_register(struct cpumask *cpumask);
+
+void idle_injection_unregister(struct idle_injection_device *ii_dev);
+
+int idle_injection_start(struct idle_injection_device *ii_dev);
+
+void idle_injection_stop(struct idle_injection_device *ii_dev);
+
+void idle_injection_set_duration(struct idle_injection_device *ii_dev,
+				 unsigned int run_duration_ms,
+				 unsigned int idle_duration_ms);
+
+void idle_injection_get_duration(struct idle_injection_device *ii_dev,
+				 unsigned int *run_duration_ms,
+				 unsigned int *idle_duration_ms);
+#endif /* __IDLE_INJECTION_H__ */
-- 
2.7.4
