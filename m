Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeBIL0Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:26:25 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51355 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:26:23 -0500
X-Google-Smtp-Source: AH8x226z/JZR1aSpp72gWYL9nkjxh+wfJ0PHyCRHwJEIbY3SJOFWp2DH9xU9yR9xJBZ0wgcV9VVPkw==
Date: Fri, 9 Feb 2018 12:26:18 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Message-ID: <20180209112618.GE12979@localhost.localdomain>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
 <20180209035143.GX28462@vireshk-i7>
 <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
 <11598161.veS9VGWB8G@aspire.rjw.lan>
 <20180209105305.GD12979@localhost.localdomain>
 <CAJZ5v0h9L2mMEaV6oECk9f2ob42Nr9zyqafymwvb+UP+G1q04Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h9L2mMEaV6oECk9f2ob42Nr9zyqafymwvb+UP+G1q04Q@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/18 12:04, Rafael J. Wysocki wrote:
> On Fri, Feb 9, 2018 at 11:53 AM, Juri Lelli <juri.lelli@redhat.com> wrote:
> > Hi,
> >
> > On 09/02/18 11:36, Rafael J. Wysocki wrote:
> >> On Friday, February 9, 2018 9:02:34 AM CET Claudio Scordino wrote:
> >> > Hi Viresh,
> >> >
> >> > Il 09/02/2018 04:51, Viresh Kumar ha scritto:
> >> > > On 08-02-18, 18:01, Claudio Scordino wrote:
> >> > >> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> >> > >> we should not wait for the rate limit, otherwise we may miss some deadline.
> >> > >>
> >> > >> Tests using rt-app on Exynos5422 have shown reductions of about 10% of deadline
> >> > >> misses for tasks with low RT periods.
> >> > >>
> >> > >> The patch applies on top of the one recently proposed by Peter to drop the
> >> > >> SCHED_CPUFREQ_* flags.
> >> > >>
> >>
> >> [cut]
> >>
> >> >
> >> > >
> >> > > Is it possible to (somehow) check here if the DL tasks will miss
> >> > > deadline if we continue to run at current frequency? And only ignore
> >> > > rate-limit if that is the case ?
> >
> > Isn't it always the case? Utilization associated to DL tasks is given by
> > what the user said it's needed to meet a task deadlines (admission
> > control). If that task wakes up and we realize that adding its
> > utilization contribution is going to require a frequency change, we
> > should _theoretically_ always do it, or it will be too late. Now, user
> > might have asked for a bit more than what strictly required (this is
> > usually the case to compensate for discrepancies between theory and real
> > world, e.g.  hw transition limits), but I don't think there is a way to
> > know "how much". :/
> 
> You are right.
> 
> I'm somewhat concerned about "fast switch" cases when the rate limit
> is used to reduce overhead.

Mmm, right. I'm thinking that in those cases we could leave rate limit
as is. The user should then be aware of it and consider it as proper
overhead when designing her/his system.

But then, isn't it the same for "non fast switch" platforms? I mean,
even in the latter case we can't go faster than hw limits.. mmm, maybe
the difference is that in the former case we could go as fast as theory
would expect.. but we shouldn't. :)
