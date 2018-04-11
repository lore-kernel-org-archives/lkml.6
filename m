Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeDKPlr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:41:47 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:56135 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbeDKPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:41:46 -0400
X-Google-Smtp-Source: AIpwx48BIoN/z7Nr8MdlK/Oc9tDWyh6JMqbvWqoim3TtXsHyua2Mznxjo5Ow3T3h2ikpiIZ8peX2C+fOc2X6Dj56xUY=
MIME-Version: 1.0
In-Reply-To: <20180411153710.GN4082@hirez.programming.kicks-ass.net>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin> <20180411151450.GK4043@hirez.programming.kicks-ass.net>
 <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com> <20180411153710.GN4082@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 11 Apr 2018 17:41:24 +0200
Message-ID: <CAKfTPtCNdxSmDfDO0Etf7fbYPeryrjdQChSGwMWxSRH8CcXqqg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
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

On 11 April 2018 at 17:37, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 11, 2018 at 05:29:01PM +0200, Vincent Guittot wrote:
>> On 11 April 2018 at 17:14, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Tue, Apr 10, 2018 at 12:04:12PM +0100, Patrick Bellasi wrote:
>> >> On 09-Apr 10:51, Vincent Guittot wrote:
>> >
>> >> > Peter,
>> >> > what was your goal with adding the condition "if
>> >> > (rq->cfs.h_nr_running)" for the aggragation of CFS utilization
>> >>
>> >> The original intent was to get rid of sched class flags, used to track
>> >> which class has tasks runnable from within schedutil. The reason was
>> >> to solve some misalignment between scheduler class status and
>> >> schedutil status.
>> >>
>> >> The solution, initially suggested by Viresh, and finally proposed by
>> >> Peter was to exploit RQ knowledges directly from within schedutil.
>> >>
>> >> The problem is that now schedutil updated depends on two information:
>> >> utilization changes and number of RT and CFS runnable tasks.
>> >>
>> >> Thus, using cfs_rq::h_nr_running is not the problem... it's actually
>> >> part of a much more clean solution of the code we used to have.
>> >>
>> >> The problem, IMO is that we now depend on other information which
>> >> needs to be in sync before calling schedutil... and the patch I
>> >> proposed is meant to make it less likely that all the information
>> >> required are not aligned (also in the future).
>> >
>> > Specifically, the h_nr_running test was get rid of
>> >
>> >                 if (delta_ns > TICK_NSEC) {
>> >                         j_sg_cpu->iowait_boost = 0;
>> >                         j_sg_cpu->iowait_boost_pending = false;
>> > -                       j_sg_cpu->util_cfs = 0;
>> >
>> >                         ^^^^^^^^^^^^^^^^^^^^^^^ that..
>> >
>> > -                       if (j_sg_cpu->util_dl == 0)
>> > -                               continue;
>> >                 }
>> >
>> >
>> > because that felt rather arbitrary.
>>
>> yes I agree.
>>
>> With the patch that updates blocked idle load, we should not have the
>> problem of blocked utilization anymore and get rid of the code above
>> and h_nr_running test
>
> Yes, these patches predate those, but indeed, now that we age the
> blocked load consistently it should no longer be required.
>
> Of course, you still have that weird regression report against those
> patches... :-)

Yes. and to be honest I don't have any clues of the root cause :-(
Heiner mentioned that it's much better in latest linux-next but I
haven't seen any changes related to the code of those patches
