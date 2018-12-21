Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B80C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828D321906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbTf0clR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbeLUIbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:31:55 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38461 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLUIbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:31:55 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so2974985ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxi1fIdr2QJ4/htQ4EsQX0DIZ6dvX8fuKWvZGh98toc=;
        b=BbTf0clRXwzA6L2S4Efg4xFyuswVZYaT34r4FGCgupNz80zM+4wF7Bh2+32ytFFhh7
         M7ukmpc3pYRhOGozJNTAnjIWDNHVECPm3ZePGDytpoIMb0szi+PJsTtd4DqJ5Ti/yadY
         Jgo+ah2ng4YwzfV4JSMEwQ+EWdcYydPTe1uiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxi1fIdr2QJ4/htQ4EsQX0DIZ6dvX8fuKWvZGh98toc=;
        b=LfFz4XYpj749KayzXhq+Kqd7X7PWxK9GUdr8pYKYnC5JF3n2Bq7HpCt6snDl5FzU2z
         4+7LzbwgIl/OcbSPpLVYEyqeBV9vhJ/LMx2INYtjOsXcrP5SaS8mU3qu9qfLoCWn3eIy
         M6z1fCZXWiVgLaFAoNIncpbgTAdvO0xeIFmTX10kp/wSzOwHMhozAOGlnywPxsZB/v/5
         /qoOyOuGnO4lzB4LnXmX/BvU9v73I4JFQ0vHA9y6JF6N/roButUiuE1Edilu5GaZZ7lV
         Uq2wkShuqdrJkYc/uBk5fwiNRwPB90MENPeeuR0S4jt7P59j+l5nUQWY0Xm3xcwE5PTj
         SLlw==
X-Gm-Message-State: AJcUukejAvRaywTN7fv8stKrcQchVWDKIn0Y5g3TQN4/n2IWeD/ACVcK
        QM5TFrt2Qd8cSfe2y3ymHLg4Q6A3BL0vU/pUTzLjfA==
X-Google-Smtp-Source: ALg8bN7M6zZqr1lvg2BnLAomY4JBJWuo7U58fesRLi9XY0rlQol+UPoc9ESm29+N9vKrD+CqceWOfrGNvjuxFQZ3QIg=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr155326ioc.18.1545381113866;
 Fri, 21 Dec 2018 00:31:53 -0800 (PST)
MIME-Version: 1.0
References: <1545315426-14545-1-git-send-email-vincent.guittot@linaro.org> <CAPDyKFqPf3RzUG+YjSQmMPESjDhmgQmQXpbQdp5j7zk7b9hVNA@mail.gmail.com>
In-Reply-To: <CAPDyKFqPf3RzUG+YjSQmMPESjDhmgQmQXpbQdp5j7zk7b9hVNA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Dec 2018 09:31:43 +0100
Message-ID: <CAKfTPtAkZ54mrkiHOms-5g0-6JVVZ=KvTPPa68p4sV49P4UyQw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Thu, 20 Dec 2018 at 23:03, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 20 Dec 2018 at 15:17, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > From: Thara Gopinath <thara.gopinath@linaro.org>
> >
> > This patch replaces jiffies based accounting for runtime_active_time
> > and runtime_suspended_time with ktime base accounting. This makes the
> > runtime debug counters inline with genpd and other pm subsytems which
> > uses ktime based accounting.
> >
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > [move from ktime to raw nsec]
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 17 +++++++++--------
> >  drivers/base/power/sysfs.c   | 11 ++++++++---
> >  include/linux/pm.h           |  6 +++---
> >  3 files changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index e695544..f700524 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -64,8 +64,8 @@ static int rpm_suspend(struct device *dev, int rpmflags);
> >   */
> >  void update_pm_runtime_accounting(struct device *dev)
> >  {
> > -       unsigned long now = jiffies;
> > -       unsigned long delta;
> > +       u64 now = ktime_to_ns(ktime_get());
> > +       u64 delta;
> >
> >         delta = now - dev->power.accounting_timestamp;
> >
> > @@ -75,9 +75,9 @@ void update_pm_runtime_accounting(struct device *dev)
> >                 return;
> >
> >         if (dev->power.runtime_status == RPM_SUSPENDED)
> > -               dev->power.suspended_jiffies += delta;
> > +               dev->power.suspended_time += delta;
> >         else
> > -               dev->power.active_jiffies += delta;
> > +               dev->power.active_time += delta;
> >  }
> >
> >  static void __update_runtime_status(struct device *dev, enum rpm_status status)
> > @@ -88,17 +88,18 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> >
> >  u64 pm_runtime_suspended_time(struct device *dev)
> >  {
> > -       unsigned long flags, time;
> > +       u64 time;
> > +       unsigned long flags;
> >
> >         spin_lock_irqsave(&dev->power.lock, flags);
> >
> >         update_pm_runtime_accounting(dev);
> >
> > -       time = dev->power.suspended_jiffies;
> > +       time = dev->power.suspended_time;
> >
> >         spin_unlock_irqrestore(&dev->power.lock, flags);
> >
> > -       return jiffies_to_nsecs(time);
> > +       return time;
> >  }
> >  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
> >
> > @@ -1503,7 +1504,7 @@ void pm_runtime_init(struct device *dev)
> >         dev->power.request_pending = false;
> >         dev->power.request = RPM_REQ_NONE;
> >         dev->power.deferred_resume = false;
> > -       dev->power.accounting_timestamp = jiffies;
> > +       dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
>
> This change worries me a bit, but it may not be a problem in practice.
>
> pm_runtime_init() is called when devices get initialized, via
> device_initialize(). If timekeeping has not been initialized prior a
> call to ktime_get() is done, it will fail and causing a NULL pointer
> deference or something along those lines.
>
> In other words, do we know that device_initialize() is always called
> after timekeeping has been initialized during boot?

That something we discussed at lpc and we should be safe

>
> [...]
>
> Kind regards
> Uffe
