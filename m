Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF50C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6B8218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlSGMD2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbeLTVKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:10:37 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43092 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbeLTVKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:10:36 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so1967245vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 13:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUq9TBBK9t1BgxHFuMyVN3iuBzPgKImOP2CXu8v7xh8=;
        b=QlSGMD2rj7s0+DheMQQSufYJhmCo8Zle1mdgAVDYkipVq9GdMLYYBayBErQLSXE0hW
         +H0GlKGcO9QpP4zNSaApPqF3zcNTQj43G+is0wmxB47MzLVrYxOejTXILZ+on5ecNTHl
         uRwemciysky7AeB34k431kNOLWV7tk3wynLXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUq9TBBK9t1BgxHFuMyVN3iuBzPgKImOP2CXu8v7xh8=;
        b=UEAxwHbh3zENRZRe3kD0RxZaQc6kX5zd+lyHMopOeOMtaCJM72IUOHM6wPxTxFRvE+
         DVN2pRKN2CD+JSucaaqLVAV78zd6SSaC24otZQd9rHBHSZPGv6g7FzBkbtDBpPOJImV5
         S/YwmeWmSmczQsFiF2ug4Fquzv2qPE6KV/PtwMh00sI9/CL7ztx75GaHn4NzuJemhC94
         WV6CFnDmIJJIe+7qcGh3CWCH3cS0vOlKP/AhrH0SLQm8U9dAcfJfJJGC6wiPwxKFHEu8
         vBBaz1mRVhFRiODngajCrB7Y3F6XQvZihPnAAVHrO4ghemzbuXPM1KCsd/ltZMc2QPaJ
         AJ3w==
X-Gm-Message-State: AA+aEWYG65fMpZacYeQe5dTZpxNvDGD1JIT594zbQ8Qye/MGoanhkEml
        ykMyIFowUY8xJiNd5zpd800B/S/THkN5Twnd158SkQ==
X-Google-Smtp-Source: AFSGD/UcKr+fxrsy9M49vWoFuydwg4E2/rRLDRfl/NqRVf2+hPr3L0AsZWYY7rX7f/wwiG3lJS2dg9psDnSV/eqyykk=
X-Received: by 2002:a67:7685:: with SMTP id r127mr12790733vsc.35.1545340235233;
 Thu, 20 Dec 2018 13:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-19-ulf.hansson@linaro.org> <fa99b1a9-2e4d-e97c-9478-43b4d3ef9819@linaro.org>
In-Reply-To: <fa99b1a9-2e4d-e97c-9478-43b4d3ef9819@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Dec 2018 22:09:58 +0100
Message-ID: <CAPDyKFo5Qf-fODAugZK4CqOL81-r0uUjZVmoD2h+M8_b+-_95A@mail.gmail.com>
Subject: Re: [PATCH v10 18/27] drivers: firmware: psci: Add support for PM
 domains using genpd
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

[...]

> > -obj-$(CONFIG_ARM_PSCI_FW)    += psci.o
> > +obj-$(CONFIG_ARM_PSCI_FW)    += psci.o psci_pm_domain.o
>
> Same comment as 17/27.
>
> +obj-$(CONFIG_PSCI_IDLE) += psci_pm_domain.o

Let's discuss that in patch 17 to agree on the way forward.

[...]

> > +static int psci_pd_power_off(struct generic_pm_domain *pd)
> > +{
> > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > +     u32 *pd_state;
> > +     u32 composite_pd_state;
> > +
> > +     /* If we have failed to enable OSI mode, then abort power off. */
> > +     if (psci_has_osi_support() && !osi_mode_enabled)
> > +             return -EBUSY;
>
> I'm not sure EBUSY is the best error code to describe this situation.
> May be ENOTSUP ?

I see your point. However, -EBUSY is the correct code for this case as
it tells genpd that the PM domain could not power off, but needs to
stay powered on.

To be clear, genpd treat -EBUSY, in a bit special way.

>
> However, how possible is it to pass in this function if the OSI mode was
> not enabled ?

If we fail to enable OSI mode, we keep having the CPUs attached to
PSCI PM PM domains. Although, as we are then running in platform
coordinated mode, there is no point allowing a cluster idle state.

The option would be to convert to the flattened model in case we fail
to enable OSI mode, but that error path is going to be rather
complicated (we need to detach CPUs, unregister domains and providers,
etc). Instead the assumption is that it simply shouldn't fail when we
decide to try. If it does, it's likely something need to be fixed
anyways.

>
> > +     if (!state->data)
> > +             return 0;
> > +
> > +     /* When OSI mode is enabled, set the corresponding domain state. */
> > +     pd_state = state->data;
> > +     composite_pd_state = *pd_state | psci_get_domain_state();
> > +     psci_set_domain_state(composite_pd_state);
> > +
> > +     return 0;
> > +}
> > +
> > +static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
> > +                             int state_count)
>
> __init ?

Yes, probably. I will check and see if/where it could makes sense.
Thanks for pointing it out!

[...]

Kind regards
Uffe
