Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754447AbeDMLXV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:23:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41508 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754051AbeDMLXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:23:19 -0400
Cc: viresh.kumar@linaro.org, edubezval@gmail.com,
        Sudeep Holla <sudeep.holla@arm.com>, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Daniel Lezcano <daniel.lezcano@linaro.org>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <3f3b3b7a-3b74-aee2-2fac-f2759babe3f0@arm.com>
Date: Fri, 13 Apr 2018 12:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 05/04/18 17:16, Daniel Lezcano wrote:

[...]

> +/**
> + * cpuidle_cooling_register - Idle cooling device initialization function
> + *
> + * This function is in charge of creating a cooling device per cluster
> + * and register it to thermal framework. For this we rely on the
> + * topology as there is nothing yet describing better the idle state
> + * power domains.
> + *
> + * We create a cpuidle cooling device per cluster. For this reason we
> + * must, for each cluster, allocate and initialize the cooling device
> + * and for each cpu belonging to this cluster, do the initialization
> + * on a cpu basis.
> + *
> + * This approach for creating the cooling device is needed as we don't
> + * have the guarantee the CPU numbering is sequential.
> + *
> + * Unfortunately, there is no API to browse from top to bottom the
> + * topology, cluster->cpu, only the usual for_each_possible_cpu loop.
> + * In order to solve that, we use a cpumask to flag the cluster_id we
> + * already processed. The cpumask will always have enough room for all
> + * the cluster because it is based on NR_CPUS and it is not possible
> + * to have more clusters than cpus.
> + *
> + */
> +void __init cpuidle_cooling_register(void)
> +{
> +	struct cpuidle_cooling_device *idle_cdev = NULL;
> +	struct thermal_cooling_device *cdev;
> +	struct device_node *np;
> +	cpumask_var_t cpumask;
> +	char dev_name[THERMAL_NAME_LENGTH];
> +	int ret = -ENOMEM, cpu;
> +	int cluster_id;
> +
> +	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +
> +		cluster_id = topology_physical_package_id(cpu);
> +		if (cpumask_test_cpu(cluster_id, cpumask))
> +			continue;

Sorry for chiming in randomly, I haven't read the patches in detail.
But it was brought to my notice that topology_physical_package_id is
being used for cluster ID here. It's completely wrong and will
changesoon with ACPI topology related changes Jeremy is working on.

You will get the physical socket number(which is mostly 0 on single SoC
system). Makes sure that this won't break with that change.

Please note with cluster id not defined architecturally, relying on that
is simply problematic.
-- 
Regards,
Sudeep
