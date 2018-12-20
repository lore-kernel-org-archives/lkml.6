Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F561C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F416218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c93U3Jyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbeLTPtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:49:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38636 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbeLTPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:49:48 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so1357720vsa.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qn72qtavczvyDQK9+bypOLwn0vE7TYTvQ62AhlWVQvc=;
        b=c93U3JyxU7xHglhNXDNeXprXo6AnSMsYOYtv0bAJBQYaG/VFNHKiSoh3sjn5+4EIok
         BsWcGL3OAaiRmdepRf3pLtbpU/MyRxY+e9CW10GFIT3euZGvyafmJ2CwrGITnes/vCii
         hHBBU11S/aM8xzbF6ZSfauHf0vFO6wijkdxpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qn72qtavczvyDQK9+bypOLwn0vE7TYTvQ62AhlWVQvc=;
        b=UWoQWLryzPgtRhaJQ0UaDsolxlDFysaxRNg1fRAaS8IfeiI45lHpa58zuERPHXxGSP
         aivNLllbTZPjbDDXkbOgFD0Ckeqod/l3R0IMmN8Z05ZvrEonOqNVNu8bk7CP2DiVzbsD
         d42uePeQ2dPuwvI/jWyP+js65VScyUSJwlQeaqgRK6YVZaTPArCNpvo/IexZjWhPPRnB
         FoQfMLXrwzeNfko9ssfYdMslHhrzFU2PgASeUw2vw3E+6NNAekKhjpwrYjlzTHSQBcS1
         3irbzANBZn31JA9B5DnX9DK/+jOsDmYszoRVwF84Z+3nxiOaiQJcdg+VhMidrYA69fHc
         GkUQ==
X-Gm-Message-State: AA+aEWbO1fCNbk9DxD0p00xLaXo9Y/2OY4V5q/qAR2S2YvqAfD6ilVuU
        tygYID2AgdH6QWsMa0ZXQ9l3zfn6c5KyicI3oDvNfQ==
X-Google-Smtp-Source: AFSGD/X0T/PUFBNw2axl+qwYI9yKy7q7VEdIgg/mW+jwrGKXNHWex9SJwM4cT5gy19+WAPLksaxH3/8dcTlPwFuGwik=
X-Received: by 2002:a67:7685:: with SMTP id r127mr12276554vsc.35.1545320986457;
 Thu, 20 Dec 2018 07:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org> <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
In-Reply-To: <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Dec 2018 16:49:09 +0100
Message-ID: <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM domains
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

On Thu, 20 Dec 2018 at 15:19, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > Following changes are about to implement support for PM domains to PSCI.
> > Those changes are mainly going to be implemented in a new separate file,
> > hence a couple of the internal PSCI functions needs to be shared to be
> > accessible. So, let's do that via adding new PSCI header file.
> >
> > Moreover, the changes deploying support for PM domains, needs to be able to
> > switch the PSCI FW into the OS initiated mode. For that reason, let's add a
> > new function that deals with this and share it via the new PSCI header
> > file.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - New patch. Re-places the earlier patch: "drivers: firmware: psci:
> >         Share a few internal PSCI functions".
> >
> > ---
> >  drivers/firmware/psci/psci.c | 28 +++++++++++++++++++++-------
> >  drivers/firmware/psci/psci.h | 14 ++++++++++++++
> >  2 files changed, 35 insertions(+), 7 deletions(-)
> >  create mode 100644 drivers/firmware/psci/psci.h
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 8dbcdecc2ae4..623591b541a4 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -34,6 +34,8 @@
> >  #include <asm/smp_plat.h>
> >  #include <asm/suspend.h>
> >
> > +#include "psci.h"
> > +
> >  /*
> >   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> >   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> > @@ -90,23 +92,35 @@ static u32 psci_function_id[PSCI_FN_MAX];
> >  static DEFINE_PER_CPU(u32, domain_state);
> >  static u32 psci_cpu_suspend_feature;
> >
> > -static inline u32 psci_get_domain_state(void)
> > +u32 psci_get_domain_state(void)
> >  {
> >       return __this_cpu_read(domain_state);
> >  }
> >
> > -static inline void psci_set_domain_state(u32 state)
> > +void psci_set_domain_state(u32 state)
> >  {
> >       __this_cpu_write(domain_state, state);
> >  }
> >
> > +bool psci_set_osi_mode(void)
> > +{
> > +     int ret;
> > +
> > +     ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
> > +                     PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
> > +     if (ret)
> > +             pr_warn("failed to enable OSI mode: %d\n", ret);
> > +
> > +     return !ret;
> > +}
>
> Please keep the convention with the error code (0 => success)
>
> In the next patch it can be called:
>
> if (psci_has_osi_support())
>         osi_mode_enabled = psci_set_osi_mode() ? false : true;
>

Sure!

> > +
> >  static inline bool psci_has_ext_power_state(void)
> >  {
> >       return psci_cpu_suspend_feature &
> >                               PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
> >  }
> >
> > -static inline bool psci_has_osi_support(void)
> > +bool psci_has_osi_support(void)
> >  {
> >       return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
> >  }
> > @@ -285,10 +299,7 @@ static int __init psci_features(u32 psci_func_id)
> >                             psci_func_id, 0, 0);
> >  }
> >
> > -#ifdef CONFIG_CPU_IDLE
> > -static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> > -
> > -static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> > +int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >  {
> >       int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
> >
> > @@ -305,6 +316,9 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_CPU_IDLE
>
> It would be nicer if you can remove the CONFIG_CPU_IDLE by replacing it
> with a specific one (eg. CONFIG_PSCI_IDLE) and make it depend on
> CONFIG_CPU_IDLE, so the config options stay contained in their
> respective subsystems directory.

I am all for simplifying the Kconfig options in here, as indeed it's
rather messy. However, I would rather avoid folding in additional
cleanup changes to this series, is already extensive enough.

Would you be okay if we deal with that on top?

[...]

Kind regards
Uffe
