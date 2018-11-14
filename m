Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A358C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE43221582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EciIJfC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE43221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeKNOEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:04:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39671 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNOEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:04:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so7104036pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 20:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/6H6fCpHKgt4ovDnj/a7mCGZ9VH8jkTFvWTLJAvTOw=;
        b=EciIJfC7U4jHvmXl4c5Tu+aXjxzXJ/HRavJpAuCT/vGlYsvc+UPVPdRRrzTeZNa44m
         zxyPpuhu77lz8EHVeyvwV9wdNGjyLJsBpcbCdMfQUZAa/vBX0mDSay0SSseNXL10OL8q
         GuYWczKtwx181U2t8xoQFY6EouGk9oVg1HyMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/6H6fCpHKgt4ovDnj/a7mCGZ9VH8jkTFvWTLJAvTOw=;
        b=RHNPpCr+HW8F7487Md2+utfCDh6qht1eNxLEFF7ajIfQr2YnJbrMEsBuT/+9O1mavf
         3PZHvEAErok46598PN+HhchOOBr+QK6PCh9B9ErREr/Zp/RibZ4lbJmndmJA9D4ga4cI
         se/kbyInSitLdbb3mkPw3oi3gK7aL5qnPjARpxXxiWPowk2F/JlgMyMrs6/K+elAXCYK
         yXQhcuvxwzQEVGt4NSrVL1w5UrBygbUPB4xYGoXes5tqo1n1O2lnAa/5EU+xIrI/WeHz
         5mKKtkJPdmgr8qWHtrSpmQ9wq+aSJY1xzPnA1rRMBSUn7zQynffMgJwUPtofSWjvCpjS
         LJFg==
X-Gm-Message-State: AGRZ1gLFGgHSrgbu7Yzp87z9Rf5gLR8P/eteAoueACDrYE7KlQLhEBgL
        DovYiGPWalAz4jHetM3dwJzs6g==
X-Google-Smtp-Source: AJdET5e+aMX4pmGJmlZs23GN/v+lh8I2fHYY3bCdfeOu5LN+lieu/3D/UvMSgkEYszWGITv225f06A==
X-Received: by 2002:a17:902:112b:: with SMTP id d40-v6mr353179pla.48.1542168166734;
        Tue, 13 Nov 2018 20:02:46 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id 186sm16283741pga.36.2018.11.13.20.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 20:02:45 -0800 (PST)
Date:   Wed, 14 Nov 2018 09:32:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dave Gerlach <d-gerlach@ti.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy J <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4] cpufreq: ti-cpufreq: Only register platform_device
 when supported
Message-ID: <20181114040242.wfpvazl62g6phy3o@vireshk-i7>
References: <20181113193040.15181-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113193040.15181-1-d-gerlach@ti.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-11-18, 13:30, Dave Gerlach wrote:
> Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
> the driver to probe on any platforms where the driver is built in.
> However, this should only happen on platforms that actually can make use
> of the driver. There is already functionality in place to match the
> SoC compatible so let's factor this out into a separate call and
> make sure we find a match before creating the ti-cpufreq platform device.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4: Use platform_device_register_data rather than
> 	platform_device_register_resndata as we are only passing data.
> 
> 	v3: https://patchwork.kernel.org/patch/10681161/
> 
>  drivers/cpufreq/ti-cpufreq.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 3f0e2a14895a..22b53bf26817 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -201,19 +201,28 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
>  	{},
>  };
>  
> +static const struct of_device_id *ti_cpufreq_match_node(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +
> +	np = of_find_node_by_path("/");
> +	match = of_match_node(ti_cpufreq_of_match, np);
> +	of_node_put(np);
> +
> +	return match;
> +}
> +
>  static int ti_cpufreq_probe(struct platform_device *pdev)
>  {
>  	u32 version[VERSION_COUNT];
> -	struct device_node *np;
>  	const struct of_device_id *match;
>  	struct opp_table *ti_opp_table;
>  	struct ti_cpufreq_data *opp_data;
>  	const char * const reg_names[] = {"vdd", "vbb"};
>  	int ret;
>  
> -	np = of_find_node_by_path("/");
> -	match = of_match_node(ti_cpufreq_of_match, np);
> -	of_node_put(np);
> +	match = dev_get_platdata(&pdev->dev);
>  	if (!match)
>  		return -ENODEV;
>  
> @@ -290,7 +299,14 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  static int ti_cpufreq_init(void)
>  {
> -	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
> +	const struct of_device_id *match;
> +
> +	/* Check to ensure we are on a compatible platform */
> +	match = ti_cpufreq_match_node();
> +	if (match)
> +		platform_device_register_data(NULL, "ti-cpufreq", -1, match,
> +					      sizeof(*match));
> +
>  	return 0;
>  }
>  module_init(ti_cpufreq_init);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
