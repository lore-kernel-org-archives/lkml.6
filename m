Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239CAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8CD217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LshlPeCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeLSJZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:25:41 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45134 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeLSJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:25:40 -0500
Received: by mail-vs1-f68.google.com with SMTP id x28so4189806vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YFadwpuZcfVEFWcCzUcEgRvcZTrxwdfmiRjz2ylHj8=;
        b=LshlPeCoVpD26Tmvlsv3zUQYK0SbK+/4vz/6Z5F8xTTNGaNc+GweAIt5ftztz23i+V
         sUyncwfdxyEIhPSdKiAvKJNQNGzuLjEksTt4yd8AydjvbJpzcUM1RCiY/5qvqxY0W4yj
         aAO/4SsLZLA21cxp3gRLhf4dkGzrAKHRC8WzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YFadwpuZcfVEFWcCzUcEgRvcZTrxwdfmiRjz2ylHj8=;
        b=Pg/DegT8YjIN94vQ2jqBW99dyy6Ala6Jww6xj8svEPfj/DtaB7XQPg3+rSuUVQ1Mbb
         7Mpz39FbUk28caIou5u0XR+xBr0YQr+DctZd+gZtzHemVDUnni48NhkllkLqDO/ejKa8
         Bof42ShXKRZuEgk7PU+RVept5TYUiZTwtl3viLovZOD4nxwEqdzvhq71v99DP9uW4wnp
         XkBH8QBt07aJCosGWg51nVWpMSS3oOcQl/alKxKuWY3e338bJcCL1/PvPjm7fkUTHiXW
         Z7WoY/gJLFWVcrJSIymLPZ38VwU5uMTd12u3Ti5RvUkQB79Qr2smie8sz/Ga4EbTC9li
         BQzQ==
X-Gm-Message-State: AA+aEWa6PBB4qajFXSXWKYbmL7hPJWLRVlrZWbIvhGXqFdhdMoYda8Tk
        3bpP1kSi0xE1I7xNyg0WO83aQ7mnU87Y9+uT48ZaNg==
X-Google-Smtp-Source: AFSGD/X7/ZoBiHWkSK5GSy7e5TvKS7Ik/pWNZbOrXoP2nijcOkSvcEpxKgZg/F8dJ2CnfGsx/eP4g1CW9ySB6McIKMQ=
X-Received: by 2002:a67:7685:: with SMTP id r127mr9732513vsc.35.1545211538543;
 Wed, 19 Dec 2018 01:25:38 -0800 (PST)
MIME-Version: 1.0
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org> <1544797347-20601-2-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1544797347-20601-2-git-send-email-vincent.guittot@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 10:25:02 +0100
Message-ID: <CAPDyKFprdJ8hTAdtbMf+P4q0N8EhpSywteFK7HvxoSpVf50Pew@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM/pm_runtime: move autosuspend on hrtimer
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

On Fri, 14 Dec 2018 at 15:22, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> pm runtime uses the timer infrastructure for autosuspend. This implies that
> the minimum time before autosuspending a device is in the range
> of 1 tick included to 2 ticks excluded
> -On arm64 this means between 4ms and 8ms with default jiffies configuration
> -And on arm, it is between 10ms and 20ms
>
> These values are quite high for embedded system which sometimes wants
> duration in the range of 1 ms.
>
> We can move autosuspend on hrtimer to get finer granularity for short
> duration and takes advantage of slack to keep some margins and gathers
> long timeout in minimum wakeups.
>
> On an arm64 platform that uses 1ms for autosuspending timeout of its GPU,
> the power consumption improves by 10% for idle use case with hrtimer.
>
> The latency impact on arm64 hikey octo cores is :
> - mark_last_busy: from 1.11 us to 1.25 us
> - rpm_suspend: from 15.54 us to 15.38 us
>   Only the code path of rpm_suspend that starts hrtimer has been measured
>
> arm64 image (arm64 default defconfig) decreases by around 3KB
> with following details:
>
> $ size vmlinux-timer
>    text    data     bss     dec     hex filename
> 12034646        6869268  386840 19290754        1265a82 vmlinux
>
> $ size vmlinux-hrtimer
>    text    data     bss     dec     hex filename
> 12030550        6870164  387032 19287746        1264ec2 vmlinux
>
> The latency impact on arm 32bits snowball dual cores is :
> - mark_last_busy: from 0.31 us usec to 0.77 us
> - rpm_suspend: from 6.83 us to 6.67 usec
>
> The increase of the image for snowball platform that I used for testing
> performance impact, is neglictable (244B)
>
> $ size vmlinux-timer
>    text    data     bss     dec     hex filename
> 7157961 2119580  264120 9541661  91981d build-ux500/vmlinux
>
> size vmlinux-hrtimer
>    text    data     bss     dec     hex filename
> 7157773 2119884  264248 9541905  919911 vmlinux-hrtimer
>
> And arm 32bits image (multi_v7_defconfig) increases by around 1.7KB
> with following details:
>
> $ size vmlinux-timer
>    text    data     bss     dec     hex filename
> 13304443        6803420  402768 20510631        138f7a7 vmlinux
>
> $ size vmlinux-hrtimer
>    text    data     bss     dec     hex filename
> 13304299        6805276  402768 20512343        138fe57 vmlinux
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

If not too late, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c | 63 ++++++++++++++++++++++++--------------------
>  include/linux/pm.h           |  5 ++--
>  include/linux/pm_runtime.h   |  6 ++---
>  3 files changed, 40 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index beb85c3..7062469 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -8,6 +8,8 @@
>   */
>
>  #include <linux/sched/mm.h>
> +#include <linux/ktime.h>
> +#include <linux/hrtimer.h>
>  #include <linux/export.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_wakeirq.h>
> @@ -93,7 +95,7 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
>  static void pm_runtime_deactivate_timer(struct device *dev)
>  {
>         if (dev->power.timer_expires > 0) {
> -               del_timer(&dev->power.suspend_timer);
> +               hrtimer_cancel(&dev->power.suspend_timer);
>                 dev->power.timer_expires = 0;
>         }
>  }
> @@ -124,12 +126,11 @@ static void pm_runtime_cancel_pending(struct device *dev)
>   * This function may be called either with or without dev->power.lock held.
>   * Either way it can be racy, since power.last_busy may be updated at any time.
>   */
> -unsigned long pm_runtime_autosuspend_expiration(struct device *dev)
> +u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  {
>         int autosuspend_delay;
> -       long elapsed;
> -       unsigned long last_busy;
> -       unsigned long expires = 0;
> +       u64 last_busy, expires = 0;
> +       u64 now = ktime_to_ns(ktime_get());
>
>         if (!dev->power.use_autosuspend)
>                 goto out;
> @@ -139,19 +140,9 @@ unsigned long pm_runtime_autosuspend_expiration(struct device *dev)
>                 goto out;
>
>         last_busy = READ_ONCE(dev->power.last_busy);
> -       elapsed = jiffies - last_busy;
> -       if (elapsed < 0)
> -               goto out;       /* jiffies has wrapped around. */
>
> -       /*
> -        * If the autosuspend_delay is >= 1 second, align the timer by rounding
> -        * up to the nearest second.
> -        */
> -       expires = last_busy + msecs_to_jiffies(autosuspend_delay);
> -       if (autosuspend_delay >= 1000)
> -               expires = round_jiffies(expires);
> -       expires += !expires;
> -       if (elapsed >= expires - last_busy)
> +       expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
> +       if (expires <= now)
>                 expires = 0;    /* Already expired. */
>
>   out:
> @@ -515,7 +506,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>         /* If the autosuspend_delay time hasn't expired yet, reschedule. */
>         if ((rpmflags & RPM_AUTO)
>             && dev->power.runtime_status != RPM_SUSPENDING) {
> -               unsigned long expires = pm_runtime_autosuspend_expiration(dev);
> +               u64 expires = pm_runtime_autosuspend_expiration(dev);
>
>                 if (expires != 0) {
>                         /* Pending requests need to be canceled. */
> @@ -528,10 +519,20 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>                          * expire; pm_suspend_timer_fn() will take care of the
>                          * rest.
>                          */
> -                       if (!(dev->power.timer_expires && time_before_eq(
> -                           dev->power.timer_expires, expires))) {
> +                       if (!(dev->power.timer_expires &&
> +                                       dev->power.timer_expires <= expires)) {
> +                               /*
> +                                * We add a slack of 25% to gather wakeups
> +                                * without sacrificing the granularity.
> +                                */
> +                               u64 slack = READ_ONCE(dev->power.autosuspend_delay) *
> +                                                   (NSEC_PER_MSEC >> 2);
> +
>                                 dev->power.timer_expires = expires;
> -                               mod_timer(&dev->power.suspend_timer, expires);
> +                               hrtimer_start_range_ns(&dev->power.suspend_timer,
> +                                               ns_to_ktime(expires),
> +                                               slack,
> +                                               HRTIMER_MODE_ABS);
>                         }
>                         dev->power.timer_autosuspends = 1;
>                         goto out;
> @@ -895,23 +896,25 @@ static void pm_runtime_work(struct work_struct *work)
>   *
>   * Check if the time is right and queue a suspend request.
>   */
> -static void pm_suspend_timer_fn(struct timer_list *t)
> +static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>  {
> -       struct device *dev = from_timer(dev, t, power.suspend_timer);
> +       struct device *dev = container_of(timer, struct device, power.suspend_timer);
>         unsigned long flags;
> -       unsigned long expires;
> +       u64 expires;
>
>         spin_lock_irqsave(&dev->power.lock, flags);
>
>         expires = dev->power.timer_expires;
>         /* If 'expire' is after 'jiffies' we've been called too early. */
> -       if (expires > 0 && !time_after(expires, jiffies)) {
> +       if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
>                 dev->power.timer_expires = 0;
>                 rpm_suspend(dev, dev->power.timer_autosuspends ?
>                     (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
>         }
>
>         spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +       return HRTIMER_NORESTART;
>  }
>
>  /**
> @@ -922,6 +925,7 @@ static void pm_suspend_timer_fn(struct timer_list *t)
>  int pm_schedule_suspend(struct device *dev, unsigned int delay)
>  {
>         unsigned long flags;
> +       ktime_t expires;
>         int retval;
>
>         spin_lock_irqsave(&dev->power.lock, flags);
> @@ -938,10 +942,10 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
>         /* Other scheduled or pending requests need to be canceled. */
>         pm_runtime_cancel_pending(dev);
>
> -       dev->power.timer_expires = jiffies + msecs_to_jiffies(delay);
> -       dev->power.timer_expires += !dev->power.timer_expires;
> +       expires = ktime_add(ktime_get(), ms_to_ktime(delay));
> +       dev->power.timer_expires = ktime_to_ns(expires);
>         dev->power.timer_autosuspends = 0;
> -       mod_timer(&dev->power.suspend_timer, dev->power.timer_expires);
> +       hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
>
>   out:
>         spin_unlock_irqrestore(&dev->power.lock, flags);
> @@ -1491,7 +1495,8 @@ void pm_runtime_init(struct device *dev)
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
> -       timer_setup(&dev->power.suspend_timer, pm_suspend_timer_fn, 0);
> +       hrtimer_init(&dev->power.suspend_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> +       dev->power.suspend_timer.function = pm_suspend_timer_fn;
>
>         init_waitqueue_head(&dev->power.wait_queue);
>  }
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e723b78..0bd9de1 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -26,6 +26,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
>  #include <linux/timer.h>
> +#include <linux/hrtimer.h>
>  #include <linux/completion.h>
>
>  /*
> @@ -608,7 +609,7 @@ struct dev_pm_info {
>         unsigned int            should_wakeup:1;
>  #endif
>  #ifdef CONFIG_PM
> -       struct timer_list       suspend_timer;
> +       struct hrtimer          suspend_timer;
>         unsigned long           timer_expires;
>         struct work_struct      work;
>         wait_queue_head_t       wait_queue;
> @@ -631,7 +632,7 @@ struct dev_pm_info {
>         enum rpm_status         runtime_status;
>         int                     runtime_error;
>         int                     autosuspend_delay;
> -       unsigned long           last_busy;
> +       u64                     last_busy;
>         unsigned long           active_jiffies;
>         unsigned long           suspended_jiffies;
>         unsigned long           accounting_timestamp;
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index f0fc470..54af4ee 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -51,7 +51,7 @@ extern void pm_runtime_no_callbacks(struct device *dev);
>  extern void pm_runtime_irq_safe(struct device *dev);
>  extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
>  extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
> -extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
> +extern u64 pm_runtime_autosuspend_expiration(struct device *dev);
>  extern void pm_runtime_update_max_time_suspended(struct device *dev,
>                                                  s64 delta_ns);
>  extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
> @@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
>
>  static inline void pm_runtime_mark_last_busy(struct device *dev)
>  {
> -       WRITE_ONCE(dev->power.last_busy, jiffies);
> +       WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
>  }
>
>  static inline bool pm_runtime_is_irq_safe(struct device *dev)
> @@ -168,7 +168,7 @@ static inline void __pm_runtime_use_autosuspend(struct device *dev,
>                                                 bool use) {}
>  static inline void pm_runtime_set_autosuspend_delay(struct device *dev,
>                                                 int delay) {}
> -static inline unsigned long pm_runtime_autosuspend_expiration(
> +static inline u64 pm_runtime_autosuspend_expiration(
>                                 struct device *dev) { return 0; }
>  static inline void pm_runtime_set_memalloc_noio(struct device *dev,
>                                                 bool enable){}
> --
> 2.7.4
>
