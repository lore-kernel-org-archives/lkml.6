Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeERL3q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 07:29:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40816 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbeERL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 07:29:41 -0400
Date: Fri, 18 May 2018 13:29:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20180518112919.GI12217@hirez.programming.kicks-ass.net>
References: <20180516154733.GF12198@hirez.programming.kicks-ass.net>
 <20180516163105.GP28366@localhost.localdomain>
 <20180517105907.GC22493@localhost.localdomain>
 <20180517150418.GF22493@localhost.localdomain>
 <1526571692.11765.10.camel@linux.intel.com>
 <20180517161649.GX12217@hirez.programming.kicks-ass.net>
 <1526575358.11765.14.camel@linux.intel.com>
 <CAJZ5v0j82sm94iCpLOVMBwoSksKx1Y49RfJv=nhhJiKhenZykg@mail.gmail.com>
 <20180517182803.GY12217@hirez.programming.kicks-ass.net>
 <20180518105742.GN30654@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518105742.GN30654@e110439-lin>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:57:42AM +0100, Patrick Bellasi wrote:
> Thus, my simple (maybe dumb) questions are:
> - why can't we just fold turbo boost frequency into the existing concepts?
> - what are the limitations of such a "simple" approach?

Perhaps... but does this not further complicate the whole capacity vs
util thing we already have in say the misfit patches? And the
util_fits_capacity() thing from the EAS ones.

The thing is, we either need to dynamically scale the util or the
capacity or both. I think for Thermal there are patches out there that
drop the capacity.

But we'd then have to do the same for turbo/vector and all the other
stuff as well. Otherwise we risk things like running at low U with 0%
idle and not triggering the tipping point between eas and regular
balancing.

So either way around we need to know the 'true' max, either to fudge
util or to fudge capacity. And I'm not sure we can know in some of these
cases :/

And while Vincent's patches might have been inspired by another problem,
they do have the effect of always allowing util to go to 1, which is
nice for this.
