Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeDCEWL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 00:22:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41234 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbeDCEWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 00:22:09 -0400
X-Google-Smtp-Source: AIpwx4+aof+Vn+l8yWRJ+SGGZe6k6im2y0dKF0Nb92POWgQ/jpYpORfLRkO3B4nVGFlvWwhkAok0Dw==
Date: Tue, 3 Apr 2018 09:52:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Suman Anna <s-anna@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zumeng Chen <zumeng.chen@gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: ti-cpufreq: Use devres managed API in
 probe()
Message-ID: <20180403042204.GH3572@vireshk-i7>
References: <20180402164958.20057-1-s-anna@ti.com>
 <20180402164958.20057-3-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402164958.20057-3-s-anna@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-04-18, 11:49, Suman Anna wrote:
> The ti_cpufreq_probe() function uses regular kzalloc to allocate
> the ti_cpufreq_data structure and kfree for freeing this memory
> on failures. Simplify this code by using the devres managed
> API.
> 
> Cc: Zumeng Chen <zumeng.chen@gmail.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 46d1ab2dea87..7d353a21935b 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -217,7 +217,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  	if (!match)
>  		return -ENODEV;
>  
> -	opp_data = kzalloc(sizeof(*opp_data), GFP_KERNEL);
> +	opp_data = devm_kzalloc(&pdev->dev, sizeof(*opp_data), GFP_KERNEL);
>  	if (!opp_data)
>  		return -ENOMEM;
>  
> @@ -226,8 +226,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  	opp_data->cpu_dev = get_cpu_device(0);
>  	if (!opp_data->cpu_dev) {
>  		pr_err("%s: Failed to get device for CPU0\n", __func__);
> -		ret = -ENODEV;
> -		goto free_opp_data;
> +		return -ENODEV;
>  	}
>  
>  	opp_data->opp_node = dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
> @@ -285,8 +284,6 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  fail_put_node:
>  	of_node_put(opp_data->opp_node);
> -free_opp_data:
> -	kfree(opp_data);
>  
>  	return ret;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
