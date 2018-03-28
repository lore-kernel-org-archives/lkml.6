Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeC1INp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:13:45 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:43018 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeC1INj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:13:39 -0400
X-Google-Smtp-Source: AIpwx4/BQMyJX4wl0fYu/V1fNiVHCVU7WPpEQxDmyqi5HKGPqOTRepSlzESadPWBl2/w7nRDVCm2yjPrpV/fgUNZVyc=
MIME-Version: 1.0
In-Reply-To: <4198010.6ArFqS34NK@aspire.rjw.lan>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <2249320.0Z4q8AXauv@aspire.rjw.lan>
 <6462e44a-e207-6b97-22bf-ad4aed69afc2@tu-dresden.de> <4198010.6ArFqS34NK@aspire.rjw.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Mar 2018 10:13:38 +0200
X-Google-Sender-Auth: QDGS3QbEp3QGbLWdT72aLij4NRs
Message-ID: <CAJZ5v0j5mEaQSAiW4ynitM1ee=sqkpc8G_tZ40RYUgyavXXhqQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v7 6/8] sched: idle: Select idle state before
 stopping the tick
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
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

On Wed, Mar 28, 2018 at 12:10 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, March 27, 2018 11:50:02 PM CEST Thomas Ilsche wrote:
>> On 2018-03-20 16:45, Rafael J. Wysocki wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > In order to address the issue with short idle duration predictions
>> > by the idle governor after the tick has been stopped, reorder the
>> > code in cpuidle_idle_call() so that the governor idle state selection
>> > runs before tick_nohz_idle_go_idle() and use the "nohz" hint returned
>> > by cpuidle_select() to decide whether or not to stop the tick.
>> >
>> > This isn't straightforward, because menu_select() invokes
>> > tick_nohz_get_sleep_length() to get the time to the next timer
>> > event and the number returned by the latter comes from
>> > __tick_nohz_idle_enter().  Fortunately, however, it is possible
>> > to compute that number without actually stopping the tick and with
>> > the help of the existing code.
>>
>> I think something is wrong with the new tick_nohz_get_sleep_length.
>> It seems to return a value that is too large, ignoring immanent
>> non-sched timer.
>
> That's a very useful hint, let me have a look.
>
>> I tested idle-loop-v7.3. It looks very similar to my previous results
>> on the first idle-loop-git-version [1]. Idle and traditional synthetic
>> powernightmares are mostly good.
>
> OK
>
>> But it selects too deep C-states for short idle periods, which is bad
>> for power consumption [2].
>
> That still needs to be improved, then.
>
>> I tracked this down with additional tests using
>> __attribute__((optimize("O0"))) menu_select
>> and perf probe. With this the behavior seems slightly different, but it
>> shows that data->next_timer_us is:
>> v4.16-rc6: the expected ~500 us [3]
>> idle-loop-v7.3: many milliseconds to minutes [4].
>> This leads to the governor to wrongly selecting C6.
>>
>> Checking with 372be9e and 6ea0577, I can confirm that the change is
>> introduced by this patch.
>
> Yes, that's where the most intrusive reordering happens.

Overall, this is an interesting conundrum, because the case in
question is when the tick should never be stopped at all during the
workload and the code's behavior in that case should not change, so
the change was not intentional.

Now, from walking through the code, as long as can_stop_idle_tick()
returns 'true' all should be fine or at least I don't see why there is
any difference in behavior in that case.

However, if can_stop_idle_tick() returns 'false' (for example, because
need_resched() returns 'true' when it is evaluated), the behavior *is*
different in a couple of ways.  I sort of know how that can be
addressed, but I'd like to reproduce your results here.

Are you still using the same workload as before to trigger this behavior?
