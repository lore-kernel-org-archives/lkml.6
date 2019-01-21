Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116EFC2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31002063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCaRjo75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfAUOYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:24:03 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33600 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbfAUOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:24:03 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so12718390vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtHk7/+QGCTjFekyd8dDMNSjrVxFUNnVyEvOJvlFAEQ=;
        b=OCaRjo75JhWwAkI/LMcQ8gKpvDMpdErmS6pUJ5gmHpMmpn1g37TPs445sEEnYuN5T5
         aks6YEJsAEbzCOxFJPS3+ghTDywzaoOgjqht00FjJsKWpw9PTHciEH154FV1s9Zagnim
         u/602M3P8BuFMhFBI7iQDEb2LtlHk4c38gYoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtHk7/+QGCTjFekyd8dDMNSjrVxFUNnVyEvOJvlFAEQ=;
        b=D38baPHa0+oAyfJZpoFEAoX56p/PalvY/PRQuh5EoVppSrJGNwtx3Bfbm20KDw2ssF
         Lux9ogkjlf9aUlab39xUZaJj7bxdCS3jgfsXxXTYR4pg+y+iE/g7eTJh7jm0k1cNv53K
         SEuowCTRRc/CQ9oWXOiD8d82lcVl99tr/XFkWobhWfGvesl50qrFZYBp1PtoKFhLgXBn
         4LQ4BortwHVrBRlTg4Tz29IJJvReY05KxGY4iGbBhFORqgPy0TVwQAwD1ec8tzkc4Q1g
         hm5Qg+qKsvT+zGHP9Kx2Zg4N6Avbk2+bmDHx53P7xr/i0mfpNXXCVwS1Q4TLD1KhF6pM
         7vuQ==
X-Gm-Message-State: AJcUukfTU+t/pq843IdxZf3eQq9JCIXzznWWJH4quo7YW7kaR1lWL30J
        ofaMIfz9pvHn3irJdP4VUxWXJ10i0Qh4nub/rzJ9qA==
X-Google-Smtp-Source: ALg8bN52V8aSzjWz5Qk6K/4Ja2DV0YHlkeHbUfQT7SLIPpNcL4TNgUr7Hq6aFIA9pRwle0fJ4AoOv1+0HvAnrMPIQtw=
X-Received: by 2002:a67:e0d4:: with SMTP id m20mr12629570vsl.182.1548080641551;
 Mon, 21 Jan 2019 06:24:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <e195496f42375259f1b202eae39d20a56725f4a7.1547458732.git.amit.kucheria@linaro.org>
 <154751027198.169631.16299398103212295726@swboyd.mtv.corp.google.com>
In-Reply-To: <154751027198.169631.16299398103212295726@swboyd.mtv.corp.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Jan 2019 19:53:50 +0530
Message-ID: <CAHLCerNHWh5odX5d27RqTR=jgq_OMexto9mfQVWDTpxZPzCu+Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: Add a flag to auto-register a cooling device
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 5:27 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-01-14 02:21:06)
> > All cpufreq drivers do similar things to register as a cooling device.
> > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > to register the cooling device on their behalf. This allows us to get
> > rid of duplicated code in the drivers.
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
> >  include/linux/cpufreq.h   |  6 ++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 6f23ebb395f1..7faebfc61e60 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/syscore_ops.h>
> >  #include <linux/tick.h>
> >  #include <trace/events/power.h>
> > +#include <linux/cpu_cooling.h>
>
> Maybe this is supposed to be ordered alphabetically? If so, this should
> be much higher.

Fixed

> >
> >  static LIST_HEAD(cpufreq_policy_list);
> >
> > @@ -1318,6 +1319,12 @@ static int cpufreq_online(unsigned int cpu)
> >         if (cpufreq_driver->ready)
> >                 cpufreq_driver->ready(policy);
> >
> > +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> > +               struct thermal_cooling_device **cdev = &policy->cooldev;
> > +
> > +               *cdev = of_cpufreq_cooling_register(policy);
> > +       }
>
> This seems to be some complicated way of writing:
>
>                 policy->cooldev = of_cpufreq_cooling_register(policy);
>
> ?

Indeed. Fixed.

> > +
> >         pr_debug("initialization complete\n");
> >
> >         return 0;
> > @@ -1411,6 +1418,12 @@ static int cpufreq_offline(unsigned int cpu)
> >         if (has_target())
> >                 cpufreq_exit_governor(policy);
> >
> > +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> > +               struct thermal_cooling_device **cdev = &policy->cooldev;
> > +
> > +               cpufreq_cooling_unregister(*cdev);
>
> Similar? I'm confused!
>

_un_register as opposed to register above. :-)

Thanks for the review.
