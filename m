Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeCVJ7M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:59:12 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35115 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeCVJ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:59:10 -0400
X-Google-Smtp-Source: AG47ELt6bRteIBbXeY69xYaDmhWZu0gMSRrR4YoyvSwkh8fZQFEAWsdg05gNDFperDxHlKatdOxOXA==
Date: Thu, 22 Mar 2018 17:59:03 +0800
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] PM / Domain: Add struct device to genpd
Message-ID: <20180322095903.h7hgm3xylq3esjyf@vireshk-mac-ubuntu>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
 <a7867661e9bc6f5b1571f60398266ef678ccc1c0.1513926033.git.viresh.kumar@linaro.org>
 <CAPDyKFprVsOd7_nKCXDCxDErh-K+vfaWojqDo0arzt0ZJKCPjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFprVsOd7_nKCXDCxDErh-K+vfaWojqDo0arzt0ZJKCPjQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-18, 10:30, Ulf Hansson wrote:
> On 22 December 2017 at 08:26, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > The power-domain core would be using the OPP core going forward and the
> > OPP core has the basic requirement of a device structure for its working.
> 
> According to the OPP core also seems to require the ->dev.of_node to
> be set. Actually, it seems like that part belongs in patch4 instead,
> while starting to make use of the opp OF APIs. Could you please move
> it?

You meaning setting of the of_node to the next patch? I can do that if that;s
what you want.

> > +static struct bus_type genpd_bus_type = {
> > +       .name =         "genpd",
> > +};
> 
> This seems silly. Can't we just avoid having a bus type altogether,
> thus no need to call bus_register() as well?

I thought we need a bus where we want to add the device, haven't tried with that
pointer being empty. Will try that and let you know.

> > +
> >  /**
> >   * pm_genpd_init - Initialize a generic I/O PM domain object.
> >   * @genpd: PM domain object to initialize.
> > @@ -1687,6 +1691,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> >                         return ret;
> >         }
> >
> > +       genpd->dev.bus = &genpd_bus_type;
> > +       device_initialize(&genpd->dev);
> > +       dev_set_name(&genpd->dev, "%s", genpd->name);
> > +
> > +       ret = device_add(&genpd->dev);
> 
> What's the point of adding the device? Can we skip this step, as I
> guess the opp core is only using the device as cookie rather actual
> using it? No?

We also use it for the OPP debugfs stuff, so that would be required I believe.
We also use it for playing with clk/regulator stuff as well, though we may not
use it in genpd case for now.

-- 
viresh
