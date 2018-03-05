Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935096AbeCENFO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:05:14 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:37884 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934878AbeCENFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:05:11 -0500
X-Google-Smtp-Source: AG47ELurrS0woJP7LOOR/T5HqtX40ZPQ5QsBeveMu0MUr5Ht4cPVEBxr5NWLieL7aa7PYSoYss/wgI0xRdx9qt//wTE=
MIME-Version: 1.0
In-Reply-To: <20180305125012.GA25181@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <2332986.m9oRvTSu8E@aspire.rjw.lan>
 <20180305113803.GO25201@hirez.programming.kicks-ass.net> <CAJZ5v0gdsSXOLL=nJW801L0LzE0CeyPCCrgq4_0tyi40wNLa+w@mail.gmail.com>
 <20180305125012.GA25181@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Mar 2018 14:05:10 +0100
X-Google-Sender-Auth: WFgGv8gl7PiPMocRj7--VG5rGS8
Message-ID: <CAJZ5v0g5x9EWh0MH7wUh4sem9aYB-JuWb_Pn96qNwj=XefOcHg@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH 4/7] cpuidle: menu: Split idle duration
 prediction from state selection
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Mon, Mar 5, 2018 at 1:50 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 05, 2018 at 12:47:23PM +0100, Rafael J. Wysocki wrote:
>> On Mon, Mar 5, 2018 at 12:38 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > We really should be predicting state not duration. Yes the duration
>> > thing is an intermediate value, but I don't think it makes any sense
>> > what so ever to preserve that in the predictor. The end result is the
>> > idle state, we should aim for that.
>> >
>> > As per:
>> >
>> >   https://lkml.org/lkml/2017/7/18/615
>> >
>> > there are definite advantages to _not_ preserving duration information
>> > beyond the state boundaries.
>>
>> Well, OK
>>
>> The reason why I need the predicted idle duration is because the
>> target residency of the selected state may be below the tick period
>> duration and if this is the deepest state available, we still want to
>> stop the tick if the predicted idle duration is long.
>
> Right, so in that case we'd split the deepest state and mark the
> resulting smaller state as not disabling the tick and the resulting
> larger state as disabling the tick.
>
> So suppose your deepest state is < TICK_USEC, then we introduce a copy
> of that state, modify the boundary to be TICK_USEC and set the 'disable
> tick for this state' thing to true.
>
>> IOW, the target residency of the selected state doesn't tell you how
>> much time you should expect to be idle in general.
>
> Right, but I think that measure isn't of primary relevance. What we want
> to know is: 'should I stop the tick' and 'what C state do I go to'.
>
> In order to answer those questions we need durations as input, but I
> don't think we should preserve durations throughout. The scheme from the
> above link reduces to N states in order to deal with arbitrary
> distributions, only the actual states -- ie boundaries where our answers
> changes -- are relevant, anything inside those boundaries would lead to
> the exact same answer anyway.

I generally agree here, but I'm not convinced about flagging the
states, splitting them and so on.

Maybe just return a "nohz" indicator from cpuidle_select() in addition
to the state index and make the decision in the governor?
