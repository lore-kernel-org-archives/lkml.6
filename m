Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDEO3c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:29:32 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33205 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:29:30 -0400
X-Google-Smtp-Source: AIpwx4+Pbf+xat9TFpvgAicP/a1KE6RnIztVq6D3WDYmLnfXg38xydebxmUBvRA/D+FXDOOI0uteSuCVoTcxWHBxbos=
MIME-Version: 1.0
In-Reply-To: <20180405141326.GH4129@hirez.programming.kicks-ass.net>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <6542020.eHGLEK9V0J@aspire.rjw.lan>
 <20180405124757.GQ4082@hirez.programming.kicks-ass.net> <CAJZ5v0h2c5RtUxwF2z3Gjy8O2RSBaD7wN3CxUXrg57jH57_xoA@mail.gmail.com>
 <20180405141127.GS4043@hirez.programming.kicks-ass.net> <20180405141326.GH4129@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Apr 2018 16:29:29 +0200
X-Google-Sender-Auth: X1WqRCDqI88alxe5OqT0mqcVILw
Message-ID: <CAJZ5v0iJx7qfPTVMJbXJRSL-K9KstMPD2JYXjeQQn+vsQHe6HA@mail.gmail.com>
Subject: Re: [PATCH v9 10/10] cpuidle: menu: Avoid selecting shallow states
 with stopped tick
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 4:13 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Apr 05, 2018 at 04:11:27PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 05, 2018 at 03:49:32PM +0200, Rafael J. Wysocki wrote:
>> > On Thu, Apr 5, 2018 at 2:47 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > > On Wed, Apr 04, 2018 at 10:50:36AM +0200, Rafael J. Wysocki wrote:
>> > >> +     if (tick_nohz_tick_stopped()) {
>> > >> +             /*
>> > >> +              * If the tick is already stopped, the cost of possible short
>> > >> +              * idle duration misprediction is much higher, because the CPU
>> > >> +              * may be stuck in a shallow idle state for a long time as a
>> > >> +              * result of it.  In that case say we might mispredict and try
>> > >> +              * to force the CPU into a state for which we would have stopped
>> > >> +              * the tick, unless the tick timer is going to expire really
>> > >> +              * soon anyway.
>> > >
>> > > Wait what; the tick was stopped, therefore it _cannot_ expire soon.
>> > >
>> > > *confused*
>> > >
>> > > Did you mean s/tick/a/ ?
>> >
>> > Yeah, that should be "a timer".
>>
>> *phew* ok, that makes a lot more sense ;-)
>>
>> My only concern with this is that we can now be overly pessimistic. The
>> predictor might know that statistically it's very likely a device
>> interrupt will arrive soon, but because the tick is already disabled, we
>> don't dare trust it, causing possible excessive latencies.

That's possible, but then we already stopped the tick before and the
CPU was in a deep idle state (or we wouldn't have got here with the
tick stopped), so the extra bit of latency coming from this is not
likely to matter IMO.

And the code can stay simpler this way. :-)

>> Would an alternative be to make @stop_tick be an enum capable of forcing
>> the tick back on?
>>
>> enum tick_action {
>>       NOHZ_TICK_STOP,
>>       NOHZ_TICK_RETAIN,
>>       NOHZ_TICK_START,
>> };
>>
>>       enum tick_action tick_action = NOHZ_TICK_STOP;
>>
>>       state = cpuidle_select(..., &tick_action);
>>
>>       switch (tick_action) {
>>       case NOHZ_TICK_STOP:
>>               tick_nohz_stop_tick();
>>               break;
>>
>>       case NOHZ_TICK_RETAIN:
>>               tick_nozh_retain_tick();
>>               break;
>>
>>       case NOHZ_TICK_START:
>>               tick_nohz_start_tick();
>>               break;
>>       };
>>
>>
>> Or something along those lines?
>
> To clarify, RETAIN keeps the status quo, if its off, it stays off, if
> its on it stays on.

That could be done, but I'm not sure if the menu governor has a good
way to decide whether to use NOHZ_TICK_RETAIN or NOHZ_TICK_START.

Doing NOHZ_TICK_START every time the predicted idle duration is within
the tick range may be wasteful.

Besides, enum tick_action and so on can be introduced later if really
needed, but for now it looks like the simpler code gets the job done.
