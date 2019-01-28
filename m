Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1418C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF67420881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOkNh2v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfA1I3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:29:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34004 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfA1I3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:29:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so9809462wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xaZLqmjl7uAF/GfT0BEsIeS38dElN6qNBXfpitdP+bw=;
        b=UOkNh2v/GXEzBkzsbrFkR6jHKhSs9Dc4QzFBMvh8oYxHYLwuy4QCnQMbbfHhsoESFB
         oANeFGXcpn/UcmVAYX0GmTlGL3asGaH9bMUSYlrSaJwwU2O5nIZExtwmtkbB5nF8V4OY
         /ORG4PTbrhcH+vvs0QmwlbBtVLkuAsK9G1XwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xaZLqmjl7uAF/GfT0BEsIeS38dElN6qNBXfpitdP+bw=;
        b=Z+fcaJFDt3wCFyIKka3xXH8sFSg00TxvkW6LOdvht4VHxywl++nICMC5e+ZdPaJ+4T
         fMhaLPURlEk8gF4lL4Tai/xwXZWI8Gy4hh4CLHoQPmUWaz1+94f7sXC56kkLH5r6n+O7
         zxnTRIJnJpmSD8KRygDhaVuiXLb09HmUL7MD/tMGVBA/YS3+JQQJgr8g7VXKzr6XWOrq
         dqpftNeo9ziWo7G6H5pqUOtvHEHk2wrv7iXaTsMrzjD8ppCYJ9Zr0M/F5DFuzeOvMx1B
         lY27RkrvFbMBJvXwz6zokC8nUXuElJyBE/tDzUMcBBbT+l6dcXT+kpdSXctuHsJwQTs3
         P51g==
X-Gm-Message-State: AJcUukeB23Mh+VMPrIf1rIhrAcqACJpNgP2jnCDGmv6lqI0nnZR/O96E
        E3Vq6+st+p4it2g7dp8luG9psQ==
X-Google-Smtp-Source: ALg8bN5LKxBHJgLyry8zv402M9w9b4pxYMA1wcWPyLZUKmL6f5AQmiYYVS1R/gcu4EKhS6ZaCFoVfg==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr15974313wmf.3.1548664152096;
        Mon, 28 Jan 2019 00:29:12 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
        by smtp.googlemail.com with ESMTPSA id h16sm231507479wrb.62.2019.01.28.00.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:29:11 -0800 (PST)
Subject: Re: [PATCH v4 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8dc3dcab-c1f5-2f6a-69fd-0283735e6241@linaro.org>
Date:   Mon, 28 Jan 2019 09:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2019 07:41, Amit Kucheria wrote:
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

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>



>  drivers/cpufreq/cpufreq.c | 9 +++++++++
>  include/linux/cpufreq.h   | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..29ed78b0b77b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -19,6 +19,7 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> @@ -1318,6 +1319,9 @@ static int cpufreq_online(unsigned int cpu)
>  	if (cpufreq_driver->ready)
>  		cpufreq_driver->ready(policy);
>  
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
> +		policy->cdev = of_cpufreq_cooling_register(policy);
> +
>  	pr_debug("initialization complete\n");
>  
>  	return 0;
> @@ -1405,6 +1409,11 @@ static int cpufreq_offline(unsigned int cpu)
>  		goto unlock;
>  	}
>  
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +		cpufreq_cooling_unregister(policy->cdev);
> +		policy->cdev = NULL;
> +	}
> +
>  	if (cpufreq_driver->stop_cpu)
>  		cpufreq_driver->stop_cpu(policy);
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index bd7fbd6a4478..55ca61a64fc2 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -151,6 +151,9 @@ struct cpufreq_policy {
>  
>  	/* For cpufreq driver's internal use */
>  	void			*driver_data;
> +
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cdev;
>  };
>  
>  /* Only for ACPI */
> @@ -386,6 +389,12 @@ struct cpufreq_driver {
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
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

