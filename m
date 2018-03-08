Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935700AbeCHQeX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:34:23 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34794 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbeCHQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:34:21 -0500
X-Google-Smtp-Source: AG47ELuwMtYH39H9ZyW+zWz0KOO/aH+ZmpWQ3+UfIXE94Ug1q5nO22/nUm3oqJE8eIgYFuq947GrgE0oFBN5RQhD70w=
MIME-Version: 1.0
In-Reply-To: <20180308151407.GA11118@lerouge>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan> <4136227.b9g9WnMbNJ@aspire.rjw.lan>
 <20180307231827.GA9367@lerouge> <1938066.lrFpnYERYl@aspire.rjw.lan> <20180308151407.GA11118@lerouge>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Mar 2018 17:34:20 +0100
X-Google-Sender-Auth: ShXg5IOG3qpBLXntr82LfmiGVgM
Message-ID: <CAJZ5v0gGzBY2YGLeY-jqRghoDJ_Ao+HxhZkttC-_hS6atrwC1Q@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v2 1/6] time: tick-sched: Reorganize idle tick
 management code
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
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

On Thu, Mar 8, 2018 at 4:14 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> On Thu, Mar 08, 2018 at 10:22:26AM +0100, Rafael J. Wysocki wrote:
>> On Thursday, March 8, 2018 12:18:29 AM CET Frederic Weisbecker wrote:
>> > On Tue, Mar 06, 2018 at 10:02:01AM +0100, Rafael J. Wysocki wrote:
>> > > Index: linux-pm/kernel/time/tick-sched.c
>> > > ===================================================================
>> > > --- linux-pm.orig/kernel/time/tick-sched.c
>> > > +++ linux-pm/kernel/time/tick-sched.c
>> > > +
>> > > +/**
>> > > + * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
>> > > + *
>> > > + * Called when we start the idle loop.
>> > > + */
>> > > +void tick_nohz_idle_prepare(void)
>> > > +{
>> > > + struct tick_sched *ts;
>> > > +
>> > > + __tick_nohz_idle_prepare();
>> > > +
>> > > + local_irq_disable();
>> > > +
>> > > + ts = this_cpu_ptr(&tick_cpu_sched);
>> > > + ts->inidle = 1;
>> > > +
>> > > + local_irq_enable();
>> > > +}
>> >
>> > Why not calling tick_nohz_start_idle() from there? This is going to
>> > simplify the rest, you won't need to call tick_nohz_idle_go_idle()
>> > from places that don't want to stop the tick and you can then remove
>> > the stop_tick argument.
>>
>> So I guess I would then use ts->idle_entrytime as "now" in the
>> tick_nohz_get_sleep_length() computation, right?
>
> Ah right, I missed the need for ktime_get().
>
> You can't use ts->idle_entrytime in tick_nohz_get_sleep_length() because
> full dynticks doesn't rely on it.
>
> But I think you can just do the following, with a comment explaining that
> idle_entrytime is expected to be fresh enough at this point:
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 57b3de4..8e61796 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -923,7 +923,7 @@ static void __tick_nohz_idle_enter(struct tick_sched *ts, bool stop_tick)
>
>                 ts->idle_calls++;
>
> -               expires = tick_nohz_stop_sched_tick(ts, now, cpu);
> +               expires = tick_nohz_stop_sched_tick(ts, ts->idle_entrytime, cpu);
>                 if (expires > 0LL) {
>                         ts->idle_sleeps++;
>                         ts->idle_expires = expires;
>

That's what I was thinking about, but ktime_get() seems to be working too.
