Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8D7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEC020851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9VnFfcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfAQEmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:42:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34310 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfAQEmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:42:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so4129478plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1cmVrUp1aFFL+cMVhydqXGhQXqgypa1WPeHWGC5W2dY=;
        b=b9VnFfcdcFaaIqgWXHWvvt9J4rT+Al+INxoCKb9F3Q8Xa3uZcKLPysn053r2FAwJjO
         KUa2LHzy/u8OtuDBnBiMptSmg5uhCLXgWi3IqLg/BeK+TE1J0PiEGz5+POo0t5DGTXNN
         4SHiltNMECTepc+kF3pOPofx0UVYfdmg9OFYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1cmVrUp1aFFL+cMVhydqXGhQXqgypa1WPeHWGC5W2dY=;
        b=gYJ4qrM29Gv5onZ1MVwYyUles5JKbvcJhHK0EPFvx0cZry4hQ5GJDzhfw9queje+MS
         Wh4mvsZZ6di3nKznGCaq8EjNXZgAxcY7rVdlZgCF9+w2MojTh+Y3zEb0OvjiawLvwNds
         Yhe1MCrQX4Lf1VGczHbiYjLuFsKV5nZzSfV+uwYBXFONQvbwCEOI6h2mW6HB9AjZiYLr
         gbRMG/qjJCxR1zAUKpf0EpIzz1uCMcjeIZG3QOuG4QnCoC7KDWGt5nUvQCEUKXcAsMss
         VgRcwf7J9JkP4VeHMQfxExxOZ7aSXSadnSP6jRLHURSbjr3MokhrcP+weo9/XPFDhRA2
         EMYA==
X-Gm-Message-State: AJcUukfm1ek0xx4G3McID5LqL9u+5plAzii7dJD9QCPpZa6K0IS6zkqX
        fh9VQO64gUNsYYFlErvrzSjfXQ==
X-Google-Smtp-Source: ALg8bN6B/CVrDnN71kFYRO4QvVK6e7wj578xOD7UIjmx07w1t2wmPJ2DJcA6+V+iXpD4ESmP9mScaw==
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr13666695plz.80.1547700169898;
        Wed, 16 Jan 2019 20:42:49 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id x11sm779609pfe.72.2019.01.16.20.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 20:42:48 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:12:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 02/10] cpufreq: Add a flag to auto-register a cooling
 device
Message-ID: <20190117044246.jcwhb5bxb6he33lp@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <c1e460c49ad2f16b15ace909514a770c9753d1b1.1547481320.git.amit.kucheria@linaro.org>
 <15792961.Mmjk2FNQN5@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15792961.Mmjk2FNQN5@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-19, 00:03, Rafael J. Wysocki wrote:
> On Monday, January 14, 2019 5:34:54 PM CET Amit Kucheria wrote:
> > All cpufreq drivers do similar things to register as a cooling device.
> > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > to register the cooling device on their behalf. This allows us to get
> > rid of duplicated code in the drivers.
> > 
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 17 +++++++++++++++++
> >  include/linux/cpufreq.h   |  6 ++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 6f23ebb395f1..cd6e750d3d82 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/syscore_ops.h>
> >  #include <linux/tick.h>
> >  #include <trace/events/power.h>
> > +#include <linux/cpu_cooling.h>
> >  
> >  static LIST_HEAD(cpufreq_policy_list);
> >  
> > @@ -1318,6 +1319,14 @@ static int cpufreq_online(unsigned int cpu)
> >  	if (cpufreq_driver->ready)
> >  		cpufreq_driver->ready(policy);
> >  
> > +#ifdef CONFIG_CPU_THERMAL
> > +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> > +		struct thermal_cooling_device **cdev = &policy->cooldev;

We use cdev for the cooling device everywhere in the kernel, so please
do s/cooldev/cdev/ in your patches.

> > +
> > +		*cdev = of_cpufreq_cooling_register(policy);
> 
> What would be wrong with
> 
> 		policy->cooldev = of_cpufreq_cooling_register(policy);
> 
> > +	}
> > +#endif
> 
> Please remove the #ifdefs from cpufreq_online() and cpufreq_offline().
> 
> Use wrappers that would become empty stubs for CONFIG_CPU_THERMAL unset.
> 
> > +
> >  	pr_debug("initialization complete\n");
> >  
> >  	return 0;
> > @@ -1411,6 +1420,14 @@ static int cpufreq_offline(unsigned int cpu)
> >  	if (has_target())
> >  		cpufreq_exit_governor(policy);
> >  
> > +#ifdef CONFIG_CPU_THERMAL
> > +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> > +		struct thermal_cooling_device **cdev = &policy->cooldev;
> > +
> > +		cpufreq_cooling_unregister(*cdev);
> 
> Again, why don't you simply pass policy->cooldev here?

I also had the same comments when I looked at your patch :)

I also think we must do the unregistering before calling stop_cpu()
callback.

> Also, would it make sense to clear policy->cooldev at this point?  It points
> to freed memory after cpufreq_cooling_unregister().

Since the core doesn't refer to this field at all and uses it only
while registering/unregistering as a cooling device, there is no
technical issue that we will have today. If someone uses the dangling
pointer later on in future, it will be a bug. So I wouldn't care much
about resetting it here.

> > +	}
> > +#endif
> > +
> >  	/*
> >  	 * Perform the ->exit() even during light-weight tear-down,
> >  	 * since this is a core component, and is essential for the
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 7d0cf54125fa..70ad02088825 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -390,6 +390,12 @@ struct cpufreq_driver {
> >   */
> >  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
> >  
> > +/*
> > + * Set by drivers that want the core to automatically register the cpufreq
> > + * driver as a thermal cooling device

Add a full-stop here please.

> > + */
> > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
> > +
> >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> >  
> > 
> 

-- 
viresh
