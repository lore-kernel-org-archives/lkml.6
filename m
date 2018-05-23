Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeEWIAH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:00:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39313 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754149AbeEWIAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:00:03 -0400
X-Google-Smtp-Source: AB8JxZopHm16gB0lv5CZ2EumsW0qyUukPa/8lVZXuPKyjJAotj0BXRir2RvN7pvB1N09NJkEYu1zQg==
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
 <7ff0d7d4-be5e-2384-1201-df8616519892@linaro.org>
 <20180523054154.fvhnwgvq34ihivdj@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <61c2b628-6c38-463a-c6b5-5e5b7eeee1ab@linaro.org>
Date: Wed, 23 May 2018 10:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523054154.fvhnwgvq34ihivdj@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2018 07:41, Viresh Kumar wrote:
> On 22-05-18, 15:42, Daniel Lezcano wrote:
>> On 21/05/2018 12:32, Viresh Kumar wrote:
>>> On 18-05-18, 16:50, Daniel Lezcano wrote:
>>>> Initially, the cpu_cooling device for ARM was changed by adding a new
>>>> policy inserting idle cycles. The intel_powerclamp driver does a
>>>> similar action.
>>>>
>>>> Instead of implementing idle injections privately in the cpu_cooling
>>>> device, move the idle injection code in a dedicated framework and give
>>>> the opportunity to other frameworks to make use of it.
>>>
>>> I thought you agreed to move above in the comments section ?
>>
>> This is what I did. I just kept the relevant log here.
> 
> The fact that you are stating that you tried to update the cooling
> device earlier looked like a bit of version history to me, not what
> this patch is doing.
> 
> But its okay if you really want that to be preserved in git history :)
> 
>>>> +static void idle_injection_fn(unsigned int cpu)
>>>> +{
>>>> +	struct idle_injection_device *ii_dev;
>>>> +	struct idle_injection_thread *iit;
>>>> +	int run_duration_ms, idle_duration_ms;
>>>> +
>>>> +	ii_dev = per_cpu(idle_injection_device, cpu);
>>>> +
>>>> +	iit = per_cpu_ptr(&idle_injection_thread, cpu);
>>>> +
>>>> +	/*
>>>> +	 * Boolean used by the smpboot mainloop and used as a flip-flop
>>>> +	 * in this function
>>>> +	 */
>>>> +	iit->should_run = 0;
>>>> +
>>>> +	atomic_inc(&ii_dev->count);
>>>> +
>>>> +	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
>>>> +
>>>> +	play_idle(idle_duration_ms);
>>>> +
>>>> +	/*
>>>> +	 * The last CPU waking up is in charge of setting the timer. If
>>>> +	 * the CPU is hotplugged, the timer will move to another CPU
>>>> +	 * (which may not belong to the same cluster) but that is not a
>>>> +	 * problem as the timer will be set again by another CPU
>>>> +	 * belonging to the cluster. This mechanism is self adaptive.
>>>> +	 */
>>>> +	if (!atomic_dec_and_test(&ii_dev->count))
>>>> +		return;
>>>> +
>>>> +	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
>>>
>>> This reads as if it is okay to have run_duration_ms set as 0, so we
>>> run idle loop only once. Which is fine, but why do you mandate this to
>>> be non-zero in idle_injection_start() ?
>>
>> It does not make sense to run this function with a run duration set to
>> zero because we will immediately go to idle again after exiting idle. So
>> the action is exiting. In this context we can't accept to start
>> injecting idle cycles.
> 
> Right and that's why I said "Which is fine" in my comment above. My
> question was more on why we error out in idle_injection_start() if
> run_duration_ms is 0.
> 
> Just for my understanding, is it a valid usecase where we want to run
> the idle loop only once ? i.e. set idle_duration_ms to a non-zero
> value but run_duration_ms to 0 ? In that case we shouldn't check for
> zero run_duration_ms in idle_injection_start().

Yes, that could be a valid use case if we want to synchronously inject
idle cycles without period.

IOW, call play_idle() on a set of cpus at the same time. And the caller
of start is the one with the control of the period.

If you want this usecase, we need to implement more things:
 - single user of the framework: as soon as we register, no-one else can
use the idle injection
 - blocking stop, we wait for all the kthreads to join a barrier before
returning to the caller
 - blocking start, we wait for all the kthreads to end injecting the
idle cycle

>>>> +	if (!run_duration_ms)
>>>> +		return;
>>>> +
>>>> +	hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
>>>> +		      HRTIMER_MODE_REL_PINNED);
>>>> +}
>>>> +
>>>> +/**
>>>> + * idle_injection_set_duration - idle and run duration helper
>>>> + * @run_duration_ms: an unsigned int giving the running time in milliseconds
>>>> + * @idle_duration_ms: an unsigned int giving the idle time in milliseconds
>>>> + */
>>>> +void idle_injection_set_duration(struct idle_injection_device *ii_dev,
>>>> +				 unsigned int run_duration_ms,
>>>> +				 unsigned int idle_duration_ms)
>>>> +{
>>>> +	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
>>>> +	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);
>>>
>>> You check for valid values of these in idle_injection_start() but not
>>> here, why ?
>>
>> By checking against a zero values in the start function is a way to make
>> sure we are not starting the idle injection with uninitialized values
>> and by setting the duration to zero is a way to stop the idle injection.
> 
> Why do we need two ways of stopping the idle injection thread ? Why
> isn't just calling idle_injection_stop() the right thing to do in that
> case ?

How do we prevent the last kthread in the idle_injection_fn to set the
timer ?

>>>> +}
>>>> +
>>>> +/**
>>>> + * idle_injection_get_duration - idle and run duration helper
>>>> + * @run_duration_ms: a pointer to an unsigned int to store the running time
>>>> + * @idle_duration_ms: a pointer to an unsigned int to store the idle time
>>>> + */
>>>> +void idle_injection_get_duration(struct idle_injection_device *ii_dev,
>>>> +				 unsigned int *run_duration_ms,
>>>> +				 unsigned int *idle_duration_ms)
>>>> +{
>>>> +	*run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
>>>> +	*idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
>>>> +}
>>>> +
>>>> +/**
>>>> + * idle_injection_start - starts the idle injections
>>>> + * @ii_dev: a pointer to an idle_injection_device structure
>>>> + *
>>>> + * The function starts the idle injection cycles by first waking up
>>>> + * all the tasks the ii_dev is attached to and let them handle the
>>>> + * idle-run periods.
>>>> + *
>>>> + * Return: -EINVAL if the idle or the running durations are not set.
>>>> + */
>>>> +int idle_injection_start(struct idle_injection_device *ii_dev)
>>>> +{
>>>> +	if (!atomic_read(&ii_dev->idle_duration_ms))
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (!atomic_read(&ii_dev->run_duration_ms))
>>>> +		return -EINVAL;
>>>> +
> 
> So according to above comments from me, I am saying that this
> particular test isn't really required as we may want to run idle loop
> only once.

Note that will be the same than calling play_idle() synchronously.

>>>> +	pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
>>>> +		 cpumask_pr_args(ii_dev->cpumask));
>>>> +
>>>> +	idle_injection_wakeup(ii_dev);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * idle_injection_stop - stops the idle injections
>>>> + * @ii_dev: a pointer to an idle injection_device structure
>>>> + *
>>>> + * The function stops the idle injection by canceling the timer in
>>>> + * charge of waking up the tasks to inject idle and unset the idle and
>>>> + * running durations.
>>>> + */
>>>> +void idle_injection_stop(struct idle_injection_device *ii_dev)
>>>> +{
>>>> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
>>>> +		 cpumask_pr_args(ii_dev->cpumask));
>>>> +
>>>> +	hrtimer_cancel(&ii_dev->timer);
>>>
>>> How are we sure that idle_injection_fn() isn't running at this point
>>> and it would start the timer cancelled here again ?
>>
>> Nothing will ensure that. We will have an extra idle injection in this
>> case. We can invert the set_duration(0,0) and the timer cancellation to
>> reduce to reduce the window.
> 
> That's what I thought and so its racy. If someone calls
> idle_injection_unregister(), then we call this routine and then free
> the data structures while they are still getting used by the thread :(

Yes, we need to make the framework single-user, a refcount should be
enough. However, register() returns a pointer and the caller of
unregister must have this pointer. If it is the case, then register and
unregister code collaborate, if the one calling unregister cuts the
branch of the user of the idle_injection then we have braindead code.

We can handle this case by adding locks or we can have a single-user of
the framework without lock. We don't expect a lot of idle injection
users (I see only two right now and they are mutually exclusive), so
having lockless code is ok for me.


>>>> +
>>>> +	idle_injection_set_duration(ii_dev, 0, 0);
>>>
>>> And why exactly this this required ? Why shouldn't we allow this
>>> sequence to work:
>>>
>>> idle_injection_set_duration()
>>> idle_injection_start()
>>> idle_injection_stop()
>>> idle_injection_start()
>>> idle_injection_stop()
>>> idle_injection_start()
>>> idle_injection_stop()
>>
>> Sorry, I don't get it.
>>
>> Who will decide to start() and stop() ?
> 
> Some confusion here about the usecase then. How do you see this stuff
> getting used and how users (cooling-driver ?) will use it ?

The cooling device computes the duration and sets it every time
set_cur_state is called.

when the mitigation begins (prev state = 0 and cur state > 0), it starts
the threads.

When the mitigation ends (prev_state > 0 and cur_state = 0), it calls stop()

In between, set_duration is called via set_cur_state to vary the
mitigation effect.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
