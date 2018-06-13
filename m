Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 436A2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2E0208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BudgBffL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2E0208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964893AbeFMPLQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:11:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37308 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935656AbeFMPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:11:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id d8-v6so3160456wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WGxTlhrvhDpbRi1uDdODFz7hC2HjpM2QHHQvRmlTp2E=;
        b=BudgBffLLmUqAgj+45oBMetJtMlYQtt9RtaRE3vNSI0GM4npD1mI8DV2RtS7c8xLT1
         iqsoD+b3asfC6iVpOgIIW4uniRmarQJlUQ4FDN8etet4rheZm1vBCS32YO062Im8/9Ug
         u/QHL/vSrSR8YDLrSOjboexeFPmeWyKLKy+Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WGxTlhrvhDpbRi1uDdODFz7hC2HjpM2QHHQvRmlTp2E=;
        b=iGBnaPeJgrV+qtt0RLnuYzWLpKI2MulntEWLs4TCNdNtTfnzNTo6L76eEPIF+d0Dki
         9qZflBerigvZa6v99CJmpkaX68eez+NfcmbvRFtplUdRJoSoA+XHKfoGZdJ9KoQCEdCg
         3pkjyHLS28ZgGf4Af8MhVI4akUbPHtIx1UqKzgPMEUEetH5AdNHYdTnP79Rau9QPfDs2
         RxkYWJxKchEeDiSGYXrRkOd37xxMKgLpOyoHgRkDtwEwLUPGYcdT3C8plEYxvWZAqWQ8
         vjVOHjFP6DM4OCjal0iTjZrH7bxaEVCyOTwiOGpgCVPyKjMe2ZsaqKO3MhCulyVVFO/7
         P37A==
X-Gm-Message-State: APt69E288PTCyKaWGNMoaLg/+s9U9P1gnB4T/lRqRnzi9aTIio/3p0cb
        aoIEnr3OfczFQQY+aKrKbXsAQZ67Sac=
X-Google-Smtp-Source: ADUXVKIfXw4xmp8yj9bF7PRwAy4Olauxc4zaUOVjl5neQEj0FOW2o1vkXZyGKoXoeho1i6ivC8iLsA==
X-Received: by 2002:adf:9525:: with SMTP id 34-v6mr4275516wrs.99.1528902672771;
        Wed, 13 Jun 2018 08:11:12 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id n56-v6sm6082264wrn.72.2018.06.13.08.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:11:11 -0700 (PDT)
Subject: Re: [PATCH RESEND] backlight: gpio-backlight: Correct initial power
 state handling
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, lee.jones@linaro.org,
        jingoohan1@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180508070426.32211-1-peter.ujfalusi@ti.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <cb603304-2052-2586-1673-96ab421a5547@linaro.org>
Date:   Wed, 13 Jun 2018 16:11:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180508070426.32211-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/18 08:04, Peter Ujfalusi wrote:
> The default-on property - or the def_value via legacy pdata) should be
> handled as:
> if it is 1, the backlight must be enabled (kept enabled)
> if it is 0, the backlight must be disabled (kept disabled)
> 
> This only works for the case when default-on is set. If it is not set then
> the brightness of the backlight is set to 0. Now if the backlight is
> enabled by external driver (graphics) the backlight will stay disabled since
> the brightness is configured as 0. The backlight will not turn on.
> 
> The correct action at probe time is to configure the props.power to
> FB_BLANK_UNBLANK if we want the backlight on by default or to
> FB_BLANK_POWERDOWN if the backlight should be off by default.
> 
> The initial brightness should be set to 1.

Hmnn... I guess this comes down to the definition of "on" for a binary

Actually I'm a little worried that backlight already has too many 
different behaviors and that this patch introduces another way for them 
to be different!

Is there any mileage in adopting the same approach as PWM backlight for 
blank/unblank management as a way to get a flicker free boot?

For PWM the default property controls the initial brightness and the 
initial power state is unblanked *unless* there is a phandle link to the 
node, in which case we inherit whatever the power state the bootloader 
had configured before the driver probed.

Put another way, what happens is we implement 
gpio_backlight_initial_power_state() to perform a similar task to 
pwm_backlight_initial_power_state().


Daniel.


> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> for some reason the original patch got lost:
> https://patchwork.kernel.org/patch/9445539/
> 
> But it is still valid, so I'm resending it.
> 
> Regards,
> Peter
> 
>   drivers/video/backlight/gpio_backlight.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index e470da95d806..904a4462cefe 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -142,7 +142,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>   		return PTR_ERR(bl);
>   	}
>   
> -	bl->props.brightness = gbl->def_value;
> +	bl->props.power = gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
> +	bl->props.brightness = 1;
> +
>   	backlight_update_status(bl);
>   
>   	platform_set_drvdata(pdev, bl);
> 

