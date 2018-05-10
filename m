Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756795AbeEJKfS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:35:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50910 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeEJKfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:35:15 -0400
X-Google-Smtp-Source: AB8JxZofhduPntTtnxuS6KOsQ36Ep00K1De56P2urNO/ENb2hXSR6gQY/hIkPvA3Eo/gxJIovLbKbg==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: [PATCH] powercap/drivers/idle_injection: Add an idle injection framework
Date: Thu, 10 May 2018 12:34:18 +0200
Message-Id: <1525948458-23488-1-git-send-email-daniel.lezcano@linaro.org>
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
mainloop the common code for hotplugging and [un]parking.

The idle injection is registered with a name and a cpumask. It will
result in the creation of the kthreads on all the cpus specified in
the cpumask with a name followed by the cpu number. No idle injection
is done at this time.

The idle + run duration must be specified via the helpers and then the
idle injection can be started at this point.

The kthread will call play_idle() with the specified idle duration
from above and then will schedule itself. The latest CPU is in charge
of setting the timer for the next idle injection deadline.

The task handling the timer interrupt will wakeup all the kthreads
belonging to the cpumask.

This code was previously tested with the cpu cooling device and went
through several iterations. It results now in splitted code and API
exported in the header file. It was tested with the cpu cooling
device with success.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig          |   8 +
 drivers/powercap/Makefile         |   1 +
 drivers/powercap/idle_injection.c | 330 ++++++++++++++++++++++++++++++++++++++
 include/linux/idle_injection.h    |  62 +++++++
 4 files changed, 401 insertions(+)
 create mode 100644 drivers/powercap/idle_injection.c
 create mode 100644 include/linux/idle_injection.h

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 85727ef..1ed23e3 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -29,4 +29,12 @@ config INTEL_RAPL
 	  controller, CPU core (Power Plance 0), graphics uncore (Power Plane
 	  1), etc.
 
+config IDLE_INJECTION
+	bool "Idle injection framework"
+	depends on CPU_IDLE
+	default n
+	---help---
+	   This enable support for the idle injection framework. It
+	   provides a way to force idle periods on a set of specified
+	   CPUs for power capping.
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
index 0000000..120171f
--- /dev/null
+++ b/drivers/powercap/idle_injection.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * drivers/powercap/idle_injection.c
+ *
+ * Copyright 2018 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The idle injection framework propose a way to force a cpu to enter
+ * an idle state during a specified amount of time for a specified
+ * period.
+ *
+ */
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
+ * @smp_hotplug_thread: a pointer to a struct smp_hotplug_thread
+ * @timer: a hrtimer giving the tempo for the idle injection
+ * @count: an atomic to keep track of the last task exiting the idle cycle
+ * @idle_duration_ms: an atomic specifying the idle duration
+ * @run_duration_ms: an atomic specifying the running duration
+ */
+struct idle_injection_device {
+	struct smp_hotplug_thread *smp_hotplug_thread;
+	struct hrtimer timer;
+	atomic_t idle_duration_ms;
+	atomic_t run_duration_ms;
+	atomic_t count;
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
+	struct cpumask *cpumask = ii_dev->smp_hotplug_thread->cpumask;
+	int cpu;
+
+	for_each_cpu_and(cpu, cpumask, cpu_online_mask) {
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
+ * Always returns HRTIMER_NORESTART
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
+       struct idle_injection_device *ii_dev;
+       struct idle_injection_thread *iit;
+       int run_duration_ms, idle_duration_ms;
+
+       ii_dev = per_cpu(idle_injection_device, cpu);
+
+       iit = per_cpu_ptr(&idle_injection_thread, cpu);
+
+       /*
+	* Boolean used by the smpboot mainloop and used as a flip-flop
+	* in this function
+	*/
+       iit->should_run = 0;
+
+       atomic_inc(&ii_dev->count);
+
+       idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
+
+       play_idle(idle_duration_ms);
+
+       /*
+        * The last CPU waking up is in charge of setting the timer. If
+        * the CPU is hotplugged, the timer will move to another CPU
+        * (which may not belong to the same cluster) but that is not a
+        * problem as the timer will be set again by another CPU
+        * belonging to the cluster. This mechanism is self adaptive.
+        */
+       if (!atomic_dec_and_test(&ii_dev->count))
+               return;
+
+       run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
+       if (!run_duration_ms)
+	       return;
+
+       hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
+		     HRTIMER_MODE_REL_PINNED);
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
+ * idle-run periods
+ *
+ * Returns -EINVAL if the idle or the running duration are not set
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
+		 cpumask_pr_args(ii_dev->smp_hotplug_thread->cpumask));
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
+ * The function stops the idle injection by canceling the timer in
+ * charge of waking up the tasks to inject idle and unset the idle and
+ * running durations.
+ */
+void idle_injection_stop(struct idle_injection_device *ii_dev)
+{
+	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
+		 cpumask_pr_args(ii_dev->smp_hotplug_thread->cpumask));
+
+	hrtimer_cancel(&ii_dev->timer);
+
+	idle_injection_set_duration(ii_dev, 0, 0);
+}
+
+/**
+ * idle_injection_setup - initialize the current task as a RT task
+ * @cpu: the CPU number where the kthread is running on (not used)
+ *
+ */
+static void idle_injection_setup(unsigned int cpu)
+{
+	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO/2 };
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
+ * Returns the boolean telling if the thread can run
+ */
+static int idle_injection_should_run(unsigned int cpu)
+{
+	struct idle_injection_thread *iit =
+		per_cpu_ptr(&idle_injection_thread, cpu);
+
+	return iit->should_run;
+}
+
+/*
+ * idle_injection_threads - smp hotplug threads ops
+ */
+static struct smp_hotplug_thread idle_injection_threads = {
+	.store                  = &idle_injection_thread.tsk,
+	.thread_fn              = idle_injection_fn,
+	.thread_should_run	= idle_injection_should_run,
+	.setup                  = idle_injection_setup,
+};
+
+/**
+ * idle_injection_register - idle injection init routine
+ * @cpumask: the list of CPUs to run the kthreads
+ * @name: the threads command name
+ *
+ * This is the initialization function in charge of creating the
+ * kthreads, initializing the timer and allocate the structures.  It
+ * does not starts the idle injection cycles
+ *
+ * Returns -ENOMEM if an allocation fails, or < 0 if the smpboot
+ * kthread registering fails.
+ */
+struct idle_injection_device *
+idle_injection_register(struct cpumask *cpumask, const char *name)
+{
+	struct idle_injection_device *ii_dev;
+	struct smp_hotplug_thread *smp_hotplug_thread;
+	char *idle_injection_comm;
+	int cpu, ret;
+
+	ret = -ENOMEM;
+
+	idle_injection_comm = kasprintf(GFP_KERNEL, "%s/%%u", name);
+	if (!idle_injection_comm)
+		goto out;
+
+	smp_hotplug_thread = kmemdup(&idle_injection_threads,
+				     sizeof(*smp_hotplug_thread),
+				     GFP_KERNEL);
+	if (!smp_hotplug_thread)
+		goto out_free_thread_comm;
+
+	smp_hotplug_thread->thread_comm	= idle_injection_comm;
+
+	ii_dev = kzalloc(sizeof(*ii_dev),
+					GFP_KERNEL);
+	if (!ii_dev)
+		goto out_free_smp_hotplug;
+
+	ii_dev->smp_hotplug_thread = smp_hotplug_thread;
+
+	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	ii_dev->timer.function = idle_injection_wakeup_fn;
+
+	for_each_cpu(cpu, cpumask)
+		per_cpu(idle_injection_device, cpu) = ii_dev;
+
+	ret = smpboot_register_percpu_thread_cpumask(smp_hotplug_thread,
+						     cpumask);
+	if (ret)
+		goto out_free_idle_inject;
+
+	return ii_dev;
+
+out_free_idle_inject:
+	kfree(ii_dev);
+out_free_smp_hotplug:
+	kfree(smp_hotplug_thread);
+out_free_thread_comm:
+	kfree(idle_injection_comm);
+out:
+	return ERR_PTR(ret);
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
+	struct smp_hotplug_thread *smp_hotplug_thread = ii_dev->smp_hotplug_thread;
+
+	idle_injection_stop(ii_dev);
+	smpboot_unregister_percpu_thread(smp_hotplug_thread);
+	kfree(smp_hotplug_thread->thread_comm);
+	kfree(smp_hotplug_thread);
+	kfree(ii_dev);
+}
diff --git a/include/linux/idle_injection.h b/include/linux/idle_injection.h
new file mode 100644
index 0000000..084b999
--- /dev/null
+++ b/include/linux/idle_injection.h
@@ -0,0 +1,62 @@
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
+/**
+ * idle_injection_register - allocates and initializes an idle_injection_device
+ * @cpumask: all CPUs with a idle injection kthreads
+ * @name: a const string giving the kthread name
+ *
+ * Returns a pointer to a idle_injection_device, ERR_PTR otherwise.
+ */
+struct idle_injection_device *idle_injection_register(struct cpumask *cpumask,
+						      const char *name);
+
+/**
+ * idle_injection_unregister - stop and frees the resources
+ * @ii_dev: a pointer to an idle_injection_device structure
+ */
+void idle_injection_unregister(struct idle_injection_device *ii_dev);
+
+/**
+ * idle_injection_start - start injecting idle cycles
+ * @ii_dev: a pointer to an idle_injection_device structure
+ *
+ * Returns 0 on success, -EINVAL if the idle or the run durations are
+ * not set
+ */
+int idle_injection_start(struct idle_injection_device *ii_dev);
+
+/**
+ * idle_injection_stop - stop injecting idle cycles
+ * @ii_dev: a pointer to an idle_injection_device structure
+ */
+void idle_injection_stop(struct idle_injection_device *ii_dev);
+
+/**
+ * idle_injection_set_duration - set the idle/run durations
+ * @run_duration_ms: the running duration
+ * @idle_duration_ms : the idle duration
+ */
+void idle_injection_set_duration(struct idle_injection_device *ii_dev,
+				 unsigned int run_duration_ms,
+				 unsigned int idle_duration_ms);
+
+/**
+ * idle_injection_get_duration - get the idle/run durations
+ * @run_duration_ms: the running duration
+ * @idle_duration_ms : the idle duration
+ */
+void idle_injection_get_duration(struct idle_injection_device *ii_dev,
+				 unsigned int *run_duration_ms,
+				 unsigned int *idle_duration_ms);
+#endif /* __IDLE_INJECTION_H__ */
-- 
2.7.4
