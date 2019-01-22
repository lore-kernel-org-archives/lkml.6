Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E42C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A468021721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzLHEu/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfAVO1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:27:38 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40852 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfAVO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:27:37 -0500
Received: by mail-io1-f67.google.com with SMTP id k2so19227502iog.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 06:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uY6YEPa1qfq+QOnCjTUKRO/17Q+zAHt4AfScn3/2Wc=;
        b=GzLHEu/cv4Rtm6aA2QHv+Ygq495Cnz426ES7diDoFGbYVMjHBhWGCJrbP4EctxBy9l
         tHwVAo+AGjChh5VPVGN4S8Ml6zCW5h/+PUGu7i4x8l9z0qihKidh5aGeMFYLPipsFWBN
         4rsJ0rVEbKo/CU1HEIuTf+JjGbUNXDwjHjvQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uY6YEPa1qfq+QOnCjTUKRO/17Q+zAHt4AfScn3/2Wc=;
        b=Ce0OOxU1J2jnnLlYljpKDK+XJyRis2D3sHV8R1KXwmHdATIvs3IONjGW+2ArYKqvU0
         1XMv2vmBlpY2D6/WzPBNCZaGIYTxVwmnxJi74Q5ONm3RE8W1vXrR2ioodDZjSFh4FeWM
         ElHoEjboTX8hBp3wAFCPNiKoDTZPxvUr0Xc9ubgI4nlW2U53az5ci5hBpmLr0sc3uHeW
         R+UhEyIuNZl3S1f0/ha7390pfT+kW+e6cP3j3yqxBi7bCZoPOgLLtQwJyKHqvCFVp34Y
         9aNfTBkfRlKuQ3SLn2YQduzAmTO2bNkjkhwM0LfG60SCdvoyrysaomCKuKEXtApTykRf
         /0Mg==
X-Gm-Message-State: AJcUukeP2Xgx9UGHNsZeqLDbpk4OUu1oaP4xJPIuDGoLJgz6Txmvq0Xd
        8a81OxZYtUWXg4emr9SNMMkXnk2tUY53CZj6dd1n64ZyUJ57kg==
X-Google-Smtp-Source: ALg8bN7ASKKmueW1a4D09KObEYDIxJS2egsd+JeGqsJd9gHi0/oR8l6uc46nUC7Ud4KPm9vZ1xHmu5xpkSC3s8PX7OY=
X-Received: by 2002:a6b:6b02:: with SMTP id g2mr10195520ioc.18.1548167256643;
 Tue, 22 Jan 2019 06:27:36 -0800 (PST)
MIME-Version: 1.0
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org> <1548167070-421-3-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548167070-421-3-git-send-email-vincent.guittot@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 22 Jan 2019 15:27:25 +0100
Message-ID: <CAKfTPtBNp0VMfguY6nPh1LiZKJm-Okzvg-5dsiL5Vg_MwngT1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM-runtime: Replace jiffies based accounting with
 ktime-based accounting
To:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 at 15:24, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> From: Thara Gopinath <thara.gopinath@linaro.org>
>
> This patch replaces jiffies based accounting for runtime_active_time
> and runtime_suspended_time with ktime-based accounting. This makes the
> runtime debug counters inline with genpd and other PM subsytems which
> use ktime-based accounting.
>
> Timekeeping is initialized before driver_init(). It's only at that time
> that PM runtime can be enabled.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> [switch from ktime to raw nsec]
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Hi Ulf,

I haven't added you reviewed-by because of the changes in this new version.

Hi Guenter,

Could you test this version ?

Thanks,
Vincent

> ---
>  drivers/base/power/runtime.c | 17 +++++++++--------
>  drivers/base/power/sysfs.c   | 11 ++++++++---
>  include/linux/pm.h           |  6 +++---
>  3 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 7df1d05..e49b3a8 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -66,8 +66,8 @@ static int rpm_suspend(struct device *dev, int rpmflags);
>   */
>  void update_pm_runtime_accounting(struct device *dev)
>  {
> -       unsigned long now = jiffies;
> -       unsigned long delta;
> +       u64 now = ktime_to_ns(ktime_get());
> +       u64 delta;
>
>         delta = now - dev->power.accounting_timestamp;
>
> @@ -77,9 +77,9 @@ void update_pm_runtime_accounting(struct device *dev)
>                 return;
>
>         if (dev->power.runtime_status == RPM_SUSPENDED)
> -               dev->power.suspended_jiffies += delta;
> +               dev->power.suspended_time += delta;
>         else
> -               dev->power.active_jiffies += delta;
> +               dev->power.active_time += delta;
>  }
>
>  static void __update_runtime_status(struct device *dev, enum rpm_status status)
> @@ -90,16 +90,17 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
>
>  u64 pm_runtime_suspended_time(struct device *dev)
>  {
> -       unsigned long flags, time;
> +       u64 time;
> +       unsigned long flags;
>
>         spin_lock_irqsave(&dev->power.lock, flags);
>
>         update_pm_runtime_accounting(dev);
> -       time = dev->power.suspended_jiffies;
> +       time = dev->power.suspended_time;
>
>         spin_unlock_irqrestore(&dev->power.lock, flags);
>
> -       return jiffies_to_nsecs(time);
> +       return time;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
>
> @@ -1308,7 +1309,7 @@ void pm_runtime_enable(struct device *dev)
>
>         /* About to enable runtime pm, set accounting_timestamp to now */
>         if (dev->power.disable_depth == 1)
> -               dev->power.accounting_timestamp = jiffies;
> +               dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
>
>         if (dev->power.disable_depth > 0)
>                 dev->power.disable_depth--;
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index d713738..96c8a22 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -125,9 +125,12 @@ static ssize_t runtime_active_time_show(struct device *dev,
>                                 struct device_attribute *attr, char *buf)
>  {
>         int ret;
> +       u64 tmp;
>         spin_lock_irq(&dev->power.lock);
>         update_pm_runtime_accounting(dev);
> -       ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
> +       tmp = dev->power.active_time;
> +       do_div(tmp, NSEC_PER_MSEC);
> +       ret = sprintf(buf, "%llu\n", tmp);
>         spin_unlock_irq(&dev->power.lock);
>         return ret;
>  }
> @@ -138,10 +141,12 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
>                                 struct device_attribute *attr, char *buf)
>  {
>         int ret;
> +       u64 tmp;
>         spin_lock_irq(&dev->power.lock);
>         update_pm_runtime_accounting(dev);
> -       ret = sprintf(buf, "%i\n",
> -               jiffies_to_msecs(dev->power.suspended_jiffies));
> +       tmp = dev->power.suspended_time;
> +       do_div(tmp, NSEC_PER_MSEC);
> +       ret = sprintf(buf, "%llu\n", tmp);
>         spin_unlock_irq(&dev->power.lock);
>         return ret;
>  }
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 0bd9de1..3d2cbf9 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -633,9 +633,9 @@ struct dev_pm_info {
>         int                     runtime_error;
>         int                     autosuspend_delay;
>         u64                     last_busy;
> -       unsigned long           active_jiffies;
> -       unsigned long           suspended_jiffies;
> -       unsigned long           accounting_timestamp;
> +       u64                     active_time;
> +       u64                     suspended_time;
> +       u64                     accounting_timestamp;
>  #endif
>         struct pm_subsys_data   *subsys_data;  /* Owned by the subsystem. */
>         void (*set_latency_tolerance)(struct device *, s32);
> --
> 2.7.4
>
