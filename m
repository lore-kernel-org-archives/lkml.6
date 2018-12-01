Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B29C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BC22082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sncUupn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BC22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbeLBFxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:53:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43470 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeLBFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 00:53:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so4387422pfk.10;
        Sat, 01 Dec 2018 10:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3AqtUs9Tpc32OIY/XuOJ85jkLaPvzcYeUiqsKiMNG8=;
        b=sncUupn0N3ZdCf/ny3nAC30ZH9x1OeDI5L8Jrrux66L3TFxw7No70Iy1WtZs8avDML
         iC8TdJwGV7Z9n4RkaSn3aKxxNaEx1Ry6Mq4MHSBDvCV7wNqltIZdA+a8qqDQ1mcX07Vr
         aMdVLsyY6uK3rS6fyyUtlsgphByZWJ7gX4GhWvIpW82/MWoAE7OIZE2E0pHj9cNWqi1H
         c7yIRbToCzeEfa3q/6STrm0dmIr59oRd99dlmytoEdhi3MSu+ujppTYkNxca1S6wJ3oV
         FK1MFue/KpMFrziMpaPweV+3eCIli6A2zpotPre+UkIIVAj54L9+8B290i7tWgWKB73Y
         P8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3AqtUs9Tpc32OIY/XuOJ85jkLaPvzcYeUiqsKiMNG8=;
        b=Bw5W/1pJvpCKR2SeEkNWYpgxn2x4uHYL4xBzliXtPGKJAjli8RcMVPNq9PYPc0ruKw
         tWukq2tvwMF+nRXLGnIOl26Y3BGVktG3DYYQQj1Q6+g5gks8yVVqOYQlcemxOB6ipT9v
         HUKVZmIQd4HSHaPBVlLKiSa8YrDfg7t0sC3tqCqGBk1MFMjTPqmXe0dEKjYe57/w1S9D
         080vxXwCWIDtRODhIvfH8BA8Svxo7hGWYF6YwnH3D5FyO9H0mEIF431R2d8BAxmHz+8n
         qmDovO5NaWhQOhi7NsD+oNCTVx+qIS9t4aKWS8laMf3lWiSwD/ZlULfwm+cxLUHu1CnL
         Fc0w==
X-Gm-Message-State: AA+aEWaE8o8di6/0CXfwZID5ZcBUPh/mhjDQzQ93iBHN7dEOV9tM9TWe
        2M9B4HVkJa5P1iM/K3g4swY=
X-Google-Smtp-Source: AFSGD/WOtpUCGdyKbE4dr1KQ6JvZkKV/6YSJmclHEkmWKZf74SHki6C7lzOlj8On1ESklrcdIyL3Sg==
X-Received: by 2002:a63:df13:: with SMTP id u19mr8633057pgg.294.1543689593514;
        Sat, 01 Dec 2018 10:39:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v76sm24060908pfj.145.2018.12.01.10.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:39:52 -0800 (PST)
Date:   Sat, 1 Dec 2018 10:39:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 1/2] hwmon: (ntc_thermistor) sort thermistor id lists
 alphabetically
Message-ID: <20181201183951.GA11613@roeck-us.net>
References: <b732b7e0-0076-9cb3-a146-4d0cd80d2658@roeck-us.net>
 <20181121160327.16772-1-peda@axentia.se>
 <20181121160327.16772-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121160327.16772-2-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 04:03:39PM +0000, Peter Rosin wrote:
> Use an enum to index the array, so that it is possible to add sorted
> entries without causing churn.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ntc_thermistor.c | 82 +++++++++++++++++++++++++-----------------
>  1 file changed, 49 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index e0c6b2f244a6..7747c1ed1f02 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -45,18 +45,34 @@ struct ntc_compensation {
>  	unsigned int	ohm;
>  };
>  
> -/* Order matters, ntc_match references the entries by index */
> +/*
> + * Used as index in a zero-terminated array, holes not allowed so
> + * that NTC_LAST is the first empty array entry.
> + */
> +enum {
> +	NTC_B57330V2103,
> +	NTC_B57891S0103,
> +	NTC_NCP03WB473,
> +	NTC_NCP03WF104,
> +	NTC_NCP15WB473,
> +	NTC_NCP15WL333,
> +	NTC_NCP15XH103,
> +	NTC_NCP18WB473,
> +	NTC_NCP21WB473,
> +	NTC_LAST,
> +};
> +
>  static const struct platform_device_id ntc_thermistor_id[] = {
> -	{ "ncp15wb473", TYPE_NCPXXWB473 },
> -	{ "ncp18wb473", TYPE_NCPXXWB473 },
> -	{ "ncp21wb473", TYPE_NCPXXWB473 },
> -	{ "ncp03wb473", TYPE_NCPXXWB473 },
> -	{ "ncp15wl333", TYPE_NCPXXWL333 },
> -	{ "b57330v2103", TYPE_B57330V2103},
> -	{ "ncp03wf104", TYPE_NCPXXWF104 },
> -	{ "ncp15xh103", TYPE_NCPXXXH103 },
> -	{ "b57891s0103", TYPE_B57891S0103 },
> -	{ },
> +	[NTC_B57330V2103]     = { "b57330v2103",     TYPE_B57330V2103 },
> +	[NTC_B57891S0103]     = { "b57891s0103",     TYPE_B57891S0103 },
> +	[NTC_NCP03WB473]      = { "ncp03wb473",      TYPE_NCPXXWB473 },
> +	[NTC_NCP03WF104]      = { "ncp03wf104",      TYPE_NCPXXWF104 },
> +	[NTC_NCP15WB473]      = { "ncp15wb473",      TYPE_NCPXXWB473 },
> +	[NTC_NCP15WL333]      = { "ncp15wl333",      TYPE_NCPXXWL333 },
> +	[NTC_NCP15XH103]      = { "ncp15xh103",      TYPE_NCPXXXH103 },
> +	[NTC_NCP18WB473]      = { "ncp18wb473",      TYPE_NCPXXWB473 },
> +	[NTC_NCP21WB473]      = { "ncp21wb473",      TYPE_NCPXXWB473 },
> +	[NTC_LAST]            = { },
>  };
>  
>  /*
> @@ -327,36 +343,36 @@ static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
>  }
>  
>  static const struct of_device_id ntc_match[] = {
> -	{ .compatible = "murata,ncp15wb473",
> -		.data = &ntc_thermistor_id[0] },
> -	{ .compatible = "murata,ncp18wb473",
> -		.data = &ntc_thermistor_id[1] },
> -	{ .compatible = "murata,ncp21wb473",
> -		.data = &ntc_thermistor_id[2] },
> -	{ .compatible = "murata,ncp03wb473",
> -		.data = &ntc_thermistor_id[3] },
> -	{ .compatible = "murata,ncp15wl333",
> -		.data = &ntc_thermistor_id[4] },
>  	{ .compatible = "epcos,b57330v2103",
> -		.data = &ntc_thermistor_id[5]},
> +		.data = &ntc_thermistor_id[NTC_B57330V2103]},
> +	{ .compatible = "epcos,b57891s0103",
> +		.data = &ntc_thermistor_id[NTC_B57891S0103] },
> +	{ .compatible = "murata,ncp03wb473",
> +		.data = &ntc_thermistor_id[NTC_NCP03WB473] },
>  	{ .compatible = "murata,ncp03wf104",
> -		.data = &ntc_thermistor_id[6] },
> +		.data = &ntc_thermistor_id[NTC_NCP03WF104] },
> +	{ .compatible = "murata,ncp15wb473",
> +		.data = &ntc_thermistor_id[NTC_NCP15WB473] },
> +	{ .compatible = "murata,ncp15wl333",
> +		.data = &ntc_thermistor_id[NTC_NCP15WL333] },
>  	{ .compatible = "murata,ncp15xh103",
> -		.data = &ntc_thermistor_id[7] },
> -	{ .compatible = "epcos,b57891s0103",
> -		.data = &ntc_thermistor_id[8] },
> +		.data = &ntc_thermistor_id[NTC_NCP15XH103] },
> +	{ .compatible = "murata,ncp18wb473",
> +		.data = &ntc_thermistor_id[NTC_NCP18WB473] },
> +	{ .compatible = "murata,ncp21wb473",
> +		.data = &ntc_thermistor_id[NTC_NCP21WB473] },
>  
>  	/* Usage of vendor name "ntc" is deprecated */
> +	{ .compatible = "ntc,ncp03wb473",
> +		.data = &ntc_thermistor_id[NTC_NCP03WB473] },
>  	{ .compatible = "ntc,ncp15wb473",
> -		.data = &ntc_thermistor_id[0] },
> +		.data = &ntc_thermistor_id[NTC_NCP15WB473] },
> +	{ .compatible = "ntc,ncp15wl333",
> +		.data = &ntc_thermistor_id[NTC_NCP15WL333] },
>  	{ .compatible = "ntc,ncp18wb473",
> -		.data = &ntc_thermistor_id[1] },
> +		.data = &ntc_thermistor_id[NTC_NCP18WB473] },
>  	{ .compatible = "ntc,ncp21wb473",
> -		.data = &ntc_thermistor_id[2] },
> -	{ .compatible = "ntc,ncp03wb473",
> -		.data = &ntc_thermistor_id[3] },
> -	{ .compatible = "ntc,ncp15wl333",
> -		.data = &ntc_thermistor_id[4] },
> +		.data = &ntc_thermistor_id[NTC_NCP21WB473] },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, ntc_match);
