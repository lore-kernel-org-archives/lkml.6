Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EA8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B733F21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pg5/bTUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbeLTWDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:03:55 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46443 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbeLTWDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:03:55 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so2043830vso.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 14:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0fHO5/7OfTvBjbMwzBxKezdUGL5snzpcNslFilli/k=;
        b=Pg5/bTUXEOQcpyrjNZhMLxXLx3FuIkKjV6LUCXdiBupQGOCthzDDfpBU4t9jjf3Len
         3dpWb/Aw/vVNXxBeNes5bJFbslgeZa4HAGxO+QIlC0CX051MrN8Yca+uMrcDsy2lTS7U
         cOnGoFdsb6ua7MHK00MmwkO9JMX8yiTho6U0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0fHO5/7OfTvBjbMwzBxKezdUGL5snzpcNslFilli/k=;
        b=WyV2LzLYms8cMkmLXIv4Xet6WcssFuYtKb0DEHJbDivIvemB9LRQTSOu+YhEPY26Tr
         ycoCHI7XVef/6iqROQsQEeFpfEixmILAOdqi5XSgW2hGD6rJfgt8P1SZFkbZ/h2Iw+Zw
         1hRltYiJzo6sFESGf8JZZ3DK/ziWgXPgX+uWdKVVvNfEpKDcHN1DAAF2xQDaUYT3caYT
         J+sYybj+7wC8WhDxxZXDl/4qX3yG+wMUeWLx8KYLcs2yf7gnxRPMFxaD0f/KtYthenIC
         mpX0ng5rINwhfaOVD6JhzWBQPgTQjBl9gJVEY2TjgosAUiDhew1p8Pyxk7O0VF+A/8JX
         mrtw==
X-Gm-Message-State: AA+aEWZ5icJCO1gPwFcQLB+WqhghMkdSVvEm8DKLXuH9dH7pg5Kjey+z
        dAxR69+BfA8x/I3KzUIx6QMSvaFqOwXkSllHK7WTxg==
X-Google-Smtp-Source: AFSGD/U5gAn58gLVjQHMhut3iNrENweoiPF+F9yV4/PkJAzUyzKZmPrsVR4POqpRrJBEJ4dm7Lp/wDrcnS/A1y/UgNg=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr13000561vsa.165.1545343433879;
 Thu, 20 Dec 2018 14:03:53 -0800 (PST)
MIME-Version: 1.0
References: <1545315385-14384-1-git-send-email-vincent.guittot@linaro.org> <1545315385-14384-2-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1545315385-14384-2-git-send-email-vincent.guittot@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Dec 2018 23:03:18 +0100
Message-ID: <CAPDyKFo9GedhCVF4sRxvYzgWCiXK7aPzKnDXPWX5YT+vopAV5g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PM/runtime: Add a new interface to get accounted time
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        jani.nikula@linux.intel.com,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 at 15:16, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Some drivers (like i915/drm) needs to get the accounted suspended time.
> pm_runtime_suspended_time() will return the suspended accounted time
> in ns unit.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c | 16 ++++++++++++++++
>  include/linux/pm_runtime.h   |  2 ++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index beb85c3..e695544 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -86,6 +86,22 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
>         dev->power.runtime_status = status;
>  }
>
> +u64 pm_runtime_suspended_time(struct device *dev)
> +{
> +       unsigned long flags, time;
> +
> +       spin_lock_irqsave(&dev->power.lock, flags);
> +
> +       update_pm_runtime_accounting(dev);
> +
> +       time = dev->power.suspended_jiffies;
> +
> +       spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +       return jiffies_to_nsecs(time);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
> +
>  /**
>   * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
>   * @dev: Device to handle.
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index f0fc470..d479707 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -113,6 +113,8 @@ static inline bool pm_runtime_is_irq_safe(struct device *dev)
>         return dev->power.irq_safe;
>  }
>
> +extern u64 pm_runtime_suspended_time(struct device *dev);
> +
>  #else /* !CONFIG_PM */
>
>  static inline bool queue_pm_work(struct work_struct *work) { return false; }
> --
> 2.7.4
>
