Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeEKLzr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:55:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36466 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKLzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:55:45 -0400
X-Google-Smtp-Source: AB8JxZoIM6h8P9w82BmNZuXwaKh7IIhWQoLp7mI94qj8qGVPqzeNhiIgYgG/MPhUsdGpdmM6fi3YXA==
Date: Fri, 11 May 2018 13:55:39 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: Re: [PATCH V2] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180511115539.GC29062@mai>
References: <1525948458-23488-1-git-send-email-daniel.lezcano@linaro.org>
 <1525955163-14556-1-git-send-email-daniel.lezcano@linaro.org>
 <20180511093221.z5jfv4bo5kcdrzp4@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180511093221.z5jfv4bo5kcdrzp4@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 03:02:21PM +0530, viresh kumar wrote:
> On 10-05-18, 14:26, Daniel Lezcano wrote:
> > Initially, the cpu_cooling device for ARM was changed by adding a new
> > policy inserting idle cycles. The intel_powerclamp driver does a
> > similar action.
> > 
> > Instead of implementing idle injections privately in the cpu_cooling
> > device, move the idle injection code in a dedicated framework and give
> > the opportunity to other frameworks to make use of it.
> 
> Maybe move the above explanation in the comments section below, as it
> doesn't belong to the commit log really.

Yes that makes sense.
 
[ ... ]

> > diff --git a/drivers/powercap/idle_injection.c b/drivers/powercap/idle_injection.c
> > new file mode 100644
> > index 0000000..825ffac
> > --- /dev/null
> > +++ b/drivers/powercap/idle_injection.c
> > @@ -0,0 +1,331 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * drivers/powercap/idle_injection.c
> > + *
> 
> What's the purpose of this particular line ? Yeah, I have seen it
> quite a number of times and might have added that myself as well
> somewhere :)

I think it is a hundredth monkey effect :)
 
[ ... ]

> > +	/*
> > +	 * Boolean used by the smpboot mainloop and used as a flip-flop
> 
> s/mainloop/main loop/ ?
> 
> > +	 * in this function
> > +	 */
> > +	iit->should_run = 0;
> 
> What is the purpose of this field ? Just wanted to check on how
> smpboot stuff uses it.

This field is used as a boolean for the smpboot main loop.

You should look at the function smpboot_thread_fn().

The function idle_injection_thread_fn() idle is called every idle injection
period, sets a timer for the next idle injection deadline and tells the
smpboot main loop to schedule. The way to tell the smpboot main loop to
schedule and not call the idle_injection_thread_fn() again is by setting this
boolean to false.

static int smpboot_thread_fn(void *data)
{
	while (1) {

		[ ... ]

		if (!ht->thread_should_run(td->cpu)) {
			preempt_enable_no_resched();
			schedule();
		} else {
			__set_current_state(TASK_RUNNING);
			preempt_enable();
			ht->thread_fn(td->cpu);
		}

		[ ... ]
	}
}

[ ... ]

> > + */
> > +void idle_injection_set_duration(struct idle_injection_device *ii_dev,
> > +				 unsigned int run_duration_ms,
> > +				 unsigned int idle_duration_ms)
> > +{
> > +	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
> > +	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);
> > +}
> > +
> > +
> 
> Two blank lines here ?

Ah, yes.

[ ... ]

> > +int idle_injection_start(struct idle_injection_device *ii_dev)
> > +{
> > +	if (!atomic_read(&ii_dev->idle_duration_ms))
> > +		return -EINVAL;
> > +
> > +	if (!atomic_read(&ii_dev->run_duration_ms))
> > +		return -EINVAL;
> 
> You are required to have them as atomic variables to take care of the
> races while they are set ? 

The race is when you change the values, while the idle injection is acting and
you read those values in the idle injection thread function.

> What about getting the durations as arguments to this routine then ?

May be I missed your point but I don't think that will change the above.
 
[ ... ]

> > +/*
> > + * idle_injection_threads - smp hotplug threads ops
> > + */
> > +static struct smp_hotplug_thread idle_injection_threads = {
> > +	.store                  = &idle_injection_thread.tsk,
> > +	.thread_fn              = idle_injection_fn,
> > +	.thread_should_run	= idle_injection_should_run,
> > +	.setup                  = idle_injection_setup,
> > +};
> 
> Why should we keep this structure at all and not have these four
> assignments in the below routine itself ? It is unnecessarily copying
> a bigger structure while it is required to copy only a part of it. And
> then we keep wasting memory for this particular instance without any
> use.

With your comment below about registering the smpboot threads with a cpumask, a
single structure should be used, I will fix this.

> > +
> > +/**
> > + * idle_injection_register - idle injection init routine
> > + * @cpumask: the list of CPUs to run the kthreads
> > + * @name: the threads command name
> > + *
> > + * This is the initialization function in charge of creating the
> > + * kthreads, initializing the timer and allocate the structures.  It
> > + * does not starts the idle injection cycles
> 
> Forgot full stop (.). Please check that across file

Oops, right. I rememeber you did a similar comment on the previous version.

> > + *
> > + * Returns -ENOMEM if an allocation fails, or < 0 if the smpboot
> 
> It should be Return:

Ok.
 
> > + * kthread registering fails.
> > + */
> > +struct idle_injection_device *
> > +idle_injection_register(struct cpumask *cpumask, const char *name)
> > +{
> > +	struct idle_injection_device *ii_dev;
> > +	struct smp_hotplug_thread *smp_hotplug_thread;
> > +	char *idle_injection_comm;
> > +	int cpu, ret;
> > +
> > +	ret = -ENOMEM;
> 
> Maybe merge it earlier only ?

What do you mean ? int ret = -ENOMEM ?

> > +
> > +	idle_injection_comm = kasprintf(GFP_KERNEL, "%s/%%u", name);
> > +	if (!idle_injection_comm)
> > +		goto out;
> > +
> > +	smp_hotplug_thread = kmemdup(&idle_injection_threads,
> > +				     sizeof(*smp_hotplug_thread),
> > +				     GFP_KERNEL);
> > +	if (!smp_hotplug_thread)
> > +		goto out_free_thread_comm;
> > +
> > +	smp_hotplug_thread->thread_comm	= idle_injection_comm;
> > +
> > +	ii_dev = kzalloc(sizeof(*ii_dev),
> > +					GFP_KERNEL);
> 
> Accidental line break ?

grumf ...

> > +	if (!ii_dev)
> > +		goto out_free_smp_hotplug;
> > +
> > +	ii_dev->smp_hotplug_thread = smp_hotplug_thread;
> > +
> > +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +
> > +	ii_dev->timer.function = idle_injection_wakeup_fn;
> > +
> > +	for_each_cpu(cpu, cpumask)
> > +		per_cpu(idle_injection_device, cpu) = ii_dev;
> > +
> > +	ret = smpboot_register_percpu_thread_cpumask(smp_hotplug_thread,
> > +						     cpumask);
> 
> This creates the thread for all online CPUs and unparks only the one
> in the cpumask. I am not sure how the smpboot stuff works, but this
> looks somewhat wrong to me, we may end up creating multiple threads
> per CPU even if this function is called twice for non-intersecting cpu
> masks.

Good point! That must be fixed, calling idle_injection_register()
one time and idle_injection_start() with a cpumask would be more convenient.

> > +	if (ret)
> > +		goto out_free_idle_inject;
> > +
> > +	return ii_dev;
> > +
> > +out_free_idle_inject:
> > +	kfree(ii_dev);
> 
> What about resetting per-cpu idle_injection_device ? You missed the
> same in unregister routine below as well ?

Ok.

> > +out_free_smp_hotplug:
> > +	kfree(smp_hotplug_thread);
> > +out_free_thread_comm:
> > +	kfree(idle_injection_comm);
> > +out:
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +/**
> > + * idle_injection_unregister - Unregister the idle injection device
> > + * @ii_dev: a pointer to an idle injection device
> > + *
> > + * The function is in charge of stopping the idle injections,
> > + * unregister the kthreads and free the allocated memory in the
> > + * register function.
> > + */
> > +void idle_injection_unregister(struct idle_injection_device *ii_dev)
> > +{
> > +	struct smp_hotplug_thread *smp_hotplug_thread;
> > +
> > +	idle_injection_stop(ii_dev);
> > +	smp_hotplug_thread = ii_dev->smp_hotplug_thread;
> > +	smpboot_unregister_percpu_thread(smp_hotplug_thread);
> > +	kfree(smp_hotplug_thread->thread_comm);
> > +	kfree(smp_hotplug_thread);
> > +	kfree(ii_dev);
> 
> Ideally it is much more readable if the ordering here is exactly
> opposite of how things are done in registration time. You may need to
> change the order in which things are allocated, and that would be
> worth it :)

Ok.

> > +}
> > diff --git a/include/linux/idle_injection.h b/include/linux/idle_injection.h
> > new file mode 100644
> > index 0000000..084b999
> > --- /dev/null
> > +++ b/include/linux/idle_injection.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2018 Linaro Ltd
> > + *
> > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > + *
> > + */
> > +#ifndef __IDLE_INJECTION_H__
> > +#define __IDLE_INJECTION_H__
> > +
> > +/* private idle injection device structure */
> > +struct idle_injection_device;
> > +
> > +/**
> > + * idle_injection_register - allocates and initializes an idle_injection_device
> > + * @cpumask: all CPUs with a idle injection kthreads
> > + * @name: a const string giving the kthread name
> > + *
> > + * Returns a pointer to a idle_injection_device, ERR_PTR otherwise.
> 
> This needs to be written as "Return: XXXX.", else it wouldn't get
> documented properly in kernel doc.
> 
> And I am wondering on why you have added all these kernel doc comments
> in the .h file ? What will kernel doc look like as we will have to doc
> comments for the same function ? Maybe try generating the doc and you
> will see how it looks.

Hmm, right. I will remove the documentation in the header.

Thanks for the review.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
