Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642DC20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0g7QOtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642DC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbeGWIXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:23:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40718 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387908AbeGWIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:23:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so26934wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bogEEr5wVpntm+KKXv4R6JMO9vwjew8NkC7fRX9Lf+s=;
        b=V0g7QOtgpHymLlTvdZBs/e7lfGiszn4LSWetAv6jXeyKLZK6pyWm4mnIyzRP/5qL60
         09QgpcHptC49W/NUYNq5c48BLCiYFkIF5qI1ejN+qRPIqKhxWmqX5w1IV1RZ1wj8AOG3
         LFoB+YbDcoXLrz0OjVNW0dSQmfuQaNn3cmKEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bogEEr5wVpntm+KKXv4R6JMO9vwjew8NkC7fRX9Lf+s=;
        b=QF0DagDvcg3vddAhCC7R0ho++6+LVoGoXyxMc611WnhR8Mmb4jcF24g57mpExU7nqS
         vszyBybjX0BMSJPMaxJ6BVqQ5V9nd8WCxb8KKGbDh26ZAYlMBkwhDHOn0HxmIWz6JEmZ
         pGpxXdbzxEB+nvPn9pXQZLyFadCTataZeeZkTM2pwv/QkYXOdFv44MjrAStweYRzEJ5T
         +8s7pPUC0CZK0Z4vlck8Z3BZ1NtMFRGYvFJJSUb77n3AfkU8M++2xI/A92O2aDJpRt5U
         n+Dbt9zfoH24AJFKK21urjw/5cMtL1+34pCFOAr6lLdTL/jNAMPYerui6QoYJmOEKzKo
         cjZw==
X-Gm-Message-State: AOUpUlHFNdT4t6cWbHXsDBQ5nwJ6FpoyBdlC9cD+sDWQWxNhyiW3ZkNy
        7z6+CwHQQGh/7ft1PIIZ2gt3sA==
X-Google-Smtp-Source: AAOMgpc8SFaRqCmN1SAr4o5q0OpbtqtyilObYm1X4QSO5g4XtHBCD7P+2KVs7Ttw0q1jRIfqj3bvZA==
X-Received: by 2002:a1c:68f:: with SMTP id 137-v6mr4063456wmg.82.1532330626729;
        Mon, 23 Jul 2018 00:23:46 -0700 (PDT)
Received: from dell ([2a02:c7d:1faf:e900:9403:d00:d6f3:4419])
        by smtp.gmail.com with ESMTPSA id u4-v6sm15020566wrt.31.2018.07.23.00.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 00:23:45 -0700 (PDT)
Date:   Mon, 23 Jul 2018 08:23:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v2] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180723072343.GD4213@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180719161923.21510-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180719161923.21510-1-daniel.thompson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018, Daniel Thompson wrote:

> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined and the interpolation code will deploy randomly.
> Fix this.
> 
> Additionally fix a small grammar error that was identified and
> tighten up return code checking of DT properties, both of which came
> up during review of this patch.
> 
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> brightness-levels")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
> Notes:
>     v2:
>      - Simplify SoB chain (with Marcel's permission)
>      - Separate complex if statement and make other similar calls use same
>        return code checking approach
>      - Tidy up comment formatting and fix pre-existing grammar error
> 
>  drivers/video/backlight/pwm_bl.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

I'm hesitant to provide feedback on this, as I feel as though I've
messed you around enough, however ... ;)

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 9ee4c1b735b2..f7799f62fea0 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -284,30 +284,29 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  		ret = of_property_read_u32_array(node, "brightness-levels",
>  						 data->levels,
>  						 data->max_brightness);
> -		if (ret < 0)
> +		if (!ret)
>  			return ret;
> 
>  		ret = of_property_read_u32(node, "default-brightness-level",
>  					   &value);
> -		if (ret < 0)
> +		if (!ret)
>  			return ret;

Just FYI (it didn't even make it to 'nit' status), this should really
be done in a separate patch since it is unrelated to the rest of the
patch.

>  		data->dft_brightness = value;
> 
>  		/*
>  		 * This property is optional, if is set enables linear
> -		 * interpolation between each of the values of brightness levels
> -		 * and creates a new pre-computed table.
> +		 * interpolation between each of the values of brightness
> +		 * levels and creates a new pre-computed table.
>  		 */
> -		of_property_read_u32(node, "num-interpolated-steps",
> -				     &num_steps);
> -
> -		/*
> -		 * Make sure that there is at least two entries in the
> -		 * brightness-levels table, otherwise we can't interpolate
> -		 * between two points.
> -		 */
> -		if (num_steps) {
> +		ret = of_property_read_u32(node, "num-interpolated-steps",
> +					   &num_steps);
> +		if (!ret || num_steps) {

Not sure if it's even possible for of_property_read_u32() to fail AND
still populate num_steps, however this check makes it sound like that's
okay.  Is that correct?

I can't help but think that this all 'just goes away' if you
pre-initialise num_steps.  I wouldn't let the "do not initialise too
far away from the code using variable" affect this.  However, if
you're insistent, perhaps consider moving the declaration to just
below:

  if (data->max_brightness > 0) {

> +			/*
> +			 * Make sure that there are at least two entries in
> +			 * the brightness-levels table, otherwise we can't
> +			 * interpolate between two points.
> +			 */
>  			if (data->max_brightness < 2) {
>  				dev_err(dev, "can't interpolate\n");
>  				return -EINVAL;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
