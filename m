Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE78C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B5A2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548853583;
	bh=lG3iBNnE9kMDwCgxZmiVlgf8X6un2FKcxIOuyu5Zdbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=brfj+wky5MDJ+rm9CD1tMvrc99uxgtNQ3g1YTT6AZzN1MoF4fD9MHXO+wibNzd8LP
	 u6FAiQw6Q+dUMrIc4rl85LQB6h3WGpzAoMXL/GZtbjaDYhR7wgIzeDaTph2dTod6WE
	 ExQnrZaN+WlqZWn0cHlRMVLrxbhTluCRK8WF0v5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfA3NGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:06:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44638 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbfA3NGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:06:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id g16so17012274otg.11;
        Wed, 30 Jan 2019 05:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/xB8+fKGsHNHqt+qw739geAKACge/qKuZW9F1aYPGU=;
        b=HS63VeKg69LtxjRvwLMVZpTM126QaSLPRfWwv4oHoQLAV2squ+R7f1CYHjQZ5JBce9
         zQ3+Bv2b27+Og5OUZNKYkANqQO2NG/LuZ+4DEt+RqkAp0o9mlZlPBtz9RDMct1I2eFk3
         bdK1Hqt/Wt9Cpk6JlcDzpXtdg4Xv3q3hTdIMDGpcAZ8OOFg6cC/FE8yYmbrA0bF3T88B
         1vhlE7yaljuWFaX6CSBsoboIvR7etjXTOA1J7RX9E57n3ueZxA3pZalj365gxPuagloo
         wHaoemIR6+3SgkO1hxop5jeuQETbiTOhBnpo6YAy3irTHozYPuBmiKR09CbrYg6BrhkA
         SDpA==
X-Gm-Message-State: AJcUukdzosQ2ZOETGnV3V+V01pDyV/hKnj6RCi60Vz6N+JlM9TJYsSng
        WkJjaiZ36l8YCSOryLffstMGEQDpK9NwyAK+fGY=
X-Google-Smtp-Source: ALg8bN6Ty+Fh1ghF2ukWnelA6x0UzMZrPDCzhSDkSe54qYG+eYjZ+xTo79yOyzGKpEBSvadJ2z5deMxrHbIxP9Bb3wQ=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr21471175otl.119.1548853579044;
 Wed, 30 Jan 2019 05:06:19 -0800 (PST)
MIME-Version: 1.0
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jan 2019 14:06:07 +0100
Message-ID: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Ladislav Michl <ladis@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:16 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> A deadlock has been seen when swicthing clocksources which use PM runtime.
> The call path is:
> change_clocksource
>     ...
>     write_seqcount_begin
>     ...
>     timekeeping_update
>         ...
>         sh_cmt_clocksource_enable
>             ...
>             rpm_resume
>                 pm_runtime_mark_last_busy
>                     ktime_get
>                         do
>                             read_seqcount_begin
>                         while read_seqcount_retry
>     ....
>     write_seqcount_end
>
> Although we should be safe because we haven't yet changed the clocksource
> at that time, we can't because of seqcount protection.
>
> Use ktime_get_mono_fast_ns() instead which is lock safe for such case
>
> With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> monotonic across an update and as a result can goes backward. According to
> update_fast_timekeeper() description: "In the worst case, this can
> result is a slightly wrong timestamp (a few nanoseconds)". For
> PM runtime autosuspend, this means only that the suspend decision can
> be slightly sub optimal.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

I've queued this one up as a fix for 5.0, but unfortunately it clashes
with the patch from Ladislav Michl at
https://patchwork.kernel.org/patch/10755477/ which has been dropped
now.

Can you or Ladislav please rebase that patch on top of this one and repost?

> ---
>
> - v2: Updated commit message to explain the impact of using
>   ktime_get_mono_fast_ns()
>
>  drivers/base/power/runtime.c | 10 +++++-----
>  include/linux/pm_runtime.h   |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 457be03..708a13f 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -130,7 +130,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  {
>         int autosuspend_delay;
>         u64 last_busy, expires = 0;
> -       u64 now = ktime_to_ns(ktime_get());
> +       u64 now = ktime_get_mono_fast_ns();
>
>         if (!dev->power.use_autosuspend)
>                 goto out;
> @@ -909,7 +909,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>          * If 'expires' is after the current time, we've been called
>          * too early.
>          */
> -       if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
> +       if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
>                 dev->power.timer_expires = 0;
>                 rpm_suspend(dev, dev->power.timer_autosuspends ?
>                     (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
> @@ -928,7 +928,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>  int pm_schedule_suspend(struct device *dev, unsigned int delay)
>  {
>         unsigned long flags;
> -       ktime_t expires;
> +       u64 expires;
>         int retval;
>
>         spin_lock_irqsave(&dev->power.lock, flags);
> @@ -945,8 +945,8 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
>         /* Other scheduled or pending requests need to be canceled. */
>         pm_runtime_cancel_pending(dev);
>
> -       expires = ktime_add(ktime_get(), ms_to_ktime(delay));
> -       dev->power.timer_expires = ktime_to_ns(expires);
> +       expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC);
> +       dev->power.timer_expires = expires;
>         dev->power.timer_autosuspends = 0;
>         hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 54af4ee..fed5be7 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
>
>  static inline void pm_runtime_mark_last_busy(struct device *dev)
>  {
> -       WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
> +       WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
>  }
>
>  static inline bool pm_runtime_is_irq_safe(struct device *dev)
> --
> 2.7.4
>
