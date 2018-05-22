Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeEVNmI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:42:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41104 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEVNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:42:06 -0400
X-Google-Smtp-Source: AB8JxZr4n59v/gjm3k+Z1SWDB+eUWjPw5eD3ZRiH2Q1LnRvnLW20MJMQ0JiY+QhtD+q9rw8Y2SbVjg==
Subject: Re: [PATCH V3] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
References: <1526655056-24592-1-git-send-email-daniel.lezcano@linaro.org>
 <20180521103223.asejwsaf7pnrs777@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
X-Enigmail-Draft-Status: N11100
Message-ID: <7ff0d7d4-be5e-2384-1201-df8616519892@linaro.org>
Date: Tue, 22 May 2018 15:42:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521103223.asejwsaf7pnrs777@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2018 12:32, Viresh Kumar wrote:
> On 18-05-18, 16:50, Daniel Lezcano wrote:
>> Initially, the cpu_cooling device for ARM was changed by adding a new
>> policy inserting idle cycles. The intel_powerclamp driver does a
>> similar action.
>>
>> Instead of implementing idle injections privately in the cpu_cooling
>> device, move the idle injection code in a dedicated framework and give
>> the opportunity to other frameworks to make use of it.
> 
> I thought you agreed to move above in the comments section ?

This is what I did. I just kept the relevant log here.

>> The framework relies on the smpboot kthreads which handles via its
>> mainloop the common code for hotplugging and [un]parking.
>>
>> This code was previously tested with the cpu cooling device and went
>> through several iterations. It results now in split code and API
>> exported in the header file. It was tested with the cpu cooling device
>> with success.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  V3:
>>    - Fixed typos (Viresh Kumar)
>>    - Removed extra blank line (Viresh Kumar)
>>    - Added full stop (Viresh Kumar)
>>    - Fixed Return kerneldoc format (Viresh Kumar)
>>    - Fixed multiple kthreads initialization (Viresh Kumar)
>>    - Fixed rollbacking the actions in the unregister function (Viresh Kumar)
>>    - Make idle injection kthreads name hardcoded
>>    - Kthreads are created in the initcall process
>>
>>  V2: Fixed checkpatch warnings
>> ---
>>  drivers/powercap/Kconfig          |  10 ++
>>  drivers/powercap/Makefile         |   1 +
>>  drivers/powercap/idle_injection.c | 326 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/idle_injection.h    |  29 ++++
>>  4 files changed, 366 insertions(+)
>>  create mode 100644 drivers/powercap/idle_injection.c
>>  create mode 100644 include/linux/idle_injection.h
>>
>> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
>> index 85727ef..a767ef2 100644
>> --- a/drivers/powercap/Kconfig
>> +++ b/drivers/powercap/Kconfig
>> @@ -29,4 +29,14 @@ config INTEL_RAPL
>>  	  controller, CPU core (Power Plance 0), graphics uncore (Power Plane
>>  	  1), etc.
>>  
>> +config IDLE_INJECTION
>> +	bool "Idle injection framework"
>> +	depends on CPU_IDLE
>> +	default n
>> +	help
>> +	  This enables support for the idle injection framework. It
>> +	  provides a way to force idle periods on a set of specified
>> +	  CPUs for power capping. Idle period can be injected
>> +	  synchronously on a set of specified CPUs or alternatively
>> +	  on a per CPU basis.
>>  endif
>> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
>> index 0a21ef3..c3bbfee 100644
>> --- a/drivers/powercap/Makefile
>> +++ b/drivers/powercap/Makefile
>> @@ -1,2 +1,3 @@
>>  obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
>>  obj-$(CONFIG_INTEL_RAPL) += intel_rapl.o
>> +obj-$(CONFIG_IDLE_INJECTION) += idle_injection.o
>> diff --git a/drivers/powercap/idle_injection.c b/drivers/powercap/idle_injection.c
>> new file mode 100644
>> index 0000000..a5fe205
>> --- /dev/null
>> +++ b/drivers/powercap/idle_injection.c
>> @@ -0,0 +1,326 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * drivers/powercap/idle_injection.c
>> + *
>> + * Copyright 2018 Linaro Limited
>> + *
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *
>> + * The idle injection framework proposes a way to force a cpu to enter
>> + * an idle state during a specified amount of time for a specified
>> + * period.
>> + *
>> + * It relies on the smpboot kthreads which handles, via its main loop,
>> + * the common code for hotplugging and [un]parking.
>> + *
>> + * At init time, all the kthreads are created and parked.
>> + *
>> + * A cpumask is specified as parameter for the idle injection
>> + * registering function. The kthreads will be synchronized regarding
>> + * this cpumask.
>> + *
>> + * The idle + run duration is specified via the helpers and then the
>> + * idle injection can be started at this point.
>> + *
>> + * A kthread will call play_idle() with the specified idle duration
>> + * from above and then will schedule itself. The latest CPU belonging
>> + * to the group is in charge of setting the timer for the next idle
>> + * injection deadline.
>> + *
>> + * The task handling the timer interrupt will wakeup all the kthreads
>> + * belonging to the cpumask.
>> + */
>> +#include <linux/cpu.h>
>> +#include <linux/freezer.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/smpboot.h>
>> +
>> +#include <uapi/linux/sched/types.h>
>> +
>> +/**
>> + * struct idle_injection_thread - task on/off switch structure
>> + * @tsk: a pointer to a task_struct injecting the idle cycles
>> + * @should_run: a integer used as a boolean by the smpboot kthread API
>> + */
>> +struct idle_injection_thread {
>> +	struct task_struct *tsk;
>> +	int should_run;
>> +};
>> +
>> +/**
>> + * struct idle_injection_device - data for the idle injection
>> + * @cpumask: a cpumask containing the list of CPUs managed by the device
>> + * @timer: a hrtimer giving the tempo for the idle injection
>> + * @count: an atomic to keep track of the last task exiting the idle cycle
>> + * @idle_duration_ms: an atomic specifying the idle duration
>> + * @run_duration_ms: an atomic specifying the running duration
>> + */
>> +struct idle_injection_device {
>> +	cpumask_var_t cpumask;
>> +	struct hrtimer timer;
>> +	atomic_t count;
>> +	atomic_t idle_duration_ms;
>> +	atomic_t run_duration_ms;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct idle_injection_thread, idle_injection_thread);
>> +static DEFINE_PER_CPU(struct idle_injection_device *, idle_injection_device);
>> +
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
>> +	iit = per_cpu_ptr(&idle_injection_thread, cpu);
>> +
>> +	/*
>> +	 * Boolean used by the smpboot mainloop and used as a flip-flop
> 
> You never replied to my comment in previous posting where I suggested
> s/mainloop/main loop/ . Maybe my comment is wrong, but it needs to be
> Nak'd.

I've seen both but it seems the correct spelling is "main loop".

>> +	 * in this function
>> +	 */
>> +	iit->should_run = 0;
>> +
>> +	atomic_inc(&ii_dev->count);
>> +
>> +	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
>> +
>> +	play_idle(idle_duration_ms);
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
> 
> This reads as if it is okay to have run_duration_ms set as 0, so we
> run idle loop only once. Which is fine, but why do you mandate this to
> be non-zero in idle_injection_start() ?

It does not make sense to run this function with a run duration set to
zero because we will immediately go to idle again after exiting idle. So
the action is exiting. In this context we can't accept to start
injecting idle cycles.

>> +	if (!run_duration_ms)
>> +		return;
>> +
>> +	hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
>> +		      HRTIMER_MODE_REL_PINNED);
>> +}
>> +
>> +/**
>> + * idle_injection_set_duration - idle and run duration helper
>> + * @run_duration_ms: an unsigned int giving the running time in milliseconds
>> + * @idle_duration_ms: an unsigned int giving the idle time in milliseconds
>> + */
>> +void idle_injection_set_duration(struct idle_injection_device *ii_dev,
>> +				 unsigned int run_duration_ms,
>> +				 unsigned int idle_duration_ms)
>> +{
>> +	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
>> +	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);
> 
> You check for valid values of these in idle_injection_start() but not
> here, why ?

By checking against a zero values in the start function is a way to make
sure we are not starting the idle injection with uninitialized values
and by setting the duration to zero is a way to stop the idle injection.

>> +}
>> +
>> +/**
>> + * idle_injection_get_duration - idle and run duration helper
>> + * @run_duration_ms: a pointer to an unsigned int to store the running time
>> + * @idle_duration_ms: a pointer to an unsigned int to store the idle time
>> + */
>> +void idle_injection_get_duration(struct idle_injection_device *ii_dev,
>> +				 unsigned int *run_duration_ms,
>> +				 unsigned int *idle_duration_ms)
>> +{
>> +	*run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
>> +	*idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
>> +}
>> +
>> +/**
>> + * idle_injection_start - starts the idle injections
>> + * @ii_dev: a pointer to an idle_injection_device structure
>> + *
>> + * The function starts the idle injection cycles by first waking up
>> + * all the tasks the ii_dev is attached to and let them handle the
>> + * idle-run periods.
>> + *
>> + * Return: -EINVAL if the idle or the running durations are not set.
>> + */
>> +int idle_injection_start(struct idle_injection_device *ii_dev)
>> +{
>> +	if (!atomic_read(&ii_dev->idle_duration_ms))
>> +		return -EINVAL;
>> +
>> +	if (!atomic_read(&ii_dev->run_duration_ms))
>> +		return -EINVAL;
>> +
>> +	pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
>> +		 cpumask_pr_args(ii_dev->cpumask));
>> +
>> +	idle_injection_wakeup(ii_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * idle_injection_stop - stops the idle injections
>> + * @ii_dev: a pointer to an idle injection_device structure
>> + *
>> + * The function stops the idle injection by canceling the timer in
>> + * charge of waking up the tasks to inject idle and unset the idle and
>> + * running durations.
>> + */
>> +void idle_injection_stop(struct idle_injection_device *ii_dev)
>> +{
>> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
>> +		 cpumask_pr_args(ii_dev->cpumask));
>> +
>> +	hrtimer_cancel(&ii_dev->timer);
> 
> How are we sure that idle_injection_fn() isn't running at this point
> and it would start the timer cancelled here again ?

Nothing will ensure that. We will have an extra idle injection in this
case. We can invert the set_duration(0,0) and the timer cancellation to
reduce to reduce the window.

>> +
>> +	idle_injection_set_duration(ii_dev, 0, 0);
> 
> And why exactly this this required ? Why shouldn't we allow this
> sequence to work:
> 
> idle_injection_set_duration()
> idle_injection_start()
> idle_injection_stop()
> idle_injection_start()
> idle_injection_stop()
> idle_injection_start()
> idle_injection_stop()

Sorry, I don't get it.

Who will decide to start() and stop() ?

>> }
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
>> +/**
>> + * idle_injection_register - idle injection init routine
>> + * @cpumask: the list of CPUs managed by the idle injection device
>> + *
>> + * This is the initialization function in charge of creating the
>> + * initializing the timer and allocate the structures. It does not
>> + * starts the idle injection cycles.
>> + *
>> + * Return: NULL if an allocation fails.
>> + */
>> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
>> +{
>> +	struct idle_injection_device *ii_dev;
>> +	int cpu;
>> +
>> +	ii_dev = kzalloc(sizeof(*ii_dev), GFP_KERNEL);
>> +	if (!ii_dev)
>> +		return NULL;
>> +
>> +	if (!alloc_cpumask_var(&ii_dev->cpumask, GFP_KERNEL))
>> +		goto out_free_ii_dev;
>> +	cpumask_copy(ii_dev->cpumask, cpumask);
>> +
>> +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +
>> +	ii_dev->timer.function = idle_injection_wakeup_fn;
>> +
>> +	for_each_cpu(cpu, cpumask)
>> +		per_cpu(idle_injection_device, cpu) = ii_dev;
> 
> Not sure but do we need protection against registration done twice for
> a CPU ?

Yeah, that would be safer.

>> +
>> +	return ii_dev;
>> +
>> +out_free_ii_dev:
>> +	kfree(ii_dev);
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * idle_injection_unregister - Unregister the idle injection device
>> + * @ii_dev: a pointer to an idle injection device
>> + *
>> + * The function is in charge of stopping the idle injections,
>> + * unregister the kthreads and free the allocated memory in the
>> + * register function.
>> + */
>> +void idle_injection_unregister(struct idle_injection_device *ii_dev)
>> +{
>> +	int cpu;
>> +
>> +	idle_injection_stop(ii_dev);
>> +
>> +	for_each_cpu(cpu, ii_dev->cpumask)
>> +		per_cpu(idle_injection_device, cpu) = NULL;
>> +
>> +	kfree(ii_dev);
>> +}
>> +
>> +static struct smp_hotplug_thread idle_injection_threads = {
>> +	.store = &idle_injection_thread.tsk,
>> +	.setup = idle_injection_setup,
>> +	.thread_fn = idle_injection_fn,
>> +	.thread_comm = "idle_inject/%u",
>> +	.thread_should_run = idle_injection_should_run,
>> +};
>> +
>> +static int __init idle_injection_init(void)
>> +{
>> +	return smpboot_register_percpu_thread(&idle_injection_threads);
>> +}
>> +early_initcall(idle_injection_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
