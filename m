Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeC1KhK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:37:10 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33275 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeC1KhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:37:07 -0400
X-Google-Smtp-Source: AIpwx4+GPCB8BN0jltJQxCJ/M0BjtcPSzS6CmI5FzVkvGMhzGlo2ixKsLE6v0u2hLWG514q0N44XFNHPhTyuIu84JEc=
MIME-Version: 1.0
In-Reply-To: <b904266b-b5bb-587d-334a-844a70341f8d@tu-dresden.de>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <2249320.0Z4q8AXauv@aspire.rjw.lan>
 <6462e44a-e207-6b97-22bf-ad4aed69afc2@tu-dresden.de> <4198010.6ArFqS34NK@aspire.rjw.lan>
 <CAJZ5v0j5mEaQSAiW4ynitM1ee=sqkpc8G_tZ40RYUgyavXXhqQ@mail.gmail.com> <b904266b-b5bb-587d-334a-844a70341f8d@tu-dresden.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Mar 2018 12:37:06 +0200
X-Google-Sender-Auth: g481QCn5NOH5bhH2rO9MOS6FZYw
Message-ID: <CAJZ5v0iRjj5DEKU1m2_y96WRBNu6U1w=GSADRxWXfVDN9K+edQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v7 6/8] sched: idle: Select idle state before
 stopping the tick
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 10:38 AM, Thomas Ilsche
<thomas.ilsche@tu-dresden.de> wrote:
> On 2018-03-28 10:13, Rafael J. Wysocki wrote:
>>
>> On Wed, Mar 28, 2018 at 12:10 AM, Rafael J. Wysocki <rjw@rjwysocki.net>
>> wrote:
>>>
>>> On Tuesday, March 27, 2018 11:50:02 PM CEST Thomas Ilsche wrote:
>>>>
>>>> On 2018-03-20 16:45, Rafael J. Wysocki wrote:
>>>>>
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> In order to address the issue with short idle duration predictions
>>>>> by the idle governor after the tick has been stopped, reorder the
>>>>> code in cpuidle_idle_call() so that the governor idle state selection
>>>>> runs before tick_nohz_idle_go_idle() and use the "nohz" hint returned
>>>>> by cpuidle_select() to decide whether or not to stop the tick.
>>>>>
>>>>> This isn't straightforward, because menu_select() invokes
>>>>> tick_nohz_get_sleep_length() to get the time to the next timer
>>>>> event and the number returned by the latter comes from
>>>>> __tick_nohz_idle_enter().  Fortunately, however, it is possible
>>>>> to compute that number without actually stopping the tick and with
>>>>> the help of the existing code.
>>>>
>>>>
>>>> I think something is wrong with the new tick_nohz_get_sleep_length.
>>>> It seems to return a value that is too large, ignoring immanent
>>>> non-sched timer.
>>>
>>>
>>> That's a very useful hint, let me have a look.
>>>
>>>> I tested idle-loop-v7.3. It looks very similar to my previous results
>>>> on the first idle-loop-git-version [1]. Idle and traditional synthetic
>>>> powernightmares are mostly good.
>>>
>>>
>>> OK
>>>
>>>> But it selects too deep C-states for short idle periods, which is bad
>>>> for power consumption [2].
>>>
>>>
>>> That still needs to be improved, then.
>>>
>>>> I tracked this down with additional tests using
>>>> __attribute__((optimize("O0"))) menu_select
>>>> and perf probe. With this the behavior seems slightly different, but it
>>>> shows that data->next_timer_us is:
>>>> v4.16-rc6: the expected ~500 us [3]
>>>> idle-loop-v7.3: many milliseconds to minutes [4].
>>>> This leads to the governor to wrongly selecting C6.
>>>>
>>>> Checking with 372be9e and 6ea0577, I can confirm that the change is
>>>> introduced by this patch.
>>>
>>>
>>> Yes, that's where the most intrusive reordering happens.
>>
>>
>> Overall, this is an interesting conundrum, because the case in
>> question is when the tick should never be stopped at all during the
>> workload and the code's behavior in that case should not change, so
>> the change was not intentional.
>>
>> Now, from walking through the code, as long as can_stop_idle_tick()
>> returns 'true' all should be fine or at least I don't see why there is
>> any difference in behavior in that case.
>>
>> However, if can_stop_idle_tick() returns 'false' (for example, because
>> need_resched() returns 'true' when it is evaluated), the behavior *is*
>> different in a couple of ways.  I sort of know how that can be
>> addressed, but I'd like to reproduce your results here.
>>
>> Are you still using the same workload as before to trigger this behavior?
>>
>
> Yes, the exact code I use is as follows
>
> $ gcc poller.c -O3 -fopenmp -o poller_omp
> $ GOMP_CPU_AFFINITY=0-35 ./poller_omp 500
>
> #include <stdlib.h>
> #include <stdio.h>
> #include <unistd.h>
>
> int main(int argc, char *argv[])
> {
>     int sleep_us = 10000;
>     if (argc == 2) {
>         sleep_us = atoi(argv[1]);
>     }
>
>     #pragma omp parallel
>     {
>         while (1) {
>             usleep(sleep_us);
>         }
>     }
> }

So I do

$ for cpu in 0 1 2 3; do taskset -c $cpu sh -c 'while true; do usleep
500; done' & done

which is a shell kind of imitation of the above and I cannot see this
issue at all.

I count the number of times data->next_timer_us in menu_select() is
greater than TICK_USEC and while this "workload" is running, that
number is exactly 0.

I'll try with a C program still.
