Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeDLHCK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:02:10 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:39245 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbeDLHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:02:08 -0400
X-Google-Smtp-Source: AIpwx495oQs8gcKBY6GBZSx5HWFbffXC1mXBZenZOZgezcE7WiZ4Y4rvZNDQLyMJXM8SYWtSnBNFkda4S6+5C1zsh7w=
MIME-Version: 1.0
In-Reply-To: <CAJWu+orqbT0n+dHabinf=kWN8Frh+3VH6cpc6ADit_BDhFFhTQ@mail.gmail.com>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin> <CAKfTPtAJQgA7w+2PRwhrY1xzsVH9CUt-wZurc+9qdmMLopYfUQ@mail.gmail.com>
 <20180411101517.GL14248@e110439-lin> <CAKfTPtBKPx0o7AfEMsJv998aCggYQzsOnxmy-qu6B8UULCZabA@mail.gmail.com>
 <CAJWu+orqbT0n+dHabinf=kWN8Frh+3VH6cpc6ADit_BDhFFhTQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Apr 2018 09:01:47 +0200
Message-ID: <CAKfTPtAkcATqmahtuc046GC6sw1084PFokx+Nb8Z3ucBPPCeFQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 11 April 2018 at 23:34, Joel Fernandes <joelaf@google.com> wrote:
> Hi Vincent,
>
> On Wed, Apr 11, 2018 at 4:56 AM, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>> On 11 April 2018 at 12:15, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>>> On 11-Apr 08:57, Vincent Guittot wrote:
>>>> On 10 April 2018 at 13:04, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>>>> > On 09-Apr 10:51, Vincent Guittot wrote:
>>>> >> On 6 April 2018 at 19:28, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>>>> >> Peter,
>>>> >> what was your goal with adding the condition "if
>>>> >> (rq->cfs.h_nr_running)" for the aggragation of CFS utilization
>>>> >
>>>> > The original intent was to get rid of sched class flags, used to track
>>>> > which class has tasks runnable from within schedutil. The reason was
>>>> > to solve some misalignment between scheduler class status and
>>>> > schedutil status.
>>>>
>>>> This was mainly for RT tasks but it was not the case for cfs task
>>>> before commit 8f111bc357aa
>>>
>>> True, but with his solution Peter has actually come up with a unified
>>> interface which is now (and can be IMO) based just on RUNNABLE
>>> counters for each class.
>>
>> But do we really want to only take care of runnable counter for all class ?
>>
>>>
>>>> > The solution, initially suggested by Viresh, and finally proposed by
>>>> > Peter was to exploit RQ knowledges directly from within schedutil.
>>>> >
>>>> > The problem is that now schedutil updated depends on two information:
>>>> > utilization changes and number of RT and CFS runnable tasks.
>>>> >
>>>> > Thus, using cfs_rq::h_nr_running is not the problem... it's actually
>>>> > part of a much more clean solution of the code we used to have.
>>>>
>>>> So there are 2 problems there:
>>>> - using cfs_rq::h_nr_running when aggregating cfs utilization which
>>>> generates a lot of frequency drop
>>>
>>> You mean because we now completely disregard the blocked utilization
>>> where a CPU is idle, right?
>>
>> yes
>>
>>>
>>> Given how PELT works and the recent support for IDLE CPUs updated, we
>>> should probably always add contributions for the CFS class.
>>>
>>>> - making sure that the nr-running are up-to-date when used in sched_util
>>>
>>> Right... but, if we always add the cfs_rq (to always account for
>>> blocked utilization), we don't have anymore this last dependency,
>>> isn't it?
>>
>> yes
>>
>>>
>>> We still have to account for the util_est dependency.
>>>
>>> Should I add a patch to this series to disregard cfs_rq::h_nr_running
>>> from schedutil as you suggested?
>>
>> It's probably better to have a separate patch as these are 2 different topics
>> - when updating cfs_rq::h_nr_running and when calling cpufreq_update_util
>> - should we use runnable or running utilization for CFS
>
> By runnable you don't mean sched_avg::load_avg right? I got a bit
> confused, since runnable means load_avg and running means util_avg.

Sorry for the confusion. By runnable utilization, I meant taking into
account the number of running task (cfs_rq::h_nr_running) like what is
done by commit (8f111bc357a)


> But I didn't follow here why we are talking about load_avg for
> schedutil at all. I am guessing by "runnable" you mean h_nr_running !=
> 0.

yes

>
> Also that aside, the "running util" is what was used to drive the CFS
> util before Peter's patch (8f111bc357a). That was accounting the
> blocked and decaying utilization but that patch changed the behavior.
> It seems logical we should just use that not check for h_nr_running
> for CFS so we don't miss on the decayed  utilization. What is the use
> of checking h_nr_running or state of runqueue for CFS? I am sure to be
> missing something here. :-(

As Peter mentioned, the change in commit (8f111bc357a) was to remove
the test that was arbitrary removing the util_avg of a cpu that has
not been updated since a tick

But with the update of blocked idle load, we don't need to handle the
case of stalled load/utilization

>
> thanks!
>
> - Joel
