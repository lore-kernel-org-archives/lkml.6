Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227A3ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C028720853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C028720853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeINRpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:45:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60746 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbeINRpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:45:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D30C18A;
        Fri, 14 Sep 2018 05:30:52 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1B303F703;
        Fri, 14 Sep 2018 05:30:48 -0700 (PDT)
Date:   Fri, 14 Sep 2018 13:30:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
Message-ID: <20180914123037.GA22926@e107981-ln.cambridge.arm.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
 <20180809153925.GA20329@red-moon>
 <5398488.CyAMIAYSYI@aspire.rjw.lan>
 <20180914104431.GA20567@e107981-ln.cambridge.arm.com>
 <CAJZ5v0j27p9XHsLsJ+Eg9PGh1bbF5CRNFOrVW8qvNx1Am6W-2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j27p9XHsLsJ+Eg9PGh1bbF5CRNFOrVW8qvNx1Am6W-2A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 01:34:14PM +0200, Rafael J. Wysocki wrote:

[...]

> > > So for example, if your logical CPU has an idle state A that may trigger an
> > > idle state X at the cluster level (if the other logical CPUs happen to be in
> > > the right states and so on), then the worst-case exit latency for that
> > > is the one of state X.
> >
> > I will provide an example:
> >
> > IDLE STATE A (affects CPU {0,1}): exit latency 1ms, min-residency 1.5ms
> >
> > CPU 0 is about to enter IDLE state A since its "next-event" fulfill the
> > residency requirements and exit latency constraints.
> >
> > CPU 1 is in idle state A (given that CPU 0 is ON, some of the common
> > logic shared between CPU {0,1} is still ON, but, as soon as CPU 0
> > enters idle state A CPU {0,1} can enter the "full" idle state A
> > power savings mode).
> >
> > The current CPUidle governor does not check the "next-event" for CPU 1,
> > that it may wake up in, say, 10us.
> 
> Right.
> 
> > Requesting IDLE STATE A is a waste of power (if firmware or hardware
> > does not demote it since it does peek at CPU 1 next-event and actually
> > demote CPU 0 request).
> 
> OK, I see.
> 
> That's because the state is "collaborative" so to speak.  But was't
> that supposed to be covered by the "coupled" thing?

The coupled idle states code was merged because on some early SMP
ARM platforms CPUs must enter cluster idle states orderly otherwise
the system would break; "coupled" as-in "syncronized idle state entry".

Basically coupled idle code fixed a HW bug. This series code instead
applies to all arches where an idle state may span multiple CPUs (x86
inclusive, but as I mentioned it is probably not needed since FW/HW
behind mwait is capable of detecting whether that's wortwhile to shut
down, say, a package. PSCI, whether OSI or PC mode can work the same way).

Entering an idle state spanning multiple cpus need not be synchronized
but a sort of cpumask aware governor may help optimize idle state
selection.

I hope this makes the whole point clearer.

Cheers,
Lorenzo
