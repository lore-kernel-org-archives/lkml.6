Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935025AbeCENA4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:00:56 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33582 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934109AbeCENAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:00:55 -0500
X-Google-Smtp-Source: AG47ELuXILRj43GmFW8pspG4GeFrA9x9JiNcKIIzY9hGX9GamtGAootXm3b5wLQlN3kJm5JFrcJaeVMywiT0FiUxrCc=
MIME-Version: 1.0
In-Reply-To: <20180305124217.GZ25181@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <2048240.1dZKXsSxFh@aspire.rjw.lan>
 <20180305114542.GP25201@hirez.programming.kicks-ass.net> <CAJZ5v0hmmVTSnC52EgXxbHh6akCDeBw64w30F8npdpvyabNucw@mail.gmail.com>
 <CAJZ5v0jxmVAvGuW=2uWuWHaUhdt1E6GXXy3DpkNOwhKWLfAqWA@mail.gmail.com> <20180305124217.GZ25181@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Mar 2018 14:00:53 +0100
X-Google-Sender-Auth: z_fsIFt5j652ljK_P-mRrujIXVA
Message-ID: <CAJZ5v0jdqcXSC+VGwWKjdM6_NkyNs2rcTydscj3ZqaUZCpTfDw@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
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

On Mon, Mar 5, 2018 at 1:42 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 05, 2018 at 01:07:07PM +0100, Rafael J. Wysocki wrote:
>> On Mon, Mar 5, 2018 at 12:50 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > On Mon, Mar 5, 2018 at 12:45 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> >> So I think this is entirely wrong, I would much rather see something
>> >> like:
>> >>
>> >>         tick_nohz_idle_go_idle(next_state->nohz);
>> >>
>> >> Where the selected state itself has the nohz property or not.
>> >
>> > Can you elaborate here, I'm not following?
>> >
>> >> We can always insert an extra state at whatever the right boundary point
>> >> is for nohz if it doesn't line up with an existing point.
>>
>> OK, I guess I know what you mean: to add a state flag meaning "stop
>> the tick if this state is selected".
>
> Yes, that.
>
>> That could work, but I see problems, like having to go through all of
>> the already defined states and deciding what to do with them.
>
> Shouldn't be too hard, upon registering a cpuidle driver to the cpuidle
> core, the core could go through the provided states and flag all those <
> TICK_USEC as not stopping, all those > TICK_USEC as stopping and
> splitting the state we'd select for TICK_NSEC sleeps, stopping it for <
> and disabling it for >.
>

Well, on Intel everything below C8 has target residencies below 1 ms. :-)

I think that we want C6 to be "nohz" too, though, at least in some cases.

And what about C3 if C6 is disabled?
