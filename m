Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeEOGVw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:21:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50743 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeEOGVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:21:49 -0400
X-Google-Smtp-Source: AB8JxZquP4WzKujPoCMw6U8ic2SRfrLHFFFZl38p3CY2T2qIJvxApHa2n9aeWKygWmZyIRuZYdIy32DaGkEebwNNE3E=
MIME-Version: 1.0
In-Reply-To: <20180514164812.GI30654@e110439-lin>
References: <20180511131509.16275-1-patrick.bellasi@arm.com>
 <20180511131509.16275-2-patrick.bellasi@arm.com> <CAKfTPtD3GJH3LLp6tpYoz7Uf0eXb-ZLMbGdQdRUsAgczZMr47g@mail.gmail.com>
 <20180514164812.GI30654@e110439-lin>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 15 May 2018 08:21:28 +0200
Message-ID: <CAKfTPtBmhgNRmyAs-0UZQwgb8-We08uvgHfPMv+Rv4ipRqNWDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/cpufreq: always consider blocked FAIR utilization
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2018 at 18:48, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> On 14-May 11:16, Vincent Guittot wrote:
>> Hi Patrick,
>
> Hi Vincent,
>
>> On 11 May 2018 at 15:15, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>> > Since the refactoring introduced by:
>> >
>> >    commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
>> >
>> > we aggregate FAIR utilization only if this class has runnable tasks.
>> > This was mainly due to avoid the risk to stay on an high frequency just
>> > because of the blocked utilization of a CPU not being properly decayed
>> > while the CPU was idle.
>> >
>> > However, since:
>> >
>> >    commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle")
>> >
>> > the FAIR blocked utilization is properly decayed also for IDLE CPUs.
>> >
>> > This allows us to use the FAIR blocked utilization as a safe mechanism
>> > to gracefully reduce the frequency only if no FAIR tasks show up on a
>> > CPU for a reasonable period of time.
>> >
>> > Moreover, we also reduce the frequency drops of CPUs running periodic
>> > tasks which, depending on the task periodicity and the time required
>> > for a frequency switch, was increasing the chances to introduce some
>> > undesirable performance variations.
>> >
>> > Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
>> > Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
>> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > Cc: Ingo Molnar <mingo@redhat.com>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> > Cc: Joel Fernandes <joelaf@google.com>
>> > Cc: linux-kernel@vger.kernel.org
>> > Cc: linux-pm@vger.kernel.org
>>
>> With this patch, I can't see the spurious OPP changes that I was seeing before
>
> Cool thanks... regarding OPP updates I've added some more comments in
> my reply to Joel's comments to my last patch of this series.
>
> Would be nice if you can have a look... toward the end there are some
> considerations about schedutil updates (indirectly) triggered by your
> patches for blocked load updates on IDLE CPUs.

I have started to have a look at the 3rd patch and was checking if
there were some hole and your proposal regarding the update of blocked
load and the removed utilization
I will read your latest comment.

>
>> FWIW
>> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Thanks for testing, will add these to the next respin.
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
