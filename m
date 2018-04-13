Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeDMUMy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 16:12:54 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33701 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeDMUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 16:12:52 -0400
X-Google-Smtp-Source: AIpwx4/mud3i4pjjy0glbr+8ZXMTPRRW0tdIW82pT8pQVjhxNFL9TXXVyvoNGShGgwLqvPEY5doIjFJPkn3mF+2l35k=
MIME-Version: 1.0
In-Reply-To: <20180406125825.GT4589@e105550-lin.cambridge.arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
 <20180329125324.GR4589@e105550-lin.cambridge.arm.com> <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com> <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
 <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com> <CAKfTPtCQayuu5-84931ZxzXV1-roV_CfRd_5wXG1oxOEUZmZgw@mail.gmail.com>
 <20180405154630.GS4589@e105550-lin.cambridge.arm.com> <CAKfTPtBv7BzAqZWTxU9HaCoNjQa2B8usk6dfO1qgofjGYG7S=w@mail.gmail.com>
 <20180406125825.GT4589@e105550-lin.cambridge.arm.com>
From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Date: Fri, 13 Apr 2018 13:12:50 -0700
Message-ID: <CAEi0qNntckRk7dRvb2cutyx6WinbwP7_OznLM82ZzPtxoPfhFQ@mail.gmail.com>
Subject: Re: [PATCH] sched: support dynamiQ cluster
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 5:58 AM, Morten Rasmussen
<morten.rasmussen@arm.com> wrote:
> On Thu, Apr 05, 2018 at 06:22:48PM +0200, Vincent Guittot wrote:
>> Hi Morten,
>>
>> On 5 April 2018 at 17:46, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>> > On Wed, Apr 04, 2018 at 03:43:17PM +0200, Vincent Guittot wrote:
>> >> On 4 April 2018 at 12:44, Valentin Schneider <valentin.schneider@arm.com> wrote:
>> >> > Hi,
>> >> >
>> >> > On 03/04/18 13:17, Vincent Guittot wrote:
>> >> >> Hi Valentin,
>> >> >>
>> >> > [...]
>> >> >>>
>> >> >>> I believe ASYM_PACKING behaves better here because the workload is only
>> >> >>> sysbench threads. As stated above, since task utilization is disregarded, I
>> >> >>
>> >> >> It behaves better because it doesn't wait for the task's utilization
>> >> >> to reach a level before assuming the task needs high compute capacity.
>> >> >> The utilization gives an idea of the running time of the task not the
>> >> >> performance level that is needed
>> >> >>
>> >> >
>> >> > [
>> >> > That's my point actually. ASYM_PACKING disregards utilization and moves those
>> >> > threads to the big cores ASAP, which is good here because it's just sysbench
>> >> > threads.
>> >> >
>> >> > What I meant was that if the task composition changes, IOW we mix "small"
>> >> > tasks (e.g. periodic stuff) and "big" tasks (performance-sensitive stuff like
>> >> > sysbench threads), we shouldn't assume all of those require to run on a big
>> >> > CPU. The thing is, ASYM_PACKING can't make the difference between those, so
>> > [Morten]
>> >>
>> >> That's the 1st point where I tend to disagree: why big cores are only
>> >> for long running task and periodic stuff can't need to run on big
>> >> cores to get max compute capacity ?
>> >> You make the assumption that only long running tasks need high compute
>> >> capacity. This patch wants to always provide max compute capacity to
>> >> the system and not only long running task
>> >
>> > There is no way we can tell if a periodic or short-running tasks
>> > requires the compute capacity of a big core or not based on utilization
>> > alone. The utilization can only tell us if a task could potentially use
>> > more compute capacity, i.e. the utilization approaches the compute
>> > capacity of its current cpu.
>> >
>> > How we handle low utilization tasks comes down to how we define
>> > "performance" and if we care about the cost of "performance" (e.g.
>> > energy consumption).
>> >
>> > Placing a low utilization task on a little cpu should always be fine
>> > from _throughput_ point of view. As long as the cpu has spare cycles it
>>
>> [Vincent]
>> I disagree, throughput is not only a matter of spare cycle it's also a
>> matter of how fast you compute the work like with IO activity as an
>> example
>
> [Morten]
> From a cpu centric point of view it is, but I agree that from a
> application/user point of view completion time might impact throughput
> too. For example of if your throughput depends on how fast you can
> offload work to some peripheral device (GPU for example).
>
> However, as I said in the beginning we don't know what the task does.

[Joel]
Just wanted to say about Vincent point of IO loads throughput -
remembering from when I was playing with the iowait boost stuff, that
- say you have a little task that does some IO and blocks and does so
periodically. In the scenario the task will run for little time and is
a little task by way of looking at utilization. However, if we were to
run it on the BIG CPUs, the overall throughput of the I/O activity
would be higher.

For this case, it seems its impossible to specify the "default"
behavior correctly. Like, do we care about performance or energy more?
This seems more like a policy-decision from userspace and not
something the scheduler should necessarily have to decide. Like if I/O
activity is background and not affecting the user experience.

thanks,

- Joel
