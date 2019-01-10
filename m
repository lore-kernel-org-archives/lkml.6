Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A956DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A95A214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyFN34cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfAJS4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:56:32 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46897 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfAJS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:56:32 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so9766695ios.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BgF4kh9Xmlpw50K9SbfmwVdmpzqbAle3GfrvnRfGmk=;
        b=SyFN34cb6X7nCgBYzsAzXOb9UUWhX+NfdDJaApUeY6oM0bWGvd2oAhEfM9LwF34glr
         +4GvkzgsPgfa2jenE6CcTmKmCeASazCXEvWf8L9Hj8JRtISD6JrrM0WNb2B7+hROCg/D
         yQEX7hQmhZkDylS2lChIBGRE2u+M+Q3+58T8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BgF4kh9Xmlpw50K9SbfmwVdmpzqbAle3GfrvnRfGmk=;
        b=RBJbt+QUJg4B9M9lt+OMUdD9pU2ozKRypvRgtmUH21PAcEVMC6fDsdrSAnID8ATL+U
         Khe0WCWtrENEipmrRDmlPNTtNZgT0iccO3G23QJNjnI44Qa5hm6N429N0x/T2BLWKmRu
         TrWrYpHI1cZYJILlIt2Ac2xO2D98SiWvJ5Dc5dNZlly3fgRhQxIJwFqfxixyEZ3yUET4
         p/7IAbCMG+ceBO/en1nJxD+8xn6Fy4CIUZru5JqAdUuTrS3TsiHeK4q8t4nlxWKizwwS
         3Gxc1NOEpQYLENT/nqwvuc1P7cOuth1xWWyjZApfufc4MYSMtYhHJqbHdpM8U62bWTnv
         ri2w==
X-Gm-Message-State: AJcUukdZSC1718e5LqoALQieeOyOMNnes6OKAz2au3+Vz+7mto/nZZGr
        ShoJvi1jjt7S+XgA6yAGpjWgJzYOcKWuZ73rfpa3vEeGYroNnQ==
X-Google-Smtp-Source: ALg8bN6EBRB2D+ruHx7MaylPDpx+z+ZfTSkB8UjltZZWghyOWFgN0Ivly2UPnBQY0eqcH3TV+og4p1w1Gb6VGwE8/a8=
X-Received: by 2002:a6b:6b02:: with SMTP id g2mr7195717ioc.18.1547146590880;
 Thu, 10 Jan 2019 10:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20190110095125.GA4491@lenoch>
In-Reply-To: <20190110095125.GA4491@lenoch>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jan 2019 19:56:19 +0100
Message-ID: <CAKfTPtCV=PYAqG=LavafTpMxvXdr7W-bfsOkpP+04EtOaicjyg@mail.gmail.com>
Subject: Re: [PATCH] PM/runtime: Do not needlessly call ktime_get
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 10:51, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> pm_runtime_autosuspend_expiration calls ktime_get even when
> its returned value may be unused. Therefore get current time
> later and remove gotos while there.
>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  NOTE: Depends on Vincent's "[PATCH v2] PM/runtime: Fix autosuspend_delay
>        on 32bits arch"!
>
>  drivers/base/power/runtime.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 457be03b744d..836b1b8784eb 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -129,24 +129,21 @@ static void pm_runtime_cancel_pending(struct device *dev)
>  u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  {
>         int autosuspend_delay;
> -       u64 last_busy, expires = 0;
> -       u64 now = ktime_to_ns(ktime_get());
> +       u64 expires;
>
>         if (!dev->power.use_autosuspend)
> -               goto out;
> +               return 0;
>
>         autosuspend_delay = READ_ONCE(dev->power.autosuspend_delay);
>         if (autosuspend_delay < 0)
> -               goto out;
> -
> -       last_busy = READ_ONCE(dev->power.last_busy);
> +               return 0;
>
> -       expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
> -       if (expires <= now)
> -               expires = 0;    /* Already expired. */
> +       expires  = READ_ONCE(dev->power.last_busy);
> +       expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
> +       if (expires > ktime_to_ns(ktime_get()))
> +               return expires; /* Expires in the future */
>
> - out:
> -       return expires;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
>
> --
> 2.20.1
>
