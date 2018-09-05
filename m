Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144A9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DA820869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSJiPz/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DA820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIEPJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeIEPJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:09:57 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4AB92086A;
        Wed,  5 Sep 2018 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536144019;
        bh=T9wBMznCKudnOkR62/1OScS/rQUtrmusCxX+oGrg76Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lSJiPz/7ymIGwaZeOILM1k9YRJ4GqIt9hP7Gt0Vmies0lE9yo9dpokdB4Y1U8qHkm
         QZxVjrqKl/Kvhj1fC3Usc6CLydj0DQhUVBcN9KgsapqUhJBSaEr7fzA2QnBM6feo3F
         wTiAmHjyadDdXqKfu98YKa35WtAVhfN2xpU3mkoM=
Received: by mail-wm0-f50.google.com with SMTP id f21-v6so7432906wmc.5;
        Wed, 05 Sep 2018 03:40:18 -0700 (PDT)
X-Gm-Message-State: APzg51Dyfni9fPOo1/laKGcMilAmDeDrXngL724SEsX90NykrUHhTPvO
        41pbqo5MS+k0B+2+4UULddbzD6fVutS3V7dAl4A=
X-Google-Smtp-Source: ANB0VdbhZTsZIqOxzbh4l8AB2aiZndp4T9ZzfATTvCaZ2JR4fOHNBW92rRVWbwmd7GVsZ5XdRRq6LeE7cCAImJvDI+g=
X-Received: by 2002:a1c:ac1:: with SMTP id 184-v6mr5235169wmk.119.1536144017208;
 Wed, 05 Sep 2018 03:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180905093305eucas1p19cbdec510c32cedaf9a9de58fd2de9e1@eucas1p1.samsung.com>
 <20180905093243.3861-1-m.szyprowski@samsung.com>
In-Reply-To: <20180905093243.3861-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 5 Sep 2018 12:40:05 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe-LDrDK8htEb3FrRn_UPd_6j7ZZ-adj8g8Xoxm--mojA@mail.gmail.com>
Message-ID: <CAJKOXPe-LDrDK8htEb3FrRn_UPd_6j7ZZ-adj8g8Xoxm--mojA@mail.gmail.com>
Subject: Re: [PATCH] mfd: max8997: Enale irq-wakeup unconditionally
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, myungjoo.ham@samsung.com,
        lee.jones@linaro.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 at 11:33, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> IRQ wakeup support for MAX8997 driver was initially configured by
> respective property in pdata. However, after the driver conversion to
> device-tree, setting it was left as 'todo'. Nowadays most of other MAX PMIC
> MFD drivers initialized from device-tree simply assume unconditionally that
> they can be an irq wakeup source, so enable wakeup support also for
> MAX8997. This fixes support for wakeup from MAX8997 RTC alarm.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

If you want to have wakeup always, then just remove pd->wakeup and use
always true in device_init_wakeup(). Otherwise (if it still should be
configurable), use wakeup-source property in DTS:
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/power/wakeup-source.txt

Best regards,
Krzysztof

> ---
>  drivers/mfd/max8997.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
> index 3f554c447521..7155e991cb82 100644
> --- a/drivers/mfd/max8997.c
> +++ b/drivers/mfd/max8997.c
> @@ -152,12 +152,7 @@ static struct max8997_platform_data *max8997_i2c_parse_dt_pdata(
>                 return ERR_PTR(-ENOMEM);
>
>         pd->ono = irq_of_parse_and_map(dev->of_node, 1);
> -
> -       /*
> -        * ToDo: the 'wakeup' member in the platform data is more of a linux
> -        * specfic information. Hence, there is no binding for that yet and
> -        * not parsed here.
> -        */
> +       pd->wakeup = true;
>
>         return pd;
>  }
> --
> 2.17.1
>
