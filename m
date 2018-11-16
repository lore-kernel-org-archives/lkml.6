Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E511BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D0520892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHQ/KSj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D0520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbeKPUvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:51:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37035 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeKPUvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:51:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so20550031wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4RKp13BXaAR2TDE0/4UZD1H1UciAcXbRM613Uvjpyj0=;
        b=aHQ/KSj2XVgEExJxqTaG/d8HXWMzbOhxKGH9yraS9aqrWN9noKCD23puBBUyV2Hebp
         ipTKN978bI8mvbynlGEiXjzYSUJkwtShTh0DOstlCBwxhJQqVAtYOhXrEG3uhefE3bm8
         2Ae40bvK93hXVJYEvKpQ+pM7rULuOXNrzXlUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4RKp13BXaAR2TDE0/4UZD1H1UciAcXbRM613Uvjpyj0=;
        b=a3vvt4fjbWDVtfTsA6HKeoE2B7QjlFn66k+Qa1jY1VLSUFtbklbIri5qOxNrmNGQhV
         y6Vhm8rxU+x9/szLKG9N9sns+FXrqzN5cfzqCaApVFz/4K4PVrhN5PAj3egiTOmId/YI
         rhCjv3p13yWS9pDqwmAbAXIrYcU7YzPwkkgzIAMB0O7nouCLrQJ3wBdRcQbE1EjX2rV/
         FujGkmadZlsVrsAQpZo4415L8mCn0EewH5IHPPsrnDHwi/yo3kEqBfk/VnZlJ7uu0JOl
         NmSnIgl6jgww3CpVsj0XGciD+rBSvcK20vTDJGKy/QzAEZkx4NqD7rBL+aVj13CdB0ZH
         KsAw==
X-Gm-Message-State: AA+aEWZqVDQ+a1WRCc9iIHYbXFNit+T3GMfnqef8Uj/PPCfa9GfXbNsP
        HU+cfWbQfHxymh6qr/w3V4pClg==
X-Google-Smtp-Source: AJdET5f2+aBRZI1YjKM2KNjvVzyvUYRcbaV6ZBfPz1+78C+jvjOD0RLfLNsqlZbeUpPEQmQ2idvYKA==
X-Received: by 2002:a1c:8089:: with SMTP id b131mr7565wmd.141.1542364796996;
        Fri, 16 Nov 2018 02:39:56 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f68sm13960771wmd.15.2018.11.16.02.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 02:39:56 -0800 (PST)
Date:   Fri, 16 Nov 2018 10:39:53 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: Re: [PATCH] backlight: pwm_bl: fix devicetree parsing with
 auto-generated brightness tables
Message-ID: <20181116103953.xcrsbn6gh366yxcp@holly.lan>
References: <20181112090257.7084-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112090257.7084-1-heiko@sntech.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 10:02:57AM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly
> to human eye") made the parse-dt function return early when using an auto-
> generated brightness-table, but didn't take into account that some more
> settings were handled below the brightness handling, like power-on-delays
> and also setting the pdata enable-gpio to -EINVAL.
> 
> This surfaces for example in the case of a backlight without any
> enable-gpio which then tries to use gpio-0 in error.
> 
> Fix this by simply moving the trailing settings above the brightness
> handling.
> 
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/pwm_bl.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index bcd08b41765d..b7b5b31f3824 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -272,6 +272,16 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  
>  	memset(data, 0, sizeof(*data));
>  
> +	/*
> +	 * These values are optional and set as 0 by default, the out values
> +	 * are modified only if a valid u32 value can be decoded.
> +	 */
> +	of_property_read_u32(node, "post-pwm-on-delay-ms",
> +			     &data->post_pwm_on_delay);
> +	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
> +
> +	data->enable_gpio = -EINVAL;
> +
>  	/*
>  	 * Determine the number of brightness levels, if this property is not
>  	 * set a default table of brightness levels will be used.
> @@ -384,15 +394,6 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  		data->max_brightness--;
>  	}
>  
> -	/*
> -	 * These values are optional and set as 0 by default, the out values
> -	 * are modified only if a valid u32 value can be decoded.
> -	 */
> -	of_property_read_u32(node, "post-pwm-on-delay-ms",
> -			     &data->post_pwm_on_delay);
> -	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
> -
> -	data->enable_gpio = -EINVAL;
>  	return 0;
>  }
>  
> -- 
> 2.18.0
> 
