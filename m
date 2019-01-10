Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F521738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSbDvTUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfAJGMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:12:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44720 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfAJGMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:12:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so4824850pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 22:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nzfrVJW9G24WIb1bBk7/hio2+2C25a6nj7XsTozBYq8=;
        b=CSbDvTUOhTMLrqo6CCFBPvvcgdYvHLz9oC02hF43ZxcsDidlXJDl/E6ZUjzGWbQj5w
         v1E+D7MdWQ762t35/yV8KzK4S5/kTJ7+O7X3cLW7XIeS4wmGxKO8gbI5/M4NFO00/K3U
         n7xEaot55DvO7tYuOe5uETc0HwOsDSY3cNNTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nzfrVJW9G24WIb1bBk7/hio2+2C25a6nj7XsTozBYq8=;
        b=FpowHEd18GTinj9/E4bv8qFz6aNDPBbMHg7tR2C3jVBNxHrD3ogWZgQ7azlOZyg/Qu
         1IBQ5POoUfMfPABGChVYkXyqjEqo5oHOR0NSrqsd34qHWKNJr3MqBqRxG9EcMXWcyhWH
         Ij6gSONcyiaY28uRdHhHPE59FCgyKAHKO/HtNCh941xrXtEkssXlksF79y1l8Ao0CwAK
         7TNXJxh1RuxuhOf2b9q9GYKcwCiYhZlJpp+wSGqQ5XXA9pfx//GhN3d0flB9FgH3bznq
         NHprooz9sd4dXyoLNv+bThehH1gQYA4QkL+J47V1JTivxX4dKuqy/frHvpkPeLVOewI3
         3TNg==
X-Gm-Message-State: AJcUukeuxp/420ONQ40z/5dChvlHQ09GSpVHs3uaa8qRsUksWMmA6kib
        dtu5ydfdGrT3YwztOew3MmqcnA==
X-Google-Smtp-Source: ALg8bN6nUrMd2yYeWGtZ4+YLeBOt2J6vL4J5JqpNYLTCiN61v/3mHVuqfSp6TfMUCnxyXa8udbAnEg==
X-Received: by 2002:a62:6cc9:: with SMTP id h192mr8926733pfc.223.1547100733745;
        Wed, 09 Jan 2019 22:12:13 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id g28sm128749478pfd.100.2019.01.09.22.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 22:12:12 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:42:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 5/7] cpufreq: qcom-hw: Register as a cpufreq cooling
 device
Message-ID: <20190110061210.lz5i5wf7wxh22q7c@vireshk-i7>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <3c7d0e4a8373e89d6922543ccf56749970de5567.1547078153.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c7d0e4a8373e89d6922543ccf56749970de5567.1547078153.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-19, 05:30, Amit Kucheria wrote:
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 649dddd72749..1c01311e5927 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -216,7 +217,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	void __iomem *base = policy->driver_data - REG_PERF_STATE;
> +	struct thermal_cooling_device *cdev = policy->cooldev;
>  
> +	if (cdev)
> +		cpufreq_cooling_unregister(cdev);
>  	kfree(policy->freq_table);
>  	devm_iounmap(&global_pdev->dev, base);
>  
> @@ -238,6 +242,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>  	.init		= qcom_cpufreq_hw_cpu_init,
>  	.exit		= qcom_cpufreq_hw_cpu_exit,
>  	.fast_switch    = qcom_cpufreq_hw_fast_switch,
> +	.ready		= generic_cpufreq_ready,
>  	.name		= "qcom-cpufreq-hw",
>  	.attr		= qcom_cpufreq_hw_attr,
>  };

I liked the idea of reducing code duplication, but not much the
implementation. All we were able to get rid of was a call to
of_cpufreq_cooling_register() and nothing else. Is it worth it ?

Maybe we can add another flag in cpufreq.h:

#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)

and let the core do it all automatically by itself, that will get rid
of code duplication actually.

@Rafael: What do you say ?

-- 
viresh
