Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCOQu5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:50:57 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36532 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCOQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:50:55 -0400
X-Google-Smtp-Source: AG47ELtr6lJFlypNCV2Uo5VCJ+Kfi4pEKUwbvY6ptP7XmXMDZIQ1VahoTmzYDInFycvwbogcszWQpYx+vSvEjkeCoG4=
MIME-Version: 1.0
In-Reply-To: <20180315161031.GA12313@lerouge>
References: <2352117.3UUoYAu18A@aspire.rjw.lan> <2177770.i4UbKDJpnI@aspire.rjw.lan>
 <20180315161031.GA12313@lerouge>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Mar 2018 17:50:52 +0100
X-Google-Sender-Auth: P7pd9pAgQDRYIELNBevNSV2nCSc
Message-ID: <CAJZ5v0iVsby7J2dEApmFa0PfzRL+NV7iPoUcuiEudoJ-RRpk+w@mail.gmail.com>
Subject: Re: [RFT][PATCH v4 2/7] sched: idle: Do not stop the tick upfront in
 the idle loop
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 5:10 PM, Frederic Weisbecker
<frederic@kernel.org> wrote:
> On Mon, Mar 12, 2018 at 10:51:11AM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Push the decision whether or not to stop the tick somewhat deeper
>> into the idle loop.
>>
>> Stopping the tick upfront leads to unpleasant outcomes in case the
>> idle governor doesn't agree with the timekeeping code on the duration
>> of the upcoming idle period.
>
> Looks like you meant "nohz" instead of "timekeeping"?

Yes, I did.

>> Specifically, if the tick has been
>> stopped and the idle governor predicts short idle, the situation is
>> bad regardless of whether or not the prediction is accurate.  If it
>> is accurate, the tick has been stopped unnecessarily which means
>> excessive overhead.  If it is not accurate, the CPU is likely to
>> spend too much time in the (shallow, because short idle has been
>> predicted) idle state selected by the governor [1].
>>
>> As the first step towards addressing this problem, change the code
>> to make the tick stopping decision inside of the loop in do_idle().
>> In particular, do not stop the tick in the cpu_idle_poll() code path.
>> Also don't do that in tick_nohz_irq_exit() which doesn't really have
>> enough information on whether or not to stop the tick.
>>
>> Link: https://marc.info/?l=linux-pm&m=150116085925208&w=2 # [1]
>> Link: https://tu-dresden.de/zih/forschung/ressourcen/dateien/projekte/haec/powernightmares.pdf
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  kernel/sched/idle.c      |    8 +++++---
>>  kernel/time/tick-sched.c |    6 ++----
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> Index: linux-pm/kernel/sched/idle.c
>> ===================================================================
>> --- linux-pm.orig/kernel/sched/idle.c
>> +++ linux-pm/kernel/sched/idle.c
>> @@ -241,10 +241,12 @@ static void do_idle(void)
>>                * broadcast device expired for us, we don't want to go deep
>>                * idle as we know that the IPI is going to arrive right away.
>>                */
>> -             if (cpu_idle_force_poll || tick_check_broadcast_expired())
>> +             if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
>>                       cpu_idle_poll();
>> -             else
>> +             } else {
>> +                     tick_nohz_idle_stop_tick();
>>                       cpuidle_idle_call();
>> +             }
>
> I'm worried about one thing here. Say we enter cpuidle_idle_call() and the tick is stopped.
> Later on, we get a tick, so we exit cpuidle_idle_call(), then we find cpu_idle_force_poll
> or tick_check_broadcast_expired() to be true. So we poll but the tick hasn't been updated
> to fire again.
>
> I don't know if it can happen but cpu_idle_poll_ctrl() seem to be callable anytime.
> It looks like it's only used on __init code or on power suspend/resume, not sure about
> the implications on the latter, still there could be further misuse in the future.
>
> Concerning tick_check_broadcast_expired(), it's hard to tell if it can be enabled
> concurrently from another CPU or from interrupts.
>
> Anyway perhaps we should have, out of paranoia:
>
> +               if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
> +                       tick_nohz_idle_restart_tick();
>                         cpu_idle_poll();
> -               else
>

Agreed, I'll update the patch accordingly.

Thanks!
