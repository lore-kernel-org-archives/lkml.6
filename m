Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61A5206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZLopK7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61A5206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJCL2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 07:28:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33015 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeJCL2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 07:28:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so1060259pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 21:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mZ9hKOIb6sedp+U/NYBKdQqU+QZ7Xeb6W7xS8YMPzj0=;
        b=DZLopK7mCQOekvBGvr8Z/WaNGOiswXw5jHu9dRhYqUehJpmvQYJocOtJE6jl+C8fFr
         hXL/YV64Jb1fVWqtb4yskpkwEIFekUCDhW6XZIE12wpt5BnB2lbOBlsLmV8rQhE0ZkxA
         Gj4I/Aa8e1+GyEB0I+tXMV9yHOdZOf/OnMmH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mZ9hKOIb6sedp+U/NYBKdQqU+QZ7Xeb6W7xS8YMPzj0=;
        b=alr9QJvOximRVDw8meYLM8khqZa63s9FFi7/MbTIKK8rFirRcWbDVFGEt95pZquspf
         jJAEQq3kIS0Aqb0T/WVIdDValT7EvWOYb7fkhlULQjngoCbgpRaVHLBOekVJamEex4n+
         cNix8QP82I5Dky7eoAS+CsoTE4YX+KCk4lU6pVom3cTOKFoHB6aX7fm1XBaHzwOeLSs6
         4jhXpNGhHWn9e+ISPspcq2UVjmAr9RzuOkTfTfC4F7WqsdR6fHNUCNdYYIy189QsLkmm
         KZrnigAGrlCLFNLFZydfMSJeEYrJW5+ovrXCZITtj80jQqt9xT6PSGBqiuwlYBo96+sh
         Tanw==
X-Gm-Message-State: ABuFfojY0RQTKYB6iud7JJXqTWWu2Vczjud/YeKteAoYgVtIZZheT7SR
        Hzj0JqUMJ4Oa5/YwA3r8XymDdQ==
X-Google-Smtp-Source: ACcGV62hTFwzIrGHUxoazUjc+9MPCRhxpwO/9pARNXOqsU6vWS/XI2FPd7WY/1ooxmx09Bq5Cgxscg==
X-Received: by 2002:a62:f610:: with SMTP id x16-v6mr19201171pfh.169.1538541712998;
        Tue, 02 Oct 2018 21:41:52 -0700 (PDT)
Received: from localhost ([122.167.25.174])
        by smtp.gmail.com with ESMTPSA id u184-v6sm327380pgd.27.2018.10.02.21.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 21:41:52 -0700 (PDT)
Date:   Wed, 3 Oct 2018 10:11:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt-platdev: mark RK3399 as having separate
 policies per cluster
Message-ID: <20181003044150.i46eaoyco3w47nid@vireshk-i7>
References: <20181001202153.GA240123@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001202153.GA240123@dtor-ws>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-10-18, 13:21, Dmitry Torokhov wrote:
> RK3399 has one cluster with 4 small cores, and another one with 2 big
> cores, with cores in different clusters having different OPPs and thus
> different policies. Let's enable this via "have_governor_per_policy"
> platform data.

The policies are always different in such cases, with or without this flag. What
this flag rather enables is for us to have separate set of tunables for the
governor for individual policies.

For example, without this flag there will be a single governor directory:

/sys/devices/system/cpu/cpufreq/schedutil/

and the value of tunables in that directory will be used for all cpufreq
policies.

With this flag you wouldn't have the governor directory there, but rather in:

/sys/devices/system/cpu/cpufreq/policy*/schedutil/

i.e. tunables per policy and that's why the name of the flag is:
have_governor_per_policy.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Not tested, but we had a patch unconditionally enabling
> CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag in tree we used to ship devices
> based on RK3399 platform. 

Sure, that sounds good. Just that you need to update the commit log a bit.

>  drivers/cpufreq/cpufreq-dt-platdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index fe14c57de6ca..040ec0f711f9 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -78,7 +78,10 @@ static const struct of_device_id whitelist[] __initconst = {
>  	{ .compatible = "rockchip,rk3328", },
>  	{ .compatible = "rockchip,rk3366", },
>  	{ .compatible = "rockchip,rk3368", },
> -	{ .compatible = "rockchip,rk3399", },
> +	{ .compatible = "rockchip,rk3399",
> +	  .data = &(struct cpufreq_dt_platform_data)

data is void *. No need to provide typecast information. This shouldn't throw
any build warnings I believe.

> +		{ .have_governor_per_policy = true, },

-- 
viresh
