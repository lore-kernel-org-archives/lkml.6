Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5FCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77222146F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwiIy9+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfBEIKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:10:30 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:47081 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfBEIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:10:29 -0500
Received: by mail-ua1-f65.google.com with SMTP id v24so830059uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxoEnVe+Vjte4GPkatgNUZFr6HlYZiQ/Ql2mHZyW+BE=;
        b=CwiIy9+8bQhetX3jE/IloHLl00yjggv0xrVSzfSfNonBSIkyGmMy0siLmglUFGH1CU
         1xZT8ehXbPTXlUminWUjuW/XJ/zsClZXDVbci8oSax9EhVyBmVqUF9UmR6n0XgLFcPz+
         QOGm/q7UgiaZ9vzfQE9OUz7QLsJ0rIdKJwfzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxoEnVe+Vjte4GPkatgNUZFr6HlYZiQ/Ql2mHZyW+BE=;
        b=epRtxF77j3WSbUq3hPdnaj6xzuRg0jdiLM5FPLqlfrr1LBvDcGq6ZafRchLOovvnVS
         /WQyam3BysvLLn+mEVslll3rJjz2K6HMqRu+8DAsLpy8JpwKikoEUQ24EHCwVC57wYC6
         Em0UbWKmTHJJGAa+Q9dRqJpAZBzvVWrnEfjHWcxhX9A34rorHylwiYFyA5Z3OE7SdZSt
         rF3xgIWuCwMdGeVoEFnx0M8foAK0RVPe3xrUjm0dsw05DORs3BtIcV57wYaIBzCALHlh
         rEHtH2hz8hKy11F6cnE+5edeN+2NY1IjJgi/eFc2A0lIDybGVxJjKeNjR4Plh/KKZE8M
         w9mw==
X-Gm-Message-State: AHQUAuajAMjtWv0ib2avi4HstMGm/Ia22yxszsRToKSl8+FBblihDynt
        utI7PI6fsmlCh5SiJW4o8W1zcPH3D7cgPO8+UhZYfw==
X-Google-Smtp-Source: AHgI3IYdcq4Qsyb1csuGEXT3J5FqsCuk81iMJIjnMeZ3ljIufq8VriCbdiW+TQeYNOMH0TKiv0PmLU3SlDnHXCnWRrs=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr1387608uan.107.1549354227865;
 Tue, 05 Feb 2019 00:10:27 -0800 (PST)
MIME-Version: 1.0
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org> <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Feb 2019 09:09:50 +0100
Message-ID: <CAPDyKFrzs5PvrK_23HARKYkytPr3LF4S7j5rJ6LJANKmm7BMrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 at 17:25, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> Similarly to what happened whith autosuspend, a deadlock has been raised
> with runtime accounting in the sequence:
>
> change_clocksource
>     ...
>     write_seqcount_begin
>     ...
>     timekeeping_update
>         ...
>         sh_cmt_clocksource_enable
>             ...
>             rpm_resume
>                 update_pm_runtime_accounting
>                     ktime_get
>                         do
>                             read_seqcount_begin
>                         while read_seqcount_retry
>     ....
>     write_seqcount_end
>
> Move runtime accounting on ktime_get_mono_fast_ns()
> With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> monotonic across an update of timekeeping and as a result time can goes
> backward. Add a test to skip accounting for such situation which should
> stay exceptional.
>
> Fixes: a08c2a5a3194 ("PM-runtime: Replace jiffies-based accounting with ktime-based accounting")
> Reported-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 1caa394..50740da 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -66,13 +66,22 @@ static int rpm_suspend(struct device *dev, int rpmflags);
>   */
>  void update_pm_runtime_accounting(struct device *dev)
>  {
> -       u64 now = ktime_to_ns(ktime_get());
> +       u64 now = ktime_get_mono_fast_ns();
> +       u64 last = dev->power.accounting_timestamp;
>         u64 delta;
>
> -       delta = now - dev->power.accounting_timestamp;
> -
>         dev->power.accounting_timestamp = now;
>
> +       /*
> +        * Because ktime_get_mono_fast_ns() is not monotonic during
> +        * timekeeping update, we must ensure that now is after the last saved
> +        * timesptamp
> +        */
> +       if (now < last)
> +               return;
> +
> +       delta = now - last;
> +
>         if (dev->power.disable_depth > 0)
>                 return;
>
> @@ -1312,7 +1321,7 @@ void pm_runtime_enable(struct device *dev)
>
>                 /* About to enable runtime pm, set accounting_timestamp to now */
>                 if (!dev->power.disable_depth)
> -                       dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
> +                       dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
>         } else {
>                 dev_warn(dev, "Unbalanced %s!\n", __func__);
>         }
> --
> 2.7.4
>
