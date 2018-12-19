Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00CB21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQ3h4xZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeLSKKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:10:05 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39168 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbeLSKKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:10:05 -0500
Received: by mail-vs1-f65.google.com with SMTP id h78so11892890vsi.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/K3ksz2cOuGH+8ZePuFENnYOvHlfiSjHSQXc/PYJ2c=;
        b=RQ3h4xZ8xf011F6uO04XuKcLaR0eSLQf56kPf2PwCFf8encr5t4yZcsP2//ZUyeqZb
         0XXXQmjZFkshO8WK7FK5I42B2gPtvDAJeSIXTVi/NmmtJ6ZrNE1Z7zS/bkzbmnlLRXbj
         HWW1rGq17p4uQiOt++oJtRbnnmPV1J0IvFiv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/K3ksz2cOuGH+8ZePuFENnYOvHlfiSjHSQXc/PYJ2c=;
        b=ZgN7GonQpvhqgqXVrqIUNfLuMJl6fC/+hNcaaGUx241rnYATkel6Cstm/Iaj9+oLnY
         lcf/csThXwDhSMRlIM/CNOmD8oCI2Y2FNHaPF1CoNlpPwzoUPwdvpZeAxnMMruB2DmL5
         70aUdhM31QRiNHCa7gO1GDxLvhFUeZf9Cfg3Cd0pTVOpEXtUp6bTpmeNTn6Zkik1DH/M
         hwGDIHTwaUNyexBDPGsez/rhYpEF6d9WFMQt5Tqa0SUpVllHUNHlt7B+XY0PiI1ma3ve
         hRlwh0WjHQP7aZI88JGT8op5VLVmD06Y8VnX1+3gyptIN6IryE55iCaoey+7iFQalNBb
         yW3w==
X-Gm-Message-State: AA+aEWZeA3HLCdDmGliUTtroXB3fqMNM+gGYpVEqI4+Q6z9nXW8BP9oE
        diiPky1Eb/0pRo8RN+K4hYIoTpVINvwPNbtGquV9Og==
X-Google-Smtp-Source: AFSGD/WwtGYT9ruDBSvX6LKMVI14aD24tA/A1hBTdZNZP1nRDiYXyKMWV01DtQ4Mro4VlMQdNoA1Zx3cqygYixgWxrk=
X-Received: by 2002:a67:e002:: with SMTP id c2mr10059987vsl.34.1545214203976;
 Wed, 19 Dec 2018 02:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-5-ulf.hansson@linaro.org> <5529fc0a-af96-b10a-ca4a-f1417598f4ee@linaro.org>
In-Reply-To: <5529fc0a-af96-b10a-ca4a-f1417598f4ee@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 11:09:28 +0100
Message-ID: <CAPDyKFr4KmCMciLANLCEsTKj2Mz-B89BybSvX4Y8g=L5vim=fw@mail.gmail.com>
Subject: Re: [PATCH v10 04/27] PM / Domains: Add genpd governor for CPUs
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 10:54, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > As it's now perfectly possible that a PM domain managed by genpd contains
> > devices belonging to CPUs, we should start to take into account the
> > residency values for the idle states during the state selection process.
> > The residency value specifies the minimum duration of time, the CPU or a
> > group of CPUs, needs to spend in an idle state to not waste energy entering
> > it.
> >
> > To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
> > may be used for a PM domain that have CPU devices attached or if the CPUs
> > are attached through subdomains.
> >
> > The new governor computes the minimum expected idle duration time for the
> > online CPUs being attached to the PM domain and its subdomains. Then in the
> > state selection process, trying the deepest state first, it verifies that
> > the idle duration time satisfies the state's residency value.
> >
> > It should be noted that, when computing the minimum expected idle duration
> > time, we use the information from tick_nohz_get_next_wakeup(), to find the
> > next wakeup for the related CPUs. Future wise, this may deserve to be
> > improved, as there are more reasons to why a CPU may be woken up from idle.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Fold in patch that extended the new genpd CPU governor to cope with
> >         QoS constraints, as to avoid confusion.
> >       - Simplified the code according to suggestions from Rafael.
> >
> > ---
> >  drivers/base/power/domain_governor.c | 61 +++++++++++++++++++++++++++-
> >  include/linux/pm_domain.h            |  3 ++
> >  2 files changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> > index 99896fbf18e4..61a7c3c03c98 100644
> > --- a/drivers/base/power/domain_governor.c
> > +++ b/drivers/base/power/domain_governor.c
> > @@ -10,6 +10,9 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_qos.h>
> >  #include <linux/hrtimer.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/ktime.h>
> > +#include <linux/tick.h>
> >
> >  static int dev_update_qos_constraint(struct device *dev, void *data)
> >  {
> > @@ -211,8 +214,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
> >       struct generic_pm_domain *genpd = pd_to_genpd(pd);
> >       struct gpd_link *link;
> >
> > -     if (!genpd->max_off_time_changed)
> > +     if (!genpd->max_off_time_changed) {
> > +             genpd->state_idx = genpd->cached_power_down_state_idx;
> >               return genpd->cached_power_down_ok;
> > +     }
> >
> >       /*
> >        * We have to invalidate the cached results for the masters, so
> > @@ -237,6 +242,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
> >               genpd->state_idx--;
> >       }
> >
> > +     genpd->cached_power_down_state_idx = genpd->state_idx;
> >       return genpd->cached_power_down_ok;
> >  }
> >
> > @@ -245,6 +251,54 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
> >       return false;
> >  }
> >
> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> > +{
> > +     struct generic_pm_domain *genpd = pd_to_genpd(pd);
> > +     ktime_t domain_wakeup, cpu_wakeup;
> > +     s64 idle_duration_ns;
> > +     int cpu, i;
> > +
> > +     /* Validate dev PM QoS constraints. */
> > +     if (!default_power_down_ok(pd))
> > +             return false;
> > +
> > +     if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
> > +             return true;
>
> Is it possible to have this function called without the
> GENPD_FLAG_CPU_DOMAIN flag set in the genpd?

Theoretically yes, however in practice, probably not.

Do note, if the GENPD_FLAG_CPU_DOMAIN isn't set, then we haven't
allocated the cpumask for the genpd, so then we shouldn't use it.

>
> > +     /*
> > +      * Find the next wakeup for any of the online CPUs within the PM domain
> > +      * and its subdomains. Note, we only need the genpd->cpus, as it already
> > +      * contains a mask of all CPUs from subdomains.
> > +      */
> > +     domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> > +     for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> > +             cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
> > +             if (ktime_before(cpu_wakeup, domain_wakeup))
> > +                     domain_wakeup = cpu_wakeup;
> > +     }
> > +

[...]

Kind regards
Uffe
