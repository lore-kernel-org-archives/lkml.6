Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A8F204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLmwMxzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfARKxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:53:48 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39132 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfARKxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:53:47 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so10361216iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x2FhQcEErNq+RMWxaZmUHws/qr/EfRxf379MbUeT8Zo=;
        b=NLmwMxzAT7v+r2e3qPzDm5CO8Y1VezQ7r+N20wl987D6osfPTfaJO+7GU3TeHfFZ3a
         BBmOMF+E0gRVXVLqyh+VGFnlxeHBBl4QYZhqDWCbSSNXY2iVeGQP91d0qaC8kpJYCXMz
         bjOmeaHgEbA65fxGILw+X0ou9zDZBCojssftQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x2FhQcEErNq+RMWxaZmUHws/qr/EfRxf379MbUeT8Zo=;
        b=NK3Uq9QAbmc+APK9lWeMsvlxcd2nYElwMcRGz8Y0zD9oEKpLq73izbHmbRRLeXWrIS
         R/LKVwz/IkdD2hHzyFos+rZ7+GSMGnHqfIDJimV/mB3At9bZJ9vRxOGQIYJog4IStV5q
         9mIAx8AAWGUDZo1NkQt/l6rQT+XvxEtZQZRF9Jwogn+Hpi5HuOplAn4qEK4XOFS0okom
         iKDN1QC3Le8y5LA/POW6N5E/pBHg5QsnDo7oDPP76CeYXsvPFYAAP3+YA1ySaeEoL7Sh
         VSdFn/oTQbeHHgaM7tVZt+msujDetEVaB8k+3uV38vF76NvF1NJn1MSAw8MtpSDCtLVQ
         +bMw==
X-Gm-Message-State: AJcUukcIQiFpUDaySiiBkUX1+xoOFC4I7cPMtdzHAbLtR8bQmMr447bJ
        lF+6J0eXV0mpoq0N+c41SfSNnotyylk6nnjBTNTLmA==
X-Google-Smtp-Source: ALg8bN4ED8k8dfADB/d6AK6guEAydLajCRPFFS6pV0N/3FD1jMQhfWfZBoRiQg2YoEh3nRdiH4ejNlYLcM9l3ujO34k=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr9407400iof.183.1547808826109;
 Fri, 18 Jan 2019 02:53:46 -0800 (PST)
MIME-Version: 1.0
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
 <20190117221628.GA21979@roeck-us.net> <20190118104215.GA13168@linaro.org>
In-Reply-To: <20190118104215.GA13168@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 18 Jan 2019 11:53:35 +0100
Message-ID: <CAKfTPtD9fu06sw8=MvjwfQfJoQHb0kT3un9=kdw+WZj+rbVUZg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 at 11:42, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Guenter,
>
> Le Thursday 17 Jan 2019 =C3=A0 14:16:28 (-0800), Guenter Roeck a =C3=A9cr=
it :
> > On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
> > > From: Thara Gopinath <thara.gopinath@linaro.org>
> > >
> > > This patch replaces jiffies based accounting for runtime_active_time
> > > and runtime_suspended_time with ktime base accounting. This makes the
> > > runtime debug counters inline with genpd and other pm subsytems which
> > > uses ktime based accounting.
> > >
> > > timekeeping is initialized before pm_runtime_init() so ktime_get() wi=
ll
> > > be ready before first call. In fact, timekeeping_init() is called ear=
ly
> > > in start_kernel() which is way before driver_init() (and that's when
> > > devices can start to be initialized) called from rest_init() via
> > > kernel_init_freeable() and do_basic_setup().
> > >
> > This is not (always) correct. My qemu "collie" boot test fails with thi=
s
> > patch applied. Reverting the patch fixes the problem. Bisect log attach=
ed.
> >
>
> Can you try the patch below ?
> ktime_get_mono_fast_ns() has the advantage of being init with dummy clock=
 so
> it can be used at early_init.

Another possibility would be delay the init of the gpiochip

>
> ---
>  drivers/base/power/runtime.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index ae1c728..118c7f6 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -66,7 +66,7 @@ static int rpm_suspend(struct device *dev, int rpmflags=
);
>   */
>  void update_pm_runtime_accounting(struct device *dev)
>  {
> -       u64 now =3D ktime_to_ns(ktime_get());
> +       u64 now =3D ktime_get_mono_fast_ns();
>         u64 delta;
>
>         delta =3D now - dev->power.accounting_timestamp;
> @@ -1507,7 +1507,7 @@ void pm_runtime_init(struct device *dev)
>         dev->power.request_pending =3D false;
>         dev->power.request =3D RPM_REQ_NONE;
>         dev->power.deferred_resume =3D false;
> -       dev->power.accounting_timestamp =3D ktime_to_ns(ktime_get());
> +       dev->power.accounting_timestamp =3D ktime_get_mono_fast_ns();
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires =3D 0;
> --
> 2.7.4
>
>
> > With some added debugging:
> >
> > ...
> > IRQS: 16, nr_irqs: 65, preallocated irqs: 65
> > irq: Cannot allocate irq_descs @ IRQ1, assuming pre-allocated
> > gpio gpiochip0: ############### pm_runtime_init() ############
> > irq: Cannot allocate irq_descs @ IRQ33, assuming pre-allocated
> > ############## timekeeping_init() ####################
> > sched_clock: 32 bits at 3686kHz, resolution 271ns, wraps every 58254222=
2200ns^M
> > ...
> >
> > This is with:
> >
> > void pm_runtime_init(struct device *dev)
> > {
> > +       dev_info(dev, "############### pm_runtime_init() ############\n=
");
> > +
> > ...
> > @@ -1526,6 +1526,8 @@ void __init timekeeping_init(void)
> >       struct clocksource *clock;
> >       unsigned long flags;
> >
> > +       pr_info("############## timekeeping_init() ####################=
\n");
> > +
> >
> > Guenter
> >
> > ---
> > # bad: [a37d50ca3b837c19a297f349365d11a20c1087d0] Add linux-next specif=
ic files for 20190117
> > # good: [1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8] Linux 5.0-rc2
> > git bisect start 'HEAD' 'v5.0-rc2'
> > # bad: [4edb817d29fdf19fb5d52784bb3c29c40e00f586] Merge remote-tracking=
 branch 'pm/linux-next'
> > git bisect bad 4edb817d29fdf19fb5d52784bb3c29c40e00f586
> > # good: [6d95886720d306a1914a7c9a8aeb0bcbc7aef018] Merge remote-trackin=
g branch 'omap/for-next'
> > git bisect good 6d95886720d306a1914a7c9a8aeb0bcbc7aef018
> > # good: [975b5cdd74430bc8a04f832d65a47cdb95b73fec] Merge remote-trackin=
g branch 'fuse/for-next'
> > git bisect good 975b5cdd74430bc8a04f832d65a47cdb95b73fec
> > # good: [112386d2189fc54b979c3a8bf64b2908df91e123] Merge remote-trackin=
g branch 'i2c/i2c/for-next'
> > git bisect good 112386d2189fc54b979c3a8bf64b2908df91e123
> > # good: [3943f059823b6e15884387f31618b84826e924b3] media: coda: Add con=
trol for h.264 chroma qp index offset
> > git bisect good 3943f059823b6e15884387f31618b84826e924b3
> > # good: [44970bbbbb5079ee100875b06e45db5d6e91a16e] Merge remote-trackin=
g branch 'v4l-dvb/master'
> > git bisect good 44970bbbbb5079ee100875b06e45db5d6e91a16e
> > # bad: [599170c2b860aca3364574f833bb9cc801c9668d] Merge branch 'pm-core=
' into linux-next
> > git bisect bad 599170c2b860aca3364574f833bb9cc801c9668d
> > # good: [347d570919ca9a3a3653ce9cbb7399c7c0ba8248] Merge branch 'acpi-p=
ci' into linux-next
> > git bisect good 347d570919ca9a3a3653ce9cbb7399c7c0ba8248
> > # good: [e0a9fde86ba1bc26dd754c733b32e70cd8f1c187] Merge branches 'acpi=
-tables' and 'acpi-apei' into linux-next
> > git bisect good e0a9fde86ba1bc26dd754c733b32e70cd8f1c187
> > # good: [3b4ed2e2eb5583774a1ed4aa4596a5a3c55f2567] drm/i915: Move on th=
e new pm runtime interface
> > git bisect good 3b4ed2e2eb5583774a1ed4aa4596a5a3c55f2567
> > # bad: [c75c303933a68c547f3352d1d708843f9449d3f4] PM: clock_ops: fix mi=
ssing clk_prepare() return value check
> > git bisect bad c75c303933a68c547f3352d1d708843f9449d3f4
> > # bad: [3982ab9ce433efc72ca31eb9ddc85d9355966444] PM-runtime: Replace j=
iffies based accounting with ktime-based accounting
> > git bisect bad 3982ab9ce433efc72ca31eb9ddc85d9355966444
> > # first bad commit: [3982ab9ce433efc72ca31eb9ddc85d9355966444] PM-runti=
me: Replace jiffies based accounting with ktime-based accounting
