Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411B2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F268F21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmR8s7G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfAJGOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:14:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35012 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJGOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:14:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so4855217pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 22:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7kSoE1otNeDSansIN8QBD/iK4dJ5xymaADb++4gEuGg=;
        b=NmR8s7G4ojSRXWsUkMknri8EOMasQ4t7MtinjwBpFujzu2KyowW006CkONX858kcSN
         VC1l8JBHmlF2nZxUuooDX/SwoTs4GhhffXchJF+v/AvznvvE51D2S7iLcCEEQKPskZ9b
         dPcjBBLQgMc3llazGCN3tGIehDgC4DUy3OtRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7kSoE1otNeDSansIN8QBD/iK4dJ5xymaADb++4gEuGg=;
        b=b0I+Snt+46sSW8YHL+3cdCJJKZbkbPbF4OqWSw+FTjTRsmI4VwtSWggzgq0kn0YIWr
         DBs2QnJFML/Idx8kNIrJekmzSYNj8To9EZK5hB65Y4rJuQDPRJmFhvD4+S1vuqt9nDap
         037zI0ic+VvAkBQTiM4xCFSsuKSTXBKhL97JxhqvjHu4hllpVryHA1U5FQ0Mv1ej8iLl
         iAdbtIRHJMLCs98bJuoxeqfd4SzxW388q8xrpnHWxajgI1sSGOgs9vWgx2eBcMo0BOlk
         qPuH4DrgmV7VAcwP8Rj6P0zCh+XWLegFLYk+zXtExfkGxyIP6xdHjAxKTkRRJQCPy8vT
         WOKQ==
X-Gm-Message-State: AJcUukdJwDpqPC/fmjc9lz569YsDX+pB3+fDuPTTy9e6/9MeCLEuGcsw
        7OlAgdpghGYk7pwx/0kkHp/KLQ==
X-Google-Smtp-Source: ALg8bN7zsnNCygeXMZt5QeZLq+OacBfB6MXmlMqNJA/z2Ml0wsaNUuEQ2omLbmcf79vajp7XUYYPnQ==
X-Received: by 2002:a63:7418:: with SMTP id p24mr8279057pgc.196.1547100892997;
        Wed, 09 Jan 2019 22:14:52 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id w11sm90217076pgk.16.2019.01.09.22.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 22:14:52 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:44:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 3/7] cpu_cooling: Add generic driver ready callback
Message-ID: <20190110061450.tdvanixjr6zdajhb@vireshk-i7>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <9cccfabf22ccae92dfd31175b57baab3206eac0d.1547078153.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cccfabf22ccae92dfd31175b57baab3206eac0d.1547078153.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-19, 05:30, Amit Kucheria wrote:
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a generic call back so we can get rid of duplicated code in the
> drivers.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/thermal/cpu_cooling.c | 18 ++++++++++++++++++
>  include/linux/cpu_cooling.h   |  9 +++++++++
>  2 files changed, 27 insertions(+)

We may be doing this differently, but I found some other issues with
the patch.

> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index dfd23245f778..5154ffc12332 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -694,6 +694,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  
>  	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
>  	cpufreq_cdev->cdev = cdev;
> +	policy->cooldev = cdev;

Why was this required ? The below routine was already doing it...

>  
>  	mutex_lock(&cooling_list_lock);
>  	/* Register the notifier for first cpufreq cooling device */
> @@ -785,6 +786,23 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  }
>  EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
>  
> +/**
> + * generic_cpufreq_ready - generic driver callback to register a thermal_cooling_device
> + * @policy: cpufreq policy
> + */
> +void generic_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	struct thermal_cooling_device **cdev = &policy->cooldev;
> +
> +	*cdev = of_cpufreq_cooling_register(policy);

... here

> +	if (IS_ERR(*cdev)) {

We never get an error here, only NULL.

> +		pr_err("Failed to register cpufreq cooling device for CPU%d: %ld\n",
> +		       policy->cpu, PTR_ERR(cdev));

The of_cpufreq_cooling_register() routine already prints enough error
messages on failures.

> +		cdev = NULL;

This is a meaningless statement, perhaps you wanted to do *cdev = NULL
:)

-- 
viresh
