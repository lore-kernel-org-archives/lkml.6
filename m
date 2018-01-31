Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeAaFU6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 00:20:58 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36761 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbeAaFU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 00:20:56 -0500
X-Google-Smtp-Source: AH8x226K4GTVtbkCoON6bd9PWpWq31OD2tpNHYoXcvDlzrhZcnIDk5N7vHLe6uuoqUcd9w2GinrERQ==
Date: Wed, 31 Jan 2018 10:50:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/8] thermal/drivers/cpu_cooling: Remove pointless field
Message-ID: <20180131052053.GI13395@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-4-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516721671-16360-4-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-18, 16:34, Daniel Lezcano wrote:
> The structure cpufreq_cooling_device provides a backpointer to the thermal
> device but this one is used for a trace and to unregister. For the trace,
> we don't really need this field and the unregister function as the same
> pointer passed as parameter. Remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index e62be75..d05bb73 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -88,7 +88,6 @@ struct cpufreq_cooling_device {
>  	unsigned int clipped_freq;
>  	unsigned int max_level;
>  	struct freq_table *freq_table;	/* In descending order */
> -	struct thermal_cooling_device *cdev;
>  	struct cpufreq_policy *policy;
>  	struct list_head node;
>  	struct time_in_idle *idle_time;
> @@ -197,8 +196,7 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
>  
>  	dev = get_cpu_device(cpu);
>  	if (unlikely(!dev)) {
> -		dev_warn(&cpufreq_cdev->cdev->device,
> -			 "No cpu device for cpu %d\n", cpu);
> +		pr_warn("No cpu device for cpu %d\n", cpu);
>  		return -ENODEV;
>  	}
>  
> @@ -762,7 +760,6 @@ __cpufreq_cooling_register(struct device_node *np,
>  		goto remove_ida;
>  
>  	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
> -	cpufreq_cdev->cdev = cdev;
>  
>  	mutex_lock(&cooling_list_lock);
>  	/* Register the notifier for first cpufreq cooling device */
> @@ -922,7 +919,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
>  					    CPUFREQ_POLICY_NOTIFIER);
>  
> -	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
> +	thermal_cooling_device_unregister(cdev);
>  	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
>  	kfree(cpufreq_cdev->idle_time);
>  	kfree(cpufreq_cdev->freq_table);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
