Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7BCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAD321916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dk6Ze+CX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389957AbeLUKoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:44:00 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45351 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbeLUKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:43:59 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so1047249vke.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4D098usCHkCqTbhd3oG7ttdgNibmNFeIsjQheCu8FI=;
        b=Dk6Ze+CXJJ/PcjwECXaKYS+pqZqXyJdpIGuYmrdWCEaMhnPjtUVDtw0bSJKo4Ph5o5
         qJrvwlW/6wm/1xzxmmWW0gvIQHsca+4EJsRKSta8aJtHIC1siiuQK4C6wtIyRRphDiCI
         4I0dQBrwg/M8mhyUq4wMx9DPAdRXSk6c5Bii4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4D098usCHkCqTbhd3oG7ttdgNibmNFeIsjQheCu8FI=;
        b=aPmZQD094bc/1DN7HN8Ib81/iMtYc1g3wdcvl9Y9Qahzu9szJ2acEYMYddmp5RBqw1
         /9cfIAhXeypZYWsLNEkBE5f+w7vVJHjYIQBmYS7TO+zBGluJkjCMguTt5aIkT2wB9Ma1
         jV+YI+/Z/6eModmrtlNWcCdnbX/0UsbWdwZ2mJtnJ7ATcX1xV9WEG9YZyIBqlGarsxF6
         /IarjNeYMqfanlaWmTxMl9TO+k6kUFStdj+P9auBAQbucJbRcNZJvFwjcNFwRkpErHej
         uFyVQyRMyfA7vmOUA88b/Qy/nNqxG8vk2G9peKgw4lfwEOdZh0FHmIL2rxhO9wXviMjR
         vHeA==
X-Gm-Message-State: AJcUukf8Cgb8nAtjC/m8ZXQDXp3kTee1G6AK2u5SSi39acqnqRTlsfk6
        IpEWbB19rEuhr6xAzEBfjlpMZ+2Efjl0B4uis7qmmQ==
X-Google-Smtp-Source: ALg8bN7hMWcxQS6voLlTFYf7No37ptcQgCxc0MGASBaqB8Aj2o0kUxGysa/YmYz5qscegsS+nStworBgDIbdDs9ZvS0=
X-Received: by 2002:a1f:60c9:: with SMTP id u192mr702948vkb.36.1545389038455;
 Fri, 21 Dec 2018 02:43:58 -0800 (PST)
MIME-Version: 1.0
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org> <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Dec 2018 11:43:22 +0100
Message-ID: <CAPDyKFrQ_NPWXJz8ELL7S8FBBDjmzOpRABWPEgFeLnwshtjXEA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
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

On Fri, 21 Dec 2018 at 11:34, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> From: Thara Gopinath <thara.gopinath@linaro.org>
>
> This patch replaces jiffies based accounting for runtime_active_time
> and runtime_suspended_time with ktime base accounting. This makes the
> runtime debug counters inline with genpd and other pm subsytems which
> uses ktime based accounting.
>
> timekeeping is initialized before pm_runtime_init() so ktime_get() will
> be ready before first call. In fact, timekeeping_init() is called early
> in start_kernel() which is way before driver_init() (and that's when
> devices can start to be initialized) called from rest_init() via
> kernel_init_freeable() and do_basic_setup().
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> [move from ktime to raw nsec]
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c | 17 +++++++++--------
>  drivers/base/power/sysfs.c   | 11 ++++++++---
>  include/linux/pm.h           |  6 +++---
>  3 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index e695544..f700524 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -64,8 +64,8 @@ static int rpm_suspend(struct device *dev, int rpmflags);
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
> @@ -75,9 +75,9 @@ void update_pm_runtime_accounting(struct device *dev)
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
> @@ -88,17 +88,18 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
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
>
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
> @@ -1503,7 +1504,7 @@ void pm_runtime_init(struct device *dev)
>         dev->power.request_pending = false;
>         dev->power.request = RPM_REQ_NONE;
>         dev->power.deferred_resume = false;
> -       dev->power.accounting_timestamp = jiffies;
> +       dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
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
> index e723b78..e5a34e2 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -632,9 +632,9 @@ struct dev_pm_info {
>         int                     runtime_error;
>         int                     autosuspend_delay;
>         unsigned long           last_busy;
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
