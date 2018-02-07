Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeBGKel (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:34:41 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36503 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753424AbeBGKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:34:39 -0500
X-Google-Smtp-Source: AH8x227axmONy7TqV6OhXJcCXp7xJUmYzZYhbzE5n6nb5suzJ+WpRT0XzP4Nh+XF9vro/NafbWS24A==
Subject: Re: [PATCH 5/8] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
 <20180207091231.GQ28462@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <54759b82-29e9-f376-bbe8-dcf683ed0cce@linaro.org>
Date: Wed, 7 Feb 2018 11:34:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207091231.GQ28462@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Viresh,

thanks for reviewing.

On 07/02/2018 10:12, Viresh Kumar wrote:
> On 23-01-18, 16:34, Daniel Lezcano wrote:
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> 
>> +/**
>> + * cpuidle_cooling_ops - thermal cooling device ops
>> + */
>> +static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
>> +	.get_max_state = cpuidle_cooling_get_max_state,
>> +	.get_cur_state = cpuidle_cooling_get_cur_state,
>> +	.set_cur_state = cpuidle_cooling_set_cur_state,
>> +};
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
> 
> Don't really need doc style comments for internal routines.

>From Documentation/doc-guide/kernel-doc.rst:

"We also recommend providing kernel-doc formatted documentation for
private (file "static") routines, for consistency of kernel source code
layout. But this is lower priority and at the discretion of the
MAINTAINER of that kernel source file."

Vote is open :)

>> +static void __init cpuidle_cooling_release(struct kref *kref)
>> +{
>> +	struct cpuidle_cooling_device *idle_cdev =
>> +		container_of(kref, struct cpuidle_cooling_device, kref);
>> +
>> +	thermal_cooling_device_unregister(idle_cdev->cdev);
>> +	kfree(idle_cdev->waitq);
>> +	kfree(idle_cdev->tsk);
>> +	kfree(idle_cdev);
> 
> What about list-del here (cpuidle_cdev_list) ?

Yes, thanks for pointing this. I have to convert the calling loop with
the 'safe' list variant.

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
>> + */
>> +int cpuidle_cooling_register(void)
>> +{
>> +	struct cpuidle_cooling_device *idle_cdev = NULL;
>> +	struct thermal_cooling_device *cdev;
>> +	struct task_struct *tsk;
>> +	struct device_node *np;
>> +	cpumask_t *cpumask;
>> +	char dev_name[THERMAL_NAME_LENGTH];
>> +	int weight;
>> +	int ret = -ENOMEM, cpu;
>> +	int index = 0;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +
> 
> Perhaps this is coding choice, but just for the sake of consistency in
> this driver should we remove such empty lines at the beginning of a
> blocks ?

Yes, it is coding choice. I'm in favor of separated blocks. I can remove
the lines if that hurts.

>> +		cpumask = topology_core_cpumask(cpu);
>> +		weight = cpumask_weight(cpumask);
>> +
>> +		/*
>> +		 * This condition makes the first cpu belonging to the
>> +		 * cluster to create a cooling device and allocates
>> +		 * the structure. Others CPUs belonging to the same
>> +		 * cluster will just increment the refcount on the
>> +		 * cooling device structure and initialize it.
>> +		 */
>> +		if (cpu == cpumask_first(cpumask)) {
>> +
> 
> Like here as well.

Ok.

[ ... ]

>> +	pr_err("Failed to create idle cooling device (%d)\n", ret);
>> +
>> +	return ret;
>> +}
> 
> What about cpuidle_cooling_unregister() ?

The unregister function is not needed because cpuidle can't be unloaded.
The cpuidle cooling device is registered after the cpuidle successfully
initialized itself, there is no error path.

>> +#endif
>> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
>> index d4292eb..2b5950b 100644
>> --- a/include/linux/cpu_cooling.h
>> +++ b/include/linux/cpu_cooling.h
>> @@ -45,6 +45,7 @@ struct thermal_cooling_device *
>>  cpufreq_power_cooling_register(struct cpufreq_policy *policy,
>>  			       u32 capacitance, get_static_t plat_static_func);
>>  
>> +extern int cpuidle_cooling_register(void);
>>  /**
>>   * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
>>   * @np: a valid struct device_node to the cooling device device tree node.
>> @@ -118,6 +119,11 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>>  {
>>  	return;
>>  }
>> +
>> +static inline int cpuidle_cooling_register(void)
> 
> You need to use the new macros of cpufreq and cpuidle here as well,
> else you will see compile time errors with some configurations.

Ok, I thought I tried the different combinations but I will double check.

Thanks

  -- Daniel

>> +{
>> +	return 0;
>> +}
>>  #endif	/* CONFIG_CPU_THERMAL */
>>  
>>  #endif /* __CPU_COOLING_H__ */
>> -- 
>> 2.7.4
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
