Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069C221909
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545382713;
	bh=Ro4yIaTCeQsTGbVC/sLEVI60Q0pt6plj5g0qoTyyFOM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TU09m7vIU27a4PYxtrrJACMoN3G8ru0qgpMTr3RYl9kZK53jS3WquiABUgxOBxcYx
	 tZGGLWNKEktJ5C0RBesPpDjWXrDolG2/IQiSmn459Oc4bu6/3nSYBzyRIU04HV2xTU
	 nxZ1ebaHwr8TsU5xGzbUf4qX47cQ6olOaYq4IGXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbeLUI6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:58:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44821 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeLUI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:58:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so4458136otl.11;
        Fri, 21 Dec 2018 00:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxp37XsPBprIwPTDNqXiT9gyPfRsLk1dntwC8kVxdZw=;
        b=Dc4z9LMcThKvx9wkXkYATL7aCUgICOwcIoFLtZoP4si3B5HCtxoMtBj3GiU8vFjisr
         HWhifUtjbW+mXnWgNYjuJPldm4YaIOs1n0hARy/m4D9mSPW6TFVMU541IuvPBmjA+WLm
         wpNRysnRdlBv5g2oT6MjHnvjUwsEq6LWawS51qBe8dbdpZKHs4EiMDHGf4BBCtUWm3Gh
         zGkuCcZjBVUPjbANm4DOrIBWGjPCcLBMoAi3EwVXK0v3Gvc7TO5GjeuRm7aAl0YvsCes
         eba9zFyMhdDITk8UcvckJIthSkdxAK3mrjrFfCWmSxg3gsZPxUHidXchfdMQkXZjb9rK
         /Xkw==
X-Gm-Message-State: AJcUukdDwYfdT7XoA0vQEnPIZQ3zCJsJ6/TSpkvuulyODt6o9AUcRSMx
        JOTKEWA/nXDJzh9U9kAfVUW0QV+vyecT9l3W1+E=
X-Google-Smtp-Source: ALg8bN4C/7p9UlnJPcjrwfrh0QMGoG/5lIks3mR8+50uf2WcILwscu3y/ZaHz56rm1ccddw5aIKZ8qBvK/HR/Y6mycM=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr982652otf.124.1545382710109;
 Fri, 21 Dec 2018 00:58:30 -0800 (PST)
MIME-Version: 1.0
References: <1545315426-14545-1-git-send-email-vincent.guittot@linaro.org> <CAPDyKFqPf3RzUG+YjSQmMPESjDhmgQmQXpbQdp5j7zk7b9hVNA@mail.gmail.com>
In-Reply-To: <CAPDyKFqPf3RzUG+YjSQmMPESjDhmgQmQXpbQdp5j7zk7b9hVNA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Dec 2018 09:58:18 +0100
Message-ID: <CAJZ5v0jp-+rG2usiumWmORTvqCYDJJbFUB+ey3wLyQUrimdTLw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:03 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
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

We do.

timekeeping_init() is called early in start_kernel() which is way
before driver_init() (and that's when devices can start to be
initialized) called from rest_init() via kernel_init_freeable() and
do_basic_setup().
