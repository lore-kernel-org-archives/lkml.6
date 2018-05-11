Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeEKGMA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 02:12:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:38111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbeEKGL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 02:11:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,387,1520924400";
   d="scan'208";a="38476307"
Date: Fri, 11 May 2018 14:11:22 +0800
From: kbuild test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kbuild-all@01.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: Re: [PATCH] powercap/drivers/idle_injection: Add an idle injection
 framework
Message-ID: <201805111348.jwOOmfVZ%fengguang.wu@intel.com>
References: <1525948458-23488-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525948458-23488-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.17-rc4 next-20180510]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Lezcano/powercap-drivers-idle_injection-Add-an-idle-injection-framework/20180511-074751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/powercap/idle_injection.c:242:36: sparse: incorrect type in initializer (different address spaces) @@    expected struct task_struct [noderef] <asn:3>**store @@    got struct task_struct [noderef] <asn:3>**store @@
   drivers/powercap/idle_injection.c:242:36:    expected struct task_struct [noderef] <asn:3>**store
   drivers/powercap/idle_injection.c:242:36:    got struct task_struct *[noderef] <asn:3>*<noident>

vim +242 drivers/powercap/idle_injection.c

   138	
   139	/**
   140	 * idle_injection_set_duration - idle and run duration helper
   141	 * @run_duration_ms: an unsigned int giving the running time in milliseconds
   142	 * @idle_duration_ms: an unsigned int giving the idle time in milliseconds
   143	 */
 > 144	void idle_injection_set_duration(struct idle_injection_device *ii_dev,
   145					 unsigned int run_duration_ms,
   146					 unsigned int idle_duration_ms)
   147	{
   148		atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
   149		atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);
   150	}
   151	
   152	
   153	/**
   154	 * idle_injection_get_duration - idle and run duration helper
   155	 * @run_duration_ms: a pointer to an unsigned int to store the running time
   156	 * @idle_duration_ms: a pointer to an unsigned int to store the idle time
   157	 */
   158	void idle_injection_get_duration(struct idle_injection_device *ii_dev,
   159					 unsigned int *run_duration_ms,
   160					 unsigned int *idle_duration_ms)
   161	{
   162		*run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
   163		*idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
   164	}
   165	
   166	/**
   167	 * idle_injection_start - starts the idle injections
   168	 * @ii_dev: a pointer to an idle_injection_device structure
   169	 *
   170	 * The function starts the idle injection cycles by first waking up
   171	 * all the tasks the ii_dev is attached to and let them handle the
   172	 * idle-run periods
   173	 *
   174	 * Returns -EINVAL if the idle or the running duration are not set
   175	 */
   176	int idle_injection_start(struct idle_injection_device *ii_dev)
   177	{
   178		if (!atomic_read(&ii_dev->idle_duration_ms))
   179			return -EINVAL;
   180	
   181		if (!atomic_read(&ii_dev->run_duration_ms))
   182			return -EINVAL;
   183	
   184		pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
   185			 cpumask_pr_args(ii_dev->smp_hotplug_thread->cpumask));
   186	
   187		idle_injection_wakeup(ii_dev);
   188	
   189		return 0;
   190	}
   191	
   192	/**
   193	 * idle_injection_stop - stops the idle injections
   194	 * @ii_dev: a pointer to an idle injection_device structure
   195	 *
   196	 * The function stops the idle injection by canceling the timer in
   197	 * charge of waking up the tasks to inject idle and unset the idle and
   198	 * running durations.
   199	 */
   200	void idle_injection_stop(struct idle_injection_device *ii_dev)
   201	{
   202		pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
   203			 cpumask_pr_args(ii_dev->smp_hotplug_thread->cpumask));
   204	
   205		hrtimer_cancel(&ii_dev->timer);
   206	
   207		idle_injection_set_duration(ii_dev, 0, 0);
   208	}
   209	
   210	/**
   211	 * idle_injection_setup - initialize the current task as a RT task
   212	 * @cpu: the CPU number where the kthread is running on (not used)
   213	 *
   214	 */
   215	static void idle_injection_setup(unsigned int cpu)
   216	{
   217		struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO/2 };
   218	
   219		set_freezable();
   220	
   221		sched_setscheduler(current, SCHED_FIFO, &param);
   222	}
   223	
   224	/**
   225	 * idle_injection_should_run - function helper for the smpboot API
   226	 * @cpu: the CPU number where the kthread is running on
   227	 *
   228	 * Returns the boolean telling if the thread can run
   229	 */
   230	static int idle_injection_should_run(unsigned int cpu)
   231	{
   232		struct idle_injection_thread *iit =
   233			per_cpu_ptr(&idle_injection_thread, cpu);
   234	
   235		return iit->should_run;
   236	}
   237	
   238	/*
   239	 * idle_injection_threads - smp hotplug threads ops
   240	 */
   241	static struct smp_hotplug_thread idle_injection_threads = {
 > 242		.store                  = &idle_injection_thread.tsk,
   243		.thread_fn              = idle_injection_fn,
   244		.thread_should_run	= idle_injection_should_run,
   245		.setup                  = idle_injection_setup,
   246	};
   247	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
