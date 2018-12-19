Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EC721871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESTlneAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeLSKCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:02:43 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33504 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeLSKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:02:42 -0500
Received: by mail-ua1-f66.google.com with SMTP id t8so6786833uap.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 02:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQx7dLUJGiSAdVx/e9rnK06sQwchI0BSenA1bBEwXWM=;
        b=ESTlneAdRAvwkG+zZ26ezJt7iDxfFGWlUc3J7WkSnuGT/Si2x2H3LHwRoD5AupI9xI
         r2RVktvCRDT9LEsXK7hSdzePAY9E7Q0cQSJknQDSmE/2FcIIUxWJQ6vZMXWqCrlM6+QY
         JvdtcM36xJtSnNKcalSFnzRJR6qo4xstBZQ5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQx7dLUJGiSAdVx/e9rnK06sQwchI0BSenA1bBEwXWM=;
        b=UBXmYdPp07lhJk1/UtAAXCoN3OjDti88TnxFuc3xNIXP8gwQ1iBFLkF2Ve+7ydviix
         spPSxYPkaqFZyu/GA0pGPlk0lQHwSbh2Y438Wbj0audKugLT8AXW4I68pL0YpMtxA9sv
         oR4QbtdQ3dw+Zd8Rwc5rTF1J9uWFJdQW4gYqU/+SCyPfU4kq10rOzQWSr3lQg2OyvXDB
         WhWGVgaVyyf5RAqDMvacppyWICt7cH77hcSYgc4t+XKkuvWVPMFyJt6W9+8Rehz+/t76
         ghLb/wVg5aB79FTTaKk2Ng4GSFUmC6p0+fiA3jp7ROqyWbvNIABTY+l/RYGb5qpoiU/m
         Vjcg==
X-Gm-Message-State: AA+aEWaVMY1uiskfvphBLywDmogvozWPgJIlo8mazFFRgTMkCgjHMbLQ
        ywwUMIP+pioz4JMPohuGY/P0wPPY99OwFyiNILmL3A==
X-Google-Smtp-Source: AFSGD/VwoVhy63mcAPAyB7tvXdB338299OtPsVMetYCfWdZ7miCMyRZSMVVAxuuDM4tC725I/ZurmECoM7YO5mF3Gt0=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr10084799uan.107.1545213761724;
 Wed, 19 Dec 2018 02:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-3-ulf.hansson@linaro.org> <45ff9a4b-6130-7800-28cc-a2f5f736f44b@linaro.org>
In-Reply-To: <45ff9a4b-6130-7800-28cc-a2f5f736f44b@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 11:02:05 +0100
Message-ID: <CAPDyKFpPa1u1ouoa2zFzMe2McqEpxu7Vex2zd1nYoQUQtY2s-A@mail.gmail.com>
Subject: Re: [PATCH v10 02/27] PM / Domains: Add support for CPU devices to genpd
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 10:53, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > To enable a device belonging to a CPU to be attached to a PM domain managed
> > by genpd, let's do a few changes to it, as to make it convenient to manage
> > the specifics around CPUs.
> >
> > To be able to quickly find out what CPUs that are attached to a genpd,
> > which typically becomes useful from a genpd governor as following changes
> > is about to show, let's add a cpumask to the struct generic_pm_domain. At
> > the point when a CPU device gets attached to a genpd, let's update its
> > cpumask. Moreover, let's also propagate changes to the cpumask upwards in
> > the topology to the master PM domains. In this way, the cpumask for a genpd
> > hierarchically reflects all CPUs attached to the topology below it.
> >
> > Finally, let's make this an opt-in feature, to avoid having to manage CPUs
> > and the cpumask for a genpd that doesn't need it. For that reason, let's
> > add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Don't allocate the cpumask when not used.
> >       - Simplify the code that updates the cpumask.
> >       - Document the GENPD_FLAG_CPU_DOMAIN.
> >
> > ---
> >  drivers/base/power/domain.c | 66 ++++++++++++++++++++++++++++++++++++-
> >  include/linux/pm_domain.h   | 13 ++++++++
> >  2 files changed, 78 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index e27b91d36a2a..c3ff8e395308 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/suspend.h>
> >  #include <linux/export.h>
> > +#include <linux/cpu.h>
> >
> >  #include "power.h"
> >
> > @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SAFE)
> >  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS_ON)
> >  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> > +#define genpd_is_cpu_domain(genpd)   (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> >
> >  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
> >               const struct generic_pm_domain *genpd)
> > @@ -1377,6 +1379,56 @@ static void genpd_free_dev_data(struct device *dev,
> >       dev_pm_put_subsys_data(dev);
> >  }
> >
> > +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> > +                                int cpu, bool set, unsigned int depth)
> > +{
> > +     struct gpd_link *link;
> > +
> > +     if (!genpd_is_cpu_domain(genpd))
> > +             return;
>
> With this test, we won't continue updating the cpumask for the other
> masters. Is it done on purpose ?

Correct, and yes it's on purpose.

We are not even allocating the cpumask for the genpd in question,
unless it has the GENPD_FLAG_CPU_DOMAIN set.

[...]

Kind regards
Uffe
