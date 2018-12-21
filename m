Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0857C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6983321906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+w8gnkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbeLUKHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:07:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38517 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbeLUKHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:07:05 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so5817731ith.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ft4u393HmiXxDH+RT0NdO0p20EVuGq569qeRw+Yez3k=;
        b=K+w8gnkJ51IFMI5TgNfY3u+cKmBXUl0Kz6oOmoo+MPc8Vwio33TIkDuxbs+u0VM28V
         JDpl6wIpsQVOxtVIdwFj47uVeyI5Qcxt6RUd7ti/iabj8P/AiQp4YMkSoNtdoSsLAUdN
         lPwVmZqj7k3LXy6TjfjKaw3tqeC/3RBxdJKWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ft4u393HmiXxDH+RT0NdO0p20EVuGq569qeRw+Yez3k=;
        b=gZR7DmZpsdrygvPumBtjjAzaSiJn7ML3wBeqY5OYc+//wIX8oWrLonYJUbjHSnQNcT
         JNChS1rjMy/6VANVqKAWYTQQVUVrx9VC2lVCIJsWXfXy6cDJ2T0LvV2G89rI0jPA+f6W
         xH1beweD1Q0ZVB8uoaci5+IEusjvAYOEdpCn3yAThC4oCmxnGKvkkkkB6MPd6ZO3OtwZ
         1DITwaDc3xV0Hs8ROVMklfKpCouK3PvRtliajdoPddCab+yNBLXNqM8VN8fCZCQIS2ed
         aUTJad5Qnmbx1JdSyKvS/jMo9PUDwwIjjB08S5ksbzLOinHPZSwqlshYDbwHrgbcpS1f
         wqlA==
X-Gm-Message-State: AJcUukefJWpwLtrFbwAUq1DTfAPXeAfGbkQ28TSdNqPWXD24ATJqe0Qe
        la4QjqrLImY4TQMee38VxGjOJvYpm7Jck1yOMWVhfw==
X-Google-Smtp-Source: ALg8bN4kVBs+rMUCly4HhD6xFlS4Qi+wUeiwsFTmDZl2g9PooyUFRUbCXTuZELsrYOTU7CGHGvs8mxY5Aqv6uiOpr10=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr1578882itf.14.1545386824276;
 Fri, 21 Dec 2018 02:07:04 -0800 (PST)
MIME-Version: 1.0
References: <1545315426-14545-1-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFqPf3RzUG+YjSQmMPESjDhmgQmQXpbQdp5j7zk7b9hVNA@mail.gmail.com> <CAJZ5v0jp-+rG2usiumWmORTvqCYDJJbFUB+ey3wLyQUrimdTLw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jp-+rG2usiumWmORTvqCYDJJbFUB+ey3wLyQUrimdTLw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Dec 2018 11:06:53 +0100
Message-ID: <CAKfTPtC47-KHWJibvuN1oi==CrtRTNUyHfYZcJtZ+7Y6rM+Chg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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

Hi Rafael,

On Fri, 21 Dec 2018 at 09:58, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 20, 2018 at 11:03 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 20 Dec 2018 at 15:17, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > From: Thara Gopinath <thara.gopinath@linaro.org>
> > >
> > > This patch replaces jiffies based accounting for runtime_active_time
> > > and runtime_suspended_time with ktime base accounting. This makes the
> > > runtime debug counters inline with genpd and other pm subsytems which
> > > uses ktime based accounting.
> > >
> > > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > > [move from ktime to raw nsec]
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  drivers/base/power/runtime.c | 17 +++++++++--------
> > >  drivers/base/power/sysfs.c   | 11 ++++++++---
> > >  include/linux/pm.h           |  6 +++---
> > >  3 files changed, 20 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index e695544..f700524 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -64,8 +64,8 @@ static int rpm_suspend(struct device *dev, int rpmflags);
> > >   */
> > >  void update_pm_runtime_accounting(struct device *dev)
> > >  {
> > > -       unsigned long now = jiffies;
> > > -       unsigned long delta;
> > > +       u64 now = ktime_to_ns(ktime_get());
> > > +       u64 delta;
> > >
> > >         delta = now - dev->power.accounting_timestamp;
> > >
> > > @@ -75,9 +75,9 @@ void update_pm_runtime_accounting(struct device *dev)
> > >                 return;
> > >
> > >         if (dev->power.runtime_status == RPM_SUSPENDED)
> > > -               dev->power.suspended_jiffies += delta;
> > > +               dev->power.suspended_time += delta;
> > >         else
> > > -               dev->power.active_jiffies += delta;
> > > +               dev->power.active_time += delta;
> > >  }
> > >
> > >  static void __update_runtime_status(struct device *dev, enum rpm_status status)
> > > @@ -88,17 +88,18 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> > >
> > >  u64 pm_runtime_suspended_time(struct device *dev)
> > >  {
> > > -       unsigned long flags, time;
> > > +       u64 time;
> > > +       unsigned long flags;
> > >
> > >         spin_lock_irqsave(&dev->power.lock, flags);
> > >
> > >         update_pm_runtime_accounting(dev);
> > >
> > > -       time = dev->power.suspended_jiffies;
> > > +       time = dev->power.suspended_time;
> > >
> > >         spin_unlock_irqrestore(&dev->power.lock, flags);
> > >
> > > -       return jiffies_to_nsecs(time);
> > > +       return time;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
> > >
> > > @@ -1503,7 +1504,7 @@ void pm_runtime_init(struct device *dev)
> > >         dev->power.request_pending = false;
> > >         dev->power.request = RPM_REQ_NONE;
> > >         dev->power.deferred_resume = false;
> > > -       dev->power.accounting_timestamp = jiffies;
> > > +       dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
> >
> > This change worries me a bit, but it may not be a problem in practice.
> >
> > pm_runtime_init() is called when devices get initialized, via
> > device_initialize(). If timekeeping has not been initialized prior a
> > call to ktime_get() is done, it will fail and causing a NULL pointer
> > deference or something along those lines.
> >
> > In other words, do we know that device_initialize() is always called
> > after timekeeping has been initialized during boot?
>
> We do.
>
> timekeeping_init() is called early in start_kernel() which is way
> before driver_init() (and that's when devices can start to be
> initialized) called from rest_init() via kernel_init_freeable() and
> do_basic_setup().

Thanks for the confirmation. I'm going to add your answer in the
commit message so we will have the answer next time someone will
wonder
