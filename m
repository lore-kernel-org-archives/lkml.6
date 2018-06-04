Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeFDMgT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:36:19 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44627 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeFDMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:36:17 -0400
X-Google-Smtp-Source: ADUXVKKQJg8swfgb0GWtKuhFZYIkNuzzB1PhN7e3cKmDb3vVQDuY+iO3eCWioIDPV1tBTPHqFDAD1WNeVYUvnBKC5u0=
MIME-Version: 1.0
In-Reply-To: <20180604101247.GB2731@localhost.localdomain>
References: <CAKfTPtDCkzPMt6XrXRcURXm=53LABiwbFd3JMQkJDWpTprycRQ@mail.gmail.com>
 <20180528152243.GD1293@localhost.localdomain> <CAKfTPtAY26HZ00R02RuW2kvZLvZxHGvh-kbfrqv-hPumdknvWg@mail.gmail.com>
 <20180531102735.GM30654@e110439-lin> <CAKfTPtCeoimTehLktVk4WiTEM5h9KW_4yvuxGof8p6ZOgsRE2Q@mail.gmail.com>
 <20180601135307.GA28550@linaro.org> <20180601174526.GA105687@joelaf.mtv.corp.google.com>
 <CAKfTPtBu5D=P3ib6fqfVLz9yQXN19ipRQAz5L6s1+ewnVTrHmg@mail.gmail.com>
 <20180604070438.GA2731@localhost.localdomain> <CAKfTPtD9KQTeeP0BNyhnqh=UXL0T_jK0PcvWWBjoyj0VC8TkRg@mail.gmail.com>
 <20180604101247.GB2731@localhost.localdomain>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Jun 2018 14:35:56 +0200
Message-ID: <CAKfTPtCLgeuw5VpM3myv9vy+oerOQZexWCOHjr+cFaufyRiqvg@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 June 2018 at 12:12, Juri Lelli <juri.lelli@redhat.com> wrote:
> On 04/06/18 09:14, Vincent Guittot wrote:
>> On 4 June 2018 at 09:04, Juri Lelli <juri.lelli@redhat.com> wrote:
>> > Hi Vincent,
>> >
>> > On 04/06/18 08:41, Vincent Guittot wrote:
>> >> On 1 June 2018 at 19:45, Joel Fernandes <joelaf@google.com> wrote:
>> >> > On Fri, Jun 01, 2018 at 03:53:07PM +0200, Vincent Guittot wrote:
>> >
>> > [...]
>> >
>> >> > IMO I feel its overkill to account dl_avg when we already have DL's running
>> >> > bandwidth we can use. I understand it may be too instanenous, but perhaps we
>> >>
>> >> We keep using dl bandwidth which is quite correct for dl needs but
>> >> doesn't reflect how it has disturbed other classes
>> >>
>> >> > can fix CFS's problems within CFS itself and not have to do this kind of
>> >> > extra external accounting ?
>> >
>> > I would also keep accounting for waiting time due to higher prio classes
>> > all inside CFS. My impression, when discussing it with you on IRC, was
>> > that we should be able to do that by not decaying cfs.util_avg when CFS
>> > is preempted (creating a new signal for it). Is not this enough?
>>
>> We don't just want to not decay a signal but increase the signal to
>> reflect the amount of preemption
>
> OK.
>
>> Then, we can't do that in a current signal. So you would like to add
>> another metrics in cfs_rq ?
>
> Since it's CFS related, I'd say it should fit in CFS.

It's dl and cfs as the goal is to track cfs preempted by dl
This means creating a new struct whereas some fields are unused in avg_dl struct
And duplicate some call to ___update_load_sum as we track avg_dl for
removing sched_rt_avg_update
and update_dl/rt_rq_load_avg are already call in fair.c for updating
blocked load

>
>> The place doesn't really matter to be honest in cfs_rq or in dl_rq but
>> you will not prevent to add call in dl class to start/stop the
>> accounting of the preemption
>>
>> >
>> > I feel we should try to keep cross-class accounting/interaction at a
>> > minimum.
>>
>> accounting for cross class preemption can't be done without
>> cross-class accounting
>
> Mmm, can't we distinguish in, say, pick_next_task_fair() if prev was of
> higher prio class and act accordingly?

we will not be able to make the difference between rt/dl/stop
preemption by using only pick_next_task_fair

Thanks

>
> Thanks,
>
> - Juri
