Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938365AbeBUPac (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:30:32 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36481 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938264AbeBUPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:30:00 -0500
X-Google-Smtp-Source: AH8x2274cKJy6sCG9iHvW+Ypt88Wj57C5b+FuAM37bQKzY/HOrbTJXoyXY/eoVH2FBnPicEcTUlB2g==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
Date: Wed, 21 Feb 2018 16:29:27 +0100
Message-Id: <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu idle cooling driver performs synchronized idle injection across all
cpus belonging to the same cluster and offers a new method to cool down a SoC.

Each cluster has its own idle cooling device, each core has its own idle
injection thread, each idle injection thread uses play_idle to enter idle.  In
order to reach the deepest idle state, each cooling device has the idle
injection threads synchronized together.

It has some similarity with the intel power clamp driver but it is actually
designed to work on the ARM architecture via the DT with a mathematical proof
with the power model which comes with the Documentation.

The idle injection cycle is fixed while the running cycle is variable. That
allows to have control on the device reactivity for the user experience. At
the mitigation point the idle threads are unparked, they play idle the
specified amount of time and they schedule themselves. The last thread sets
the next idle injection deadline and when the timer expires it wakes up all
the threads which in turn play idle again. Meanwhile the running cycle is
changed by set_cur_state.  When the mitigation ends, the threads are parked.
The algorithm is self adaptive, so there is no need to handle hotplugging.

If we take an example of the balanced point, we can use the DT for the hi6220.

The sustainable power for the SoC is 3326mW to mitigate at 75°C. Eight cores
running at full blast at the maximum OPP consumes 5280mW. The first value is
given in the DT, the second is calculated from the OPP with the formula:

   Pdyn = Cdyn x Voltage^2 x Frequency

As the SoC vendors don't want to share the static leakage values, we assume
it is zero, so the Prun = Pdyn + Pstatic = Pdyn + 0 = Pdyn.

In order to reduce the power to 3326mW, we have to apply a ratio to the
running time.

ratio = (Prun - Ptarget) / Ptarget = (5280 - 3326) / 3326 = 0,5874

We know the idle cycle which is fixed, let's assume 10ms. However from this
duration we have to substract the wake up latency for the cluster idle state.
In our case, it is 1.5ms. So for a 10ms latency for idle, we are really idle
8.5ms.

As we know the idle duration and the ratio, we can compute the running cycle.

   running_cycle = 8.5 / 0.5874 = 14.47ms

So for 8.5ms of idle, we have 14.47ms of running cycle, and that brings the
SoC to the balanced trip point of 75°C.

The driver has been tested on the hi6220 and it appears the temperature
stabilizes at 75°C with an idle injection time of 10ms (8.5ms real) and
running cycle of 14ms as expected by the theory above.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig       |  10 +
 drivers/thermal/cpu_cooling.c | 451 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpu_cooling.h   |   9 +
 3 files changed, 470 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5aaae1b..6c34117 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -166,6 +166,16 @@ config CPU_FREQ_THERMAL
 	  This will be useful for platforms using the generic thermal interface
 	  and not the ACPI interface.
 
+config CPU_IDLE_THERMAL
+       bool "CPU idle cooling strategy"
+       depends on CPU_IDLE
+       help
+	 This implements the generic CPU cooling mechanism through
+	 idle injection.  This will throttle the CPU by injecting
+	 fixed idle cycle.  All CPUs belonging to the same cluster
+	 will enter idle synchronously to reach the deepest idle
+	 state.
+
 endchoice
 
 config CLOCK_THERMAL
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 5c219dc..9340216 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -10,18 +10,32 @@
  *		Viresh Kumar <viresh.kumar@linaro.org>
  *
  */
+#undef DEBUG
+#define pr_fmt(fmt) "CPU cooling: " fmt
+
 #include <linux/module.h>
 #include <linux/thermal.h>
 #include <linux/cpufreq.h>
+#include <linux/cpuidle.h>
 #include <linux/err.h>
+#include <linux/freezer.h>
 #include <linux/idr.h>
+#include <linux/kthread.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
+#include <linux/sched/prio.h>
+#include <linux/sched/rt.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
+#include <linux/wait.h>
+
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 #include <trace/events/thermal.h>
 
+#include <uapi/linux/sched/types.h>
+
 #ifdef CONFIG_CPU_FREQ_THERMAL
 /*
  * Cooling state <-> CPUFreq frequency
@@ -928,3 +942,440 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
 #endif /* CONFIG_CPU_FREQ_THERMAL */
+
+#ifdef CONFIG_CPU_IDLE_THERMAL
+/*
+ * The idle duration injection. As we don't have yet a way to specify
+ * from the DT configuration, let's default to a tick duration.
+ */
+#define DEFAULT_IDLE_TIME_US TICK_USEC
+
+/**
+ * struct cpuidle_cooling_device - data for the idle cooling device
+ * @cdev: a pointer to a struct thermal_cooling_device
+ * @cpumask: a cpumask containing the CPU managed by the cooling device
+ * @timer: a hrtimer giving the tempo for the idle injection cycles
+ * @kref: a kernel refcount on this structure
+ * @count: an atomic to keep track of the last task exiting the idle cycle
+ * @idle_cycle: an integer defining the duration of the idle injection
+ * @state: an normalized integer giving the state of the cooling device
+ */
+struct cpuidle_cooling_device {
+	struct thermal_cooling_device *cdev;
+	struct cpumask *cpumask;
+	struct list_head node;
+	struct hrtimer timer;
+	struct kref kref;
+	atomic_t count;
+	unsigned int idle_cycle;
+	unsigned int state;
+};
+
+/**
+ * @tsk: an array of pointer to the idle injection tasks
+ * @waitq: the waiq for the idle injection tasks
+ */
+struct cpuidle_cooling_tsk {
+	struct task_struct *tsk;
+	wait_queue_head_t waitq;
+};
+
+DEFINE_PER_CPU(struct cpuidle_cooling_tsk, cpuidle_cooling_tsk);
+
+static LIST_HEAD(cpuidle_cdev_list);
+
+/**
+ * cpuidle_cooling_wakeup - Wake up all idle injection threads
+ * @idle_cdev: the idle cooling device
+ *
+ * Every idle injection task belonging to the idle cooling device and
+ * running on an online cpu will be wake up by this call.
+ */
+static void cpuidle_cooling_wakeup(struct cpuidle_cooling_device *idle_cdev)
+{
+	int cpu;
+	struct cpuidle_cooling_tsk *cct;
+
+	for_each_cpu_and(cpu, idle_cdev->cpumask, cpu_online_mask) {
+		cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
+		wake_up_process(cct->tsk);
+	}
+}
+
+/**
+ * cpuidle_cooling_wakeup_fn - Running cycle timer callback
+ * @timer: a hrtimer structure
+ *
+ * When the mitigation is acting, the CPU is allowed to run an amount
+ * of time, then the idle injection happens for the specified delay
+ * and the idle task injection schedules itself until the timer event
+ * wakes the idle injection tasks again for a new idle injection
+ * cycle. The time between the end of the idle injection and the timer
+ * expiration is the allocated running time for the CPU.
+ *
+ * Returns always HRTIMER_NORESTART
+ */
+static enum hrtimer_restart cpuidle_cooling_wakeup_fn(struct hrtimer *timer)
+{
+	struct cpuidle_cooling_device *idle_cdev =
+		container_of(timer, struct cpuidle_cooling_device, timer);
+
+	cpuidle_cooling_wakeup(idle_cdev);
+
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * cpuidle_cooling_runtime - Running time computation
+ * @idle_cdev: the idle cooling device
+ *
+ * The running duration is computed from the idle injection duration
+ * which is fixed. If we reach 100% of idle injection ratio, that
+ * means the running duration is zero. If we have a 50% ratio
+ * injection, that means we have equal duration for idle and for
+ * running duration.
+ *
+ * The formula is deduced as the following:
+ *
+ *  running = idle x ((100 / ratio) - 1)
+ *
+ * For precision purpose for integer math, we use the following:
+ *
+ *  running = (idle x 100) / ratio - idle
+ *
+ * For example, if we have an injected duration of 50%, then we end up
+ * with 10ms of idle injection and 10ms of running duration.
+ *
+ * Returns a s64 nanosecond based
+ */
+static s64 cpuidle_cooling_runtime(struct cpuidle_cooling_device *idle_cdev)
+{
+	s64 next_wakeup;
+	int state = idle_cdev->state;
+
+	/*
+	 * The function must never be called when there is no
+	 * mitigation because:
+	 * - that does not make sense
+	 * - we end up with a division by zero
+	 */
+	BUG_ON(!state);
+
+	next_wakeup = (s64)((idle_cdev->idle_cycle * 100) / state) -
+		idle_cdev->idle_cycle;
+
+	return next_wakeup * NSEC_PER_USEC;
+}
+
+/**
+ * cpuidle_cooling_injection_thread - Idle injection mainloop thread function
+ * @arg: a void pointer containing the idle cooling device address
+ *
+ * This main function does basically two operations:
+ *
+ * - Goes idle for a specific amount of time
+ *
+ * - Sets a timer to wake up all the idle injection threads after a
+ *   running period
+ *
+ * That happens only when the mitigation is enabled, otherwise the
+ * task is scheduled out.
+ *
+ * In order to keep the tasks synchronized together, it is the last
+ * task exiting the idle period which is in charge of setting the
+ * timer.
+ *
+ * This function never returns.
+ */
+static int cpuidle_cooling_injection_thread(void *arg)
+{
+	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO/2 };
+	struct cpuidle_cooling_device *idle_cdev = arg;
+	struct cpuidle_cooling_tsk *cct = per_cpu_ptr(&cpuidle_cooling_tsk,
+						      smp_processor_id());
+	DEFINE_WAIT(wait);
+
+	set_freezable();
+
+	sched_setscheduler(current, SCHED_FIFO, &param);
+
+	while (1) {
+		s64 next_wakeup;
+
+		prepare_to_wait(&cct->waitq, &wait, TASK_INTERRUPTIBLE);
+
+		schedule();
+
+		atomic_inc(&idle_cdev->count);
+
+		play_idle(idle_cdev->idle_cycle / USEC_PER_MSEC);
+
+		/*
+		 * The last CPU waking up is in charge of setting the
+		 * timer. If the CPU is hotplugged, the timer will
+		 * move to another CPU (which may not belong to the
+		 * same cluster) but that is not a problem as the
+		 * timer will be set again by another CPU belonging to
+		 * the cluster, so this mechanism is self adaptive and
+		 * does not require any hotplugging dance.
+		 */
+		if (!atomic_dec_and_test(&idle_cdev->count))
+			continue;
+
+		if (!idle_cdev->state)
+			continue;
+
+		next_wakeup = cpuidle_cooling_runtime(idle_cdev);
+
+		hrtimer_start(&idle_cdev->timer, ns_to_ktime(next_wakeup),
+			      HRTIMER_MODE_REL_PINNED);
+	}
+
+	finish_wait(&cct->waitq, &wait);
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_release - Kref based release helper
+ * @kref: a pointer to the kref structure
+ *
+ * This function is automatically called by the kref_put function when
+ * the idle cooling device refcount reaches zero. At this point, we
+ * have the guarantee the structure is no longer in use and we can
+ * safely release all the ressources.
+ */
+static void __init cpuidle_cooling_release(struct kref *kref)
+{
+	struct cpuidle_cooling_device *idle_cdev =
+		container_of(kref, struct cpuidle_cooling_device, kref);
+
+	thermal_cooling_device_unregister(idle_cdev->cdev);
+	kfree(idle_cdev);
+}
+
+/**
+ * cpuidle_cooling_get_max_state - Get the maximum state
+ * @cdev  : the thermal cooling device
+ * @state : a pointer to the state variable to be filled
+ *
+ * The function gives always 100 as the injection ratio is percentile
+ * based for consistency accros different platforms.
+ *
+ * The function can not fail, it returns always zero.
+ */
+static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
+					 unsigned long *state)
+{
+	/*
+	 * Depending on the configuration or the hardware, the running
+	 * cycle and the idle cycle could be different. We want unify
+	 * that to an 0..100 interval, so the set state interface will
+	 * be the same whatever the platform is.
+	 *
+	 * The state 100% will make the cluster 100% ... idle. A 0%
+	 * injection ratio means no idle injection at all and 50%
+	 * means for 10ms of idle injection, we have 10ms of running
+	 * time.
+	 */
+	*state = 100;
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_get_cur_state - Get the current cooling state
+ * @cdev: the thermal cooling device
+ * @state: a pointer to the state
+ *
+ * The function just copy the state value from the private thermal
+ * cooling device structure, the mapping is 1 <-> 1.
+ *
+ * The function can not fail, it returns always zero.
+ */
+static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
+					 unsigned long *state)
+{
+        struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
+
+	*state = idle_cdev->state;
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_set_cur_state - Set the current cooling state
+ * @cdev: the thermal cooling device
+ * @state: the target state
+ *
+ * The function checks first if we are initiating the mitigation which
+ * in turn wakes up all the idle injection tasks belonging to the idle
+ * cooling device. In any case, it updates the internal state for the
+ * cooling device.
+ *
+ * The function can not fail, it returns always zero.
+ */
+static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
+					 unsigned long state)
+{
+	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
+	unsigned long current_state = idle_cdev->state;
+
+	idle_cdev->state = state;
+
+	if (current_state == 0 && state > 0) {
+		pr_debug("Starting cooling cpus '%*pbl'\n",
+			 cpumask_pr_args(idle_cdev->cpumask));
+		cpuidle_cooling_wakeup(idle_cdev);
+	} else if (current_state > 0 && !state)  {
+		pr_debug("Stopping cooling cpus '%*pbl'\n",
+			 cpumask_pr_args(idle_cdev->cpumask));
+	}
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_ops - thermal cooling device ops
+ */
+static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
+	.get_max_state = cpuidle_cooling_get_max_state,
+	.get_cur_state = cpuidle_cooling_get_cur_state,
+	.set_cur_state = cpuidle_cooling_set_cur_state,
+};
+
+/**
+ * cpuilde_cooling_unregister - Idle cooling device exit function
+ *
+ * This function unregisters the cpuidle cooling device and frees the
+ * ressources previously allocated by the init function. This function
+ * is called when the initialization fails.
+ */
+static void cpuidle_cooling_unregister(void)
+{
+	struct cpuidle_cooling_device *tmp, *idle_cdev = NULL;
+	struct cpuidle_cooling_tsk *cct;
+	int cpu;
+
+	list_for_each_entry_safe(idle_cdev, tmp, &cpuidle_cdev_list, node) {
+		for_each_cpu(cpu, idle_cdev->cpumask) {
+			cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
+			if (cct->tsk)
+				kthread_stop(cct->tsk);
+			kref_put(&idle_cdev->kref, cpuidle_cooling_release);
+		}
+	}
+}
+
+/**
+ * cpuidle_cooling_register - Idle cooling device initialization function
+ *
+ * This function is in charge of creating a cooling device per cluster
+ * and register it to thermal framework. For this we rely on the
+ * topology as there is nothing yet describing better the idle state
+ * power domains.
+ *
+ * For each first CPU of the cluster's cpumask, we allocate the idle
+ * cooling device, initialize the general fields and then we initialze
+ * the rest in a per cpu basis.
+ *
+ * Returns zero on success, < 0 otherwise.
+ */
+int cpuidle_cooling_register(void)
+{
+	struct cpuidle_cooling_device *idle_cdev = NULL;
+	struct thermal_cooling_device *cdev;
+	struct cpuidle_cooling_tsk *cct;
+	struct task_struct *tsk;
+	struct device_node *np;
+	cpumask_t *cpumask;
+	char dev_name[THERMAL_NAME_LENGTH];
+	int ret = -ENOMEM, cpu;
+	int index = 0;
+
+	for_each_possible_cpu(cpu) {
+		cpumask = topology_core_cpumask(cpu);
+
+		cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
+
+		/*
+		 * This condition makes the first cpu belonging to the
+		 * cluster to create a cooling device and allocates
+		 * the structure. Others CPUs belonging to the same
+		 * cluster will just increment the refcount on the
+		 * cooling device structure and initialize it.
+		 */
+		if (cpu == cpumask_first(cpumask)) {
+			np = of_cpu_device_node_get(cpu);
+
+			idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
+			if (!idle_cdev)
+				goto out_fail;
+
+			idle_cdev->idle_cycle = DEFAULT_IDLE_TIME_US;
+
+			atomic_set(&idle_cdev->count, 0);
+
+			kref_init(&idle_cdev->kref);
+
+			/*
+			 * Initialize the timer to wakeup all the idle
+			 * injection tasks
+			 */
+			hrtimer_init(&idle_cdev->timer,
+				     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+			/*
+			 * The wakeup function callback which is in
+			 * charge of waking up all CPUs belonging to
+			 * the same cluster
+			 */
+			idle_cdev->timer.function = cpuidle_cooling_wakeup_fn;
+
+			/*
+			 * The thermal cooling device name
+			 */
+			snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", index++);
+			cdev = thermal_of_cooling_device_register(np, dev_name,
+								  idle_cdev,
+								  &cpuidle_cooling_ops);
+			if (IS_ERR(cdev)) {
+				ret = PTR_ERR(cdev);
+				goto out_fail;
+			}
+
+			idle_cdev->cdev = cdev;
+
+			idle_cdev->cpumask = cpumask;
+
+			list_add(&idle_cdev->node, &cpuidle_cdev_list);
+
+			pr_info("Created idle cooling device for cpus '%*pbl'\n",
+				cpumask_pr_args(cpumask));
+		}
+
+		kref_get(&idle_cdev->kref);
+
+		init_waitqueue_head(&cct->waitq);
+
+		tsk = kthread_create_on_cpu(cpuidle_cooling_injection_thread,
+					    idle_cdev, cpu, "kidle_inject/%u");
+		if (IS_ERR(tsk)) {
+			ret = PTR_ERR(tsk);
+			goto out_fail;
+		}
+
+		cct->tsk = tsk;
+
+		wake_up_process(tsk);
+	}
+
+	return 0;
+
+out_fail:
+	cpuidle_cooling_unregister();
+	pr_err("Failed to create idle cooling device (%d)\n", ret);
+
+	return ret;
+}
+#endif /* CONFIG_CPU_IDLE_THERMAL */
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index c0accc7..fee2038 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -120,4 +120,13 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 }
 #endif	/* CONFIG_CPU_FREQ_THERMAL */
 
+#ifdef CONFIG_CPU_IDLE_THERMAL
+extern int cpuidle_cooling_register(void);
+#else /* CONFIG_CPU_IDLE_THERMAL */
+static inline int cpuidle_cooling_register(void)
+{
+	return 0;
+}
+#endif /* CONFIG_CPU_IDLE_THERMAL */
+
 #endif /* __CPU_COOLING_H__ */
-- 
2.7.4
