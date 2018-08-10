Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8129C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F147223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F147223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeHJLM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:12:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46274 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeHJLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:12:58 -0400
Received: from 79.184.254.16.ipv4.supernova.orange.pl (79.184.254.16) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id c22b0072e55ac5c6; Fri, 10 Aug 2018 10:44:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v5 03/14] PM: Introduce an Energy Model management framework
Date:   Fri, 10 Aug 2018 10:41:56 +0200
Message-ID: <2467271.WAtZ4Z8dKT@aspire.rjw.lan>
In-Reply-To: <20180810081537.w3utogy4ujxf2cp4@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com> <1598998.9rBByrtVSM@aspire.rjw.lan> <20180810081537.w3utogy4ujxf2cp4@queper01-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Friday, August 10, 2018 10:15:39 AM CEST Quentin Perret wrote:
> Hi Rafael,
> 
> On Thursday 09 Aug 2018 at 23:52:29 (+0200), Rafael J. Wysocki wrote:
> > I'm a bit concerned that the code here appears to be designed around the
> > frequency domains concept which seems to be a limitation and which probably
> > is related to the properties of the current generation of hardware.
> 
> That's correct. I went for 'frequency domains' only because this is what
> EAS and IPA are interested in, as of today at least. And both of them
> are somewhat dependent on CPU-Freq, which is called CPU-*Freq*, not
> CPU-Perf after all :-)

Still, cpufreq manages CPU performance scaling really.

A cpufreq policy may represent a frequency domain or generally a group of
related CPUs and what matters is that there is a coordination between them
and not how that coordination happens at the hardware/firmware level etc.

> > Assumptions like that tend to get tangled into the code tightly over time
> > and they may be hard to untangle from it when new use cases arise later.
> > 
> > For example, there probably will be more firmware involvement in future
> > systems and the firmware may not be willing to expose "raw" frequency
> > domains to the OS.  That already is the case with P-states on Intel HW and
> > with ACPI CPPC in general.
> 
> Agreed, and embedded/mobile systems are going in that direction too ...
> 
> > IMO, frequency domains in your current code could be replaced with something
> > more general, like "performance domains"
> 
> I don't mind using a more abstract name as long as we keep the same
> assumptions, and especially that all CPUs in a perf. domain *must* have
> the same micro-architecture.

That's fair enough I think.

> From that assumption result several
> properties that EAS (in its current) form needs. The first one is that
> all CPUs of a performance domain have the same capacity at any possible
> performance state. And the second is that they all consume the same
> amount of (active) power.
> 
> I know it is theoretically possible to mix CPU types in the same perf
> domain, but that becomes nightmare-ish to manage in EAS, and I don't
> think there is a single platform like this on the market today. And I
> hope nobody will build one. Peter wanted to mandate that too, I think.

There are departures, say, at least as far as the capacity is concerned.

The uarch is the same for all of them, but the max capacity may vary
between them.

> > providing the scheduler with the (relative) cost of running a task
> 
> What do you mean by relative ? That we should normalize the power costs ?
> Or just use an abstract scale, without specifying the unit ?

I mean "relative with respect to the other choices"; not absolute.

> The main reason I'm a bit reluctant to do that just now is because IPA
> needs to compare the power of CPUs with the power of other components
> (GPUs, for example). And the power of those other components is specified
> with a specific unit too. So, not imposing a comparable unit for the
> power of CPUs will result in an unspecified behaviour in IPA, and that
> will break things for sure. I would very much like to avoid that, of
> course.

The absolute power numbers are generally hard to get though.

In the majority of cases you can figure out what the extra cost of X with
respect to (alternative) Y is (in certain units), but you may not be able
to say what X and Y are equal to in absolute terms (for example, there
may be an unknown component in both X and Y that you cannot measure, but
it may not be relevant for the outcome of the computation).

> What I am currently proposing is to keep the unit (mW) in the EM
> framework so that migrating IPA to using it can be done in a (relatively)
> painless way. On a system where drivers  don't know the exact wattage,
> then they should just 'lie' to the EM framework, but it's their job to
> lie coherently to all subsystems and keep things consistent, because all
> subsystems have specified power in comparable units.

Alternatively, there could be a translation layer between EM and IPA.

From my experience, if you want people to come up with some numbers,
they will just choose them to game the system this way or another
unless those numbers can be measured directly or are clearly documented.

And if that happens and then you want to make any significant changes,
you'll need to deal with "regressions" occuring because someone chose
the numbers to make the system behave in a specific way and your changes
break that.

As a rule, I rather avoid requesting unknown numbers from people. :-)

> Another solution to solve this problem could be to extend the EM
> framework introduced by this patch and make it manage the EM of any
> device, not just CPUs. Then we could just specify that all power costs
> must be in the same scale, regardless of the actual unit, and register
> the EM of CPUs, GPUs, ...
> However, I was hoping that this patch as-is was enough for a first step,
> and that this extension of the framework could be done in a second step ?
> Thoughts ?
> 
> In any case, if we decide to keep the mW unit for now, I should at least
> explain clearly why in the commit message.

Right.

Actually, the unit is as good as any other, but you need to bear in mind that
the numbers provided may not be realistic.

> > on a busy (non-idle) CPU (and, analogously,
> > "idle domains" that would provide the scheduler with the - relative - cost
> > of waking up an idle CPU to run a task on it or, the other way around, the
> > possible relative gain from taking all tasks away from a CPU in order to make
> > it go idle).
> 
> +1 for idle costs as a second type of 'domains' which could be managed
> by the EM framework, alongside the 'perf' domains. I don't think we have
> users of that just now (or providers of idle costs ?) so maybe that is
> for later too ?

Yes, this is for later IMO.

Thanks,
Rafael

