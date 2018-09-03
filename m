Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B980C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B52F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DiJvO+9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B52F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeICKuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:50:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37483 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeICKuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:50:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so8237139pfd.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 23:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U1OsCg59PTGtszobUnJ/ZTfUQpqX81aecLOXDWSZYvM=;
        b=DiJvO+9IjqHxkJbFRaSOVQBGTJLvuEKhCoe9AHhYwzidCRQADK3/On9RTgosznkRhR
         BLLsE84NY+Ls72x+TwvjMyB4b2zl8wq73QFjO3Me3II5DHvIjJSH/nF4+w6D0HyYWv67
         XBrgoQjTl7QK/dR1jGVfhRYZAO8HXEDeCGriw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U1OsCg59PTGtszobUnJ/ZTfUQpqX81aecLOXDWSZYvM=;
        b=TtQp21A3UH3gVpGnIA4+uqWWZUDDUl3tgq+nkyRHstn+vWhb/G+vZNhTvjKpINoNu1
         F+Yn6TcNVf3jX1NRBb5eNdarijOldlfGpDg1e2PCu8gPJKmsGVUEOD7f3Gfnl4PCXkzM
         aAgw6+6tv6uxCGXLq41zztzIhnM9B//bgXyFtUNSytYccgROBQKY9rRPeb6doTlB1OTu
         hpaOZ/ApGr5S7BlP3S3qs50DAQubd9AckilLSDi7/eh1q3Dw3O0WmG7FwUq/IwuKsVXE
         RvkNMrSJUirH69Q/nK2rExxn6lapGiN5S8yaeJActaFQAFBqER9o+0bNUEFfrEqb7S2d
         f5uQ==
X-Gm-Message-State: APzg51CHphO2LM01qh2uPd0ukyvLwuX5t14iPnOJpTgor0mJXo+Ev0pV
        4IOP36vXXx9O7PxQmg0aTPQyJQ==
X-Google-Smtp-Source: ANB0VdaFRBEWQCpHVUwR0LLd8mlQZjHhxu6+VDl9gI97jenDBiKziiX0g0nwrVSpt4AxGo3lyG2TdA==
X-Received: by 2002:a62:90d4:: with SMTP id q81-v6mr27827883pfk.37.1535956294491;
        Sun, 02 Sep 2018 23:31:34 -0700 (PDT)
Received: from localhost ([122.171.76.41])
        by smtp.gmail.com with ESMTPSA id g5-v6sm35401541pgn.73.2018.09.02.23.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 23:31:33 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:01:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dave Gerlach <d-gerlach@ti.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Keerthy J <j-keerthy@ti.com>
Subject: Re: [PATCH v2] cpufreq: ti-cpufreq: Only register platform_device
 when supported
Message-ID: <20180903063131.6wmbl66544svagst@vireshk-i7>
References: <20180823192035.22940-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823192035.22940-1-d-gerlach@ti.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-18, 14:20, Dave Gerlach wrote:
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
> v1->v2:
> * Return 'match' directly in ti_cpufreq_match_node.
> * Add Johan's Reviewed-by.
> 
>  drivers/cpufreq/ti-cpufreq.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 3f0e2a14895a..6b025953ddee 100644
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
> +	match = ti_cpufreq_match_node();
>  	if (!match)
>  		return -ENODEV;
>  
> @@ -290,7 +299,10 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  static int ti_cpufreq_init(void)
>  {
> -	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
> +	/* Check to ensure we are on a compatible platform */
> +	if (ti_cpufreq_match_node())
> +		platform_device_register_simple("ti-cpufreq", -1, NULL, 0);

Maybe call platform_device_register_resndata() here instead and pass match->data
to it and then you wouldn't be required to match again in probe ?

-- 
viresh
