Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF38FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA9721871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUZUtIYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeLSKLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:11:54 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46945 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbeLSKLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:11:53 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so15135219ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 02:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZeWy4aC10R9gy8kgv7xr2HboE3ekBeUUn/LW1kxWWg=;
        b=GUZUtIYv7NFeUWLRaUe1qbnc8k2gUMXI9xr5aG058o8cmK/CpkfSx5PfVpJSJ5Wzyc
         VaHPVW3vpQ+ZH/5LrHZK8lhGcuhMwmcjTdvly8q8dE8R1fQt9IHtE/SHLXRDvNkm0Yrf
         XXZ3jkAs0vsGxy0xkS8FsCL51Tv2GDtFBd0Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZeWy4aC10R9gy8kgv7xr2HboE3ekBeUUn/LW1kxWWg=;
        b=JWxZQ4URbP454LhQ24v5JAwmukowXRVu2IlTn1iLp5VIbI0UQDvbejpe/nrrVQx4gR
         Z+W1S4gHU+Wi6F6crdgmBhqbaFkhJpOt4DqlnPisHSrXS0EPkFXyLRSmrZlcDwMUAEhr
         hWJjMkqj7rv9byyzYzix9V4tOCLxfan7pVlHY193h+F6HkbI4xghUuMOIXwT2afeG/+i
         4sG5MYX1VmUb6TnnG6napbSR0rBQHlpmaUemdKjYv6PRC9cPYwrjHzkEUCuFU/2/436I
         o0YBEpo5+/3BU/cXeQZTPuSULsMo5y4sSoqukmy1hmuFYO8ggWEfOArBi8BP974bS0L+
         Ij+A==
X-Gm-Message-State: AA+aEWblEXOCXuqqi171VA6lMUX2ff+3g/CPHvgHuZmF2JI+nwZmlbNi
        OnESx4psW9Ps00g5PHkOKkcIhVh9Js/VjwWC4/CidLU1x+oc9Q==
X-Google-Smtp-Source: AFSGD/UGcPu3MuA9rhXES8XvuCuRtf4fq8KvdPaeU1Xb2FkXJj4n6erktGhoIp5iKyuJZIkziq3x3UXi7VIxPmeeg3k=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr16486586iof.183.1545214312585;
 Wed, 19 Dec 2018 02:11:52 -0800 (PST)
MIME-Version: 1.0
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
 <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org> <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
In-Reply-To: <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 11:11:40 +0100
Message-ID: <CAKfTPtCpv0MqF64JGTyR63bqKdAhXzL1fEsNbS6DHsD-jXYpKw@mail.gmail.com>
Subject: Re: [RFC v3 1/3] PM/runtime: Add a new interface to get accounted time
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 10:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 18 Dec 2018 at 15:55, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Some drivers (like i915/drm) need to get the accounted suspended time.
> > pm_runtime_accounted_time_get() will return the suspended or active
> > accounted time until now.
>
> I suggest to leave the active accounted time out for now. At least
> until we have some users.

This is needed to keep same feature level for i915/drm

>
> That said, perhaps rename the function to something along the lines
> of, pm_runtime_last_suspended_time(), to make it more clear.
>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 26 ++++++++++++++++++++++++++
> >  include/linux/pm_runtime.h   |  2 ++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 7062469..6461469 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> >         dev->power.runtime_status = status;
> >  }
> >
> > +u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
> > +{
> > +       u64 now = ktime_to_ns(ktime_get());
>
> I think you should stay on jiffies here - and then switch to ktime in patch 3.
>
> > +       u64 delta = 0, time = 0;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&dev->power.lock, flags);
> > +
> > +       if (dev->power.disable_depth > 0)
> > +               goto unlock;
> > +
> > +       /* Add ongoing state  if requested */
> > +       if (update && dev->power.runtime_status == status)
> > +               delta = now - dev->power.accounting_timestamp;
> > +
>
> Hmm. Do we really need to update the accounting timestamp? I would
> rather avoid it if possible.

i915/drm uses this to track ongoing suspended state. In fact they are
mainly interested by this part

>
> It seems like it should be sufficient to return the delta between
> "now" and the "dev->power.accounting_timestamp", when
> "dev->power.runtime_status == RPM_SUSPENDED".
>
> In other case, just return 0, because we are not in RPM_SUSPENDED state.

only the RPM_SUSPENDED is used by i915/drm but wanted to provide a
generic interface to get
suspended or not suspend state

>
> > +       if (status == RPM_SUSPENDED)
> > +               time = dev->power.suspended_time + delta;
> > +       else
> > +               time = dev->power.active_time + delta;
> > +
> > +unlock:
> > +       spin_unlock_irqrestore(&dev->power.lock, flags);
> > +
> > +       return time;
> > +}
> > +
> >  /**
> >   * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
> >   * @dev: Device to handle.
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 54af4ee..86f21f9 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -113,6 +113,8 @@ static inline bool pm_runtime_is_irq_safe(struct device *dev)
> >         return dev->power.irq_safe;
> >  }
> >
> > +extern u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update);
> > +
> >  #else /* !CONFIG_PM */
> >
> >  static inline bool queue_pm_work(struct work_struct *work) { return false; }
> > --
> > 2.7.4
> >
>
> Kind regards
> Uffe
