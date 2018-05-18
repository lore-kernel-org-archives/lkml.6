Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeERK5u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:57:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbeERK5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:57:47 -0400
Date: Fri, 18 May 2018 11:57:42 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Message-ID: <20180518105742.GN30654@e110439-lin>
References: <20180516151925.GO28366@localhost.localdomain>
 <20180516154733.GF12198@hirez.programming.kicks-ass.net>
 <20180516163105.GP28366@localhost.localdomain>
 <20180517105907.GC22493@localhost.localdomain>
 <20180517150418.GF22493@localhost.localdomain>
 <1526571692.11765.10.camel@linux.intel.com>
 <20180517161649.GX12217@hirez.programming.kicks-ass.net>
 <1526575358.11765.14.camel@linux.intel.com>
 <CAJZ5v0j82sm94iCpLOVMBwoSksKx1Y49RfJv=nhhJiKhenZykg@mail.gmail.com>
 <20180517182803.GY12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517182803.GY12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-May 20:28, Peter Zijlstra wrote:
> On Thu, May 17, 2018 at 06:56:37PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 17, 2018 at 6:42 PM, Srinivas Pandruvada
> 
> > > What will happen if we look at all core turbo as max and cap any
> > > utilization above this to 1024?
> > 
> > I was going to suggest that.
> 
> To the basic premise behind all our frequency scaling is that there's a
> linear relation between utilization and frequency, where u=1 gets us the
> fastest.
> 
> Now, we all know this is fairly crude, but it is what we work with.
> 
> OTOH, the whole premise of turbo is that you don't in fact know what the
> fastest is, and in that respect setting u=1 at the guaranteed or
> sustainable frequency makes sense.

Looking from the FAIR class standpoint, we can also argue that
although you know that the max possible utilization is 1024, you are
not always granted to reach it because of RT and Interrupts pressure.
Or in big.LITTLE systems, because of the arch scaling factor.

Is it not something quite similar to the problem of having
   "some not always available OPPs"
?

To track these "capacity limitations" we already have the two
different concepts of cpu_capacity_orig and cpu_capacity.

Are not "thermal constraints" and "some not always available OPPs"
just another form of "capacity limitations".
They are:
 - transient
   exactly like RT and Interrupt pressure
 - HW related
   which is the main different wrt RT and Interrupt pressure

But, apart from this last point (i.e.they have an HW related "nature"),
IMHO they seems quite similar concept... which are already addresses,
although only within the FAIR class perhaps.

Thus, my simple (maybe dumb) questions are:
- why can't we just fold turbo boost frequency into the existing concepts?
- what are the limitations of such a "simple" approach?

IOW: utilization always measures wrt the maximum possible capacity
(i.e. max turbo mode) and then there is a way to know what is, on each
CPU and at every decision time, the actual "transient maximum" we can
expect to reach for a "reasonable" future time.

> The direct concequence of allowing clipping is that u=1 doesn't select
> the highest frequency, but since we don't select anything anyway
> (p-code does that for us) all we really need is to have u=1 above that
> turbo activation point you mentioned.

If clipping means that we can also have >1024 values which are just
clamped at read/get time, this could maybe have some side-effects on
math (signals propagations across TG) and type ranges control?

> For parts where we have to directly select frequency this obviously
> comes apart.

Moreover, utilization is not (will not be) just for frequency driving.
We should keep the task placement perspective into account.

On that side, I personally like the definition _I think_ we have now:

  utilization is the amount of maximum capacity used

where maximum is a constant defined at boot time and representing the
absolute max you can expect to get...
... apart from "transient capacity limitations".

Scaling the maximum depending on these transient conditions to me it
reads like "changing the scale". Which I fear will make it more
difficult for example to compare in space (different CPUs) or time
(different scheduler events) what a utilization measure means.

For example, if you have a busy loop running on a CPU which is subject
to RT pressure, you will read a <100% utilization (let say 60%). Still
it's interesting to know that maybe I can try to move that task on an
IDLE CPU to run it faster.

Should not be the same for turbo boost?

If the same task is generating only 60% utilization, because of not
available turbo boost OPPs,  should still not be useful to see that
there is for example another CPU (maybe on a different NUMA node)
which is IDLE and cold, where we can move the task there to exploit
the 100% capacity provided by the topmost turbo boost mode?

> However; what happens when the sustainable freq drops below our initial
> 'max'? Imagine us dropping below the all-core-turbo because of AVX. Then
> we're back to running at u<1 at full tilt.
> 
> Or for mobile parts, the sustainable frequency could drop because of
> severe thermal limits. Now I _think_ we have the possibility for getting
> interrupts and reading the new guaranteed frequency, so we could
> re-guage.
> 
> So in theory I think it works, in practise we need to always be able to
> find the actual max -- be it all-core turbo, AVX or thermal constrained
> frequency. Can we do that in all cases?
> 
> 
> I need to go back to see what the complains against Vincent's proposal
> were, because I really liked the fact that it did away with all this.

AFAIR Vincent proposal was mainly addressing a different issue: fast
ramp-up... I don't recall if there was any specific intent to cover
the issue of "transient maximum capacities".

And still, based on my (maybe bogus) reasoning above, I think we are
discussing here a slightly different problem which has already a
(maybe partial) solution.

-- 
#include <best/regards.h>

Patrick Bellasi
