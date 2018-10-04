Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B22C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E95A2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="httUygJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E95A2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJDUQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:16:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38099 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:16:27 -0400
Received: by mail-it1-f195.google.com with SMTP id i76-v6so13930999ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fhrln2Ni8CMM1C65rN9ObT4bBIxJeaQ97/JOaRHhPWo=;
        b=httUygJskY4ixpUHgMoRf3uxgMxqCgJErsabpz9X97yUITPyRjwHZ6d/d5SryYdUKb
         KuUsNRxTzRVjDxb1+YXr8kA633ga2GzO/luSsabh3JEHv4cfjLBF01pj6yGd7zCpCm3K
         fYrHKZSbFhZrt1Lq00cHnArYmbMxPco/D3W1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fhrln2Ni8CMM1C65rN9ObT4bBIxJeaQ97/JOaRHhPWo=;
        b=LRpaOWzvhJpOoENMZ6fT9QhIfpylhjp/zWQTNVLPlZcOv/b7Noh2mgQiYydTFD3jWG
         V6A169Bj1Rh0fjE+Pckrk4fNcyPXVROtWvpqcMYvOELEiM3l0WbTPAAd9LJ0SHenhsrT
         K/8OcZDVaNqAuveb7paRhHs87/4///Xmgi3mOoBOXv9qiroEvXpmo/El3Veq7MMgtF6/
         y90TUVWAis0IbWYXmXwbVv117uMVS9aEBVQF7Etow9SdgKOiosPzM6CFnwITJcl12PUV
         Glw2olfhDMc1MiDAJVqwDZxfvJiMKAlM5ipXJNLwMNvaPC+hlemE1tiY9v1A1kKqr1pN
         LNAg==
X-Gm-Message-State: ABuFfogE9gNjjWy25S2NCvcTG+tDwtu8t4kEQKXbz2lXR2PrFR59OHPS
        x25msq2k3dJDTfMwupESGCHPsz7n49FewuM2uYd6Gw==
X-Google-Smtp-Source: ACcGV60WGXXzTHcuAtWUVdnwHsuY/3KFCyv2uj9IZu3S3WRGa2m/7gYbiDAqd022sr7VOJRRunOFWQtYPxhc67+KleQ=
X-Received: by 2002:a05:660c:243:: with SMTP id t3mr4669638itk.146.1538659389507;
 Thu, 04 Oct 2018 06:23:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 06:22:29 -0700 (PDT)
In-Reply-To: <61559514.Vym8FNvob2@aspire.rjw.lan>
References: <61559514.Vym8FNvob2@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 15:22:29 +0200
Message-ID: <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Al Cooper <alcooperx@gmail.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If __device_suspend() returns early on an error or pending wakeup
> and the power.direct_complete flag has been set for the device
> already, the subsequent device_resume() will be confused by it
> and it will call pm_runtime_enable() incorrectly, as runtime PM
> has not been disabled for the device by __device_suspend().

I think it would be fair to mention that is related to the async
suspend path, in dpm_suspend().

>
> To avoid that, clear power.direct_complete if __device_suspend()
> is not going to disable runtime PM for the device before returning.

Overall, by looking at the behavior in dpm_suspend() of async
suspended devices, it does look a bit fragile to me.

My worries is that we put asynced suspended devices in the
dpm_suspended_list, no matter if the device was successfully suspended
or not. This differs from the no-async path.

In the long run, maybe we should change that instead?

>
> Fixes: aae4518b3124 (PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily)
> Reported-by: Al Cooper <alcooperx@gmail.com>
> Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1713,8 +1713,10 @@ static int __device_suspend(struct devic
>
>         dpm_wait_for_subordinate(dev, async);
>
> -       if (async_error)
> +       if (async_error) {
> +               dev->power.direct_complete = false;
>                 goto Complete;
> +       }
>
>         /*
>          * If a device configured to wake up the system from sleep states
> @@ -1726,6 +1728,7 @@ static int __device_suspend(struct devic
>                 pm_wakeup_event(dev, 0);
>
>         if (pm_wakeup_pending()) {
> +               dev->power.direct_complete = false;
>                 async_error = -EBUSY;
>                 goto Complete;
>         }
>
