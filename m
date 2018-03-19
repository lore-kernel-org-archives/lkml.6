Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755500AbeCSL6E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:58:04 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:41204 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755418AbeCSL6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:58:02 -0400
X-Google-Smtp-Source: AG47ELuWaqZSbBbz+zQqe+CNY/1kffSYaL50oOuhnaP5BW2hqA59tOBt0DZFORxr4MCbCLkbB71diriP2EFs5ELlCng=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iE-LZ9TyahT7rsJW8zBnKfgnx6C-=SYJrpzspTQXV4zg@mail.gmail.com>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
 <2043615.lCdO10SMaB@aspire.rjw.lan> <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com>
 <20180319104900.GH4043@hirez.programming.kicks-ass.net> <CAJZ5v0iE-LZ9TyahT7rsJW8zBnKfgnx6C-=SYJrpzspTQXV4zg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Mar 2018 12:58:00 +0100
X-Google-Sender-Auth: g6Hj4WfBsjaYnMhuN88EKOKcHUQ
Message-ID: <CAJZ5v0hRK6+onUhnd8vL2PpTbU1KUAVtgqEia=wgwmTnTDSFQw@mail.gmail.com>
Subject: Re: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
To: Peter Zijlstra <peterz@infradead.org>
Cc: Doug Smythies <dsmythies@telus.net>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 12:36 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Mar 19, 2018 at 11:49 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Sun, Mar 18, 2018 at 05:15:22PM +0100, Rafael J. Wysocki wrote:
>>> On Sun, Mar 18, 2018 at 12:00 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> > @@ -354,6 +360,7 @@ static int menu_select(struct cpuidle_dr
>>> >         if (latency_req > interactivity_req)
>>> >                 latency_req = interactivity_req;
>>> >
>>> > +       expected_interval = TICK_USEC_HZ;
>>> >         /*
>>> >          * Find the idle state with the lowest power while satisfying
>>> >          * our constraints.
>>> > @@ -367,17 +374,44 @@ static int menu_select(struct cpuidle_dr
>>> >                         continue;
>>> >                 if (idx == -1)
>>> >                         idx = i; /* first enabled state */
>>> > -               if (s->target_residency > data->predicted_us)
>>> > +               if (s->target_residency > data->predicted_us) {
>>> > +                       /*
>>> > +                        * Retain the tick if the selected state is shallower
>>> > +                        * than the deepest available one with target residency
>>> > +                        * within the tick period range.
>>> > +                        *
>>> > +                        * This allows the tick to be stopped even if the
>>> > +                        * predicted idle duration is within the tick period
>>> > +                        * range to counter the effect by which the prediction
>>> > +                        * may be skewed towards lower values due to the tick
>>> > +                        * bias.
>>> > +                        */
>>> > +                       expected_interval = s->target_residency;
>>> >                         break;
>>>
>>> BTW, I guess I need to explain the motivation here more thoroughly, so
>>> here it goes.
>>>
>>> The governor predicts idle duration under the assumption that the
>>> tick will be stopped, so if the result of the prediction is within the tick
>>> period range and it is not accurate, that needs to be taken into
>>> account in the governor's statistics.  However, if the tick is allowed
>>> to run every time the governor predicts idle duration within the tick
>>> period range, the governor will always see that it was "almost
>>> right" and the correction factor applied by it to improve the
>>> prediction next time will not be sufficient.  For this reason, it
>>> is better to stop the tick at least sometimes when the governor
>>> predicts idle duration within the tick period range and the idea
>>> here is to do that when the selected state is the deepest available
>>> one with the target residency within the tick period range.  This
>>> allows the opportunity to save more energy to be seized which
>>> balances the extra overhead of stopping the tick.
>>
>> My brain is just not willing to understand how that work this morning.
>> Also it sounds really dodgy.
>
> Well, I guess I can't really explain it better. :-)
>
> The reason why this works better than the original v5 is because of
> how menu_update() works AFAICS.

Actually, it looks like menu_update() doesn't do the right thing when
the tick isn't stopped at all, because data->next_timer_us is useless
then.

Let me try to fix that in a new respin of the series.
