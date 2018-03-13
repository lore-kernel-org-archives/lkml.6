Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeCMTPm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:15:42 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33097 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeCMTPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:15:40 -0400
X-Google-Smtp-Source: AG47ELtilkxsxTtfcwW+NjMppQ2vuL8BRr1fdaxIBlu9c3JIGG8IlxbB9FSsz1j97MSFpiCkXPaSPg==
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
 <faaf027c-e01c-6801-9a0c-ab7e0ba669a1@linaro.org>
 <20180226043021.GK26947@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a16ade5e-2584-af75-ac60-c352edf1d7ec@linaro.org>
Date: Tue, 13 Mar 2018 20:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226043021.GK26947@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 05:30, Viresh Kumar wrote:

[ ... ]

>>>> +		/*
>>>> +		 * The last CPU waking up is in charge of setting the
>>>> +		 * timer. If the CPU is hotplugged, the timer will
>>>> +		 * move to another CPU (which may not belong to the
>>>> +		 * same cluster) but that is not a problem as the
>>>> +		 * timer will be set again by another CPU belonging to
>>>> +		 * the cluster, so this mechanism is self adaptive and
>>>> +		 * does not require any hotplugging dance.
>>>> +		 */
>>>
>>> Well this depends on how CPU hotplug really happens. What happens to
>>> the per-cpu-tasks which are in the middle of something when hotplug
>>> happens?  Does hotplug wait for those per-cpu-tasks to finish ?
> 
> Missed this one ?

To be frank, I don't know. I have been through the hp code and didn't
find the answer. AFAICT, the sched/core.c sched_cpu_dying() disables the
rq and then migrates the tasks. I assume this kthread is not migrated
and stays in sleeping state until the rq is online again. As the wakeup
callback discards offline cpus, the kthread is not wakeup at any moment.

I created a situation where that happens: mitigation (raised with
dhrystone) + cpu hotplugging (offline/online loop) and never hit any issue.

However, I'm wondering if using the 'struct smp_hotplug_thread'
infra-stucture (git show f97f8f06) shouldn't be used.


>>>> +int cpuidle_cooling_register(void)
>>>> +{
>>>> +	struct cpuidle_cooling_device *idle_cdev = NULL;
>>>> +	struct thermal_cooling_device *cdev;
>>>> +	struct cpuidle_cooling_tsk *cct;
>>>> +	struct task_struct *tsk;
>>>> +	struct device_node *np;
>>>> +	cpumask_t *cpumask;
>>>> +	char dev_name[THERMAL_NAME_LENGTH];
>>>> +	int ret = -ENOMEM, cpu;
>>>> +	int index = 0;
>>>> +
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		cpumask = topology_core_cpumask(cpu);
>>>> +
>>>> +		cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
>>>> +
>>>> +		/*
>>>> +		 * This condition makes the first cpu belonging to the
>>>> +		 * cluster to create a cooling device and allocates
>>>> +		 * the structure. Others CPUs belonging to the same
>>>> +		 * cluster will just increment the refcount on the
>>>> +		 * cooling device structure and initialize it.
>>>> +		 */
>>>> +		if (cpu == cpumask_first(cpumask)) {
>>>
>>> Your function still have few assumptions of cpu numbering and it will
>>> break in few cases. What if the CPUs on a big Little system (4x4) are
>>> present in this order: B L L L L B B B  ??
>>>
>>> This configuration can happen if CPUs in DT are marked as: 0-3 LITTLE,
>>> 4-7 big and a big CPU is used by the boot loader to bring up Linux.
>>
>> Ok, how can I sort it out ?
> 
> I would do something like this:
> 
>         cpumask_copy(possible, cpu_possible_mask);
>         
>         while (!cpumask_empty(possible)) {
>                 first = cpumask_first(possible);
>                 cpumask = topology_core_cpumask(first);
>                 cpumask_andnot(possible, possible, cpumask);
>         
>                 allocate_cooling_dev(first); //This is most of this function in your patch.
>         
>                 while (!cpumask_empty(cpumask)) {
>                         temp = cpumask_first(possible);
>                         //rest init "temp"
>                         cpumask_clear_cpu(temp, cpumask);
>                 }
>         
>                 //Everything done, register cooling device for cpumask.
>         }
> 
>>>> +			np = of_cpu_device_node_get(cpu);
>>>> +
>>>> +			idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
>>>> +			if (!idle_cdev)
>>>> +				goto out_fail;
>>>> +
>>>> +			idle_cdev->idle_cycle = DEFAULT_IDLE_TIME_US;
>>>> +
>>>> +			atomic_set(&idle_cdev->count, 0);
>>>
>>> This should already be 0, isn't it ?
>>
>> Yes.
> 
> I read it as, "I will drop it" :)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
