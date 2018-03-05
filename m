Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933876AbeCENhl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:37:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbeCENhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:37:38 -0500
Date: Mon, 5 Mar 2018 14:37:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
Message-ID: <20180305133725.GU25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2048240.1dZKXsSxFh@aspire.rjw.lan>
 <20180305123552.GY25181@hirez.programming.kicks-ass.net>
 <1520255955.6857.18.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520255955.6857.18.camel@surriel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 08:19:15AM -0500, Rik van Riel wrote:
> > Also, I think that at this point you've introduced a problem; by not
> > disabling the tick unconditionally, we'll have extra wakeups due to
> > the (now still running) tick, which will bias the estimation, as per
> > reflect(), downwards.
> > 
> > We should effectively discard tick wakeups when we could have
> > entered nohz but didn't, accumulating the idle period in reflect and
> > only commit once we get a !tick wakeup.
> 
> How much of a problem would that actually be?
> 
> Don't all but the very deepest C-states have
> target residencies that are orders of magnitude
> smaller than the tick period?
> 
> In other words, if our sleeps end up getting
> "cut short" to 600us, we will still select C6,
> and it will not result in picking C3 by mistake.
> 
> This only seems to affect C7 states and deeper.

On modern Intel, what about other platforms? This is something that
should work across the board.

> It may be worth fixing in the long run, but that
> would require keeping track of whether anything
> non-idle was done in-between two invocations of
> do_idle(), and then checking that there.
> 
> That would include not just seeing whether there
> have been any context switches on the CPU (easy?),
> but also whether any non-timer interrupts were run.

Right, its the interrupts that are 'interesting' although I suppose we
could magic something in irq_enter().
