Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934784AbeCELib (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:38:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51032 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbeCELiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:38:25 -0500
Date: Mon, 5 Mar 2018 12:38:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH 4/7] cpuidle: menu: Split idle duration
 prediction from state selection
Message-ID: <20180305113803.GO25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2332986.m9oRvTSu8E@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2332986.m9oRvTSu8E@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 11:26:24PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to address the issue with short idle duration predictions
> by the idle governor after the tick has been stopped, prepare the
> menu governor code for reordering with respect to the timekeeping
> code that stops the tick.
> 
> Use the observation that menu_select() can be split into two
> functions, one predicting the idle duration and one selecting the
> idle state, and rework it accordingly.

I actually think this is the wrong way around.

We really should be predicting state not duration. Yes the duration
thing is an intermediate value, but I don't think it makes any sense
what so ever to preserve that in the predictor. The end result is the
idle state, we should aim for that.

As per:

  https://lkml.org/lkml/2017/7/18/615

there are definite advantages to _not_ preserving duration information
beyond the state boundaries.
