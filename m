Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeFEKjX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:39:23 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41072 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbeFEKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:39:21 -0400
X-Google-Smtp-Source: ADUXVKLgfXMtDCZ4zLM7tWSoKUIBhLRmNcObTnhVpzX1wCr8ETdkgHw+LTihz2TgPjMXMhVhszL+rg==
Date: Tue, 5 Jun 2018 16:09:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-18, 11:16, Daniel Lezcano wrote:
> diff --git a/drivers/powercap/idle_injection.c b/drivers/powercap/idle_injection.c
> +/**
> + * idle_injection_wakeup - Wake up all idle injection threads
> + * @ii_dev: the idle injection device
> + *
> + * Every idle injection task belonging to the idle injection device
> + * and running on an online CPU will be wake up by this call.
> + */
> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
> +{
> +	struct idle_injection_thread *iit;
> +	int cpu;
> +
> +	for_each_cpu_and(cpu, ii_dev->cpumask, cpu_online_mask) {
> +		atomic_inc(&ii_dev->count);

This may not be sufficient enough in some extremely corner cases, as it is
possible that the idle_injection_fn() starts running for the first cpu in the
cpumask right after first iteration of this loop completes. And so
atomic_dec_and_test() may return true there before idle_injection_fn() task gets
a chance to run on all cpus in the cpumask. Normally this wouldn't be a big
problem as the hrtimer can get reprogrammed in that case, but there is a case I
am worried about. More on this later..

> +		iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +		iit->should_run = 1;
> +		wake_up_process(iit->tsk);
> +	}
> +}
> +
> +/**
> + * idle_injection_wakeup_fn - idle injection timer callback
> + * @timer: a hrtimer structure
> + *
> + * This function is called when the idle injection timer expires which
> + * will wake up the idle injection tasks and these ones, in turn, play
> + * idle a specified amount of time.
> + *
> + * Return: HRTIMER_NORESTART.
> + */
> +static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer *timer)
> +{
> +	struct idle_injection_device *ii_dev =
> +		container_of(timer, struct idle_injection_device, timer);
> +
> +	idle_injection_wakeup(ii_dev);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +/**
> + * idle_injection_fn - idle injection routine
> + * @cpu: the CPU number the tasks belongs to
> + *
> + * The idle injection routine will stay idle the specified amount of
> + * time
> + */
> +static void idle_injection_fn(unsigned int cpu)
> +{
> +	struct idle_injection_device *ii_dev;
> +	struct idle_injection_thread *iit;
> +	int run_duration_ms, idle_duration_ms;
> +
> +	ii_dev = per_cpu(idle_injection_device, cpu);
> +	iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +
> +	/*
> +	 * Boolean used by the smpboot main loop and used as a
> +	 * flip-flop in this function
> +	 */
> +	iit->should_run = 0;
> +
> +	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
> +	if (idle_duration_ms)
> +		play_idle(idle_duration_ms);
> +
> +	/*
> +	 * The last CPU waking up is in charge of setting the timer. If
> +	 * the CPU is hotplugged, the timer will move to another CPU
> +	 * (which may not belong to the same cluster) but that is not a
> +	 * problem as the timer will be set again by another CPU
> +	 * belonging to the cluster. This mechanism is self adaptive.
> +	 */
> +	if (!atomic_dec_and_test(&ii_dev->count))
> +		return;
> +
> +	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
> +	if (run_duration_ms) {
> +		hrtimer_start(&ii_dev->timer, ms_to_ktime(run_duration_ms),
> +			      HRTIMER_MODE_REL_PINNED);
> +		return;
> +	}
> +
> +	complete(&ii_dev->stop_complete);
> +}

Here is the corner case I was talking about. Consider the cpumask contains
CPU0/1/2/3.

PATH A                                                  PATH B

                                                        unregister()
                                                          -> idle_injection_stop()

idle_injection_wakeup()
  -> Running loop for CPU0
  -> atomic inc (count == 1)
  -> wake_up_process(tsk)
  -> At this point the current task stops
  running and idle_injection_fn() starts running
  (maybe on a different CPU)

                                                        


idle_injection_fn()
  -> atomic_dec_and_test(), returns true
  as count == 0


                                                             -> set-duration to 0
                                                             -> wait for completion


  -> atomic_read(run_duration), returns 0
  -> complete()

                                                             -> kfree(ii_dev);   


But the initial loop idle_injection_wakeup() has only run for CPU0 until now and
will continue running for other CPUs and will crash as ii_dev is already freed.

Am I still making a mistake here ?

> +static struct idle_injection_device *ii_dev_alloc(void)
> +{
> +	struct idle_injection_device *ii_dev;
> +
> +	ii_dev = kzalloc(sizeof(*ii_dev), GFP_KERNEL);
> +	if (!ii_dev)
> +		return NULL;
> +
> +	if (!alloc_cpumask_var(&ii_dev->cpumask, GFP_KERNEL)) {
> +		kfree(ii_dev);
> +		return NULL;
> +	}
> +
> +	return ii_dev;
> +}
> +
> +static void ii_dev_free(struct idle_injection_device *ii_dev)
> +{
> +	free_cpumask_var(ii_dev->cpumask);
> +	kfree(ii_dev);
> +}
> +
> +/**
> + * idle_injection_register - idle injection init routine
> + * @cpumask: the list of CPUs managed by the idle injection device
> + *
> + * This is the initialization function in charge of creating the
> + * initializing of the timer and allocate the structures. It does not
> + * starts the idle injection cycles.
> + *
> + * Return: NULL if an allocation fails.
> + */
> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
> +{
> +	struct idle_injection_device *ii_dev;
> +	int cpu;
> +
> +	ii_dev = ii_dev_alloc();
> +	if (!ii_dev)
> +		return NULL;
> +
> +	cpumask_copy(ii_dev->cpumask, cpumask);
> +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ii_dev->timer.function = idle_injection_wakeup_fn;
> +	init_completion(&ii_dev->stop_complete);
> +
> +	for_each_cpu(cpu, ii_dev->cpumask) {
> +
> +		if (per_cpu(idle_injection_device, cpu)) {
> +			pr_err("cpu%d is already registered\n", cpu);
> +			goto out_rollback_per_cpu;
> +		}
> +
> +		per_cpu(idle_injection_device, cpu) = ii_dev;
> +	}
> +
> +	return ii_dev;
> +
> +out_rollback_per_cpu:
> +	for_each_cpu(cpu, ii_dev->cpumask)
> +		per_cpu(idle_injection_device, cpu) = NULL;

Maybe move above into ii_dev_free(), as I suggested earlier, as that will remove
same code from unregister routine as well.

-- 
viresh
