Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeDKL5U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:57:20 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:44377 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeDKL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:57:18 -0400
X-Google-Smtp-Source: AIpwx4+zoWw3tpbS96/4dCFWVz95+FZbq67dexBjawsQv7wvDYAZpjzQP/mxr1Rb4pD1obCJzmaOB0kj4JFPR3aKRdA=
MIME-Version: 1.0
In-Reply-To: <20180411101517.GL14248@e110439-lin>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin> <CAKfTPtAJQgA7w+2PRwhrY1xzsVH9CUt-wZurc+9qdmMLopYfUQ@mail.gmail.com>
 <20180411101517.GL14248@e110439-lin>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 11 Apr 2018 13:56:57 +0200
Message-ID: <CAKfTPtBKPx0o7AfEMsJv998aCggYQzsOnxmy-qu6B8UULCZabA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 April 2018 at 12:15, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> On 11-Apr 08:57, Vincent Guittot wrote:
>> On 10 April 2018 at 13:04, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>> > On 09-Apr 10:51, Vincent Guittot wrote:
>> >> On 6 April 2018 at 19:28, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>> >> Peter,
>> >> what was your goal with adding the condition "if
>> >> (rq->cfs.h_nr_running)" for the aggragation of CFS utilization
>> >
>> > The original intent was to get rid of sched class flags, used to track
>> > which class has tasks runnable from within schedutil. The reason was
>> > to solve some misalignment between scheduler class status and
>> > schedutil status.
>>
>> This was mainly for RT tasks but it was not the case for cfs task
>> before commit 8f111bc357aa
>
> True, but with his solution Peter has actually come up with a unified
> interface which is now (and can be IMO) based just on RUNNABLE
> counters for each class.

But do we really want to only take care of runnable counter for all class ?

>
>> > The solution, initially suggested by Viresh, and finally proposed by
>> > Peter was to exploit RQ knowledges directly from within schedutil.
>> >
>> > The problem is that now schedutil updated depends on two information:
>> > utilization changes and number of RT and CFS runnable tasks.
>> >
>> > Thus, using cfs_rq::h_nr_running is not the problem... it's actually
>> > part of a much more clean solution of the code we used to have.
>>
>> So there are 2 problems there:
>> - using cfs_rq::h_nr_running when aggregating cfs utilization which
>> generates a lot of frequency drop
>
> You mean because we now completely disregard the blocked utilization
> where a CPU is idle, right?

yes

>
> Given how PELT works and the recent support for IDLE CPUs updated, we
> should probably always add contributions for the CFS class.
>
>> - making sure that the nr-running are up-to-date when used in sched_util
>
> Right... but, if we always add the cfs_rq (to always account for
> blocked utilization), we don't have anymore this last dependency,
> isn't it?

yes

>
> We still have to account for the util_est dependency.
>
> Should I add a patch to this series to disregard cfs_rq::h_nr_running
> from schedutil as you suggested?

It's probably better to have a separate patch as these are 2 different topics
- when updating cfs_rq::h_nr_running and when calling cpufreq_update_util
- should we use runnable or running utilization for CFS

Vincent,

>
>> > The problem, IMO is that we now depend on other information which
>> > needs to be in sync before calling schedutil... and the patch I
>> > proposed is meant to make it less likely that all the information
>> > required are not aligned (also in the future).
>> >
>> > --
>> > #include <best/regards.h>
>> >
>> > Patrick Bellasi
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
