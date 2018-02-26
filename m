Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeBZEa1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 23:30:27 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:40446 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeBZEaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 23:30:24 -0500
X-Google-Smtp-Source: AG47ELvUoMw03ttme9CNOdCGnEZ6KsXLZOCU7xOhCFgfrif/1wMTNhIEho6Xkp6TJEJ6uviUi/WMXA==
Date: Mon, 26 Feb 2018 10:00:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180226043021.GK26947@vireshk-i7>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
 <20180223073432.GF26947@vireshk-i7>
 <faaf027c-e01c-6801-9a0c-ab7e0ba669a1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faaf027c-e01c-6801-9a0c-ab7e0ba669a1@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-18, 12:28, Daniel Lezcano wrote:
> On 23/02/2018 08:34, Viresh Kumar wrote:
> > On 21-02-18, 16:29, Daniel Lezcano wrote:
> >> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> >> index 5c219dc..9340216 100644
> >> --- a/drivers/thermal/cpu_cooling.c
> >> +++ b/drivers/thermal/cpu_cooling.c
> >> @@ -10,18 +10,32 @@
> >>   *		Viresh Kumar <viresh.kumar@linaro.org>
> >>   *
> >>   */
> >> +#undef DEBUG
> > 
> > Why is this required ?
> 
> It is usually added, so if you set the -DDEBUG flag when compiling, you
> don't get all the pr_debug traces for all files, but the just the ones
> where you commented the #undef above. pr_debug is a no-op otherwise.

Yeah, but this is a mess as you need to go edit the files before
enabling debug with it. Everyone prefers the dynamic debug thing now,
where we don't need such stuff. Just drop it.

> >> +#define pr_fmt(fmt) "CPU cooling: " fmt
> > 
> > I think you can use the dev_***() routines instead, as you can
> > directly the CPU device from anywhere.
> 
> Can we postpone this change for later ? All the file is using pr_*
> (cpufreq_cooling included). There is only one place where dev_err is
> used but it is removed by the patch 3/7.

okay.

> >> +	while (1) {
> >> +		s64 next_wakeup;
> >> +
> >> +		prepare_to_wait(&cct->waitq, &wait, TASK_INTERRUPTIBLE);
> >> +
> >> +		schedule();
> >> +
> >> +		atomic_inc(&idle_cdev->count);
> >> +
> >> +		play_idle(idle_cdev->idle_cycle / USEC_PER_MSEC);
> >> +
> >> +		/*
> >> +		 * The last CPU waking up is in charge of setting the
> >> +		 * timer. If the CPU is hotplugged, the timer will
> >> +		 * move to another CPU (which may not belong to the
> >> +		 * same cluster) but that is not a problem as the
> >> +		 * timer will be set again by another CPU belonging to
> >> +		 * the cluster, so this mechanism is self adaptive and
> >> +		 * does not require any hotplugging dance.
> >> +		 */
> > 
> > Well this depends on how CPU hotplug really happens. What happens to
> > the per-cpu-tasks which are in the middle of something when hotplug
> > happens?  Does hotplug wait for those per-cpu-tasks to finish ?

Missed this one ?

> >> +int cpuidle_cooling_register(void)
> >> +{
> >> +	struct cpuidle_cooling_device *idle_cdev = NULL;
> >> +	struct thermal_cooling_device *cdev;
> >> +	struct cpuidle_cooling_tsk *cct;
> >> +	struct task_struct *tsk;
> >> +	struct device_node *np;
> >> +	cpumask_t *cpumask;
> >> +	char dev_name[THERMAL_NAME_LENGTH];
> >> +	int ret = -ENOMEM, cpu;
> >> +	int index = 0;
> >> +
> >> +	for_each_possible_cpu(cpu) {
> >> +		cpumask = topology_core_cpumask(cpu);
> >> +
> >> +		cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
> >> +
> >> +		/*
> >> +		 * This condition makes the first cpu belonging to the
> >> +		 * cluster to create a cooling device and allocates
> >> +		 * the structure. Others CPUs belonging to the same
> >> +		 * cluster will just increment the refcount on the
> >> +		 * cooling device structure and initialize it.
> >> +		 */
> >> +		if (cpu == cpumask_first(cpumask)) {
> > 
> > Your function still have few assumptions of cpu numbering and it will
> > break in few cases. What if the CPUs on a big Little system (4x4) are
> > present in this order: B L L L L B B B  ??
> > 
> > This configuration can happen if CPUs in DT are marked as: 0-3 LITTLE,
> > 4-7 big and a big CPU is used by the boot loader to bring up Linux.
> 
> Ok, how can I sort it out ?

I would do something like this:

        cpumask_copy(possible, cpu_possible_mask);
        
        while (!cpumask_empty(possible)) {
                first = cpumask_first(possible);
                cpumask = topology_core_cpumask(first);
                cpumask_andnot(possible, possible, cpumask);
        
                allocate_cooling_dev(first); //This is most of this function in your patch.
        
                while (!cpumask_empty(cpumask)) {
                        temp = cpumask_first(possible);
                        //rest init "temp"
                        cpumask_clear_cpu(temp, cpumask);
                }
        
                //Everything done, register cooling device for cpumask.
        }

> >> +			np = of_cpu_device_node_get(cpu);
> >> +
> >> +			idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
> >> +			if (!idle_cdev)
> >> +				goto out_fail;
> >> +
> >> +			idle_cdev->idle_cycle = DEFAULT_IDLE_TIME_US;
> >> +
> >> +			atomic_set(&idle_cdev->count, 0);
> > 
> > This should already be 0, isn't it ?
> 
> Yes.

I read it as, "I will drop it" :)

-- 
viresh
