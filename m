Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AFD2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="muGqARjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfARBqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:46:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42803 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfARBqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:46:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so5260587pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 17:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dixzj7VKilm6MuLAMg8zryq24qHSx5sterP35c6fFzM=;
        b=muGqARjhimCLspDbG/aFeEME3Lkq16zcAPPW4eaMab0s5w1L1MNkX1fUJTya37HpMK
         8wEGCftEy5uP4pCl86YaR7HySXhIJ0Y6t72YyJjHYzD5DHtbMYwtj8S9gsee5QMN82kq
         LyiwUXFE1Fet7Xujz6l+tyJiSOaowjtUMxGAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dixzj7VKilm6MuLAMg8zryq24qHSx5sterP35c6fFzM=;
        b=Gewv2DQ77BW2aSsW9/JO13w1etGM178VxfDAVlrkl+Glvd5tikPBFxuFK7zmTCwKfm
         UzS5b5JpeNjvf+7N9hj1P8kgHej1P4TuFQkUmu02cvcyf8SyUk8zTU4/awtmHN8OaqVQ
         ntovkTBzZQhpPZ+Brh6xUEUbNbYYGS5nUMZOZBbPuBBC3af8VuLPsFi3By0XZbV7cX0L
         IAXmMsT0dW3o7qgHvKwy5mRPx1fNnhwZtBktKC6zL51aceVJRNKKFUZ1VvVXe/GTNx0X
         jxDYZ/zM13Z2xomu28447JaQsduucHjuTrqbBWizyBTP4/VltVzz/x/ggtrvErCyqF9K
         RMfg==
X-Gm-Message-State: AJcUukcBynSV9oq9ZXE0VKBujsEGzbRcoWaDuX5cSst+p6V+yGosCnZc
        zpp3T9r0bmc7gtj34/17Lv49QQ==
X-Google-Smtp-Source: ALg8bN4b40JVFxvY+4Dy5P5iZP4U1dsskM4JssO9xHXjm579whd15ZGZEYKL//OBMaPRB34HsrYnCQ==
X-Received: by 2002:a63:5455:: with SMTP id e21mr15816407pgm.316.1547775993917;
        Thu, 17 Jan 2019 17:46:33 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f32sm3509590pgf.80.2019.01.17.17.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 17:46:32 -0800 (PST)
Date:   Thu, 17 Jan 2019 17:46:32 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: Implement freq-constraint callback
Message-ID: <20190118014632.GY261387@google.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <d6dad7a600a528665eaf309ab2182bc7b5e8060c.1547197612.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6dad7a600a528665eaf309ab2182bc7b5e8060c.1547197612.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 02:48:35PM +0530, Viresh Kumar wrote:
> This implements the frequency constraint callback and registers it with
> the freq-constraint framework whenever a policy is created. On policy
> removal the callback is unregistered.
> 
> The constraints are also taken into consideration in
> cpufreq_set_policy().
> 
> No constraints are added until now though.

nit: 'for now'?

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig   |  1 +
>  drivers/cpufreq/cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 608af20a3494..2c2842cf2734 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -2,6 +2,7 @@ menu "CPU Frequency scaling"
>  
>  config CPU_FREQ
>  	bool "CPU Frequency scaling"
> +	select DEVICE_FREQ_CONSTRAINT
>  	select SRCU
>  	help
>  	  CPU Frequency scaling allows you to change the clock speed of 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a8fa684f5f90..63028612d011 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -21,6 +21,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/freq_constraint.h>
>  #include <linux/init.h>
>  #include <linux/kernel_stat.h>
>  #include <linux/module.h>
> @@ -1163,6 +1164,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  		per_cpu(cpufreq_cpu_data, cpu) = NULL;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
> +	freq_constraint_remove_cpumask_callback(policy->related_cpus);
>  	cpufreq_policy_put_kobj(policy);
>  	free_cpumask_var(policy->real_cpus);
>  	free_cpumask_var(policy->related_cpus);
> @@ -1170,6 +1172,24 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	kfree(policy);
>  }
>  
> +static void freq_constraint_callback(void *param)
> +{
> +	struct cpufreq_policy *policy = param;
> +	struct cpufreq_policy new_policy = *policy;
> +
> +	new_policy.min = policy->user_policy.min;
> +	new_policy.max = policy->user_policy.max;
> +
> +	down_write(&policy->rwsem);
> +	if (policy_is_inactive(policy))
> +		goto unlock;
> +
> +	cpufreq_set_policy(policy, &new_policy);
> +
> +unlock:
> +	up_write(&policy->rwsem);
> +}
> +
>  static int cpufreq_online(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy;
> @@ -1236,6 +1256,14 @@ static int cpufreq_online(unsigned int cpu)
>  			per_cpu(cpufreq_cpu_data, j) = policy;
>  			add_cpu_dev_symlink(policy, j);
>  		}
> +
> +		ret = freq_constraint_set_cpumask_callback(policy->related_cpus,
> +					freq_constraint_callback, policy);
> +		if (ret) {
> +			pr_err("Failed to set freq-constraints: %d (%*pbl)\n",
> +			       ret, cpumask_pr_args(policy->cpus));
> +			goto out_destroy_policy;
> +		}
>  	} else {
>  		policy->min = policy->user_policy.min;
>  		policy->max = policy->user_policy.max;
> @@ -2198,6 +2226,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  				struct cpufreq_policy *new_policy)
>  {
>  	struct cpufreq_governor *old_gov;
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +	unsigned long fc_min, fc_max;
>  	int ret;
>  
>  	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> @@ -2217,6 +2247,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	if (ret)
>  		return ret;
>  
> +	ret = freq_constraints_get(cpu_dev, &fc_min, &fc_max);
> +	if (ret) {
> +		dev_err(cpu_dev, "cpufreq: Failed to get freq-constraints\n");
> +	} else {
> +		if (fc_min > new_policy->min)
> +			new_policy->min = fc_min;
> +		if (fc_max < new_policy->max)
> +			new_policy->max = fc_max;
> +	}

nit: for if/else constructs with a typical and an 'exception' case
IMO it is usually more readable when the normal case is handled in the
'if' branch (first) and the exception in 'else'.

Cheers

Matthias
