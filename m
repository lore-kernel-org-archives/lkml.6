Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeFEOyT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:54:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44374 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeFEOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:54:16 -0400
X-Google-Smtp-Source: ADUXVKKkNOstIG5SeGstEG2Ok3ibBe2ll7VPSaaFcQGt/IGK88UOyLuu9RZtC5piBISw8MLwDchmAw==
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
Date: Tue, 5 Jun 2018 16:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2018 12:39, Viresh Kumar wrote:
> On 05-06-18, 11:16, Daniel Lezcano wrote:
>> diff --git a/drivers/powercap/idle_injection.c b/drivers/powercap/idle_injection.c
>> +/**
>> + * idle_injection_wakeup - Wake up all idle injection threads
>> + * @ii_dev: the idle injection device
>> + *
>> + * Every idle injection task belonging to the idle injection device
>> + * and running on an online CPU will be wake up by this call.
>> + */
>> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
>> +{
>> +	struct idle_injection_thread *iit;
>> +	int cpu;
>> +
>> +	for_each_cpu_and(cpu, ii_dev->cpumask, cpu_online_mask) {
>> +		atomic_inc(&ii_dev->count);
> 
> This may not be sufficient enough in some extremely corner cases, as it is
> possible that the idle_injection_fn() starts running for the first cpu in the
> cpumask right after first iteration of this loop completes. And so
> atomic_dec_and_test() may return true there before idle_injection_fn() task gets
> a chance to run on all cpus in the cpumask. Normally this wouldn't be a big
> problem as the hrtimer can get reprogrammed in that case, but there is a case I
> am worried about. More on this later..
> 
>> +		iit = per_cpu_ptr(&idle_injection_thread, cpu);
>> +		iit->should_run = 1;
>> +		wake_up_process(iit->tsk);
>> +	}
>> +}
>> +
>> +/**
>> + * idle_injection_wakeup_fn - idle injection timer callback
>> + * @timer: a hrtimer structure
>> + *
>> + * This function is called when the idle injection timer expires which
>> + * will wake up the idle injection tasks and these ones, in turn, play
>> + * idle a specified amount of time.
>> + *
>> + * Return: HRTIMER_NORESTART.
>> + */
>> +static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer *timer)
>> +{
>> +	struct idle_injection_device *ii_dev =
>> +		container_of(timer, struct idle_injection_device, timer);
>> +
>> +	idle_injection_wakeup(ii_dev);
>> +
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>> +/**
>> + * idle_injection_fn - idle injection routine
>> + * @cpu: the CPU number the tasks belongs to
>> + *
>> + * The idle injection routine will stay idle the specified amount of
>> + * time
>> + */
>> +static void idle_injection_fn(unsigned int cpu)
>> +{
>> +	struct idle_injection_device *ii_dev;
>> +	struct idle_injection_thread *iit;
>> +	int run_duration_ms, idle_duration_ms;
>> +
>> +	ii_dev = per_cpu(idle_injection_device, cpu);
>> +	iit = per_cpu_ptr(&idle_injection_thread, cpu);
>> +
>> +	/*
>> +	 * Boolean used by the smpboot main loop and used as a
>> +	 * flip-flop in this function
>> +	 */
>> +	iit->should_run = 0;
>> +
>> +	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
>> +	if (idle_duration_ms)
>> +		play_idle(idle_duration_ms);
>> +
>> +	/*
>> +	 * The last CPU waking up is in charge of setting the timer. If
>> +	 * the CPU is hotplugged, the timer will move to another CPU
>> +	 * (which may not belong to the same cluster) but that is not a
>> +	 * problem as the timer will be set again by another CPU
>> +	 * belonging to the cluster. This mechanism is self adaptive.
>> +	 */
>> +	if (!atomic_dec_and_test(&ii_dev->count))
>> +		return;
>> +
>> +	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
>> +	if (run_duration_ms) {
>> +		hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
>> +			      HRTIMER_MODE_REL_PINNED);
>> +		return;
>> +	}
>> +
>> +	complete(&ii_dev->stop_complete);
>> +}
> 
> Here is the corner case I was talking about. Consider the cpumask contains
> CPU0/1/2/3.
> 
> PATH A                                                  PATH B
> 
>                                                         unregister()
>                                                           -> idle_injection_stop()
> 
> idle_injection_wakeup()
>   -> Running loop for CPU0
>   -> atomic inc (count == 1)
>   -> wake_up_process(tsk)
>   -> At this point the current task stops
>   running and idle_injection_fn() starts running
>   (maybe on a different CPU)
> 
>                                                         
> 
> 
> idle_injection_fn()
>   -> atomic_dec_and_test(), returns true
>   as count == 0
> 
> 
>                                                              -> set-duration to 0
>                                                              -> wait for completion
> 
> 
>   -> atomic_read(run_duration), returns 0
>   -> complete()
> 
>                                                              -> kfree(ii_dev);   
> 
> 
> But the initial loop idle_injection_wakeup() has only run for CPU0 until now and
> will continue running for other CPUs and will crash as ii_dev is already freed.
> 
> Am I still making a mistake here ?

I don't think you are doing a mistake. Even if this can happen
theoretically, I don't think practically that is the case.

The play_idle() has 1ms minimum sleep time.

The scenario you are describing means:

1. the loop in idle_injection_wakeup() takes more than 1ms to achieve

2. at the same time, the user of the idle injection unregisters while
the idle injection is acting precisely at CPU0 and exits before another
task was wakeup by the loop in 1. more than 1ms after.

>From my POV, this scenario can't happen.

Anyway, we must write rock solid code so may be we can use a refcount to
protect against that, so instead of freeing in unregister, we refput the
ii_dev pointer.


>> +static struct idle_injection_device *ii_dev_alloc(void)
>> +{
>> +	struct idle_injection_device *ii_dev;
>> +
>> +	ii_dev = kzalloc(sizeof(*ii_dev), GFP_KERNEL);
>> +	if (!ii_dev)
>> +		return NULL;
>> +
>> +	if (!alloc_cpumask_var(&ii_dev->cpumask, GFP_KERNEL)) {
>> +		kfree(ii_dev);
>> +		return NULL;
>> +	}
>> +
>> +	return ii_dev;
>> +}
>> +
>> +static void ii_dev_free(struct idle_injection_device *ii_dev)
>> +{
>> +	free_cpumask_var(ii_dev->cpumask);
>> +	kfree(ii_dev);
>> +}
>> +
>> +/**
>> + * idle_injection_register - idle injection init routine
>> + * @cpumask: the list of CPUs managed by the idle injection device
>> + *
>> + * This is the initialization function in charge of creating the
>> + * initializing of the timer and allocate the structures. It does not
>> + * starts the idle injection cycles.
>> + *
>> + * Return: NULL if an allocation fails.
>> + */
>> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
>> +{
>> +	struct idle_injection_device *ii_dev;
>> +	int cpu;
>> +
>> +	ii_dev = ii_dev_alloc();
>> +	if (!ii_dev)
>> +		return NULL;
>> +
>> +	cpumask_copy(ii_dev->cpumask, cpumask);
>> +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	ii_dev->timer.function = idle_injection_wakeup_fn;
>> +	init_completion(&ii_dev->stop_complete);
>> +
>> +	for_each_cpu(cpu, ii_dev->cpumask) {
>> +
>> +		if (per_cpu(idle_injection_device, cpu)) {
>> +			pr_err("cpu%d is already registered\n", cpu);
>> +			goto out_rollback_per_cpu;
>> +		}
>> +
>> +		per_cpu(idle_injection_device, cpu) = ii_dev;
>> +	}
>> +
>> +	return ii_dev;
>> +
>> +out_rollback_per_cpu:
>> +	for_each_cpu(cpu, ii_dev->cpumask)
>> +		per_cpu(idle_injection_device, cpu) = NULL;
> 
> Maybe move above into ii_dev_free(), as I suggested earlier, as that will remove
> same code from unregister routine as well.

I don't like to mix operations when the function name define clearly
what is doing. The ii_dev_free() frees a structure,
idle_injection_device refers to a global variable.

Anyway if we are talking about using a refcount, we can add a release
which frees the structure and sets the per cpu idle_injection_device
global variable to NULL.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
