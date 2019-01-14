Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E9CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE96B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PulFaOoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfANUvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:51:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35680 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfANUvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:51:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so180379pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e1hQzf8kQPwGBBXZxeEhzx3i1sbMBtFzu/Gc4YZq6XY=;
        b=PulFaOojxywb0s4CTsuhM1yjWRpethCD8QoP5W93/PNGNgjfPAQwrU5PuYRSVeGEHb
         ONIkIxo+ahutubjxWnzMjrVYhHmI5u3YEufTKvr1l2e8r2xlyiqbZOOFfxS/EaodNX4q
         pnUTYt/EFzZIkY0VWxSUOxq8UpD+A+BX8nWPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e1hQzf8kQPwGBBXZxeEhzx3i1sbMBtFzu/Gc4YZq6XY=;
        b=YGKm6fJ5cTSvKdzJ0/EbrwymcQqqSfZQ6F6HjZJC2uj6sMYf9e3/j/Tnx7NszebaXo
         Dg2vNoXovPurBFSNXGxBproa+dD2KhiaQR+bV1D4p4g5bI4u5v0b55MlVS3Wg37Nxf0b
         uoPmVNcutGU//xuZjoFIWWFHMR6SQobWs6UYc5/Z5T64sjjj+2sXsUoGj+e9n6vJgLVM
         TkWwnQ45gIrbZqdSQmyBXyEnIa20OxYw47TtDPlUGig1MGn5QG83AqdHO/hQQ+fWqfaU
         Cq0n/2Wo8omtWJBSHE57gBpu5fl6rPF/Z7njjqnc3z3iAjPIXRdSXmUzCL//xevWb3er
         Qd+w==
X-Gm-Message-State: AJcUukfaKI1jbvO60YOuP2UyhWtsBq+3AIWmoT6l5AEmaHTMZpg7PSVF
        V1dRPS1xOAsyRE8YtBNPIlg0VhcPPqdI5w==
X-Google-Smtp-Source: ALg8bN6V/ogGC0UJrdWtZxIj1thJm4PaHtlZaZPlup3M33qBvkcFs1ZQv0zC0xgCB/cFvg2t10tH4g==
X-Received: by 2002:a62:140a:: with SMTP id 10mr356103pfu.157.1547499096411;
        Mon, 14 Jan 2019 12:51:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h185sm1605257pfg.143.2019.01.14.12.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:51:35 -0800 (PST)
Date:   Mon, 14 Jan 2019 12:51:35 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org,
        dianders@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 02/10] cpufreq: Add a flag to auto-register a cooling
 device
Message-ID: <20190114205135.GL261387@google.com>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <c1e460c49ad2f16b15ace909514a770c9753d1b1.1547481320.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1e460c49ad2f16b15ace909514a770c9753d1b1.1547481320.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:04:54PM +0530, Amit Kucheria wrote:
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 17 +++++++++++++++++
>  include/linux/cpufreq.h   |  6 ++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6f23ebb395f1..cd6e750d3d82 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -30,6 +30,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/tick.h>
>  #include <trace/events/power.h>
> +#include <linux/cpu_cooling.h>
>  
>  static LIST_HEAD(cpufreq_policy_list);
>  
> @@ -1318,6 +1319,14 @@ static int cpufreq_online(unsigned int cpu)
>  	if (cpufreq_driver->ready)
>  		cpufreq_driver->ready(policy);
>  
> +#ifdef CONFIG_CPU_THERMAL
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +		struct thermal_cooling_device **cdev = &policy->cooldev;
> +
> +		*cdev = of_cpufreq_cooling_register(policy);
> +	}
> +#endif
> +
>  	pr_debug("initialization complete\n");
>  
>  	return 0;
> @@ -1411,6 +1420,14 @@ static int cpufreq_offline(unsigned int cpu)
>  	if (has_target())
>  		cpufreq_exit_governor(policy);
>  
> +#ifdef CONFIG_CPU_THERMAL
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +		struct thermal_cooling_device **cdev = &policy->cooldev;
> +
> +		cpufreq_cooling_unregister(*cdev);
> +	}
> +#endif
> +
>  	/*
>  	 * Perform the ->exit() even during light-weight tear-down,
>  	 * since this is a core component, and is essential for the
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 7d0cf54125fa..70ad02088825 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -390,6 +390,12 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
>  
> +/*
> + * Set by drivers that want the core to automatically register the cpufreq
> + * driver as a thermal cooling device
> + */
> +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
> +
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
