Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03859C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D342148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlysjKYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfA2Faq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:30:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36389 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfA2Fap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:30:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so9151119pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lLtNXSuhfQ2a5ic9Oh5vSesrlVFA1pyWAIE7zBbCCXs=;
        b=UlysjKYV5FpjsXM/z43czmFiIOlLsRVxflQicHVxiJv1c4pZLAiF8SxaDclUQubbbs
         2Nrhy+iVlDdkXBdsywB9q5w7FuwecdPYI0bqWLD2HeFBTkvXlvDTm0CD8h2fDUkehM6a
         fNBpvaa7tHe2amAzNoXSEmYkRFd9rBLi4kSKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lLtNXSuhfQ2a5ic9Oh5vSesrlVFA1pyWAIE7zBbCCXs=;
        b=ud2UAu7DZFFkCHLZABh1FjHTvzddzYEJEF/QL6h1djwEf2M84DfwjPDRY4WSi25HYj
         MzioeULAUSAZ09hepF/nX8ghQNdT2xjKuKzbAirNWqvdvJTvQcy9fjVqd2H3Pjbio0Yj
         /a7z83BsknMcIoCUHXBttXIOYAbZ7MHlM4m288VU/XYRGrOIAHu0nhGlzVZ6shvNPo70
         WAccy61Zt47BzCcKGJ1shkdPhwcDbyjl7aDdO2w01P2OvGGbGyzKSFHkKY3gvQIJoS8u
         HqbkPQIMUy6ImHKa3Rk5lFlyL9L4JSsxI8fqTco2lStx2Fd8kr6frZFYxmhsYfyG25r4
         lN7w==
X-Gm-Message-State: AJcUukcQLX/2v4iblH1uV14fz0qsdnWcAuCtSM6+0GiYtzti4z9tlnkJ
        XQu7SNfeuDVF9t22VWAqWqfGXQ==
X-Google-Smtp-Source: ALg8bN7S80eAeaLyRknarNnMGbTRRAqMUdweWiSpaCtKH/p6fF8r571jOKvmjABuNzvPQXShdcCtwA==
X-Received: by 2002:a65:4784:: with SMTP id e4mr21998619pgs.12.1548739844424;
        Mon, 28 Jan 2019 21:30:44 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id 4sm43829983pfq.10.2019.01.28.21.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 21:30:43 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:00:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190129053041.ymyhfusj6eimpxfu@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-3-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-19, 16:55, Quentin Perret wrote:
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

Hmm, so all the earlier comments regarding prototype of this routine are invalid
because of this.

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

Instead use nr_opp instead of ret while calling dev_pm_opp_get_opp_count().

>  
>  	if (fallback) {
>  		cpumask_setall(policy->cpus);
> @@ -280,6 +283,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> +
>  	return 0;
>  
>  out_free_cpufreq_table:
> -- 
> 2.20.1

-- 
viresh
