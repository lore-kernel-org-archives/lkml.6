Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D9C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A590920878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3FusRNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A590920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeLFEWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:22:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39882 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeLFEWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:22:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so10029096pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 20:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tWLLtHt/pS70icpqst2a5YeU4v537QLET21z/QMRNYA=;
        b=C3FusRNgvDTeYC779vgrCRYDhqGefhCxdgNnRe6yHe3tiEblRmeyQGkyg7kxng56N0
         6Vn/9mdfF78vfI/c1PdDJ1xPSD+99+DOyWa0dRr1oA3jree3D2gvMcrS3g8ObVZL0F6q
         +3F3iAaffSbzWzRi7kqmx7JRicdaKj5UWjmIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tWLLtHt/pS70icpqst2a5YeU4v537QLET21z/QMRNYA=;
        b=Be+9yhM4knL2iIlQWddlSawY0GdAZrxw/TnMQo4AVcUDmRYBfalY6thoUr1VGkYYyY
         4TLNPBeqr//dxkJ4xP3PvKgKK30WVxPiHr9b6x78z/krUNkR9G9jOhA+yBHyoGoAMCk+
         yDinT7D2LdunQ14/9fLm6rw/e5gD/Rog9Et2uPIo1Qw7Kp2Im9Gg+dVTKOtUSSeA2NMq
         xE0G/lihbawa6bq1WOQfCggj6hDLIAmVGUsWKwt5mPMprXe69f8uRcV+V98iyQ5hop8T
         /T2hKPaeK9s7e9TodGRfSmNC3Ngphm8QvODl+qGSkOCqmUsz9oLa4V7btD93MDQn5twf
         wtRA==
X-Gm-Message-State: AA+aEWZCfNkQpsNA7DFOLr0UQeLHQUpnBMQey/pyYEFCllelL1olBx7G
        4c9ZhbHnTlHhHo5zD+Yd+VcCMA==
X-Google-Smtp-Source: AFSGD/XMXONizL1drGQMzwkaSzwHGuXES3roxbafxX5ng3tWh7sESRHD2kHUtZs4RfyneWIbK/p68A==
X-Received: by 2002:a63:5407:: with SMTP id i7mr22708026pgb.413.1544070165224;
        Wed, 05 Dec 2018 20:22:45 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id r83sm47908196pfc.115.2018.12.05.20.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 20:22:44 -0800 (PST)
Date:   Thu, 6 Dec 2018 09:52:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181206042242.pzhkkfs4ew36nsnq@vireshk-i7>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
 <20181205061600.7zglbpkgbktn27am@vireshk-i7>
 <154402920660.88331.5729780274488650479@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154402920660.88331.5729780274488650479@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-12-18, 09:00, Stephen Boyd wrote:
> Here's a patch to squash in to fix those tiny problems. I left it as
> devm_ioremap_resource() because that has all the nice features of
> resource requesting inside and it didn't seem too bad to devm_iounmap()
> on the exit path.
> 
> ---------8<--------------
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index bcf9bb37298a..1e865e216839 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/slab.h>
>  
>  #define LUT_MAX_ENTRIES			40U
>  #define LUT_SRC				GENMASK(31, 30)
> @@ -77,8 +78,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>  	unsigned int max_cores = cpumask_weight(policy->cpus);
>  	struct cpufreq_frequency_table	*table;
>  
> -	table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> -				sizeof(*table), GFP_KERNEL);
> +	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>  	if (!table)
>  		return -ENOMEM;
>  
> @@ -144,7 +144,7 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>  
>  		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>  						 "#freq-domain-cells", 0,
> -						  &args);
> +						 &args);
>  		of_node_put(cpu_np);
>  		if (ret < 0)
>  			continue;
> @@ -170,7 +170,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>  			"#freq-domain-cells", 0, &args);
>  	of_node_put(cpu_np);
> -
>  	if (ret)
>  		return ret;
>  
> @@ -184,13 +183,15 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	/* HW should be in enabled state to proceed */
>  	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
>  		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto error;
>  	}
>  
>  	qcom_get_related_cpus(index, policy->cpus);
>  	if (!cpumask_weight(policy->cpus)) {
>  		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> -		return -ENOENT;
> +		ret = -ENOENT;
> +		goto error;
>  	}
>  
>  	policy->driver_data = base + REG_PERF_STATE;
> @@ -198,11 +199,25 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
>  	if (ret) {
>  		dev_err(dev, "Domain-%d failed to read LUT\n", index);
> -		return ret;
> +		goto error;
>  	}
>  
>  	policy->fast_switch_possible = true;
>  
> +	return 0;
> +
> +error:
> +	devm_iounmap(dev, base);
> +	return ret;
> +}
> +
> +static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	void __iomem *base = policy->driver_data - REG_PERF_STATE;
> +
> +	kfree(policy->freq_table);
> +	devm_iounmap(&global_pdev->dev, base);
> +
>  	return 0;
>  }
>  
> @@ -219,6 +234,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>  	.target_index	= qcom_cpufreq_hw_target_index,
>  	.get		= qcom_cpufreq_hw_get,
>  	.init		= qcom_cpufreq_hw_cpu_init,
> +	.exit		= qcom_cpufreq_hw_cpu_exit,
>  	.fast_switch    = qcom_cpufreq_hw_fast_switch,
>  	.name		= "qcom-cpufreq-hw",
>  	.attr		= qcom_cpufreq_hw_attr,
> @@ -248,12 +264,11 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
>  	if (ret) {
>  		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> -		return ret;
> +	} else {
> +		dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
>  	}
>  
> -	dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)

LGTM

-- 
viresh
