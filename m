Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeDKJ36 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:29:58 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33820 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeDKJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:29:56 -0400
X-Google-Smtp-Source: AIpwx48yQ99Td6kPHBoJWvnvfM9h+TFLcWnQmBPQPr+lrqueTCGw5WbahxgZMQ29neE8YzfbxRazfA==
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <20180411085130.GN7671@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a1533926-0d9b-248a-96e9-e3148b4d9f08@linaro.org>
Date: Wed, 11 Apr 2018 11:29:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411085130.GN7671@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Viresh,

thanks for the review.


On 11/04/2018 10:51, Viresh Kumar wrote:

[ ... ]

>> +void __init cpuidle_cooling_register(void)
>> +{
>> +	struct cpuidle_cooling_device *idle_cdev = NULL;
>> +	struct thermal_cooling_device *cdev;
>> +	struct device_node *np;
>> +	cpumask_var_t cpumask;
> 
> maybe call it clustermask ?

Yeah, sounds better.

>> +		cdev = thermal_of_cooling_device_register(np, dev_name,
>> +							  idle_cdev,
>> +							  &cpuidle_cooling_ops);
>> +		if (IS_ERR(cdev)) {
>> +			ret = PTR_ERR(cdev);
>> +			goto out;
>> +		}
>> +
>> +		idle_cdev->cdev = cdev;
>> +		cpumask_set_cpu(cluster_id, cpumask);
>> +	}
>> +
>> +	ret = smpboot_register_percpu_thread(&cpuidle_cooling_threads);
>> +	if (ret)
>> +		goto out;
>> +
>> +	pr_info("Created cpuidle cooling device\n");
>> +out:
>> +	free_cpumask_var(cpumask);
>> +
>> +	if (ret) {
>> +		cpuidle_cooling_unregister();
>> +		pr_err("Failed to create idle cooling device (%d)\n", ret);
>> +	}
> 
> Maybe rearrange it a bit:
> 
> +	ret = smpboot_register_percpu_thread(&cpuidle_cooling_threads);
> +
> +out:
> +	if (ret) {
> +		cpuidle_cooling_unregister();
> +		pr_err("Failed to create idle cooling device (%d)\n", ret);
> +	} else {
> +	        pr_info("Created cpuidle cooling devices\n");
> +       }
> +
> +	free_cpumask_var(cpumask);
> 
> ??

I usually tend to avoid using 'else' statements when possible (a coding
style practice) but if you prefer this version I'm fine with that.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
