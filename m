Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301D120643
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfBVLov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:44:51 -0500
Received: from foss.arm.com ([217.140.101.70]:58410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbfBVLou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:44:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ACF815AB;
        Fri, 22 Feb 2019 03:44:50 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7F7F3F5C1;
        Fri, 22 Feb 2019 03:44:48 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:44:46 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Verish

On 02/21/19 16:59, Viresh Kumar wrote:

[...]

> @@ -2239,6 +2314,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  			      struct cpufreq_policy *new_policy)
>  {
>  	struct cpufreq_governor *old_gov;
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +	unsigned long min, max;
>  	int ret;
>  
>  	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> @@ -2253,11 +2330,23 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	if (new_policy->min > new_policy->max)
>  		return -EINVAL;
>  
> +	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> +	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> +
> +	if (min > new_policy->min)
> +		new_policy->min = min;
> +	if (max < new_policy->max)
> +		new_policy->max = max;
> +

Assuming for example min and max range from 1-10, and thermal throttles max to
5 using pm_qos to deal with temporary thermal pressure. But shortly after
a driver thinks that max shouldn't be greater than 7 for one reason or another.

What will happen after thermal pressure removes its constraint? Will we still
remember the driver's request and apply it so max is set to 7 instead of 10?

Thanks

--
Qais Yousef
