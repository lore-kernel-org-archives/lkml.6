Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83EF217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JecUyX7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbeLSLsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:48:30 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44610 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeLSLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:48:30 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so6851823uaq.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 03:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7SDTVKItAO5FJGbZNOH6yIuLijvFxA7I0ahvnghE+w=;
        b=JecUyX7C/oU0T3HlZiJMGON9FAvg1DhrdnqecXiFE09+x0yoErjRuuuL76SzecvR62
         TbptUyzzvMB42kDRGWOukzihmEwxSWddkYWT5F6c3wANC1rYiYcXJVVZd2cxQppYXFS6
         9TGCu0nkGqdGw4X6A928dE/1zsG6vr3On3K8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7SDTVKItAO5FJGbZNOH6yIuLijvFxA7I0ahvnghE+w=;
        b=cgAFbGsnWIgwSeOMX7/7nvTHauYHLzX5WrLOYdJk4ws3penUwgtdsA91NcuwZQ647Y
         qD8ibtSWhc5VJ4ceWGQHOBvx646tlP7ueOzpJ2GIRM25D3pRNmpiULzb2aJ7uWdiBPuC
         lcwbG1qtuYcyXxb9daLEK4ML3P4iunuajDViYKWe3F+2lIVIRg4NhRdqV1EAgrzaRqar
         cQWFTQQRTtLhR1BsZv6pC/R6PPhalhvWxQV1DW1JDFTZDmF8E031lkh0BRvrBbb/wgvk
         ye8GiGAtmHoSeywj8Q4oRAy8BxsSJB5cyzMbhBYy331KhieBTfYdLkH5vUbMOb1opSak
         1uYA==
X-Gm-Message-State: AA+aEWZoiCB2LmxpLIW7YkgsnGsVL00Gzsq+kq8IrAcdlj242J1lVerc
        2JSiP5rnaKEOU9ksUG3JtKq2D+xbpN8C6BmEdSUk5g==
X-Google-Smtp-Source: AFSGD/W5qQKUFuz8lfieLd7UcGi+i5QGT3GjMHpGMoLMSCtGNgd30SqVi0LduTzFKo0oRHlKEqithnHEjDpiqLrnzRM=
X-Received: by 2002:ab0:2b0b:: with SMTP id e11mr3362455uar.77.1545220108824;
 Wed, 19 Dec 2018 03:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-25-ulf.hansson@linaro.org> <20181219111744.GA23393@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181219111744.GA23393@e107981-ln.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 12:47:53 +0100
Message-ID: <CAPDyKFoFn=3VzYLriROYEgCT=gbrsjbx8Fc1dktTJ1BdCBxniw@mail.gmail.com>
Subject: Re: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug
 for the hierarchical model
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Wed, 19 Dec 2018 at 12:17, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Nov 29, 2018 at 06:46:57PM +0100, Ulf Hansson wrote:
> > When the hierarchical CPU topology is used and when a CPU has been put
> > offline (hotplug), that same CPU prevents its PM domain and thus also
> > potential master PM domains, from being powered off. This is because genpd
> > observes the CPU's struct device to remain being active from a runtime PM
> > point of view.
> >
> > To deal with this, let's decrease the runtime PM usage count by calling
> > pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
> > offline. Consequentially, we must then increase the runtime PM usage for
> > the CPU, while putting it online again.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Make it work when the hierarchical CPU topology is used, which may be
> >         used both for OSI and PC mode.
> >       - Rework the code to prevent "BUG: sleeping function called from
> >         invalid context".
> > ---
> >  drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index b03bccce0a5d..f62c4963eb62 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -15,6 +15,7 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/arm-smccc.h>
> > +#include <linux/cpu.h>
> >  #include <linux/cpuidle.h>
> >  #include <linux/errno.h>
> >  #include <linux/linkage.h>
> > @@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
> >
> >  static int psci_cpu_off(u32 state)
> >  {
> > +     struct device *dev;
> >       int err;
> >       u32 fn;
> >
> > +     /*
> > +      * When the hierarchical CPU topology is used, decrease the runtime PM
> > +      * usage count for the current CPU, as to allow other parts in the
> > +      * topology to enter low power states.
> > +      */
> > +     if (psci_dt_topology) {
> > +             dev = get_cpu_device(smp_processor_id());
> > +             pm_runtime_put_sync_suspend(dev);
> > +     }
> > +
> >       fn = psci_function_id[PSCI_FN_CPU_OFF];
> >       err = invoke_psci_fn(fn, state, 0, 0);
> >       return psci_to_linux_errno(err);
> > @@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
> >
> >  static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
> >  {
> > +     struct device *dev;
> >       int err;
> >       u32 fn;
> >
> > @@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
> >       err = invoke_psci_fn(fn, cpuid, entry_point, 0);
> >       /* Clear the domain state to start fresh. */
> >       psci_set_domain_state(0);
> > +
> > +     /* Increase runtime PM usage count if the hierarchical CPU toplogy. */
> > +     if (!err && psci_dt_topology) {
> > +             dev = get_cpu_device(cpuid);
>
> I do not like adding this code in the cpu_{on/off} method themselves, I will
> have a look at the patchset as whole to see how we can restructure it.

Any suggestions are welcome, of course. This was the best and most
simple option I could come up with.

Another option, could be to simply to remove the runtime PM deployment
from psci_cpu_off|on() altogether and just live with that limitation
for now. That works for me as well.

>
> More to the point, using cpuid as a logical cpu id is wrong, it is a
> physical id that you should convert to a logical id through
> get_logical_index().

Oh, didn't know that, thanks for pointing that out!

>
> Lorenzo
>
> > +             pm_runtime_get_sync(dev);
> > +     }
> > +
> >       return psci_to_linux_errno(err);
> >  }
> >
> > --
> > 2.17.1
> >

Kind regards
Uffe
