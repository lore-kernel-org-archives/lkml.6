Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755901AbeEaSZz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:25:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54246 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755888AbeEaSZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:25:50 -0400
X-Google-Smtp-Source: ADUXVKIcGBdOtEsE6f4GKMzzbSeNvScxHJAYVPiHzm8EmhjPoyWTGUJrM9rejwlweGwtRi3K6aMlow==
Subject: Re: [PATCH V4] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
References: <1527241792-5860-1-git-send-email-daniel.lezcano@linaro.org>
 <20180529093148.b2cxb5lwks7ka2tn@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
X-Enigmail-Draft-Status: N11100
Message-ID: <c7c4143d-77c4-a41b-b770-e5c38e346320@linaro.org>
Date: Thu, 31 May 2018 20:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529093148.b2cxb5lwks7ka2tn@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2018 11:31, Viresh Kumar wrote:
> Hi Daniel,
> 
> Thanks for yet another version :)
> 
> On 25-05-18, 11:49, Daniel Lezcano wrote:
>> +++ b/drivers/powercap/idle_injection.c
>> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
>> +{
>> +	struct idle_injection_thread *iit;
>> +	int cpu;
>> +
>> +	for_each_cpu_and(cpu, ii_dev->cpumask, cpu_online_mask) {
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
>> +
>> +	if (WARN_ON_ONCE(!ii_dev))
> 
> Yes, this is marked as "unlikely" and is kind of not that harmful, but
> I would suggest to just drop it and let the kernel crash if that
> serious of a bug is present in this code where ii_dev can be NULL
> here.

Ok.

>> +		return;
>> +
>> +	iit = per_cpu_ptr(&idle_injection_thread, cpu);
> 
> See, we don't check this one, why check only ii_dev ? :)
> 
>> +
>> +	/*
>> +	 * Boolean used by the smpboot main loop and used as a
>> +	 * flip-flop in this function
>> +	 */
>> +	iit->should_run = 0;
>> +
>> +	atomic_inc(&ii_dev->count);
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
> 
> I am afraid that the above comment may not be completely true all the
> time. For a quad-core platform, it is possible for 3 CPUs (0,1,2) to
> run this function as soon as the kthread is woken up, but one of the
> CPUs (3) may be stuck servicing an IRQ, Deadline or RT activity.
> Because you do atomic_inc() also in this function (above) itself,
> below decrement may return a true value for the CPU2 and that will
> restart the hrtimer, while one of the CPUs never got a chance to
> increment count in the first place.
>
> The fix is simple though, do the increment in idle_injection_wakeup()
> and things should be fine then.

Ok.

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
> 
> So you call complete() after hrtimer is potentially restarted. This
> can happen if idle_injection_stop() is called right after the above
> atomic_read() has finished :)
> 
> IOW, this doesn't look safe now as well.

It is safe, we just missed a cycle and the stop will block until the
next cycle. I did it on purpose and for me it is correct.

>> +}
> 
>> +/**
>> + * idle_injection_stop - stops the idle injections
>> + * @ii_dev: a pointer to an idle injection_device structure
>> + *
>> + * The function stops the idle injection by resetting the idle and
>> + * running durations and wait for the threads to complete. If we are
>> + * in the process of injecting an idle cycle, then this will wait the
>> + * end of the cycle.
>> + */
>> +void idle_injection_stop(struct idle_injection_device *ii_dev)
>> +{
>> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
>> +		 cpumask_pr_args(ii_dev->cpumask));
>> +
>> +	init_completion(&ii_dev->stop_complete);
> 
> This looks completely Borken (yeah, broken :)). complete() may be
> running in parallel under spinlock and updating x->done while you just
> set it to 0 here without any locking in place. init_completion()
> should be used only once after ii_dev is allocated and I don't see
> that being done either, so that looks incorrect as well.

Ok.

>> +
>> +	idle_injection_set_duration(ii_dev, 0, 0);
>> +
>> +	wait_for_completion_interruptible(&ii_dev->stop_complete);
>> +}
>> +
>> +/**
>> + * idle_injection_setup - initialize the current task as a RT task
>> + * @cpu: the CPU number where the kthread is running on (not used)
>> + *
>> + * Called one time, this function is in charge of setting the task
>> + * scheduler parameters.
>> + */
>> +static void idle_injection_setup(unsigned int cpu)
>> +{
>> +	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
>> +
>> +	set_freezable();
>> +
>> +	sched_setscheduler(current, SCHED_FIFO, &param);
>> +}
>> +
>> +/**
>> + * idle_injection_should_run - function helper for the smpboot API
>> + * @cpu: the CPU number where the kthread is running on
>> + *
>> + * Return: a boolean telling if the thread can run.
>> + */
>> +static int idle_injection_should_run(unsigned int cpu)
>> +{
>> +	struct idle_injection_thread *iit =
>> +		per_cpu_ptr(&idle_injection_thread, cpu);
>> +
>> +	return iit->should_run;
>> +}
>> +
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
>> +	int cpu, cpu2;
>> +
>> +	ii_dev = ii_dev_alloc();
>> +	if (!ii_dev)
>> +		return NULL;
>> +
>> +	cpumask_copy(ii_dev->cpumask, cpumask);
>> +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	ii_dev->timer.function = idle_injection_wakeup_fn;
>> +
>> +	for_each_cpu(cpu, ii_dev->cpumask) {
>> +
>> +		if (per_cpu(idle_injection_device, cpu)) {
> 
> Maybe add unlikely here ?

For this kind of init function and tight loop, there is no benefit of
adding the unlikely / likely. I can add it if you want, but it is useless.

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
>> +	for_each_cpu(cpu2, ii_dev->cpumask) {
>> +		if (cpu == cpu2)
> 
> And is this really required? Perhaps this conditional is making it
> worse and just setting the per-cpu variable forcefully to NULL would
> be much faster :)

We want undo what was done, setting all variables to NULL resets the
values from a previous register and we don't want that.


> Maybe move this for-loop into iid_dev_free() and you can make this
> look simple then.
> 
>> +			break;
>> +
>> +		per_cpu(idle_injection_device, cpu2) = NULL;
>> +	}
>> +
>> +	ii_dev_free(ii_dev);
>> +
>> +	return NULL;
>> +}
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
