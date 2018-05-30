Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbeE3Q5u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:57:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59640 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753474AbeE3Q5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:57:40 -0400
Date: Wed, 30 May 2018 17:57:34 +0100
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
Message-ID: <20180530165734.GL30654@e110439-lin>
References: <20180517105907.GC22493@localhost.localdomain>
 <20180517150418.GF22493@localhost.localdomain>
 <1526571692.11765.10.camel@linux.intel.com>
 <20180517161649.GX12217@hirez.programming.kicks-ass.net>
 <1526575358.11765.14.camel@linux.intel.com>
 <CAJZ5v0j82sm94iCpLOVMBwoSksKx1Y49RfJv=nhhJiKhenZykg@mail.gmail.com>
 <20180517182803.GY12217@hirez.programming.kicks-ass.net>
 <20180518105742.GN30654@e110439-lin>
 <20180518112919.GI12217@hirez.programming.kicks-ass.net>
 <20180518133353.GO30654@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518133353.GO30654@e110439-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
maybe you missed this previous my response:
   20180518133353.GO30654@e110439-lin
?

Would like to have your tought about the concept of "transient maximum
capacity" I was describing...

On 18-May 14:33, Patrick Bellasi wrote:
> On 18-May 13:29, Peter Zijlstra wrote:
> > On Fri, May 18, 2018 at 11:57:42AM +0100, Patrick Bellasi wrote:
> > > Thus, my simple (maybe dumb) questions are:
> > > - why can't we just fold turbo boost frequency into the existing concepts?
> > > - what are the limitations of such a "simple" approach?
> > 
> > Perhaps... but does this not further complicate the whole capacity vs
> > util thing we already have in say the misfit patches?
> 
> Not sure about that...
> 
> > And the  util_fits_capacity() thing from the EAS ones.
> 
> In this case instead, if we can track somehow (not saying we can)
> what is the currently available "transient maximum capacity"...
> then a util_fits_capacity() should just look at that.
> 
> If the transient capacity is already folded into cpu_capacity, as it
> is now for RT and IRQ pressure, then likely we don't have to change
> anything.
> 
> > The thing is, we either need to dynamically scale the util or the
> > capacity or both. I think for Thermal there are patches out there that
> > drop the capacity.
> 
> Not sure... but I would feel more comfortable by something which caps
> the maximum capacity. Meaning, eventually you can fill up the maximum
> possible capacity only "up to" a given value, because of thermal or other
> reasons most of the scheduler maybe doesn't even have to know why?
> 
> > But we'd then have to do the same for turbo/vector and all the other
> > stuff as well. Otherwise we risk things like running at low U with 0%
> > idle and not triggering the tipping point between eas and regular
> > balancing.
> 
> Interacting with the tipping point and/or OPP changes is indeed an
> interesting side of the problem I was not considering so far...
> 
> But again, the tipping point could not be defined as a delta
> with respect to the "transient maximum capacity" ?
> 
> > So either way around we need to know the 'true' max, either to fudge
> > util or to fudge capacity.
> 
> Right, but what I see from a concepts standpoint is something like:
> 
>      +--+--+   cpu_capacity_orig (CONSTANT at boot time)
>      |  |  |
>      |  |  |       HW generated constraints
>      |  v  |
>      +-----+   cpu_capacity_max (depending on thermal/turbo boost)
>      |  |  |
>      |  |  |       SW generated constraints
>      |  v  |
>      +-----+   cpu_capacity (depending on RT/IRQ pressure)
>      |  |  |
>      |  |  |       tipping point delta
>      +--v--+
>      |     |   Energy Aware mode available capacity
>      +-----+
> 
> Where all the wkp/lb heuristics are updated to properly consider the
> cpu_capacity_max metrics whenever it comes to know what is the max
> speed we can reach now on a CPU.
> 
> > And I'm not sure we can know in some of these cases :/
> 
> Right, this schema will eventually work only under the hypothesis that
> "somehow" we can update cpu_capacity_max from HW events.
> 
> Not entirely sure that's possible and/or at which time granularity on
> all different platforms.
> 
> > And while Vincent's patches might have been inspired by another problem,
> > they do have the effect of always allowing util to go to 1, which is
> > nice for this.
> 
> Sure, that's a nice point, but still I have the feeling that always
> reaching u=1 can defeat other interesting properties of a task,
> For example, comparing task requirements in different CPUs and/or at
> different times, which plays a big role for energy aware task
> placement decisions.
> 
> -- 
> #include <best/regards.h>
> 
> Patrick Bellasi

-- 
#include <best/regards.h>

Patrick Bellasi
