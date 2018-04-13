Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754764AbeDMLiz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:38:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51294 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754752AbeDMLix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:38:53 -0400
X-Google-Smtp-Source: AIpwx4/1j4ivyKgnY+S7Ra50waPraxu5CM04HdAyS/XHrZZZpfF57LcBpznt6GZpHd7E6B412AKbbw==
Date: Fri, 13 Apr 2018 12:38:48 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: viresh.kumar@linaro.org, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180413113848.xj7hg7gsbxpxekbo@holly.lan>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 06:16:43PM +0200, Daniel Lezcano wrote:
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
> +
> +		/*
> +		 * Allocate the cpuidle cooling device with the list
> +		 * of the cpus belonging to the cluster.
> +		 */
> +		idle_cdev = cpuidle_cooling_alloc(topology_core_cpumask(cpu));
> +		if (!idle_cdev)
> +			goto out;

Perhaps nitpicking but it might be better to set ret to -ENOMEM here 
and avoid initializing it during the declarations.

There's no bug in the current form since ret is never assigned to
outside of the error paths, but the unwritten assumption that ret keeps
its original value throughout the loop seems like a bit of a landmine
w.r.t. future maintainance.


Daniel.
