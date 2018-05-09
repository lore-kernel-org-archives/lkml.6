Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbeEIEzb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:55:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43049 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbeEIEz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:55:29 -0400
X-Google-Smtp-Source: AB8JxZrhWHcSy47xv29vWnsEY2wRXjcxwHt7k9NOJusF2GUZST5KmnAZxykwUex9AcziR+V1TvxKMg==
Date: Wed, 9 May 2018 10:25:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
Message-ID: <20180509045527.ylf2nwolsxxcsjkq@vireshk-i7>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508073340.13114-1-dietmar.eggemann@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-05-18, 08:33, Dietmar Eggemann wrote:
> This reverts commit e2cabe48c20efb174ce0c01190f8b9c5f3ea1d13.
> 
> Lifting the restriction that the sugov kthread is bound to the
> policy->related_cpus for a system with a slow switching cpufreq driver,
> which is able to perform DVFS from any cpu (e.g. cpufreq-dt), is not
> only not beneficial it also harms Enery-Aware Scheduling (EAS) on
> systems with asymmetric cpu capacities (e.g. Arm big.LITTLE).
> 
> The sugov kthread which does the update for the little cpus could
> potentially run on a big cpu. It could prevent that the big cluster goes
> into deeper idle states although all the tasks are running on the little
> cluster.
> 
> Example: hikey960 w/ 4.16.0-rc6-+
>          Arm big.LITTLE with per-cluster DVFS
> 
> root@h960:~# cat /proc/cpuinfo | grep "^CPU part"
> CPU part        : 0xd03 (Cortex-A53, little cpu)
> CPU part        : 0xd03
> CPU part        : 0xd03
> CPU part        : 0xd03
> CPU part        : 0xd09 (Cortex-A73, big cpu)
> CPU part        : 0xd09
> CPU part        : 0xd09
> CPU part        : 0xd09
> 
> root@h960:/sys/devices/system/cpu/cpufreq# ls
> policy0  policy4  schedutil
> 
> root@h960:/sys/devices/system/cpu/cpufreq# cat policy*/related_cpus
> 0 1 2 3
> 4 5 6 7
> 
> (1) w/o the revert:
> 
> root@h960:~# ps -eo pid,class,rtprio,pri,psr,comm | awk 'NR == 1 ||
> /sugov/'
>   PID CLS RTPRIO PRI PSR COMMAND
>   1489 #6      0 140   1 sugov:0
>   1490 #6      0 140   0 sugov:4
> 
> The sugov kthread sugov:4 responsible for policy4 runs on cpu0. (In this
> case both sugov kthreads run on little cpus).
> 
> cross policy (cluster) remote callback example:
> ...
> migration/1-14 [001] enqueue_task_fair: this_cpu=1 cpu_of(rq)=5
> migration/1-14 [001] sugov_update_shared: this_cpu=1 sg_cpu->cpu=5
>                      sg_cpu->sg_policy->policy->related_cpus=4-7
>   sugov:4-1490 [000] sugov_work: this_cpu=0
>                      sg_cpu->sg_policy->policy->related_cpus=4-7
> ...
> 
> The remote callback (this_cpu=1, target_cpu=5) is executed on cpu=0.
> 
> (2) w/ the revert:
> 
> root@h960:~# ps -eo pid,class,rtprio,pri,psr,comm | awk 'NR == 1 ||
> /sugov/'
>   PID CLS RTPRIO PRI PSR COMMAND
>   1491 #6      0 140   2 sugov:0
>   1492 #6      0 140   4 sugov:4
> 
> The sugov kthread sugov:4 responsible for policy4 runs on cpu4.
> 
> cross policy (cluster) remote callback example:
> ...
> migration/1-14 [001] enqueue_task_fair: this_cpu=1 cpu_of(rq)=7
> migration/1-14 [001] sugov_update_shared: this_cpu=1 sg_cpu->cpu=7
>                      sg_cpu->sg_policy->policy->related_cpus=4-7
>   sugov:4-1492 [004] sugov_work: this_cpu=4
>                      sg_cpu->sg_policy->policy->related_cpus=4-7
> ...
> 
> The remote callback (this_cpu=1, target_cpu=7) is executed on cpu=4.
> 
> Now the sugov kthread executes again on the policy (cluster) for which
> the Operating Performance Point (OPP) should be changed.
> It avoids the problem that an otherwise idle policy (cluster) is running
> schedutil (the sugov kthread) for another one.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Pavan Kondeti <pkondeti@codeaurora.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Quentin Perret <quentin.perret@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index d2c6083304b4..63014cff76a5 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -523,11 +523,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>  	}
>  
>  	sg_policy->thread = thread;
> -
> -	/* Kthread is bound to all CPUs by default */
> -	if (!policy->dvfs_possible_from_any_cpu)
> -		kthread_bind_mask(thread, policy->related_cpus);
> -
> +	kthread_bind_mask(thread, policy->related_cpus);
>  	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
>  	mutex_init(&sg_policy->work_lock);
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
