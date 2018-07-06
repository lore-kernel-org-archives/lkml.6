Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AA4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED52B23F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED52B23F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932374AbeGFKTG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:19:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34220 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932318AbeGFKTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:19:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E35DAED1;
        Fri,  6 Jul 2018 03:19:03 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F05093F5BA;
        Fri,  6 Jul 2018 03:18:59 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:18:58 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [RFC PATCH v4 12/12] OPTIONAL: cpufreq: dt: Register an Energy
 Model
Message-ID: <20180706101858.GC11862@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-13-quentin.perret@arm.com>
 <CAKfTPtAANKzw7QTzKiU_ntiGYMxZD3etd8wMzXtngwUWHXj+Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAANKzw7QTzKiU_ntiGYMxZD3etd8wMzXtngwUWHXj+Hg@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 Jul 2018 at 12:10:02 (+0200), Vincent Guittot wrote:
> On Thu, 28 Jun 2018 at 13:41, Quentin Perret <quentin.perret@arm.com> wrote:
> > +static int of_est_power(unsigned long *mW, unsigned long *KHz, int cpu)
> > +{
> > +       unsigned long mV, Hz, MHz;
> > +       struct device *cpu_dev;
> > +       struct dev_pm_opp *opp;
> > +       struct device_node *np;
> > +       u32 cap;
> > +       u64 tmp;
> > +
> > +       cpu_dev = get_cpu_device(cpu);
> > +       if (!cpu_dev)
> > +               return -ENODEV;
> > +
> > +       np = of_node_get(cpu_dev->of_node);
> > +       if (!np)
> > +               return -EINVAL;
> > +
> > +       if (of_property_read_u32(np, "dynamic-power-coefficient", &cap))
> > +               return -EINVAL;
> > +
> > +       Hz = *KHz * 1000;
> > +       opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> > +       if (IS_ERR(opp))
> > +               return -EINVAL;
> > +
> > +       mV = dev_pm_opp_get_voltage(opp) / 1000;
> > +       dev_pm_opp_put(opp);
> > +
> > +       MHz = Hz / 1000000;
> > +       tmp = (u64)cap * mV * mV * MHz;
> > +       do_div(tmp, 1000000000);
> 
> Could you explain the formula above ? and especially the 1000000000 it
> seems related to the use of mV and mW instead of uV and uW ...

That's correct, this is just a matter of units. I simply tried to
reproduce here what is currently done for IPA:

https://elixir.bootlin.com/linux/latest/source/drivers/thermal/cpu_cooling.c#L252

> 
> Can't you just optimize that into
> tmp = (u64)cap * mV * mV * Hz;
> do_div(tmp, 1000);

I don't think that'll work. If you use Hz instead of MHz you'll need to
divide tmp by 1000000000000000 to get milli-watts, as specified by the
EM framework.

FYI, I don't consider this patch to be ready to be merged. I kept it
self-contained and simple for the example but I actually think that this
of_est_power function should probably be factored-out somewhere else.
scpi-cpufreq could use it as well. Anyway, I guess we can discuss that
later once the APIs of the EM framework are agreed :-)

Thanks,
Quentin
