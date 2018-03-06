Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeCFIqD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:46:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60084 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeCFIqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:46:02 -0500
Date: Tue, 6 Mar 2018 09:45:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH 4/7] cpuidle: menu: Split idle duration
 prediction from state selection
Message-ID: <20180306084536.GZ25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2332986.m9oRvTSu8E@aspire.rjw.lan>
 <20180305113803.GO25201@hirez.programming.kicks-ass.net>
 <CAJZ5v0gdsSXOLL=nJW801L0LzE0CeyPCCrgq4_0tyi40wNLa+w@mail.gmail.com>
 <20180305125012.GA25181@hirez.programming.kicks-ass.net>
 <CAJZ5v0g5x9EWh0MH7wUh4sem9aYB-JuWb_Pn96qNwj=XefOcHg@mail.gmail.com>
 <20180305135322.GV25201@hirez.programming.kicks-ass.net>
 <43825f88-762e-11e5-d70a-45152b95599d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43825f88-762e-11e5-d70a-45152b95599d@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 10:15:10AM +0800, Li, Aubrey wrote:
> On 2018/3/5 21:53, Peter Zijlstra wrote:
> > On Mon, Mar 05, 2018 at 02:05:10PM +0100, Rafael J. Wysocki wrote:
> >> On Mon, Mar 5, 2018 at 1:50 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> >>> On Mon, Mar 05, 2018 at 12:47:23PM +0100, Rafael J. Wysocki wrote:
> > 
> >>>> IOW, the target residency of the selected state doesn't tell you how
> >>>> much time you should expect to be idle in general.
> >>>
> >>> Right, but I think that measure isn't of primary relevance. What we want
> >>> to know is: 'should I stop the tick' and 'what C state do I go to'.
> 
> I understood the benefit of mapping duration to state number, is duration <->
> state number mapping a generic solution to all arches?

Yes, all platforms have a limited set of possible idle states.

> Back to the user's concern is, "I'm running a latency sensitive application, and
> I want idle switching ASAP". So I think the user may not care about what C state
> to go into, that is, even if a deeper state has chance to go, the user striving
> for a higher workload score may still not want it?

The user caring about performance very much cares about the actual idle
state too, exit latency for deeper states is horrific and will screw
them up just as much as the whole nohz timer reprogramming does.

We can basically view the whole nohz thing as an additional entry/exit
latency for the idle state, which is why I don't think its weird to
couple them.

> >> Maybe just return a "nohz" indicator from cpuidle_select() in addition
> >> to the state index and make the decision in the governor?
> > 
> > Much better option than returning a duration :-)
> >
> So what does "nohz = disable and state index = deepest" mean? This combination
> does not make sense for performance only purpose?

I tend to agree with you that the state space allowed by a separate
variable is larger than required, but it's significantly smaller than
preserving 'time' so I can live with it.
