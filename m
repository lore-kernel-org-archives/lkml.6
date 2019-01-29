Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3199C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A341A2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgP9wfWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfA2JxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:53:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37504 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfA2JxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:53:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so21260561wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UTxLBj/MYU9MxfJEFlYDKK3fCMuYTOx/SGGih3Hwt2k=;
        b=XgP9wfWyd4KRcH1WQNHn4XVNvtZjwS/wTrf/8bKXR8gRdtnDQm8Cid9qXhNhKiJi++
         tnqo7+w7G4d7dEUeZSBBzjtv4mCX0AvcKb6TXCTfPQoAnHqzJAHi9cTnfrzZgWNmqT6h
         YuHQGiD2lhJut8OMOoaur9mGG7GbIyM0B27wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UTxLBj/MYU9MxfJEFlYDKK3fCMuYTOx/SGGih3Hwt2k=;
        b=BkZWIoIDFydWl18FOEVqBMEHVQ9IEUDc6X8lSzfiIsyZv0s5Kj+NTl11VktOMKlCxL
         iIDSKJ5wk1tGRKng9aridq73cnMH4qGbWNKwq+N8B6UQ2NPgZqADkK3b1jM0QzEgzsRX
         8UrMy+9nCItDVEr5LkO671ZrJmQq8jR5f9yWyGHwo0KY5T7Ue2dFqCVdt1yYmuuosIFk
         Al2+DODMNUtoc+iX4yG5iutd9ZxL3JoVKEBvLXPxOzb1S5gLKMiWcvhPKeB6KrjnZqiD
         /xjiuXGNCZBUD7h/jMtqp7K42qZae0bzfLN0g4w4L/VjR9glJ2KgymMnxCgV385Jnk0C
         q3ZQ==
X-Gm-Message-State: AJcUukel5+jS23zuscqzAYwuRqXWDYbGv0RW5yOrOvWkCK68pFEPAy/C
        mKBojR32Sg23NEUW+YnaODUw6H2y0CY=
X-Google-Smtp-Source: ALg8bN50IVl9PezQRSEf9l6/JcC7YMtHlDF+34ZGsoRlXomTcalqjSR15J7uVoQT+zt5HgkxarLPIA==
X-Received: by 2002:adf:ee89:: with SMTP id b9mr26130032wro.246.1548755578216;
        Tue, 29 Jan 2019 01:52:58 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 126sm1992494wmd.1.2019.01.29.01.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 01:52:57 -0800 (PST)
Subject: Re: [PATCH] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
To:     Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1548753048-78735-1-git-send-email-phil@raspberrypi.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d4a3e7b3-ed86-ca74-0e46-9b3b5f9cbef7@linaro.org>
Date:   Tue, 29 Jan 2019 10:52:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548753048-78735-1-git-send-email-phil@raspberrypi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2019 10:10, Phil Elwell wrote:
> "cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
> dereference in bcm2835_thermal_debugfs. The driver makes use of the
> implementation details of the thermal framework to retrieve a pointer
> to its private data from a struct thermal_zone_device, and gets it
> wrong - leading to the crash. Instead, store its private data as the
> drvdata and retrieve the thermal_zone_device pointer from it.
> 
> Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

One question: do you really want the thermal driver to be loaded as a
module ? Don't you want to have it operational as soon as possible
instead of waiting the OS to boot and load the kernel module?

If a module format is not needed, then the thermal_zone field won't be
needed anymore because the 'remove' ops can be removed and the need of
the tz field to unregister it disappears.

> ---
>  drivers/thermal/broadcom/bcm2835_thermal.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
> index 720760c..ba39647 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -119,8 +119,7 @@ static const struct debugfs_reg32 bcm2835_thermal_regs[] = {
>  
>  static void bcm2835_thermal_debugfs(struct platform_device *pdev)
>  {
> -	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
> -	struct bcm2835_thermal_data *data = tz->devdata;
> +	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
>  	struct debugfs_regset32 *regset;
>  
>  	data->debugfsdir = debugfs_create_dir("bcm2835_thermal", NULL);
> @@ -266,7 +265,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>  
>  	data->tz = tz;
>  
> -	platform_set_drvdata(pdev, tz);
> +	platform_set_drvdata(pdev, data);
>  
>  	/*
>  	 * Thermal_zone doesn't enable hwmon as default,
> @@ -290,8 +289,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>  
>  static int bcm2835_thermal_remove(struct platform_device *pdev)
>  {
> -	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
> -	struct bcm2835_thermal_data *data = tz->devdata;
> +	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
> +	struct thermal_zone_device *tz = data->tz;
>  
>  	debugfs_remove_recursive(data->debugfsdir);
>  	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

