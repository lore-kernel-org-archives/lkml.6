Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9B9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3605520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/T023bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfAQEtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:49:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37865 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfAQEtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:49:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so3866162pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MeMUgpknm4zDEAU65MJKosVOmnaVNkhtqHj4P3Fi190=;
        b=d/T023bg0JhLnGvsYHFgDSnC795dK3t1eyvn9MYcWrxjWNly7U6yAxKuR2539MS1zM
         70gZofnE0W7AwL5nYPRfznIiKDWaKcj3J1ZfZyqftQQsOdnz+ia4TCD1wOaVTQC3IOzx
         BkL4H+Nz7UORSq0zrcmA0ZYZ1UZAQrb0IVF4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MeMUgpknm4zDEAU65MJKosVOmnaVNkhtqHj4P3Fi190=;
        b=fEwuA6ILAGs0BIBTPZO9FSt/uHi+5ePi6AtMZwct9v1TjzUF1T5lfjpfqeMqEbi9vK
         7c8g8pn5iNoWcqHWnVdGLNQjwbYIolhu9eGKNFyBC+DTAvRhSEKZf/PdPN7WK1sbAfie
         1E8tBfR+8i6qXd1YNUa/7tBeELQf0Ib+2GbyhkDNcBWKFjCF+ygCWf/XPjYvSiHJtOri
         yPLehPFBKKFJ+mOfpHqu3/lwso69cv/GfKwWi4ffK2Odmk1lxpmYKANpHwyub5HwSRlS
         lJfGosbPyqFarTDjL3Qd0AjNLMdF6SqqvhoNrPQDs8/k+NdmZS40DMMjYTYHzFcWmoss
         yyPA==
X-Gm-Message-State: AJcUukc2oqdL4ijXRZR6fczLLJCyqhoLbzIq1S9b9W7WlkFGCBzYZe08
        cn5jPk95ryub6wK1GfMRW84XvRwhQ/E=
X-Google-Smtp-Source: ALg8bN5olbLegrOv4KrEeEk+MxcqJF45xk3SNKA2qf62l0T9o9eEie8yta8aNl+VZpMfl/D1eZhv0Q==
X-Received: by 2002:a63:4342:: with SMTP id q63mr12142864pga.63.1547700549090;
        Wed, 16 Jan 2019 20:49:09 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id d80sm605826pfm.146.2019.01.16.20.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 20:49:08 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:19:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 05/10] cpufreq: imx6q: Use auto-registration of
 thermal cooling device
Message-ID: <20190117044906.jomvwecvjrkgsuak@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <49e531e140f299127ae6c0bc905b993b97c269e2.1547481320.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e531e140f299127ae6c0bc905b993b97c269e2.1547481320.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-19, 22:04, Amit Kucheria wrote:
> Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
> automatically register as a thermal cooling device.
> 
> This allows removal of boiler plate code from the driver.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 9fedf627e000..ffb00291f48e 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -9,7 +9,6 @@
>  #include <linux/clk.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> @@ -52,7 +51,6 @@ static struct clk_bulk_data clks[] = {
>  };
>  
>  static struct device *cpu_dev;
> -static struct thermal_cooling_device *cdev;
>  static bool free_opp;
>  static struct cpufreq_frequency_table *freq_table;
>  static unsigned int max_freq;
> @@ -193,16 +191,6 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	return 0;
>  }
>  
> -static void imx6q_cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	cdev = of_cpufreq_cooling_register(policy);
> -
> -	if (!cdev)
> -		dev_err(cpu_dev,
> -			"running cpufreq without cooling device: %ld\n",
> -			PTR_ERR(cdev));
> -}
> -
>  static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	int ret;
> @@ -216,20 +204,18 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  
>  static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
>  {
> -	cpufreq_cooling_unregister(cdev);
> -
>  	return 0;
>  }

Remove the empty routine as well.

>  static struct cpufreq_driver imx6q_cpufreq_driver = {
> -	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = imx6q_set_target,
>  	.get = cpufreq_generic_get,
>  	.init = imx6q_cpufreq_init,
>  	.exit = imx6q_cpufreq_exit,
>  	.name = "imx6q-cpufreq",
> -	.ready = imx6q_cpufreq_ready,
>  	.attr = cpufreq_generic_attr,
>  	.suspend = cpufreq_generic_suspend,
>  };
> -- 
> 2.17.1

-- 
viresh
