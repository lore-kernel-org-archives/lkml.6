Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD545C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914C0218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoOpm/OG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfAYKb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:31:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46433 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAYKb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:31:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so4039186pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xV+tXi79UeoN9cizkihtQQPtSlmF7btX28r8UdCBuWA=;
        b=SoOpm/OGfS6HsgV+Dg2Z7/mvSD2gJVhgg7o+UQYQNu5jByf1egOFJAbhvuNVQIgfbl
         64UCyEgQkslEc8+nwkIwmYn/+Q2RhOC+/ViPwwKksBv1IBuP5KIsHSSZIO43fCRa/IdG
         1dOUi0lryaAChK3spMzg0qeYyIxQnk4jVlrZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xV+tXi79UeoN9cizkihtQQPtSlmF7btX28r8UdCBuWA=;
        b=cTTa7aKO3P0WFt8BZiD41Vc79RIGmgzDoN+vaOj8qjO1FPtuvGODif3czaeQNCdt4k
         950QdUIkTPmMoFieUOYVPuZlR9xKR1Mz4WQK18duTDk4oxzrVXdxT1xn+WlhTttuqXFD
         6dmIGSi3YubK3Cy0uvbylCQ6K+1AkKgsenAJVbnEfRCYxEZ7fejmDrva5jlRlTK5/xHv
         U+0ql+NyvGrixQLD1wLK1kxWZYYgehh1McA9BubfUHCn6bNsDl+rzbzOp246XvN9q+H+
         Cj9I1qKXEIgzVoay/EFyaRO/xF3t/WG23PsNADWuD0KipyAfJQ+yX3pPs62htB07WQO9
         SDHQ==
X-Gm-Message-State: AJcUukcz3wB45fcs2/uA/jHaGlsGSdVXVbrc/5r6kuO6P8kZfmjDhJBL
        owl+Ke+UeZOvEvdG1A9qHGSo0g==
X-Google-Smtp-Source: ALg8bN59R7SVqgNYPuEXvJB2xrwBJTipoK/CxZuaV9OIbgpdZtiNW6V5sPx0G8Tofkt3ZflIHWK/qQ==
X-Received: by 2002:a63:4706:: with SMTP id u6mr8943388pga.95.1548412316064;
        Fri, 25 Jan 2019 02:31:56 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id k129sm31057848pgk.29.2019.01.25.02.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 02:31:54 -0800 (PST)
Date:   Fri, 25 Jan 2019 16:01:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCHv3 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Message-ID: <20190125103152.7svjfmowgigznipm@vireshk-i7>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
 <73e091e2d56d9fa6eb94feaed9fc2be30bf6da20.1548398851.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e091e2d56d9fa6eb94feaed9fc2be30bf6da20.1548398851.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-01-19, 12:32, Amit Kucheria wrote:
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
> 
> In order to allow this, we add a struct thermal_cooling_device pointer
> to struct cpufreq_policy so that drivers don't need to store it in a
> private data structure.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/cpufreq/cpufreq.c |  6 ++++++
>  include/linux/cpufreq.h   | 21 +++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..cf1be057caf4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1318,6 +1318,9 @@ static int cpufreq_online(unsigned int cpu)
>  	if (cpufreq_driver->ready)
>  		cpufreq_driver->ready(policy);
>  
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
> +		register_cooling_device(policy);
> +
>  	pr_debug("initialization complete\n");
>  
>  	return 0;
> @@ -1405,6 +1408,9 @@ static int cpufreq_offline(unsigned int cpu)
>  		goto unlock;
>  	}
>  
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
> +		unregister_cooling_device(policy);
> +
>  	if (cpufreq_driver->stop_cpu)
>  		cpufreq_driver->stop_cpu(policy);
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index bd7fbd6a4478..c7eb59b8ce94 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/cpumask.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/completion.h>
>  #include <linux/kobject.h>
>  #include <linux/notifier.h>
> @@ -151,6 +152,9 @@ struct cpufreq_policy {
>  
>  	/* For cpufreq driver's internal use */
>  	void			*driver_data;
> +
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cdev;
>  };
>  
>  /* Only for ACPI */
> @@ -386,6 +390,12 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
>  
> +/*
> + * Set by drivers that want the core to automatically register the cpufreq
> + * driver as a thermal cooling device.
> + */
> +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
> +
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>  
> @@ -415,6 +425,17 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
>  			policy->cpuinfo.max_freq);
>  }
>  
> +static inline void register_cooling_device(struct cpufreq_policy *policy)
> +{
> +	policy->cdev = of_cpufreq_cooling_register(policy);
> +}
> +
> +static inline void unregister_cooling_device(struct cpufreq_policy *policy)
> +{
> +	cpufreq_cooling_unregister(policy->cdev);
> +	policy->cdev = NULL;
> +}

I thought that we discussed over chat that you wouldn't add any
wrapper routines. How do you see these getting used ? I will suggest
that this should be open coded in the core itself.

-- 
viresh
