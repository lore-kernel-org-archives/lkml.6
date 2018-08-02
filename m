Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41731C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD822152D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lBTiAh9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD822152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeHCB31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:29:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38036 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeHCB31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:29:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so1934587pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 16:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6O2CaPg5ISnU8MDBkUAcepOTHU7ARhfyOJ9/2xTKacw=;
        b=lBTiAh9xKlrcZuy5s50lmCiw9my8ABwI3ahxaaXWqYo1cI3CGqKM5bZgalXo1txnk2
         0w1fwCYXsTTo5OIAh1QBGeTZIVgoerWnZNN7a91gMsDY/wx8jBLSwF7vstRUjrs8SKzo
         86god2Ya4iQG5yOIeWFNsAp7MZ+D7Z1/c6sbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6O2CaPg5ISnU8MDBkUAcepOTHU7ARhfyOJ9/2xTKacw=;
        b=jMAZRiEQeZ7SX54Dhglmxs4AfYZG1N/6eQfVm7ZNpqE1V/ettPD/NJlLyhdnXw31ng
         Qm0BVnXG2NmMHWByV+QUWodk0TrxrOyKHQClnxLiSTlYHw0HoWQrPlEajOOa7CRVe0qY
         W63M62Jdxtl27cycYJ+pZsnF4zfw/xxDXbMa/Wpb/4lxMY8lszUb996LgsqqHVIm1ptu
         WKqK0lv9PVNu3OLtLbls/aQ4cXUT1XpIrpsn3wVtyFHxjuE4u06aaWzkEgPJG2hERqkG
         qKE7Oc47/sQ6hWGl45PRMUH14NQSl/yZoTMzrh/s36/2Zks9kCSnsjgwpbY1akhXLEGB
         EweQ==
X-Gm-Message-State: AOUpUlGWB3jiI7qdVJfm9404eEoIZJ+TnWK/kpwQ0I9Wz6qQhV9quN7f
        R7Gu2lYDolhspQ5dTpKhYG8wQg==
X-Google-Smtp-Source: AAOMgpccBP6tspWxgPbrsp5jvpbso4LyTliQI9WvavUbg+3lsfUm/7eqg9g3Mzc7qCLM+r5oEhSE0A==
X-Received: by 2002:a63:f849:: with SMTP id v9-v6mr1326267pgj.71.1533252961226;
        Thu, 02 Aug 2018 16:36:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j5-v6sm4248932pff.139.2018.08.02.16.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 16:36:00 -0700 (PDT)
Date:   Thu, 2 Aug 2018 16:36:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 03/12] PM / devfreq: Don't adjust to user limits in
 governors
Message-ID: <20180802233600.GT68975@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <20180703234705.227473-4-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703234705.227473-4-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

this patch and "PM / devfreq: Fix handling of min/max_freq == 0"
address issues not directly related with the throttler. It seems it
could still take a while for the throttler to move forward, do you
want me to spin out these two patches so that they can get merged
independently from the rest of the series?

Thanks

Matthias

On Tue, Jul 03, 2018 at 04:46:56PM -0700, Matthias Kaehlcke wrote:
> Several governors use the user space limits df->min/max_freq to adjust
> the target frequency. This is not necessary, since update_devfreq()
> already takes care of this. Instead the governor can request the available
> min/max frequency by setting the target frequency to DEVFREQ_MIN/MAX_FREQ
> and let update_devfreq() take care of any adjustments.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - squashed "PM / devfreq: Remove redundant frequency adjustment from governors"
>   and "PM / devfreq: governors: Return device frequency limits instead of user
>   limits"
> - updated subject and commit message
> - use DEVFREQ_MIN/MAX_FREQ instead of df->scaling_min/max_freq
> ---
>  drivers/devfreq/governor.h                |  3 +++
>  drivers/devfreq/governor_performance.c    |  5 +----
>  drivers/devfreq/governor_powersave.c      |  2 +-
>  drivers/devfreq/governor_simpleondemand.c | 12 +++---------
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  5 files changed, 12 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index cfc50a61a90d..b81700244ce3 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -25,6 +25,9 @@
>  #define DEVFREQ_GOV_SUSPEND			0x4
>  #define DEVFREQ_GOV_RESUME			0x5
>  
> +#define DEVFREQ_MIN_FREQ			0
> +#define DEVFREQ_MAX_FREQ			ULONG_MAX
> +
>  /**
>   * struct devfreq_governor - Devfreq policy governor
>   * @node:		list node - contains registered devfreq governors
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index 4d23ecfbd948..ded429fd51be 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -20,10 +20,7 @@ static int devfreq_performance_func(struct devfreq *df,
>  	 * target callback should be able to get floor value as
>  	 * said in devfreq.h
>  	 */
> -	if (!df->max_freq)
> -		*freq = UINT_MAX;
> -	else
> -		*freq = df->max_freq;
> +	*freq = DEVFREQ_MAX_FREQ;
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
> index 0c42f23249ef..9e8897f5ac42 100644
> --- a/drivers/devfreq/governor_powersave.c
> +++ b/drivers/devfreq/governor_powersave.c
> @@ -20,7 +20,7 @@ static int devfreq_powersave_func(struct devfreq *df,
>  	 * target callback should be able to get ceiling value as
>  	 * said in devfreq.h
>  	 */
> -	*freq = df->min_freq;
> +	*freq = DEVFREQ_MIN_FREQ;
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 28e0f2de7100..c0417f0e081e 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -27,7 +27,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
>  	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
>  	struct devfreq_simple_ondemand_data *data = df->data;
> -	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
>  
>  	err = devfreq_update_stats(df);
>  	if (err)
> @@ -47,7 +46,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  
>  	/* Assume MAX if it is going to be divided by zero */
>  	if (stat->total_time == 0) {
> -		*freq = max;
> +		*freq = DEVFREQ_MAX_FREQ;
>  		return 0;
>  	}
>  
> @@ -60,13 +59,13 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	/* Set MAX if it's busy enough */
>  	if (stat->busy_time * 100 >
>  	    stat->total_time * dfso_upthreshold) {
> -		*freq = max;
> +		*freq = DEVFREQ_MAX_FREQ;
>  		return 0;
>  	}
>  
>  	/* Set MAX if we do not know the initial frequency */
>  	if (stat->current_frequency == 0) {
> -		*freq = max;
> +		*freq = DEVFREQ_MAX_FREQ;
>  		return 0;
>  	}
>  
> @@ -85,11 +84,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
>  	*freq = (unsigned long) b;
>  
> -	if (df->min_freq && *freq < df->min_freq)
> -		*freq = df->min_freq;
> -	if (df->max_freq && *freq > df->max_freq)
> -		*freq = df->max_freq;
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 080607c3f34d..378d84c011df 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -26,19 +26,11 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>  {
>  	struct userspace_data *data = df->data;
>  
> -	if (data->valid) {
> -		unsigned long adjusted_freq = data->user_frequency;
> -
> -		if (df->max_freq && adjusted_freq > df->max_freq)
> -			adjusted_freq = df->max_freq;
> -
> -		if (df->min_freq && adjusted_freq < df->min_freq)
> -			adjusted_freq = df->min_freq;
> -
> -		*freq = adjusted_freq;
> -	} else {
> +	if (data->valid)
> +		*freq = data->user_frequency;
> +	else
>  		*freq = df->previous_freq; /* No user freq specified yet */
> -	}
> +
>  	return 0;
>  }
>  
