Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeBWP1S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:27:18 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35251 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeBWP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:27:17 -0500
X-Google-Smtp-Source: AG47ELtAmiwl58HNXpQAEcImZ+Av9NF5MzIxX+WQq0F1bWFyTIEVRmCp3nniOVmXz+AbhRaj1ynpwJmGNEn2hRR331o=
MIME-Version: 1.0
In-Reply-To: <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org> <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 23 Feb 2018 16:26:55 +0100
Message-ID: <CAKfTPtBZqcFcy9W8ss7vZsXPRzb7KPM0W2M7icnxMPTAq+UkPQ@mail.gmail.com>
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Kevin Wangtao <kevin.wangtao@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 21 February 2018 at 16:29, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> +
> +/**
> + * struct cpuidle_cooling_device - data for the idle cooling device
> + * @cdev: a pointer to a struct thermal_cooling_device
> + * @cpumask: a cpumask containing the CPU managed by the cooling device
> + * @timer: a hrtimer giving the tempo for the idle injection cycles
> + * @kref: a kernel refcount on this structure
> + * @count: an atomic to keep track of the last task exiting the idle cycle
> + * @idle_cycle: an integer defining the duration of the idle injection
> + * @state: an normalized integer giving the state of the cooling device
> + */
> +struct cpuidle_cooling_device {
> +       struct thermal_cooling_device *cdev;
> +       struct cpumask *cpumask;
> +       struct list_head node;
> +       struct hrtimer timer;
> +       struct kref kref;
> +       atomic_t count;
> +       unsigned int idle_cycle;
> +       unsigned int state;
> +};
> +
> +/**
> + * @tsk: an array of pointer to the idle injection tasks
> + * @waitq: the waiq for the idle injection tasks
> + */
> +struct cpuidle_cooling_tsk {
> +       struct task_struct *tsk;
> +       wait_queue_head_t waitq;

Why are you creating one wait_queue_head_t per cpu instead of one per
cooling device and then save a pointer in the per cpu struct
cpuidle_cooling_tsk ?
Then, you can use wake_up_interruptible_all() to wake up all threads
instead of using for_each_cpu ... wake_up_process() loop in
cpuidle_cooling_wakeup() ?

> +};
> +
> +DEFINE_PER_CPU(struct cpuidle_cooling_tsk, cpuidle_cooling_tsk);
> +
> +static LIST_HEAD(cpuidle_cdev_list);
> +
> +/**
> + * cpuidle_cooling_wakeup - Wake up all idle injection threads
> + * @idle_cdev: the idle cooling device
> + *
> + * Every idle injection task belonging to the idle cooling device and
> + * running on an online cpu will be wake up by this call.
> + */
> +static void cpuidle_cooling_wakeup(struct cpuidle_cooling_device *idle_cdev)
> +{
> +       int cpu;
> +       struct cpuidle_cooling_tsk *cct;
> +
> +       for_each_cpu_and(cpu, idle_cdev->cpumask, cpu_online_mask) {
> +               cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
> +               wake_up_process(cct->tsk);
> +       }
> +}
> +
> +/**
> + * cpuidle_cooling_wakeup_fn - Running cycle timer callback
> + * @timer: a hrtimer structure
> + *
> + * When the mitigation is acting, the CPU is allowed to run an amount
> + * of time, then the idle injection happens for the specified delay
> + * and the idle task injection schedules itself until the timer event
> + * wakes the idle injection tasks again for a new idle injection
> + * cycle. The time between the end of the idle injection and the timer
> + * expiration is the allocated running time for the CPU.
> + *
> + * Returns always HRTIMER_NORESTART
> + */
> +static enum hrtimer_restart cpuidle_cooling_wakeup_fn(struct hrtimer *timer)
> +{
> +       struct cpuidle_cooling_device *idle_cdev =
> +               container_of(timer, struct cpuidle_cooling_device, timer);
> +
> +       cpuidle_cooling_wakeup(idle_cdev);
> +
> +       return HRTIMER_NORESTART;
> +}
> +
> +/**
