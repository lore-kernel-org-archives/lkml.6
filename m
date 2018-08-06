Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A635C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B346C219F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmFENDgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B346C219F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeHFLoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:44:17 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41729 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbeHFLoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:44:17 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so20984130oiw.8;
        Mon, 06 Aug 2018 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=A+opYyAlr1mqtRUwRNoWnXJIpMVPT2NnIXcngaoeahE=;
        b=XmFENDgutwMUDVM1JqKAQHIcG/Sc/iXKLHYu3O8pGR/Yajwac9KMwmANe6LnpgzJMV
         k5XzEtQzq5VpXvNZBXGl/Ds0ACrcFjUv1ZuD6+a6m9nqhrnBzMKTTnfKCksSYDNU+NE+
         kv/bZ8EqklI1Je5ZW2jPvC2gLDNn1MHtm1yd3fddK5P1DTBGi6YiA5P/RvhFl3MqOG2e
         qDt6UppnefMj/ulhG4cBZu7cGKdMqd3j2ow4vAusijMZal6BzPTOClx0WfaYSNuwVeU/
         godn5CTOyCBupWVCiXS/OppXxZdHMhMGmf4YsEHn7S4TCs03kRfWT5/6gJ1HL1w6Ue9m
         yuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=A+opYyAlr1mqtRUwRNoWnXJIpMVPT2NnIXcngaoeahE=;
        b=DRZnvxdDLukJUXR3g5vCPGd7QND6idUCzhoXUvLUXl5M8nwasjkhsrJ80appZKD53i
         W5zclEbRt4mUec2U6fLOPHv0XM1I/X/G+6SQtI/9ua76nZn+5Yzh4ksNDra+tne04tCj
         APKbhVkmTh7eYPJ7FBYKAzIh3V6gUtXiGOuFSodcT2rq58JvQDipzUswJ1Mg48lGfPNU
         yjab5pi0UUnDNrRTLd5LZkHc/VJIvHimSB4mSsLn/ckr85F/uHhDePs9ExuMQCSPJQiH
         +VRUM72BuR7yxynvoGTDCPshCUlDVOoFMujkeQw1U6VQ+A2qQ8fA2dRY42gjFHnFkhsQ
         3+Og==
X-Gm-Message-State: AOUpUlHKge9HkDyWYU5bF1S2eGjQMC2GdUPbmK2q+waLmT1AZn+EV46M
        Tyw55nsxOCZwdy0L8hmm68wK3pT6AsIcm+U5tAA=
X-Google-Smtp-Source: AAOMgpeeYl6Q8VjJzZY4XRWpkF2JZnMvyOGGrGRX1+uhZXqAhVIQM+dS/bZt0rNnm438v/UFieNiD2mD47fCiGgsTbc=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr13065063oig.282.1533548163288;
 Mon, 06 Aug 2018 02:36:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 02:36:02 -0700 (PDT)
In-Reply-To: <CAPDyKFq=m7ad66SwiOr+4ab=e7PNiXrXJ6c8G0ZTPOdO1RQ_6g@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-5-ulf.hansson@linaro.org> <1678369.6pMUSOvdlV@aspire.rjw.lan>
 <CAPDyKFq=m7ad66SwiOr+4ab=e7PNiXrXJ6c8G0ZTPOdO1RQ_6g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Aug 2018 11:36:02 +0200
X-Google-Sender-Auth: dX1Zm-lORw25sKTSdgEojk8zvdQ
Message-ID: <CAJZ5v0jah=aiYoV_b_p=-x+puO0sxeGRBCtJnQAD8xb8p1QGfg@mail.gmail.com>
Subject: Re: [PATCH v8 04/26] PM / Domains: Add support for CPU devices to genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 1:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 19 July 2018 at 12:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, June 20, 2018 7:22:04 PM CEST Ulf Hansson wrote:
>>> To enable a device belonging to a CPU to be attached to a PM domain managed
>>> by genpd, let's do a few changes to genpd as to make it convenient to
>>> manage the specifics around CPUs.
>>>
>>> First, as to be able to quickly find out what CPUs that are attached to a
>>> genpd, which typically becomes useful from a genpd governor as following
>>> changes is about to show, let's add a cpumask 'cpus' to the struct
>>> generic_pm_domain.
>>>
>>> At the point when a device that belongs to a CPU, is attached/detached to
>>> its corresponding PM domain via genpd_add_device(), let's update the
>>> cpumask in genpd->cpus. Moreover, propagate the update of the cpumask to
>>> the master domains, which makes the genpd->cpus to contain a cpumask that
>>> hierarchically reflect all CPUs for a genpd, including CPUs attached to
>>> subdomains.
>>>
>>> Second, to unconditionally manage CPUs and the cpumask in genpd->cpus, is
>>> unnecessary for cases when only non-CPU devices are parts of a genpd.
>>> Let's avoid this by adding a new configuration bit, GENPD_FLAG_CPU_DOMAIN.
>>> Clients must set the bit before they call pm_genpd_init(), as to instruct
>>> genpd that it shall deal with CPUs and thus manage the cpumask in
>>> genpd->cpus.
>>>
>>> Cc: Lina Iyer <ilina@codeaurora.org>
>>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/base/power/domain.c | 69 ++++++++++++++++++++++++++++++++++++-
>>>  include/linux/pm_domain.h   |  3 ++
>>>  2 files changed, 71 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index 21d298e1820b..6149ce0bfa7b 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -20,6 +20,7 @@
>>>  #include <linux/sched.h>
>>>  #include <linux/suspend.h>
>>>  #include <linux/export.h>
>>> +#include <linux/cpu.h>
>>>
>>>  #include "power.h"
>>>
>>> @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>>>  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SAFE)
>>>  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS_ON)
>>>  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>>> +#define genpd_is_cpu_domain(genpd)   (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>>>
>>>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>>>               const struct generic_pm_domain *genpd)
>>> @@ -1377,6 +1379,62 @@ static void genpd_free_dev_data(struct device *dev,
>>>       dev_pm_put_subsys_data(dev);
>>>  }
>>>
>>> +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
>>> +                                int cpu, bool set, unsigned int depth)
>>> +{
>>> +     struct gpd_link *link;
>>> +
>>> +     if (!genpd_is_cpu_domain(genpd))
>>> +             return;
>>> +
>>> +     list_for_each_entry(link, &genpd->slave_links, slave_node) {
>>> +             struct generic_pm_domain *master = link->master;
>>> +
>>> +             genpd_lock_nested(master, depth + 1);
>>> +             __genpd_update_cpumask(master, cpu, set, depth + 1);
>>> +             genpd_unlock(master);
>>> +     }
>>> +
>>> +     if (set)
>>> +             cpumask_set_cpu(cpu, genpd->cpus);
>>> +     else
>>> +             cpumask_clear_cpu(cpu, genpd->cpus);
>>> +}
>>
>> As noted elsewhere, there is a concern about the possible weight of this
>> cpumask and I think that it would be good to explicitly put a limit on it.
>
> I have been digesting your comments on the series, but wonder if this
> is still a relevant concern?

Well, there are systems with very large cpumasks and it is sort of
good to have that in mind when designing any code using them.
