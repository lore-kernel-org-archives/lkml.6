Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B99C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04752148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUUwxdF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfA2HJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:09:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42990 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfA2HJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:09:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so8957508plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 23:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5nhScYMXrB3dbUoUOA58RqPgnn52U+cBB7sXM1FSgo=;
        b=QUUwxdF+aiAl0i/XClrwESP1CfIYuvn8HxaC3wOktHEdN56CKMBibpMbx9VJCq3IJP
         l/m7vZXsWBYmc8OsPBeEOL0LR3uqKGNp68AR/A4igg5zlE5F8TGL4lbQpghFwVzS1GqJ
         pp6R7QRkxlKxLRsv4ResOeBxRCZvmRKgFdQ+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5nhScYMXrB3dbUoUOA58RqPgnn52U+cBB7sXM1FSgo=;
        b=c7L8QRs7TsRGf8Uz9+nAQbSMsFVDJnVY2QWIdn7FqA0V8sHgns0hbUF7DoEO5LMWyj
         fVyFHdFFYxhFhC3OR/CW4ASG9eGd0YTnwLp8w4yiied7eFiaGTSTbs2mHDV6CwEBlWwT
         UTjFCAdRsyJ/iaTOTeFgzndzYRxIMSg7Jaz1P4wFK4+gxHBW0W/Zaw8GdxHf1CCfOmPs
         3z1zl5RUWmjiw1yojSpEdylqwcjQ3hHKTqZyYP0UM3tGzLZJPNd1qYx5VenaOhE5iEhN
         z9cPqc8MExDJ4jI8q03Dt7ebrxHERxunNrp+jhTk3mQ7aDp024O4AGyQOKFDk6ArlmQ3
         xBUQ==
X-Gm-Message-State: AJcUukdWF+QgQ5qCZLTlQ07yio506KtwcTe+N5kwBPxc/282xH/9S8ru
        xxI5XoVhKuB16DGAD/MuQ9iVqg==
X-Google-Smtp-Source: ALg8bN7SNSWS5JC+lc+UiQlP4+gEFuV0u7Sp+3Ph2rC/D7eG3Zk03KQaJ59mEkjrtwKUPdPsjcf6KA==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr24937353plb.150.1548745782781;
        Mon, 28 Jan 2019 23:09:42 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id c67sm64622782pfg.170.2019.01.28.23.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 23:09:41 -0800 (PST)
Date:   Tue, 29 Jan 2019 12:39:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Message-ID: <20190129070938.lqhejdu4ilra65ow@vireshk-i7>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
 <20190129053618.laa6nscfvlmhhkb5@vireshk-i7>
 <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
 <CAHLCerMAY8ZZRap4RQictmPkjhmk8gjKxRoS4o2ObP9jdv+FAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerMAY8ZZRap4RQictmPkjhmk8gjKxRoS4o2ObP9jdv+FAQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-19, 11:50, Amit Kucheria wrote:
> On Tue, Jan 29, 2019 at 11:16 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > On Tue, Jan 29, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 29-01-19, 10:25, Amit Kucheria wrote:
> > > > All cpufreq drivers do similar things to register as a cooling device.
> > > > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > > > to register the cooling device on their behalf. This allows us to get
> > > > rid of duplicated code in the drivers.
> > > >
> > > > In order to allow this, we add a struct thermal_cooling_device pointer
> > > > to struct cpufreq_policy so that drivers don't need to store it in a
> > > > private data structure.
> > > >
> > > > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > > > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
> > > >  include/linux/cpufreq.h   |  9 +++++++++
> > > >  2 files changed, 22 insertions(+)
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index e35a886e00bc..0f9b50d3ee91 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -19,6 +19,7 @@
> > > >
> > > >  #include <linux/cpu.h>
> > > >  #include <linux/cpufreq.h>
> > > > +#include <linux/cpu_cooling.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/init.h>
> > > > @@ -1318,6 +1319,11 @@ static int cpufreq_online(unsigned int cpu)
> > > >       if (cpufreq_driver->ready)
> > > >               cpufreq_driver->ready(policy);
> > > >
> > > > +#if IS_ENABLED(CONFIG_CPU_THERMAL)
> > > > +     if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> > > > +             policy->cdev = of_cpufreq_cooling_register(policy);
> > > > +#endif
> > >
> > > I am not sure if Rafael wanted it this way but maybe something like this:
> > >
> > >         if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
> > >             cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV))
> > >                 policy->cdev = of_cpufreq_cooling_register(policy);
> > >
> > > We never wanted ifdef hackery to be in there :)
> >
> > OK, that makes more sense. Should I just send out a fixup patch or the
> > entire series?

Single patch should be fine I believe.

> FWIW, I checked drivers/cpufreq and drivers/thermal before converting
> over and there is a mixed use of #if IS_ENABLED and if(IS_ENABLED).
> 
> Perhaps we should clean it up?

No objections from me on that.

-- 
viresh
