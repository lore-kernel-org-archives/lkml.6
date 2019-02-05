Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69724C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3817F20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERl4PjnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfBEIkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:40:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51102 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfBEIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:40:12 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so6476231iti.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2bmbisHuVIYawJyBYYO7RFGK5f9BbXCucFYT52KAD4=;
        b=ERl4PjnQ47C0fFglkXDzEEbSo1xup4bX5rtbQgHooqis0KvfeNsLs+5xIkQ+2Dds3G
         2NF8WogtZwqwXhmh1KNqtR5Txsdrb6un8RzdVhaGB1CBWNtg1nwurPJFqQXUEpcYeebd
         ur3CMUYrg18NWjm3DOGemSzdQjh4mk+GcHimk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2bmbisHuVIYawJyBYYO7RFGK5f9BbXCucFYT52KAD4=;
        b=FTggxN9JOtZMJHbA7Sa3Re14Gp/QC3qy+MG63oxIBQKlF1mZvUEDe+8jcDrD87pUnP
         EZFdoTynkzE0mb5DtTcQ8Px0vTcI7eLgOJWdAWddZ/e7GcDYsMKo6a1rWMyDb3d/O/Ul
         ccpfRUITpMQ6u68g6uA2yVol+YAKF7+/QodrFM3RjpsCG57Tt/hkUAWp2xQGh6WVozo+
         vRJkqdy9spZwyp0qGmj/zV3mvK610GHQvwRlRBJhnI7Kv9CVNrwJRn+p8L0Quhdx94UR
         +yP3RFeswIZ73XVZeiosxV1/w24g+IWHzpbAF6ZtdaASJzujh21nZk5N7QA5GozVDBPE
         RsOQ==
X-Gm-Message-State: AHQUAubizIpABt1CukkmwgErmj1k2XLPRD0lPBb00dL7J9Hwp1ees47W
        /ROQ4FWLgzY48URysyJqWguV0Kb3iyilX7ABckdSSA==
X-Google-Smtp-Source: AHgI3IbDR4EuPco6YNzypa0ZNqIf6S6yQEpVBszClWdskiIgbOWxkN6nloIFRJVCT+xCxeKp403dW6850iM/qOxm958=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr1897387ioh.294.1549356010339;
 Tue, 05 Feb 2019 00:40:10 -0800 (PST)
MIME-Version: 1.0
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
 <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org> <CAPDyKFrzs5PvrK_23HARKYkytPr3LF4S7j5rJ6LJANKmm7BMrA@mail.gmail.com>
In-Reply-To: <CAPDyKFrzs5PvrK_23HARKYkytPr3LF4S7j5rJ6LJANKmm7BMrA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 5 Feb 2019 09:39:59 +0100
Message-ID: <CAKfTPtCqj62fYHYDth0evMqBYxY9JgqVBngDe57D4XqBKw35UA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Tue, 5 Feb 2019 at 09:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 4 Feb 2019 at 17:25, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > Similarly to what happened whith autosuspend, a deadlock has been raised
> > with runtime accounting in the sequence:
> >
> > change_clocksource
> >     ...
> >     write_seqcount_begin
> >     ...
> >     timekeeping_update
> >         ...
> >         sh_cmt_clocksource_enable
> >             ...
> >             rpm_resume
> >                 update_pm_runtime_accounting
> >                     ktime_get
> >                         do
> >                             read_seqcount_begin
> >                         while read_seqcount_retry
> >     ....
> >     write_seqcount_end
> >
> > Move runtime accounting on ktime_get_mono_fast_ns()
> > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > monotonic across an update of timekeeping and as a result time can goes
> > backward. Add a test to skip accounting for such situation which should
> > stay exceptional.
> >
> > Fixes: a08c2a5a3194 ("PM-runtime: Replace jiffies-based accounting with ktime-based accounting")
> > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks

>
> Kind regards
> Uffe
>
>
> > ---
> >  drivers/base/power/runtime.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 1caa394..50740da 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -66,13 +66,22 @@ static int rpm_suspend(struct device *dev, int rpmflags);
> >   */
> >  void update_pm_runtime_accounting(struct device *dev)
> >  {
> > -       u64 now = ktime_to_ns(ktime_get());
> > +       u64 now = ktime_get_mono_fast_ns();
> > +       u64 last = dev->power.accounting_timestamp;
> >         u64 delta;
> >
> > -       delta = now - dev->power.accounting_timestamp;
> > -
> >         dev->power.accounting_timestamp = now;
> >
> > +       /*
> > +        * Because ktime_get_mono_fast_ns() is not monotonic during
> > +        * timekeeping update, we must ensure that now is after the last saved
> > +        * timesptamp
> > +        */
> > +       if (now < last)
> > +               return;
> > +
> > +       delta = now - last;
> > +
> >         if (dev->power.disable_depth > 0)
> >                 return;
> >
> > @@ -1312,7 +1321,7 @@ void pm_runtime_enable(struct device *dev)
> >
> >                 /* About to enable runtime pm, set accounting_timestamp to now */
> >                 if (!dev->power.disable_depth)
> > -                       dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
> > +                       dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
> >         } else {
> >                 dev_warn(dev, "Unbalanced %s!\n", __func__);
> >         }
> > --
> > 2.7.4
> >
