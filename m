Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbeBENyy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:54:54 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38461 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBENyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:54:47 -0500
X-Google-Smtp-Source: AH8x226UI7E8MYQ8cLxXP37j8ukF7j2EdE73RzCZSJXlo3nVLTgEj/GLGgP2r+rcsa+/bDXckFsOeg==
Subject: Re: [PATCH 5/8] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
To: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <d1cc42d4-f79a-e7ac-d8bb-42e889e8a4fe@linaro.org>
Date: Mon, 5 Feb 2018 13:54:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/18 15:34, Daniel Lezcano wrote:
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

Doesn't this requires DTs to be changed?

Basically the existing bindings for cpu cooling dictate that
cooling-max-levels == num OPPs - 1 .

Likewise I think cooling-max-levels *defines* the scale used by the 
cooling maps in the DT. Introducing an alternative scale means that the 
OPP limits in the cooling-map will be misinterpreted when we bind the 
cooling device.

Note that we get away with this on Hikey because its mainline cooling 
map is, AFAICT, deeply sub-optimal and doesn't set any cooling limits. 
If its cooling map has been tuned (as the Exynos ones are) then I 
suspect there could be overheating problems when the cpuidle (or combo) 
CPU coolers are enabled.


Daniel.



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
> +	kfree(idle_cdev->waitq);
> +	kfree(idle_cdev->tsk);
> +	kfree(idle_cdev);
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
> + */
> +int cpuidle_cooling_register(void)
> +{
> +	struct cpuidle_cooling_device *idle_cdev = NULL;
> +	struct thermal_cooling_device *cdev;
> +	struct task_struct *tsk;
> +	struct device_node *np;
> +	cpumask_t *cpumask;
> +	char dev_name[THERMAL_NAME_LENGTH];
> +	int weight;
> +	int ret = -ENOMEM, cpu;
> +	int index = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +
> +		cpumask = topology_core_cpumask(cpu);
> +		weight = cpumask_weight(cpumask);
> +
> +		/*
> +		 * This condition makes the first cpu belonging to the
> +		 * cluster to create a cooling device and allocates
> +		 * the structure. Others CPUs belonging to the same
> +		 * cluster will just increment the refcount on the
> +		 * cooling device structure and initialize it.
> +		 */
> +		if (cpu == cpumask_first(cpumask)) {
> +
> +			np = of_cpu_device_node_get(cpu);
> +
> +			idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
> +			if (!idle_cdev)
> +				goto out_fail;
> +
> +			idle_cdev->tsk = kzalloc(sizeof(*idle_cdev->tsk) *
> +						 weight, GFP_KERNEL);
> +			if (!idle_cdev->tsk)
> +				goto out_fail;
> +
> +			idle_cdev->waitq = kzalloc(sizeof(*idle_cdev->waitq) *
> +						   weight, GFP_KERNEL);
> +			if (!idle_cdev->waitq)
> +				goto out_fail;
> +
> +			idle_cdev->idle_cycle = DEFAULT_IDLE_TIME_US;
> +
> +			atomic_set(&idle_cdev->count, 0);
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
> +
> +			pr_info("Created idle cooling device for cpus '%*pbl'\n",
> +				cpumask_pr_args(cpumask));
> +		}
> +
> +		kref_get(&idle_cdev->kref);
> +
> +		/*
> +		 * Each cooling device is per package. Each package
> +		 * has a set of cpus where the physical number is
> +		 * duplicate in the kernel namespace. We need a way to
> +		 * address the waitq[] and tsk[] arrays with index
> +		 * which are not Linux cpu numbered.
> +		 *
> +		 * One solution is to use the
> +		 * topology_core_id(cpu). Other solution is to use the
> +		 * modulo.
> +		 *
> +		 * eg. 2 x cluster - 4 cores.
> +		 *
> +		 * Physical numbering -> Linux numbering -> % nr_cpus
> +		 *
> +		 * Pkg0 - Cpu0 -> 0 -> 0
> +		 * Pkg0 - Cpu1 -> 1 -> 1
> +		 * Pkg0 - Cpu2 -> 2 -> 2
> +		 * Pkg0 - Cpu3 -> 3 -> 3
> +		 *
> +		 * Pkg1 - Cpu0 -> 4 -> 0
> +		 * Pkg1 - Cpu1 -> 5 -> 1
> +		 * Pkg1 - Cpu2 -> 6 -> 2
> +		 * Pkg1 - Cpu3 -> 7 -> 3
> +		 */
> +		init_waitqueue_head(&idle_cdev->waitq[cpu % weight]);
> +
> +		tsk = kthread_create_on_cpu(cpuidle_cooling_injection_thread,
> +					    idle_cdev, cpu, "kidle_inject/%u");
> +		if (IS_ERR(tsk)) {
> +			ret = PTR_ERR(tsk);
> +			goto out_fail;
> +		}
> +
> +		idle_cdev->tsk[cpu % weight] = tsk;
> +
> +		wake_up_process(tsk);
> +	}
> +
> +	return 0;
> +
> +out_fail:
> +	list_for_each_entry(idle_cdev, &cpuidle_cdev_list, node) {
> +
> +		for_each_cpu(cpu, idle_cdev->cpumask) {
> +
> +			if (idle_cdev->tsk[cpu])
> +				kthread_stop(idle_cdev->tsk[cpu]);
> +
> +			kref_put(&idle_cdev->kref, cpuidle_cooling_release);
> +		}
> +	}
> +
> +	pr_err("Failed to create idle cooling device (%d)\n", ret);
> +
> +	return ret;
> +}
> +#endif
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index d4292eb..2b5950b 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -45,6 +45,7 @@ struct thermal_cooling_device *
>   cpufreq_power_cooling_register(struct cpufreq_policy *policy,
>   			       u32 capacitance, get_static_t plat_static_func);
>   
> +extern int cpuidle_cooling_register(void);
>   /**
>    * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
>    * @np: a valid struct device_node to the cooling device device tree node.
> @@ -118,6 +119,11 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>   {
>   	return;
>   }
> +
> +static inline int cpuidle_cooling_register(void)
> +{
> +	return 0;
> +}
>   #endif	/* CONFIG_CPU_THERMAL */
>   
>   #endif /* __CPU_COOLING_H__ */
> 
