Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeC0DgL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 23:36:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33454 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeC0DgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 23:36:09 -0400
X-Google-Smtp-Source: AG47ELvralTWYlWmnmYJsBUNV7aUI+DiMttwkRvjomIQHgpw426OaOQ5ctj5QxcJLA31TjK5OthKtw==
Date: Tue, 27 Mar 2018 11:35:54 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180327033554.GB21693@leoy-ThinkPad-X240s>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 04:29:27PM +0100, Daniel Lezcano wrote:

[...]

> +/**
> + * cpuidle_cooling_injection_thread - Idle injection mainloop thread function
> + * @arg: a void pointer containing the idle cooling device address
> + *
> + * This main function does basically two operations:
> + *
> + * - Goes idle for a specific amount of time
> + *
> + * - Sets a timer to wake up all the idle injection threads after a
> + *   running period
> + *
> + * That happens only when the mitigation is enabled, otherwise the
> + * task is scheduled out.
> + *
> + * In order to keep the tasks synchronized together, it is the last
> + * task exiting the idle period which is in charge of setting the
> + * timer.
> + *
> + * This function never returns.
> + */
> +static int cpuidle_cooling_injection_thread(void *arg)
> +{
> +	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO/2 };

I am just wandering if should set priority to (MAX_RT_PRIO - 1)?
Otherwise I am concern it might be cannot enter deep idle state when
any CPU idle injection thread is preempted by other higher priority RT
threads so all CPUs have no alignment for idle state entering/exiting.

> +	struct cpuidle_cooling_device *idle_cdev = arg;
> +	struct cpuidle_cooling_tsk *cct = per_cpu_ptr(&cpuidle_cooling_tsk,
> +						      smp_processor_id());
> +	DEFINE_WAIT(wait);
> +
> +	set_freezable();
> +
> +	sched_setscheduler(current, SCHED_FIFO, &param);
> +
> +	while (1) {
> +		s64 next_wakeup;
> +
> +		prepare_to_wait(&cct->waitq, &wait, TASK_INTERRUPTIBLE);
> +
> +		schedule();
> +
> +		atomic_inc(&idle_cdev->count);
> +
> +		play_idle(idle_cdev->idle_cycle / USEC_PER_MSEC);
> +
> +		/*
> +		 * The last CPU waking up is in charge of setting the
> +		 * timer. If the CPU is hotplugged, the timer will
> +		 * move to another CPU (which may not belong to the
> +		 * same cluster) but that is not a problem as the
> +		 * timer will be set again by another CPU belonging to
> +		 * the cluster, so this mechanism is self adaptive and
> +		 * does not require any hotplugging dance.
> +		 */
> +		if (!atomic_dec_and_test(&idle_cdev->count))
> +			continue;
> +
> +		if (!idle_cdev->state)
> +			continue;
> +
> +		next_wakeup = cpuidle_cooling_runtime(idle_cdev);
> +
> +		hrtimer_start(&idle_cdev->timer, ns_to_ktime(next_wakeup),
> +			      HRTIMER_MODE_REL_PINNED);

If SoC temperature descreases under tipping point, will the timer be
disabled for this case?  Or will here set next timer event with big
value from next_wakeup?

[...]

Thanks,
Leo Yan
