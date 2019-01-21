Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44905C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089D820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gcxdxebb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAUOX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:23:26 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46993 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfAUOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:23:25 -0500
Received: by mail-vk1-f194.google.com with SMTP id j23so4603613vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgP/e1eJoJLuQbBHqjtM5V9t6HH+ZvU1oJSrRi9V3o8=;
        b=GcxdxebbWInJqquUnzyMfeCuGyYptB+/rp+PHf/YQ14SQtWq9hU6ZxBiKaNwgertm8
         41hyCT5Py9QsY8CUbQ6Z6Pvziexu4zsDO9s0Zpl9lI+E6LTG+qLq9ONuJi52xkNOdz8t
         TV6XxamtSH/8vQF7EM1ykneqkK6UWx8Swd/c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgP/e1eJoJLuQbBHqjtM5V9t6HH+ZvU1oJSrRi9V3o8=;
        b=SaEFIGHlh9+rd2cK5mAub+5d/zunxNE7RS6c8NyBDCLbAzjptsYqjBPBmxmspA2clK
         MIs0pDtqFajTCrUErl5Xz+xMx7yhKgUt5Dg9xNeiX44qzQD9hRFzE7Ap9Qngy/If+2xG
         FF5aPeV5aD8s3nAI0vFUXnKpN4cfCgVHRlk7Kzpkid4N8zURvIX4O7uw7gH+hKLDRgSz
         d27dOQZPI9K3jrfvSgGTZtmSTGYhrY3ePv3IBVM/VHc7auqJByK/S+ophQJG8PFjx8kg
         e5MfG+fLMUq7HYaQdGKtljIWvgTjrnG0j7fzrq8r5uX5ay2BXYPZc/2TLroN8kreAYwr
         /tgQ==
X-Gm-Message-State: AJcUukcZrV8UIXZIMvkIINrYBUPWk8crGDXN9W9yvSBIh4cj53H9aAb7
        8miiJzXsXbu/pLb5lx0VVHtSmrHGvWPslddSAJLO1Q==
X-Google-Smtp-Source: ALg8bN7XLjQHiuGUGkW6SWEO4ET34OkKktVjod2+yr2WMRaTehMAqqjKTh6s1LfAeo/wT8XcudbI8GhYdvZt/SrL/2M=
X-Received: by 2002:a1f:b58d:: with SMTP id e135mr11681993vkf.86.1548080604230;
 Mon, 21 Jan 2019 06:23:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <c1e460c49ad2f16b15ace909514a770c9753d1b1.1547481320.git.amit.kucheria@linaro.org>
 <15792961.Mmjk2FNQN5@aspire.rjw.lan> <20190117044246.jcwhb5bxb6he33lp@vireshk-i7>
In-Reply-To: <20190117044246.jcwhb5bxb6he33lp@vireshk-i7>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Jan 2019 19:53:12 +0530
Message-ID: <CAHLCerPFcxX1LeeY0kRp5_4ayKtzzWkQUv6p8pjJ1ELxKt1LhA@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] cpufreq: Add a flag to auto-register a cooling device
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-01-19, 00:03, Rafael J. Wysocki wrote:
> > On Monday, January 14, 2019 5:34:54 PM CET Amit Kucheria wrote:
> > > All cpufreq drivers do similar things to register as a cooling device.
> > > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > > to register the cooling device on their behalf. This allows us to get
> > > rid of duplicated code in the drivers.
> > >
> > > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 17 +++++++++++++++++
> > >  include/linux/cpufreq.h   |  6 ++++++
> > >  2 files changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 6f23ebb395f1..cd6e750d3d82 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -30,6 +30,7 @@
> > >  #include <linux/syscore_ops.h>
> > >  #include <linux/tick.h>
> > >  #include <trace/events/power.h>
> > > +#include <linux/cpu_cooling.h>
> > >
> > >  static LIST_HEAD(cpufreq_policy_list);
> > >
> > > @@ -1318,6 +1319,14 @@ static int cpufreq_online(unsigned int cpu)
> > >     if (cpufreq_driver->ready)
> > >             cpufreq_driver->ready(policy);
> > >
> > > +#ifdef CONFIG_CPU_THERMAL
> > > +   if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> > > +           struct thermal_cooling_device **cdev = &policy->cooldev;
>
> We use cdev for the cooling device everywhere in the kernel, so please
> do s/cooldev/cdev/ in your patches.

Fixed

> > > +
> > > +           *cdev = of_cpufreq_cooling_register(policy);
> >
> > What would be wrong with
> >
> >               policy->cooldev = of_cpufreq_cooling_register(policy);
> >
> > > +   }
> > > +#endif
> >
> > Please remove the #ifdefs from cpufreq_online() and cpufreq_offline().
> >
> > Use wrappers that would become empty stubs for CONFIG_CPU_THERMAL unset.
> >
> > > +
> > >     pr_debug("initialization complete\n");
> > >
> > >     return 0;
> > > @@ -1411,6 +1420,14 @@ static int cpufreq_offline(unsigned int cpu)
> > >     if (has_target())
> > >             cpufreq_exit_governor(policy);
> > >
> > > +#ifdef CONFIG_CPU_THERMAL
> > > +   if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> > > +           struct thermal_cooling_device **cdev = &policy->cooldev;
> > > +
> > > +           cpufreq_cooling_unregister(*cdev);
> >
> > Again, why don't you simply pass policy->cooldev here?
>
> I also had the same comments when I looked at your patch :)
>
> I also think we must do the unregistering before calling stop_cpu()
> callback.

Fixed.

> > Also, would it make sense to clear policy->cooldev at this point?  It points
> > to freed memory after cpufreq_cooling_unregister().
>
> Since the core doesn't refer to this field at all and uses it only
> while registering/unregistering as a cooling device, there is no
> technical issue that we will have today. If someone uses the dangling
> pointer later on in future, it will be a bug. So I wouldn't care much
> about resetting it here.
>
> > > +   }
> > > +#endif
> > > +
> > >     /*
> > >      * Perform the ->exit() even during light-weight tear-down,
> > >      * since this is a core component, and is essential for the
> > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > index 7d0cf54125fa..70ad02088825 100644
> > > --- a/include/linux/cpufreq.h
> > > +++ b/include/linux/cpufreq.h
> > > @@ -390,6 +390,12 @@ struct cpufreq_driver {
> > >   */
> > >  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
> > >
> > > +/*
> > > + * Set by drivers that want the core to automatically register the cpufreq
> > > + * driver as a thermal cooling device
>
> Add a full-stop here please.

Fixed

Thanks for the review.


> > > + */
> > > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
> > > +
> > >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> > >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> > >
