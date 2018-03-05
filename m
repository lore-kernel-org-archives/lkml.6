Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964850AbeCEM5G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:57:06 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34835 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934140AbeCEM47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:56:59 -0500
X-Google-Smtp-Source: AG47ELvJgQ0DRBN/3GyZR2Hoxi8DgYDnNgEB74WTXpVyyqbA73cuVIbsgONOM3H9r0uZtWPg57cnFu1NGVZfuyS6Mpw=
MIME-Version: 1.0
In-Reply-To: <20180305123552.GY25181@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <2048240.1dZKXsSxFh@aspire.rjw.lan>
 <20180305123552.GY25181@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Mar 2018 13:56:57 +0100
X-Google-Sender-Auth: Un8zncd6jbK-cKsmI15b0s-Bcuc
Message-ID: <CAJZ5v0gwXhV6Z6TmBdBGafsppDLrnrWNcZuSr5C93MG=Gw=9Eg@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 1:35 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Mar 04, 2018 at 11:28:56PM +0100, Rafael J. Wysocki wrote:
>> Index: linux-pm/kernel/sched/idle.c
>> ===================================================================
>> --- linux-pm.orig/kernel/sched/idle.c
>> +++ linux-pm/kernel/sched/idle.c
>> @@ -188,13 +188,14 @@ static void cpuidle_idle_call(void)
>>       } else {
>>               unsigned int duration_us;
>>
>> -             tick_nohz_idle_go_idle(true);
>> -             rcu_idle_enter();
>> -
>>               /*
>>                * Ask the cpuidle framework to choose a convenient idle state.
>>                */
>>               next_state = cpuidle_select(drv, dev, &duration_us);
>> +
>> +             tick_nohz_idle_go_idle(duration_us > USEC_PER_SEC / HZ);
>
> (FWIW we have TICK_USEC for this)
>
>> +             rcu_idle_enter();
>> +
>>               entered_state = call_cpuidle(drv, dev, next_state);
>>               /*
>>                * Give the governor an opportunity to reflect on the outcome
>
> Also, I think that at this point you've introduced a problem; by not
> disabling the tick unconditionally, we'll have extra wakeups due to the
> (now still running) tick, which will bias the estimation, as per
> reflect(), downwards.

Correct, but IMO that is better than what we have now.

Also that's in theory, but in practice it may not affect the
distribution of time between different idle states that much.

> We should effectively discard tick wakeups when we could have entered
> nohz but didn't, accumulating the idle period in reflect and only commit
> once we get a !tick wakeup.
>
> Of course, for that to work we need to somehow divine what woke us,
> which is going to be tricky.

So I will only worry about this when I see numbers that will convince
me to do so. :-)
