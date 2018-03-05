Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934496AbeCEMHL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:07:11 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45764 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932817AbeCEMHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:07:08 -0500
X-Google-Smtp-Source: AG47ELtjvvT/9OqpDzMWxrd/F0r9rsoTpU8KPZBuz2Tit7UiNb4iBJ/0Ktb7iifmGbeKH7NBRc5S9Zg/v9DvYFLGIJU=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hmmVTSnC52EgXxbHh6akCDeBw64w30F8npdpvyabNucw@mail.gmail.com>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <2048240.1dZKXsSxFh@aspire.rjw.lan>
 <20180305114542.GP25201@hirez.programming.kicks-ass.net> <CAJZ5v0hmmVTSnC52EgXxbHh6akCDeBw64w30F8npdpvyabNucw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Mar 2018 13:07:07 +0100
X-Google-Sender-Auth: F2iS5_97XUYr9q6Ej9LjLvFvWJ4
Message-ID: <CAJZ5v0jxmVAvGuW=2uWuWHaUhdt1E6GXXy3DpkNOwhKWLfAqWA@mail.gmail.com>
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

On Mon, Mar 5, 2018 at 12:50 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Mar 5, 2018 at 12:45 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Sun, Mar 04, 2018 at 11:28:56PM +0100, Rafael J. Wysocki wrote:
>>> Index: linux-pm/kernel/sched/idle.c
>>> ===================================================================
>>> --- linux-pm.orig/kernel/sched/idle.c
>>> +++ linux-pm/kernel/sched/idle.c
>>> @@ -188,13 +188,14 @@ static void cpuidle_idle_call(void)
>>>       } else {
>>>               unsigned int duration_us;
>>>
>>> -             tick_nohz_idle_go_idle(true);
>>> -             rcu_idle_enter();
>>> -
>>>               /*
>>>                * Ask the cpuidle framework to choose a convenient idle state.
>>>                */
>>>               next_state = cpuidle_select(drv, dev, &duration_us);
>>> +
>>> +             tick_nohz_idle_go_idle(duration_us > USEC_PER_SEC / HZ);
>>> +             rcu_idle_enter();
>>> +
>>>               entered_state = call_cpuidle(drv, dev, next_state);
>>>               /*
>>>                * Give the governor an opportunity to reflect on the outcome
>>
>> So I think this is entirely wrong, I would much rather see something
>> like:
>>
>>         tick_nohz_idle_go_idle(next_state->nohz);
>>
>> Where the selected state itself has the nohz property or not.
>
> Can you elaborate here, I'm not following?
>
>> We can always insert an extra state at whatever the right boundary point
>> is for nohz if it doesn't line up with an existing point.

OK, I guess I know what you mean: to add a state flag meaning "stop
the tick if this state is selected".

That could work, but I see problems, like having to go through all of
the already defined states and deciding what to do with them.
