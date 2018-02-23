Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeBWHfd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:35:33 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38848 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeBWHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:34:37 -0500
X-Google-Smtp-Source: AH8x2263nhahP5jAceW/JzgMoJSDFz+KbZ6s5CLBS17E/fWLJ8csX4AMP9X1hd68iitaK2Ol8dcmDQ==
Date: Fri, 23 Feb 2018 13:04:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180223073432.GF26947@vireshk-i7>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-18, 16:29, Daniel Lezcano wrote:
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 5c219dc..9340216 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -10,18 +10,32 @@
>   *		Viresh Kumar <viresh.kumar@linaro.org>
>   *
>   */
> +#undef DEBUG

Why is this required ?

> +#define pr_fmt(fmt) "CPU cooling: " fmt

I think you can use the dev_***() routines instead, as you can
directly the CPU device from anywhere.

>  #include <linux/module.h>
>  #include <linux/thermal.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpuidle.h>
>  #include <linux/err.h>
> +#include <linux/freezer.h>
>  #include <linux/idr.h>
> +#include <linux/kthread.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
> +#include <linux/sched/prio.h>
> +#include <linux/sched/rt.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_cooling.h>
> +#include <linux/wait.h>
> +
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
>  
>  #include <trace/events/thermal.h>
>  
> +#include <uapi/linux/sched/types.h>
> +
>  #ifdef CONFIG_CPU_FREQ_THERMAL
>  /*
>   * Cooling state <-> CPUFreq frequency
> @@ -928,3 +942,440 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
>  #endif /* CONFIG_CPU_FREQ_THERMAL */
> +
> +#ifdef CONFIG_CPU_IDLE_THERMAL
> +/*
> + * The idle duration injection. As we don't have yet a way to specify
> + * from the DT configuration, let's default to a tick duration.
> + */
> +#define DEFAULT_IDLE_TIME_US TICK_USEC

I think this macro is a bit unnecessary here. Its used only at
initialization and so the same comment can be present there and you
can use TICK_USEC there.

Else, Keep it as it is and remove the "idle_cycle" field from the
below structure, as it holds a constant forever.

> +
> +/**
> + * struct cpuidle_cooling_device - data for the idle cooling device
> + * @cdev: a pointer to a struct thermal_cooling_device
> + * @cpumask: a cpumask containing the CPU managed by the cooling device

Missed @node here.

> + * @timer: a hrtimer giving the tempo for the idle injection cycles
> + * @kref: a kernel refcount on this structure
> + * @count: an atomic to keep track of the last task exiting the idle cycle
> + * @idle_cycle: an integer defining the duration of the idle injection
> + * @state: an normalized integer giving the state of the cooling device
> + */
> +struct cpuidle_cooling_device {
> +	struct thermal_cooling_device *cdev;
> +	struct cpumask *cpumask;
> +	struct list_head node;
> +	struct hrtimer timer;
> +	struct kref kref;
> +	atomic_t count;
> +	unsigned int idle_cycle;
> +	unsigned int state;
> +};
> +
> +/**
> + * @tsk: an array of pointer to the idle injection tasks
> + * @waitq: the waiq for the idle injection tasks
> + */
> +struct cpuidle_cooling_tsk {
> +	struct task_struct *tsk;
> +	wait_queue_head_t waitq;
> +};
> +
> +DEFINE_PER_CPU(struct cpuidle_cooling_tsk, cpuidle_cooling_tsk);

static ?

> +
> +static LIST_HEAD(cpuidle_cdev_list);
> +
> +/**
> + * cpuidle_cooling_wakeup - Wake up all idle injection threads
> + * @idle_cdev: the idle cooling device
> + *
> + * Every idle injection task belonging to the idle cooling device and
> + * running on an online cpu will be wake up by this call.
> + */
> +static void cpuidle_cooling_wakeup(struct cpuidle_cooling_device *idle_cdev)
> +{
> +	int cpu;
> +	struct cpuidle_cooling_tsk *cct;
> +
> +	for_each_cpu_and(cpu, idle_cdev->cpumask, cpu_online_mask) {
> +		cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
> +		wake_up_process(cct->tsk);
> +	}
> +}
> +
> +/**
> + * cpuidle_cooling_wakeup_fn - Running cycle timer callback
> + * @timer: a hrtimer structure
> + *
> + * When the mitigation is acting, the CPU is allowed to run an amount
> + * of time, then the idle injection happens for the specified delay
> + * and the idle task injection schedules itself until the timer event
> + * wakes the idle injection tasks again for a new idle injection
> + * cycle. The time between the end of the idle injection and the timer
> + * expiration is the allocated running time for the CPU.
> + *
> + * Returns always HRTIMER_NORESTART
> + */
> +static enum hrtimer_restart cpuidle_cooling_wakeup_fn(struct hrtimer *timer)
> +{
> +	struct cpuidle_cooling_device *idle_cdev =
> +		container_of(timer, struct cpuidle_cooling_device, timer);
> +
> +	cpuidle_cooling_wakeup(idle_cdev);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +/**
> + * cpuidle_cooling_runtime - Running time computation
> + * @idle_cdev: the idle cooling device
> + *
> + * The running duration is computed from the idle injection duration
> + * which is fixed. If we reach 100% of idle injection ratio, that
> + * means the running duration is zero. If we have a 50% ratio
> + * injection, that means we have equal duration for idle and for
> + * running duration.
> + *
> + * The formula is deduced as the following:
> + *
> + *  running = idle x ((100 / ratio) - 1)
> + *
> + * For precision purpose for integer math, we use the following:
> + *
> + *  running = (idle x 100) / ratio - idle
> + *
> + * For example, if we have an injected duration of 50%, then we end up
> + * with 10ms of idle injection and 10ms of running duration.
> + *
> + * Returns a s64 nanosecond based
> + */
> +static s64 cpuidle_cooling_runtime(struct cpuidle_cooling_device *idle_cdev)
> +{
> +	s64 next_wakeup;
> +	int state = idle_cdev->state;
> +
> +	/*
> +	 * The function must never be called when there is no
> +	 * mitigation because:
> +	 * - that does not make sense
> +	 * - we end up with a division by zero
> +	 */
> +	BUG_ON(!state);

As there is no locking in place, we can surely hit this case. What if
the state changed to 0 right before this routine was called ?

I would suggest we should just return 0 in that case and get away with
the BUG_ON().

> +
> +	next_wakeup = (s64)((idle_cdev->idle_cycle * 100) / state) -
> +		idle_cdev->idle_cycle;
> +
> +	return next_wakeup * NSEC_PER_USEC;
> +}
> +
> +/**
> + * cpuidle_cooling_injection_thread - Idle injection mainloop thread function
> + * @arg: a void pointer containing the idle cooling device address
> + *
> + * This main function does basically two operations:
> + *
> + * - Goes idle for a specific amount of time
> + *
> + * - Sets a timer to wake up all the idle injection threads after a
> + *   running period
> + *
> + * That happens only when the mitigation is enabled, otherwise the
> + * task is scheduled out.
> + *
> + * In order to keep the tasks synchronized together, it is the last
> + * task exiting the idle period which is in charge of setting the
> + * timer.
> + *
> + * This function never returns.
> + */
> +static int cpuidle_cooling_injection_thread(void *arg)
> +{
> +	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO/2 };
> +	struct cpuidle_cooling_device *idle_cdev = arg;
> +	struct cpuidle_cooling_tsk *cct = per_cpu_ptr(&cpuidle_cooling_tsk,
> +						      smp_processor_id());

this_cpu_ptr ?

> +	DEFINE_WAIT(wait);
> +
> +	set_freezable();
> +
> +	sched_setscheduler(current, SCHED_FIFO, &param);
> +
> +	while (1) {
> +		s64 next_wakeup;
> +
> +		prepare_to_wait(&cct->waitq, &wait, TASK_INTERRUPTIBLE);
> +
> +		schedule();
> +
> +		atomic_inc(&idle_cdev->count);
> +
> +		play_idle(idle_cdev->idle_cycle / USEC_PER_MSEC);
> +
> +		/*
> +		 * The last CPU waking up is in charge of setting the
> +		 * timer. If the CPU is hotplugged, the timer will
> +		 * move to another CPU (which may not belong to the
> +		 * same cluster) but that is not a problem as the
> +		 * timer will be set again by another CPU belonging to
> +		 * the cluster, so this mechanism is self adaptive and
> +		 * does not require any hotplugging dance.
> +		 */

Well this depends on how CPU hotplug really happens. What happens to
the per-cpu-tasks which are in the middle of something when hotplug
happens?  Does hotplug wait for those per-cpu-tasks to finish ?

> +		if (!atomic_dec_and_test(&idle_cdev->count))
> +			continue;
> +
> +		if (!idle_cdev->state)
> +			continue;
> +
> +		next_wakeup = cpuidle_cooling_runtime(idle_cdev);
> +
> +		hrtimer_start(&idle_cdev->timer, ns_to_ktime(next_wakeup),
> +			      HRTIMER_MODE_REL_PINNED);
> +	}
> +
> +	finish_wait(&cct->waitq, &wait);
> +
> +	return 0;
> +}
> +
> +/**
> + * cpuidle_cooling_release - Kref based release helper
> + * @kref: a pointer to the kref structure
> + *
> + * This function is automatically called by the kref_put function when
> + * the idle cooling device refcount reaches zero. At this point, we
> + * have the guarantee the structure is no longer in use and we can
> + * safely release all the ressources.
> + */
> +static void __init cpuidle_cooling_release(struct kref *kref)
> +{
> +	struct cpuidle_cooling_device *idle_cdev =
> +		container_of(kref, struct cpuidle_cooling_device, kref);
> +
> +	thermal_cooling_device_unregister(idle_cdev->cdev);
> +	kfree(idle_cdev);
> +}

Maybe just move it closer to the only function that calls it?

> +
> +/**
> + * cpuidle_cooling_get_max_state - Get the maximum state
> + * @cdev  : the thermal cooling device
> + * @state : a pointer to the state variable to be filled
> + *
> + * The function gives always 100 as the injection ratio is percentile
> + * based for consistency accros different platforms.
> + *
> + * The function can not fail, it returns always zero.
> + */
> +static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
> +					 unsigned long *state)
> +{
> +	/*
> +	 * Depending on the configuration or the hardware, the running
> +	 * cycle and the idle cycle could be different. We want unify
> +	 * that to an 0..100 interval, so the set state interface will
> +	 * be the same whatever the platform is.
> +	 *
> +	 * The state 100% will make the cluster 100% ... idle. A 0%
> +	 * injection ratio means no idle injection at all and 50%
> +	 * means for 10ms of idle injection, we have 10ms of running
> +	 * time.
> +	 */
> +	*state = 100;
> +
> +	return 0;
> +}
> +
> +/**
> + * cpuidle_cooling_get_cur_state - Get the current cooling state
> + * @cdev: the thermal cooling device
> + * @state: a pointer to the state
> + *
> + * The function just copy the state value from the private thermal
> + * cooling device structure, the mapping is 1 <-> 1.
> + *
> + * The function can not fail, it returns always zero.
> + */
> +static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
> +					 unsigned long *state)
> +{
> +        struct cpuidle_cooling_device *idle_cdev = cdev->devdata;

This line isn't aligned properly. Spaces are present instead of a tab.

> +
> +	*state = idle_cdev->state;
> +
> +	return 0;
> +}
> +
> +/**
> + * cpuidle_cooling_set_cur_state - Set the current cooling state
> + * @cdev: the thermal cooling device
> + * @state: the target state
> + *
> + * The function checks first if we are initiating the mitigation which
> + * in turn wakes up all the idle injection tasks belonging to the idle
> + * cooling device. In any case, it updates the internal state for the
> + * cooling device.
> + *
> + * The function can not fail, it returns always zero.

                                 it always returns zero.

Same at other places as well.

> + */
> +static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> +					 unsigned long state)
> +{
> +	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
> +	unsigned long current_state = idle_cdev->state;
> +
> +	idle_cdev->state = state;
> +
> +	if (current_state == 0 && state > 0) {
> +		pr_debug("Starting cooling cpus '%*pbl'\n",
> +			 cpumask_pr_args(idle_cdev->cpumask));
> +		cpuidle_cooling_wakeup(idle_cdev);
> +	} else if (current_state > 0 && !state)  {
> +		pr_debug("Stopping cooling cpus '%*pbl'\n",
> +			 cpumask_pr_args(idle_cdev->cpumask));
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cpuidle_cooling_ops - thermal cooling device ops
> + */
> +static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
> +	.get_max_state = cpuidle_cooling_get_max_state,
> +	.get_cur_state = cpuidle_cooling_get_cur_state,
> +	.set_cur_state = cpuidle_cooling_set_cur_state,
> +};
> +
> +/**
> + * cpuilde_cooling_unregister - Idle cooling device exit function
> + *
> + * This function unregisters the cpuidle cooling device and frees the
> + * ressources previously allocated by the init function. This function
> + * is called when the initialization fails.
> + */
> +static void cpuidle_cooling_unregister(void)
> +{
> +	struct cpuidle_cooling_device *tmp, *idle_cdev = NULL;
> +	struct cpuidle_cooling_tsk *cct;
> +	int cpu;
> +
> +	list_for_each_entry_safe(idle_cdev, tmp, &cpuidle_cdev_list, node) {
> +		for_each_cpu(cpu, idle_cdev->cpumask) {
> +			cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
> +			if (cct->tsk)
> +				kthread_stop(cct->tsk);

What about hrtimer ? Shouldn't that be stopped as well ?

> +			kref_put(&idle_cdev->kref, cpuidle_cooling_release);
> +		}
> +	}
> +}
> +
> +/**
> + * cpuidle_cooling_register - Idle cooling device initialization function
> + *
> + * This function is in charge of creating a cooling device per cluster
> + * and register it to thermal framework. For this we rely on the
> + * topology as there is nothing yet describing better the idle state
> + * power domains.
> + *
> + * For each first CPU of the cluster's cpumask, we allocate the idle
> + * cooling device, initialize the general fields and then we initialze
> + * the rest in a per cpu basis.
> + *
> + * Returns zero on success, < 0 otherwise.

This wouldn't get shown in the doc properly, it should be written as:

  * Return: zero on success, < 0 otherwise.

> + */
> +int cpuidle_cooling_register(void)
> +{
> +	struct cpuidle_cooling_device *idle_cdev = NULL;
> +	struct thermal_cooling_device *cdev;
> +	struct cpuidle_cooling_tsk *cct;
> +	struct task_struct *tsk;
> +	struct device_node *np;
> +	cpumask_t *cpumask;
> +	char dev_name[THERMAL_NAME_LENGTH];
> +	int ret = -ENOMEM, cpu;
> +	int index = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpumask = topology_core_cpumask(cpu);
> +
> +		cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
> +
> +		/*
> +		 * This condition makes the first cpu belonging to the
> +		 * cluster to create a cooling device and allocates
> +		 * the structure. Others CPUs belonging to the same
> +		 * cluster will just increment the refcount on the
> +		 * cooling device structure and initialize it.
> +		 */
> +		if (cpu == cpumask_first(cpumask)) {

Your function still have few assumptions of cpu numbering and it will
break in few cases. What if the CPUs on a big Little system (4x4) are
present in this order: B L L L L B B B  ??

This configuration can happen if CPUs in DT are marked as: 0-3 LITTLE,
4-7 big and a big CPU is used by the boot loader to bring up Linux.

> +			np = of_cpu_device_node_get(cpu);
> +
> +			idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
> +			if (!idle_cdev)
> +				goto out_fail;
> +
> +			idle_cdev->idle_cycle = DEFAULT_IDLE_TIME_US;
> +
> +			atomic_set(&idle_cdev->count, 0);

This should already be 0, isn't it ?

> +
> +			kref_init(&idle_cdev->kref);
> +
> +			/*
> +			 * Initialize the timer to wakeup all the idle
> +			 * injection tasks
> +			 */
> +			hrtimer_init(&idle_cdev->timer,
> +				     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +
> +			/*
> +			 * The wakeup function callback which is in
> +			 * charge of waking up all CPUs belonging to
> +			 * the same cluster
> +			 */
> +			idle_cdev->timer.function = cpuidle_cooling_wakeup_fn;
> +
> +			/*
> +			 * The thermal cooling device name
> +			 */
> +			snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", index++);
> +			cdev = thermal_of_cooling_device_register(np, dev_name,
> +								  idle_cdev,
> +								  &cpuidle_cooling_ops);

You registered the cooling device, while the idle_cdev is still
getting initialized. Ideally, we should register with the thermal core
(or any other framework) when we are fully ready. For example, any of
the callbacks present in cpuidle_cooling_ops() can get called by the
core after this point and you should be ready to handle them. It will
result in kernel crash in your case as idle_cdev isn't fully
initialized yet. For example, with the set-state callback you will end
up calling wake_up_task(NULL).

> +			if (IS_ERR(cdev)) {
> +				ret = PTR_ERR(cdev);
> +				goto out_fail;
> +			}
> +
> +			idle_cdev->cdev = cdev;
> +
> +			idle_cdev->cpumask = cpumask;
> +
> +			list_add(&idle_cdev->node, &cpuidle_cdev_list);

I would have removed the above two blank lines as these can all go
together.

> +
> +			pr_info("Created idle cooling device for cpus '%*pbl'\n",
> +				cpumask_pr_args(cpumask));

I am not sure if it makes sense to print the message right here. We
can still fail while creating the cooling devices. Maybe a single
print at the very end of the function is more than enough?

> +		}
> +
> +		kref_get(&idle_cdev->kref);

Did you check if the kref thing is really working here or not? I think
your structure will never get freed on errors because kref_init()
initializes the count by 1 and then you do an additional kref_get()
here for the first CPU of the cluster.

> +
> +		init_waitqueue_head(&cct->waitq);
> +
> +		tsk = kthread_create_on_cpu(cpuidle_cooling_injection_thread,
> +					    idle_cdev, cpu, "kidle_inject/%u");
> +		if (IS_ERR(tsk)) {
> +			ret = PTR_ERR(tsk);
> +			goto out_fail;
> +		}
> +
> +		cct->tsk = tsk;
> +
> +		wake_up_process(tsk);
> +	}
> +
> +	return 0;
> +
> +out_fail:
> +	cpuidle_cooling_unregister();
> +	pr_err("Failed to create idle cooling device (%d)\n", ret);

So you are already printing the error message here, just make the
return type void as the caller of this can't do anything anyway.

> +
> +	return ret;
> +}
> +#endif /* CONFIG_CPU_IDLE_THERMAL */

-- 
viresh
