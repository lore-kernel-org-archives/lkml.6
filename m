Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934820AbeCELrZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:47:25 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:46265 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933057AbeCELrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:47:24 -0500
X-Google-Smtp-Source: AG47ELva/RMnms8CK5N0YZJOBGClnRAmbIImL4vO0xfCk4buocfAGB1UClnbAB7W9XDm6alHw/sXwWB1h1IzowZikj0=
MIME-Version: 1.0
In-Reply-To: <20180305113803.GO25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <2332986.m9oRvTSu8E@aspire.rjw.lan>
 <20180305113803.GO25201@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Mar 2018 12:47:23 +0100
X-Google-Sender-Auth: 0dX11J-HNFjBdxrvhw5AXO7EphA
Message-ID: <CAJZ5v0gdsSXOLL=nJW801L0LzE0CeyPCCrgq4_0tyi40wNLa+w@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH 4/7] cpuidle: menu: Split idle duration
 prediction from state selection
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

On Mon, Mar 5, 2018 at 12:38 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Mar 04, 2018 at 11:26:24PM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> In order to address the issue with short idle duration predictions
>> by the idle governor after the tick has been stopped, prepare the
>> menu governor code for reordering with respect to the timekeeping
>> code that stops the tick.
>>
>> Use the observation that menu_select() can be split into two
>> functions, one predicting the idle duration and one selecting the
>> idle state, and rework it accordingly.
>
> I actually think this is the wrong way around.

In the meantime I concluded that this patch and the next one are
overdesign really.  I have a replacement for the two already. :-)

The only thing I need is the expected idle duration that can be
returned from ->select too.

> We really should be predicting state not duration. Yes the duration
> thing is an intermediate value, but I don't think it makes any sense
> what so ever to preserve that in the predictor. The end result is the
> idle state, we should aim for that.
>
> As per:
>
>   https://lkml.org/lkml/2017/7/18/615
>
> there are definite advantages to _not_ preserving duration information
> beyond the state boundaries.

Well, OK

The reason why I need the predicted idle duration is because the
target residency of the selected state may be below the tick period
duration and if this is the deepest state available, we still want to
stop the tick if the predicted idle duration is long.

IOW, the target residency of the selected state doesn't tell you how
much time you should expect to be idle in general.
