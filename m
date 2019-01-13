Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691A0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0EA206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547385418;
	bh=JV+LGO5OipigZkPktR4ZEeyRJfre2wODY7raNSKlCkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eFGooFyC9hbdPYZjxhn8W3hHOIqJX4hkcEoQ70U1kS4vBmyP7r0KFYNIxEoHCuRI7
	 Y8O6g7kVO7cXYA2zkPX3Q3dJHdiG9x3938WD1KgK2y6lKPXw4EawWZgNzO1mN2xAyL
	 looWAv9dRD+2oNVX2wCQVWHFt5g1ogOQabwxgy18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfAMNQa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 08:16:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36893 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfAMNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 08:16:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so16599904edb.4;
        Sun, 13 Jan 2019 05:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JjL7eeMXMIM7Zm7I/VKfxBqNJX9ibDYcknfQzbkZmdU=;
        b=uYfuE1kRL77UDB/tFt/p8qItSE71w0lCTaohrMncXYm3PFpyys1ePqRxkvJ9Q/ZrkV
         4MSvpoYpFk2wel0w4Osio6UpJ2SwSx8XOyLlzsIjcm9xjOdFjLqgdYj0vTxECG3+WXqs
         ST1Wp0TWCzMJ5uqv/4uRsXlSkG9epqHemvybJEg024RBQHN1rWkNg5hvijbWIzAfqk61
         SvJHQnmD4nW7yZ+i/GCeVQfYN5i8/Cf5WC0g0uhOZxje5aKztr8fcXw/R/amiy3RxeV7
         H5m7m6z3cH+r822tUxHZbh1iNNkXLdFTD8itX7NTJlfSaoifl+3Y+t2Nc1OXAiYM4npT
         bq2g==
X-Gm-Message-State: AJcUukek3c8K+XVVEPUYzCIvyU5vKaiuHYjaNHcA05tcnNe8EcpsYJ9q
        eQT/G9ArrXgeCxqwtccbASc=
X-Google-Smtp-Source: ALg8bN4AhWRlVq2e00OHUqq/4NiwdIBYhW53zhdRdTpopKhwHnKaKA0AgrlFKP8yxWZTUBnrRz+2Gw==
X-Received: by 2002:a50:a3d1:: with SMTP id t17mr20083256edb.238.1547385387362;
        Sun, 13 Jan 2019 05:16:27 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id r18-v6sm2065927ejz.22.2019.01.13.05.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 05:16:26 -0800 (PST)
Date:   Sun, 13 Jan 2019 14:16:24 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: s5pv210: Defer probe if getting regulators
 fail
Message-ID: <20190113131624.GA2672@kozik-lap>
References: <20190111194244.2439-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190111194244.2439-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:42:44PM +0100, Paweł Chmiel wrote:
> There is possibility, that when probing driver, regulators are not yet
> initialized. In this case we should return EPROBE_DEFER and wait till
> they're initialized, since they're required currently for cpufreq driver
> to work. Also move regulator initialization code at beginning of probe,
> so we can defer as fast as posibble.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v2:
>   - Handle all error paths in probe
> 
> Changes from v1:
>   - Fix compilation error
>   - Reorganize code so it's smaller
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 68 ++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index f51697f1e0b3..627b132e3e61 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -584,7 +584,7 @@ static struct notifier_block s5pv210_cpufreq_reboot_notifier = {
>  static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np;
> -	int id;
> +	int id, result = 0;
>  
>  	/*
>  	 * HACK: This is a temporary workaround to get access to clock
> @@ -594,18 +594,40 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  	 * this whole driver as soon as S5PV210 gets migrated to use
>  	 * cpufreq-dt driver.
>  	 */
> +	arm_regulator = regulator_get(NULL, "vddarm");
> +	if (IS_ERR(arm_regulator)) {
> +		if (PTR_ERR(arm_regulator) == -EPROBE_DEFER)
> +			pr_debug("vddarm regulator not ready, defer\n");
> +		else
> +			pr_err("failed to get regulator vddarm\n");
> +		result = PTR_ERR(arm_regulator);
> +		goto err_arm_regulator;

Just return here.

> +	}
> +
> +	int_regulator = regulator_get(NULL, "vddint");
> +	if (IS_ERR(int_regulator)) {
> +		if (PTR_ERR(int_regulator) == -EPROBE_DEFER)
> +			pr_debug("vddint regulator not ready, defer\n");
> +		else
> +			pr_err("failed to get regulator vddint\n");
> +		result = PTR_ERR(int_regulator);
> +		goto err_int_regulator;
> +	}
> +
>  	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
>  	if (!np) {
>  		pr_err("%s: failed to find clock controller DT node\n",
>  			__func__);
> -		return -ENODEV;
> +		result = -ENODEV;
> +		goto err_clock;
>  	}
>  
>  	clk_base = of_iomap(np, 0);
>  	of_node_put(np);
>  	if (!clk_base) {
>  		pr_err("%s: failed to map clock registers\n", __func__);
> -		return -EFAULT;
> +		result = -EFAULT;
> +		goto err_clock;
>  	}
>  
>  	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
> @@ -614,7 +636,8 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
>  				__func__, np);
>  			of_node_put(np);
> -			return id;
> +			result = id;
> +			goto err_clk_base;
>  		}
>  
>  		dmc_base[id] = of_iomap(np, 0);
> @@ -622,33 +645,40 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  			pr_err("%s: failed to map dmc%d registers\n",
>  				__func__, id);
>  			of_node_put(np);
> -			return -EFAULT;
> +			result = -EFAULT;
> +			goto err_dmc;
>  		}
>  	}
>  
>  	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id) {
>  		if (!dmc_base[id]) {
>  			pr_err("%s: failed to find dmc%d node\n", __func__, id);
> -			return -ENODEV;
> +			result = -ENODEV;
> +			goto err_dmc;
>  		}
>  	}
>  
> -	arm_regulator = regulator_get(NULL, "vddarm");
> -	if (IS_ERR(arm_regulator)) {
> -		pr_err("failed to get regulator vddarm\n");
> -		return PTR_ERR(arm_regulator);
> -	}
> -
> -	int_regulator = regulator_get(NULL, "vddint");
> -	if (IS_ERR(int_regulator)) {
> -		pr_err("failed to get regulator vddint\n");
> -		regulator_put(arm_regulator);
> -		return PTR_ERR(int_regulator);
> -	}
> -
>  	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
>  
>  	return cpufreq_register_driver(&s5pv210_driver);
> +
> +err_dmc:
> +	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id)
> +		if (dmc_base[id])
> +			iounmap(dmc_base[id]);

You will iounmap the same pointer twice, if first device bind failed
while following this error path and someone tries to bind second time
(again with error leading to this error path). You zero the pointer
either at beginning of probe or after iounmapping.

Best regards,
Krzysztof


> +
> +err_clk_base:
> +	iounmap(clk_base);
> +
> +err_clock:
> +	regulator_put(int_regulator);
> +
> +err_int_regulator:
> +	regulator_put(arm_regulator);
> +
> +err_arm_regulator:
> +
> +	return result;
>  }
>  
>  static struct platform_driver s5pv210_cpufreq_platdrv = {
> -- 
> 2.17.1
> 
