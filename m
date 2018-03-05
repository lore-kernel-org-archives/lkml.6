Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934691AbeCEMm3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:42:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933014AbeCEMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:42:28 -0500
Date: Mon, 5 Mar 2018 13:42:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
Message-ID: <20180305124217.GZ25181@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2048240.1dZKXsSxFh@aspire.rjw.lan>
 <20180305114542.GP25201@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmmVTSnC52EgXxbHh6akCDeBw64w30F8npdpvyabNucw@mail.gmail.com>
 <CAJZ5v0jxmVAvGuW=2uWuWHaUhdt1E6GXXy3DpkNOwhKWLfAqWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jxmVAvGuW=2uWuWHaUhdt1E6GXXy3DpkNOwhKWLfAqWA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 01:07:07PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 5, 2018 at 12:50 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Mar 5, 2018 at 12:45 PM, Peter Zijlstra <peterz@infradead.org> wrote:

> >> So I think this is entirely wrong, I would much rather see something
> >> like:
> >>
> >>         tick_nohz_idle_go_idle(next_state->nohz);
> >>
> >> Where the selected state itself has the nohz property or not.
> >
> > Can you elaborate here, I'm not following?
> >
> >> We can always insert an extra state at whatever the right boundary point
> >> is for nohz if it doesn't line up with an existing point.
> 
> OK, I guess I know what you mean: to add a state flag meaning "stop
> the tick if this state is selected".

Yes, that.

> That could work, but I see problems, like having to go through all of
> the already defined states and deciding what to do with them.

Shouldn't be too hard, upon registering a cpuidle driver to the cpuidle
core, the core could go through the provided states and flag all those <
TICK_USEC as not stopping, all those > TICK_USEC as stopping and
splitting the state we'd select for TICK_NSEC sleeps, stopping it for <
and disabling it for >.
