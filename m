Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBILEt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:04:49 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:38102 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeBILEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:47 -0500
X-Google-Smtp-Source: AH8x225N6zMz1j1M6miT5bhwkYteuMp2e7H6tdfVtApuCGC2+2fHtnniBntQphG1U5H1N0vfl8Z0P65axbAsK7sLceE=
MIME-Version: 1.0
In-Reply-To: <20180209105305.GD12979@localhost.localdomain>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
 <20180209035143.GX28462@vireshk-i7> <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
 <11598161.veS9VGWB8G@aspire.rjw.lan> <20180209105305.GD12979@localhost.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Feb 2018 12:04:46 +0100
X-Google-Sender-Auth: msgNT1OTMZLj8JZJIzhZsod0Jes
Message-ID: <CAJZ5v0h9L2mMEaV6oECk9f2ob42Nr9zyqafymwvb+UP+G1q04Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
To: Juri Lelli <juri.lelli@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 11:53 AM, Juri Lelli <juri.lelli@redhat.com> wrote:
> Hi,
>
> On 09/02/18 11:36, Rafael J. Wysocki wrote:
>> On Friday, February 9, 2018 9:02:34 AM CET Claudio Scordino wrote:
>> > Hi Viresh,
>> >
>> > Il 09/02/2018 04:51, Viresh Kumar ha scritto:
>> > > On 08-02-18, 18:01, Claudio Scordino wrote:
>> > >> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
>> > >> we should not wait for the rate limit, otherwise we may miss some deadline.
>> > >>
>> > >> Tests using rt-app on Exynos5422 have shown reductions of about 10% of deadline
>> > >> misses for tasks with low RT periods.
>> > >>
>> > >> The patch applies on top of the one recently proposed by Peter to drop the
>> > >> SCHED_CPUFREQ_* flags.
>> > >>
>>
>> [cut]
>>
>> >
>> > >
>> > > Is it possible to (somehow) check here if the DL tasks will miss
>> > > deadline if we continue to run at current frequency? And only ignore
>> > > rate-limit if that is the case ?
>
> Isn't it always the case? Utilization associated to DL tasks is given by
> what the user said it's needed to meet a task deadlines (admission
> control). If that task wakes up and we realize that adding its
> utilization contribution is going to require a frequency change, we
> should _theoretically_ always do it, or it will be too late. Now, user
> might have asked for a bit more than what strictly required (this is
> usually the case to compensate for discrepancies between theory and real
> world, e.g.  hw transition limits), but I don't think there is a way to
> know "how much". :/

You are right.

I'm somewhat concerned about "fast switch" cases when the rate limit
is used to reduce overhead.
