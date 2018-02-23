Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBWL25 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:28:57 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55711 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWL2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:28:55 -0500
X-Google-Smtp-Source: AH8x227Ja6TK+35Qm6wLjb521YEeO8SmW1r/fK7M0KvsJUWfVZnNCINqjZuNZ8cWZx9SvZSxpDYqXw==
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
 <20180223073432.GF26947@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <faaf027c-e01c-6801-9a0c-ab7e0ba669a1@linaro.org>
Date: Fri, 23 Feb 2018 12:28:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223073432.GF26947@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2018 08:34, Viresh Kumar wrote:
> On 21-02-18, 16:29, Daniel Lezcano wrote:
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index 5c219dc..9340216 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -10,18 +10,32 @@
>>   *		Viresh Kumar <viresh.kumar@linaro.org>
>>   *
>>   */
>> +#undef DEBUG
> 
> Why is this required ?

It is usually added, so if you set the -DDEBUG flag when compiling, you
don't get all the pr_debug traces for all files, but the just the ones
where you commented the #undef above. pr_debug is a no-op otherwise.

>> +#define pr_fmt(fmt) "CPU cooling: " fmt
> 
> I think you can use the dev_***() routines instead, as you can
> directly the CPU device from anywhere.

Can we postpone this change for later ? All the file is using pr_*
(cpufreq_cooling included). There is only one place where dev_err is
used but it is removed by the patch 3/7.

[ ... ]

>> +#ifdef CONFIG_CPU_IDLE_THERMAL
>> +/*
>> + * The idle duration injection. As we don't have yet a way to specify
>> + * from the DT configuration, let's default to a tick duration.
>> + */
>> +#define DEFAULT_IDLE_TIME_US TICK_USEC
> 
> I think this macro is a bit unnecessary here. Its used only at
> initialization and so the same comment can be present there and you
> can use TICK_USEC there.
> 
> Else, Keep it as it is and remove the "idle_cycle" field from the
> below structure, as it holds a constant forever.

Yes, makes sense.

>> +/**
>> + * struct cpuidle_cooling_device - data for the idle cooling device
>> + * @cdev: a pointer to a struct thermal_cooling_device
>> + * @cpumask: a cpumask containing the CPU managed by the cooling device
> 
> Missed @node here.

Ok.

>> + * @timer: a hrtimer giving the tempo for the idle injection cycles
>> + * @kref: a kernel refcount on this structure
>> + * @count: an atomic to keep track of the last task exiting the idle cycle
>> + * @idle_cycle: an integer defining the duration of the idle injection
>> + * @state: an normalized integer giving the state of the cooling device
>> + */
>> +struct cpuidle_cooling_device {
>> +	struct thermal_cooling_device *cdev;
>> +	struct cpumask *cpumask;
>> +	struct list_head node;
>> +	struct hrtimer timer;
>> +	struct kref kref;
>> +	atomic_t count;
>> +	unsigned int idle_cycle;
>> +	unsigned int state;
>> +};
>> +
>> +/**
>> + * @tsk: an array of pointer to the idle injection tasks
>> + * @waitq: the waiq for the idle injection tasks
>> + */
>> +struct cpuidle_cooling_tsk {
>> +	struct task_struct *tsk;
>> +	wait_queue_head_t waitq;
>> +};
>> +
>> +DEFINE_PER_CPU(struct cpuidle_cooling_tsk, cpuidle_cooling_tsk);
> 
> static ?

Ok.

[ ... ]

>> +static s64 cpuidle_cooling_runtime(struct cpuidle_cooling_device *idle_cdev)
>> +{
>> +	s64 next_wakeup;
>> +	int state = idle_cdev->state;
>> +
>> +	/*
>> +	 * The function must never be called when there is no
>> +	 * mitigation because:
>> +	 * - that does not make sense
>> +	 * - we end up with a division by zero
>> +	 */
>> +	BUG_ON(!state);
> 
> As there is no locking in place, we can surely hit this case. What if
> the state changed to 0 right before this routine was called ?
> 
> I would suggest we should just return 0 in that case and get away with
> the BUG_ON().

Ok.

>> +
>> +	next_wakeup = (s64)((idle_cdev->idle_cycle * 100) / state) -
>> +		idle_cdev->idle_cycle;
>> +
>> +	return next_wakeup * NSEC_PER_USEC;
>> +}
>> +
>> +/**
>> + * cpuidle_cooling_injection_thread - Idle injection mainloop thread function
>> + * @arg: a void pointer containing the idle cooling device address
>> + *
>> + * This main function does basically two operations:
>> + *
>> + * - Goes idle for a specific amount of time
>> + *
>> + * - Sets a timer to wake up all the idle injection threads after a
>> + *   running period
>> + *
>> + * That happens only when the mitigation is enabled, otherwise the
>> + * task is scheduled out.
>> + *
>> + * In order to keep the tasks synchronized together, it is the last
>> + * task exiting the idle period which is in charge of setting the
>> + * timer.
>> + *
>> + * This function never returns.
>> + */
>> +static int cpuidle_cooling_injection_thread(void *arg)
>> +{
>> +	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO/2 };
>> +	struct cpuidle_cooling_device *idle_cdev = arg;
>> +	struct cpuidle_cooling_tsk *cct = per_cpu_ptr(&cpuidle_cooling_tsk,
>> +						      smp_processor_id());
> 
> this_cpu_ptr ?

yeah, even better.

>> +	DEFINE_WAIT(wait);
>> +
>> +	set_freezable();
>> +
>> +	sched_setscheduler(current, SCHED_FIFO, &param);
>> +
>> +	while (1) {
>> +		s64 next_wakeup;
>> +
>> +		prepare_to_wait(&cct->waitq, &wait, TASK_INTERRUPTIBLE);
>> +
>> +		schedule();
>> +
>> +		atomic_inc(&idle_cdev->count);
>> +
>> +		play_idle(idle_cdev->idle_cycle / USEC_PER_MSEC);
>> +
>> +		/*
>> +		 * The last CPU waking up is in charge of setting the
>> +		 * timer. If the CPU is hotplugged, the timer will
>> +		 * move to another CPU (which may not belong to the
>> +		 * same cluster) but that is not a problem as the
>> +		 * timer will be set again by another CPU belonging to
>> +		 * the cluster, so this mechanism is self adaptive and
>> +		 * does not require any hotplugging dance.
>> +		 */
> 
> Well this depends on how CPU hotplug really happens. What happens to
> the per-cpu-tasks which are in the middle of something when hotplug
> happens?  Does hotplug wait for those per-cpu-tasks to finish ?
> 
>> +		if (!atomic_dec_and_test(&idle_cdev->count))
>> +			continue;
>> +
>> +		if (!idle_cdev->state)
>> +			continue;
>> +
>> +		next_wakeup = cpuidle_cooling_runtime(idle_cdev);
>> +
>> +		hrtimer_start(&idle_cdev->timer, ns_to_ktime(next_wakeup),
>> +			      HRTIMER_MODE_REL_PINNED);
>> +	}
>> +
>> +	finish_wait(&cct->waitq, &wait);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cpuidle_cooling_release - Kref based release helper
>> + * @kref: a pointer to the kref structure
>> + *
>> + * This function is automatically called by the kref_put function when
>> + * the idle cooling device refcount reaches zero. At this point, we
>> + * have the guarantee the structure is no longer in use and we can
>> + * safely release all the ressources.
>> + */
>> +static void __init cpuidle_cooling_release(struct kref *kref)
>> +{
>> +	struct cpuidle_cooling_device *idle_cdev =
>> +		container_of(kref, struct cpuidle_cooling_device, kref);
>> +
>> +	thermal_cooling_device_unregister(idle_cdev->cdev);
>> +	kfree(idle_cdev);
>> +}
> 
> Maybe just move it closer to the only function that calls it?

Ok.

[ ... ]

>> +/**
>> + * cpuidle_cooling_get_cur_state - Get the current cooling state
>> + * @cdev: the thermal cooling device
>> + * @state: a pointer to the state
>> + *
>> + * The function just copy the state value from the private thermal
>> + * cooling device structure, the mapping is 1 <-> 1.
>> + *
>> + * The function can not fail, it returns always zero.
>> + */
>> +static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
>> +					 unsigned long *state)
>> +{
>> +        struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
> 
> This line isn't aligned properly. Spaces are present instead of a tab.

Ok.

[ ... ]

> Same at other places as well.

Ok, I will double check it.

[ ... ]

>> +static void cpuidle_cooling_unregister(void)
>> +{
>> +	struct cpuidle_cooling_device *tmp, *idle_cdev = NULL;
>> +	struct cpuidle_cooling_tsk *cct;
>> +	int cpu;
>> +
>> +	list_for_each_entry_safe(idle_cdev, tmp, &cpuidle_cdev_list, node) {
>> +		for_each_cpu(cpu, idle_cdev->cpumask) {
>> +			cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
>> +			if (cct->tsk)
>> +				kthread_stop(cct->tsk);
> 
> What about hrtimer ? Shouldn't that be stopped as well ?

IMO, practically it is not possible to have a timer running at this
point, but rigorously it must be stopped in the release routine, so I
will add it.

>> +			kref_put(&idle_cdev->kref, cpuidle_cooling_release);
>> +		}
>> +	}
>> +}
>> +
>> +/**
>> + * cpuidle_cooling_register - Idle cooling device initialization function
>> + *
>> + * This function is in charge of creating a cooling device per cluster
>> + * and register it to thermal framework. For this we rely on the
>> + * topology as there is nothing yet describing better the idle state
>> + * power domains.
>> + *
>> + * For each first CPU of the cluster's cpumask, we allocate the idle
>> + * cooling device, initialize the general fields and then we initialze
>> + * the rest in a per cpu basis.
>> + *
>> + * Returns zero on success, < 0 otherwise.
> 
> This wouldn't get shown in the doc properly, it should be written as:
> 
>   * Return: zero on success, < 0 otherwise.

Ok.

>> + */
>> +int cpuidle_cooling_register(void)
>> +{
>> +	struct cpuidle_cooling_device *idle_cdev = NULL;
>> +	struct thermal_cooling_device *cdev;
>> +	struct cpuidle_cooling_tsk *cct;
>> +	struct task_struct *tsk;
>> +	struct device_node *np;
>> +	cpumask_t *cpumask;
>> +	char dev_name[THERMAL_NAME_LENGTH];
>> +	int ret = -ENOMEM, cpu;
>> +	int index = 0;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpumask = topology_core_cpumask(cpu);
>> +
>> +		cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
>> +
>> +		/*
>> +		 * This condition makes the first cpu belonging to the
>> +		 * cluster to create a cooling device and allocates
>> +		 * the structure. Others CPUs belonging to the same
>> +		 * cluster will just increment the refcount on the
>> +		 * cooling device structure and initialize it.
>> +		 */
>> +		if (cpu == cpumask_first(cpumask)) {
> 
> Your function still have few assumptions of cpu numbering and it will
> break in few cases. What if the CPUs on a big Little system (4x4) are
> present in this order: B L L L L B B B  ??
> 
> This configuration can happen if CPUs in DT are marked as: 0-3 LITTLE,
> 4-7 big and a big CPU is used by the boot loader to bring up Linux.

Ok, how can I sort it out ?

>> +			np = of_cpu_device_node_get(cpu);
>> +
>> +			idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
>> +			if (!idle_cdev)
>> +				goto out_fail;
>> +
>> +			idle_cdev->idle_cycle = DEFAULT_IDLE_TIME_US;
>> +
>> +			atomic_set(&idle_cdev->count, 0);
> 
> This should already be 0, isn't it ?

Yes.

>> +
>> +			kref_init(&idle_cdev->kref);
>> +
>> +			/*
>> +			 * Initialize the timer to wakeup all the idle
>> +			 * injection tasks
>> +			 */
>> +			hrtimer_init(&idle_cdev->timer,
>> +				     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +
>> +			/*
>> +			 * The wakeup function callback which is in
>> +			 * charge of waking up all CPUs belonging to
>> +			 * the same cluster
>> +			 */
>> +			idle_cdev->timer.function = cpuidle_cooling_wakeup_fn;
>> +
>> +			/*
>> +			 * The thermal cooling device name
>> +			 */
>> +			snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", index++);
>> +			cdev = thermal_of_cooling_device_register(np, dev_name,
>> +								  idle_cdev,
>> +								  &cpuidle_cooling_ops);
> 
> You registered the cooling device, while the idle_cdev is still
> getting initialized. Ideally, we should register with the thermal core
> (or any other framework) when we are fully ready. For example, any of
> the callbacks present in cpuidle_cooling_ops() can get called by the
> core after this point and you should be ready to handle them. It will
> result in kernel crash in your case as idle_cdev isn't fully
> initialized yet. For example, with the set-state callback you will end
> up calling wake_up_task(NULL).
> 
>> +			if (IS_ERR(cdev)) {
>> +				ret = PTR_ERR(cdev);
>> +				goto out_fail;
>> +			}
>> +
>> +			idle_cdev->cdev = cdev;
>> +
>> +			idle_cdev->cpumask = cpumask;
>> +
>> +			list_add(&idle_cdev->node, &cpuidle_cdev_list);
> 
> I would have removed the above two blank lines as these can all go
> together.

Ok.

>> +
>> +			pr_info("Created idle cooling device for cpus '%*pbl'\n",
>> +				cpumask_pr_args(cpumask));
> 
> I am not sure if it makes sense to print the message right here. We
> can still fail while creating the cooling devices. Maybe a single
> print at the very end of the function is more than enough?

Ok.

>> +		}
>> +
>> +		kref_get(&idle_cdev->kref);
> 
> Did you check if the kref thing is really working here or not? I think
> your structure will never get freed on errors because kref_init()
> initializes the count by 1 and then you do an additional kref_get()
> here for the first CPU of the cluster.

Yes, you are right. I will fix that.

>> +
>> +		init_waitqueue_head(&cct->waitq);
>> +
>> +		tsk = kthread_create_on_cpu(cpuidle_cooling_injection_thread,
>> +					    idle_cdev, cpu, "kidle_inject/%u");
>> +		if (IS_ERR(tsk)) {
>> +			ret = PTR_ERR(tsk);
>> +			goto out_fail;
>> +		}
>> +
>> +		cct->tsk = tsk;
>> +
>> +		wake_up_process(tsk);
>> +	}
>> +
>> +	return 0;
>> +
>> +out_fail:
>> +	cpuidle_cooling_unregister();
>> +	pr_err("Failed to create idle cooling device (%d)\n", ret);
> 
> So you are already printing the error message here, just make the
> return type void as the caller of this can't do anything anyway.

Ok.

>> +
>> +	return ret;
>> +}
>> +#endif /* CONFIG_CPU_IDLE_THERMAL */


Thanks for the review.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
