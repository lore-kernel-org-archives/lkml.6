Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB41BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D902177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfBSK06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:26:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50299 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfBSK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:26:57 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 2d9cbb1f49d518e1; Tue, 19 Feb 2019 11:26:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/2] cpufreq: Allow light-weight tear down and bring up of CPUs
Date:   Tue, 19 Feb 2019 11:25:30 +0100
Message-ID: <2678403.roXOZuBH3e@aspire.rjw.lan>
In-Reply-To: <7fcdface56ccc5df0e50738253eb3e696b2f8980.1549969209.git.viresh.kumar@linaro.org>
References: <f48f04ddfe3bd072f40154cdd971079199db0e4b.1549955027.git.viresh.kumar@linaro.org> <7fcdface56ccc5df0e50738253eb3e696b2f8980.1549969209.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 12, 2019 12:06:04 PM CET Viresh Kumar wrote:
> The cpufreq core doesn't remove the cpufreq policy anymore on CPU
> offline operation, rather that happens when the CPU device gets
> unregistered from the kernel. This allows faster recovery when the CPU
> comes back online. This is also very useful during system wide
> suspend/resume where we offline all non-boot CPUs during suspend and
> then bring them back on resume.
> 
> This commit takes the same idea a step ahead to allow drivers to do
> light weight tear-down and bring-up during CPU offline and online
> operations.
> 
> A new set of callbacks is introduced, online/offline(). online() gets
> called when the first CPU of an inactive policy is brought up and
> offline() gets called when all the CPUs of a policy are offlined.
> 
> The existing init/exit() callback get called on policy
> creation/destruction. They also get called instead of online/offline()
> callbacks if the online/offline() callbacks aren't provided.
> 
> This also moves around some code to get executed only for the new-policy
> case going forward.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3->V4:
> - Use != instead of ^
> 
>  drivers/cpufreq/cpufreq.c | 58 +++++++++++++++++++++++++--------------
>  include/linux/cpufreq.h   |  2 ++
>  2 files changed, 40 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 96a69c67a545..55e9795801a4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1201,28 +1201,39 @@ static int cpufreq_online(unsigned int cpu)
>  			return -ENOMEM;
>  	}
>  
> -	cpumask_copy(policy->cpus, cpumask_of(cpu));
> +	if (!new_policy && cpufreq_driver->online) {
> +		ret = cpufreq_driver->online(policy);
> +		if (ret) {
> +			pr_debug("%s: %d: initialization failed\n", __func__,
> +				 __LINE__);
> +			goto out_exit_policy;
> +		}
>  
> -	/* call driver. From then on the cpufreq must be able
> -	 * to accept all calls to ->verify and ->setpolicy for this CPU
> -	 */
> -	ret = cpufreq_driver->init(policy);
> -	if (ret) {
> -		pr_debug("initialization failed\n");
> -		goto out_free_policy;
> -	}
> +		/* Recover policy->cpus using related_cpus */
> +		cpumask_copy(policy->cpus, policy->related_cpus);
> +	} else {
> +		cpumask_copy(policy->cpus, cpumask_of(cpu));
>  
> -	ret = cpufreq_table_validate_and_sort(policy);
> -	if (ret)
> -		goto out_exit_policy;
> +		/*
> +		 * Call driver. From then on the cpufreq must be able
> +		 * to accept all calls to ->verify and ->setpolicy for this CPU.
> +		 */
> +		ret = cpufreq_driver->init(policy);
> +		if (ret) {
> +			pr_debug("%s: %d: initialization failed\n", __func__,
> +				 __LINE__);
> +			goto out_free_policy;
> +		}
>  
> -	down_write(&policy->rwsem);
> +		ret = cpufreq_table_validate_and_sort(policy);
> +		if (ret)
> +			goto out_exit_policy;
>  
> -	if (new_policy) {
>  		/* related_cpus should at least include policy->cpus. */
>  		cpumask_copy(policy->related_cpus, policy->cpus);
>  	}
>  
> +	down_write(&policy->rwsem);
>  	/*
>  	 * affected cpus must always be the one, which are online. We aren't
>  	 * managing offline cpus here.
> @@ -1421,11 +1432,12 @@ static int cpufreq_offline(unsigned int cpu)
>  		cpufreq_exit_governor(policy);
>  
>  	/*
> -	 * Perform the ->exit() even during light-weight tear-down,
> -	 * since this is a core component, and is essential for the
> -	 * subsequent light-weight ->init() to succeed.
> +	 * Perform the ->offline() during light-weight tear-down, as
> +	 * that allows fast recovery when the CPU comes back.
>  	 */
> -	if (cpufreq_driver->exit) {
> +	if (cpufreq_driver->offline) {
> +		cpufreq_driver->offline(policy);
> +	} else if (cpufreq_driver->exit) {
>  		cpufreq_driver->exit(policy);
>  		policy->freq_table = NULL;
>  	}
> @@ -1454,8 +1466,13 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>  	cpumask_clear_cpu(cpu, policy->real_cpus);
>  	remove_cpu_dev_symlink(policy, dev);
>  
> -	if (cpumask_empty(policy->real_cpus))
> +	if (cpumask_empty(policy->real_cpus)) {
> +		/* We did light-weight exit earlier, do full tear down now */
> +		if (cpufreq_driver->offline)
> +			cpufreq_driver->exit(policy);
> +
>  		cpufreq_policy_free(policy);
> +	}
>  }
>  
>  /**
> @@ -2488,7 +2505,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  		    driver_data->target) ||
>  	     (driver_data->setpolicy && (driver_data->target_index ||
>  		    driver_data->target)) ||
> -	     (!!driver_data->get_intermediate != !!driver_data->target_intermediate))
> +	     (!!driver_data->get_intermediate != !!driver_data->target_intermediate) ||
> +	     (!driver_data->online != !driver_data->offline))
>  		return -EINVAL;
>  
>  	pr_debug("trying to register driver %s\n", driver_data->name);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9db074ecbbd7..b160e98076e3 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -325,6 +325,8 @@ struct cpufreq_driver {
>  	/* optional */
>  	int		(*bios_limit)(int cpu, unsigned int *limit);
>  
> +	int		(*online)(struct cpufreq_policy *policy);
> +	int		(*offline)(struct cpufreq_policy *policy);
>  	int		(*exit)(struct cpufreq_policy *policy);
>  	void		(*stop_cpu)(struct cpufreq_policy *policy);
>  	int		(*suspend)(struct cpufreq_policy *policy);
> 

Applied along with the [2/2], thanks!

