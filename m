Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5788CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2594D2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VQgargok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfA1Tg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:36:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41278 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1Tg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:36:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so8194691plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fNUJ09BCIZ3YVWy/Ji5fieGPR7dMwabmPYhcIO/fyFg=;
        b=VQgargokXjtIdGA1PK+y73iiIC+deS807thO0SWlB8K2cezAE6Xo+lsNWbu84PfpW8
         zcN9EFl4XsaY3Zr/Tn3+DvFvYg5rN6UeRJ1yJp75VJPYVfFcu9ncX91x+TyxSD1mSRWM
         lFKgi6UF84qekMTQrbaBWf9/kLNdg1IuS9/z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fNUJ09BCIZ3YVWy/Ji5fieGPR7dMwabmPYhcIO/fyFg=;
        b=Apm5tocsn4PH5qPv34vgy6iX1T3gMvTbA1ogDWmyO+N1k85iTu934WZHUJB4mqDspx
         GHa7uxiks7DmxqiWZ0bL9qhEImSh2mjht9oMyzI1+FGM8gqsbA9oJaoXCpStTZYc8+ey
         RPXZdPiLNYuzx8PwMtj8Tt2QudjWmQoRQNEQaAyvdlhpFnFmpuJ8PcVzus9RcAMdhXpU
         SB6PK4hfy72mSukTqY1efcFBX921LoUWwvsSrpb4y/7fIPIdYo+IHeV6llLbNvAuvCn1
         SOygbubwlJ6pp0IUvcHNhTEv4tcoAIg1JLx8lOBPM6apPwVmAsFjFBfAqYP/cD7cq6Md
         Cb7w==
X-Gm-Message-State: AJcUukc4DGqcpzxj0+/c8E6DbBWm4WuQ7P0oB8LqFqaD53q/Kui5O9wS
        DX8Fw5W6Ovt/YIUzPavZOz1SLQ==
X-Google-Smtp-Source: ALg8bN6N18gNvICoXmmf/LmIw4oTBamfgrQCK9BROI5ovoz2+Uisd8OY1O/8j5x/CleV8Ye1HArcJA==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr23520246pll.265.1548704217884;
        Mon, 28 Jan 2019 11:36:57 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t13sm39064565pgr.42.2019.01.28.11.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 11:36:57 -0800 (PST)
Date:   Mon, 28 Jan 2019 11:36:56 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190128193656.GI81583@google.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-3-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:55:17PM +0000, Quentin Perret wrote:
> Now that PM_OPP provides a helper function to estimate the power
> consumed by CPUs, make sure to try and register an Energy Model (EM)
> from cpufreq-dt, hence ensuring interested subsystems (the task
> scheduler, for example) can make use of that information when available.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e58bfcb1169e..7556e07e7a9f 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -16,6 +16,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> +#include <linux/energy_model.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -152,6 +153,7 @@ static int resources_available(void)
>  
>  static int cpufreq_init(struct cpufreq_policy *policy)
>  {
> +	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
>  	struct cpufreq_frequency_table *freq_table;
>  	struct opp_table *opp_table = NULL;
>  	struct private_data *priv;
> @@ -160,7 +162,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	unsigned int transition_latency;
>  	bool fallback = false;
>  	const char *name;
> -	int ret;
> +	int ret, nr_opp;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -237,6 +239,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		ret = -EPROBE_DEFER;
>  		goto out_free_opp;
>  	}
> +	nr_opp = ret;
>  
>  	if (fallback) {
>  		cpumask_setall(policy->cpus);
> @@ -280,6 +283,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);

The perf domain is registered here but not unregistered in exit()
(there is currently no API do do this). When init() is called for the
second (or third, ...) time em_register_perf_domain() is called again,
though it skips the registration. To make things more explicit and not
rely on internal behavior of em_register_perf_domain() you could place
the registration inside an 'if (!em_cpu_get(cpu))' branch.

You should probably check the return value of em_register_perf_domain()
and at least print a warning in case of failure. This would require to
call em_register_perf_domain() only when CONFIG_ENERGY_MODEL=y (the
function returns -EINVAL otherwise).

I think this patch will result in error messages at registration on
platforms that use the cpufreq-dt driver and don't specify
'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
a problem as long as the cpufreq initialization succeeds regardless,
it could be seen as a not-so-gentle nudge to add the values.

Cheers

Matthias
