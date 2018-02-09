Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbeBIKxQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:53:16 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52430 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeBIKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:53:14 -0500
X-Google-Smtp-Source: AH8x225AaBQcRFIGDnIp7Dy2Pl9AMfBwVVPh3HRc+X9/mIE3THS4qbTomBFEVrcwTYLmimVJp3VhOQ==
Date: Fri, 9 Feb 2018 11:53:05 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Message-ID: <20180209105305.GD12979@localhost.localdomain>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
 <20180209035143.GX28462@vireshk-i7>
 <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
 <11598161.veS9VGWB8G@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11598161.veS9VGWB8G@aspire.rjw.lan>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/02/18 11:36, Rafael J. Wysocki wrote:
> On Friday, February 9, 2018 9:02:34 AM CET Claudio Scordino wrote:
> > Hi Viresh,
> > 
> > Il 09/02/2018 04:51, Viresh Kumar ha scritto:
> > > On 08-02-18, 18:01, Claudio Scordino wrote:
> > >> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> > >> we should not wait for the rate limit, otherwise we may miss some deadline.
> > >>
> > >> Tests using rt-app on Exynos5422 have shown reductions of about 10% of deadline
> > >> misses for tasks with low RT periods.
> > >>
> > >> The patch applies on top of the one recently proposed by Peter to drop the
> > >> SCHED_CPUFREQ_* flags.
> > >>
> 
> [cut]
> 
> > 
> > > 
> > > Is it possible to (somehow) check here if the DL tasks will miss
> > > deadline if we continue to run at current frequency? And only ignore
> > > rate-limit if that is the case ?

Isn't it always the case? Utilization associated to DL tasks is given by
what the user said it's needed to meet a task deadlines (admission
control). If that task wakes up and we realize that adding its
utilization contribution is going to require a frequency change, we
should _theoretically_ always do it, or it will be too late. Now, user
might have asked for a bit more than what strictly required (this is
usually the case to compensate for discrepancies between theory and real
world, e.g.  hw transition limits), but I don't think there is a way to
know "how much". :/

Thanks,

- Juri

> > 
> > I need to think further about it.
> 
> That would be my approach FWIW.
> 
> Increasing the frequency beyond what is necessary means wasting energy
> in any case.
> 
> Thanks,
> Rafael
> 
