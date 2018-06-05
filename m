Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeFEFO3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:14:29 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38497 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbeFEFO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:14:26 -0400
X-Google-Smtp-Source: ADUXVKJIivwpWBsx3vzj7ggLl9AV85Tce4Sqgspj7KglguHowVpcmM8R++tk8K6hg88RQvWxvGemNg==
Date: Tue, 5 Jun 2018 10:44:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: Re: [PATCH V4] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180605051421.xbpkupxem5movm57@vireshk-i7>
References: <1527241792-5860-1-git-send-email-daniel.lezcano@linaro.org>
 <20180529093148.b2cxb5lwks7ka2tn@vireshk-i7>
 <c7c4143d-77c4-a41b-b770-e5c38e346320@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7c4143d-77c4-a41b-b770-e5c38e346320@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-18, 20:25, Daniel Lezcano wrote:
> On 29/05/2018 11:31, Viresh Kumar wrote:
> > On 25-05-18, 11:49, Daniel Lezcano wrote:
> >> +	/*
> >> +	 * The last CPU waking up is in charge of setting the timer. If
> >> +	 * the CPU is hotplugged, the timer will move to another CPU
> >> +	 * (which may not belong to the same cluster) but that is not a
> >> +	 * problem as the timer will be set again by another CPU
> >> +	 * belonging to the cluster. This mechanism is self adaptive.
> >> +	 */
> > 
> > I am afraid that the above comment may not be completely true all the
> > time. For a quad-core platform, it is possible for 3 CPUs (0,1,2) to
> > run this function as soon as the kthread is woken up, but one of the
> > CPUs (3) may be stuck servicing an IRQ, Deadline or RT activity.
> > Because you do atomic_inc() also in this function (above) itself,
> > below decrement may return a true value for the CPU2 and that will
> > restart the hrtimer, while one of the CPUs never got a chance to
> > increment count in the first place.
> >
> > The fix is simple though, do the increment in idle_injection_wakeup()
> > and things should be fine then.
> 
> Ok.
> 
> >> +	if (!atomic_dec_and_test(&ii_dev->count))
> >> +		return;
> >> +
> >> +	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
> >> +	if (run_duration_ms) {
> >> +		hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
> >> +			      HRTIMER_MODE_REL_PINNED);
> >> +		return;
> >> +	}
> >> +
> >> +	complete(&ii_dev->stop_complete);
> > 
> > So you call complete() after hrtimer is potentially restarted. This
> > can happen if idle_injection_stop() is called right after the above
> > atomic_read() has finished :)
> > 
> > IOW, this doesn't look safe now as well.
> 
> It is safe, we just missed a cycle and the stop will block until the
> next cycle. I did it on purpose and for me it is correct.

Okay, what about this then:

Path A                                         Path B

idle_injection_fn()                            idle_injection_unregister()
  hrtimer_start()                                idle_injection_stop()

  complete()

                                                   wait_for_completion()
                                                 kfree(ii_dev);
  
  Hrtimer is still used here after
  getting freed.


Is this not possible ?

> >> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
> >> +{
> >> +	struct idle_injection_device *ii_dev;
> >> +	int cpu, cpu2;
> >> +
> >> +	ii_dev = ii_dev_alloc();
> >> +	if (!ii_dev)
> >> +		return NULL;
> >> +
> >> +	cpumask_copy(ii_dev->cpumask, cpumask);
> >> +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >> +	ii_dev->timer.function = idle_injection_wakeup_fn;
> >> +
> >> +	for_each_cpu(cpu, ii_dev->cpumask) {
> >> +
> >> +		if (per_cpu(idle_injection_device, cpu)) {
> > 
> > Maybe add unlikely here ?
> 
> For this kind of init function and tight loop, there is no benefit of
> adding the unlikely / likely. I can add it if you want, but it is useless.

Okay.

> >> +			pr_err("cpu%d is already registered\n", cpu);
> >> +			goto out_rollback_per_cpu;
> >> +		}
> >> +
> >> +		per_cpu(idle_injection_device, cpu) = ii_dev;
> >> +	}
> >> +
> >> +	return ii_dev;
> >> +
> >> +out_rollback_per_cpu:
> >> +	for_each_cpu(cpu2, ii_dev->cpumask) {
> >> +		if (cpu == cpu2)
> > 
> > And is this really required? Perhaps this conditional is making it
> > worse and just setting the per-cpu variable forcefully to NULL would
> > be much faster :)
> 
> We want undo what was done, setting all variables to NULL resets the
> values from a previous register and we don't want that.

Why will that happen ? We are only iterating over a particular cpumask and not
all possible CPUs. Yes I understand the "undo only what we did" part, but the
conditional is more expensive than that I feel.

-- 
viresh
