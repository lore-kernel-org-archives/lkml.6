Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeEQS2i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:28:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41964 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:28:36 -0400
Date: Thu, 17 May 2018 20:28:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
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
Message-ID: <20180517182803.GY12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
 <20180516151925.GO28366@localhost.localdomain>
 <20180516154733.GF12198@hirez.programming.kicks-ass.net>
 <20180516163105.GP28366@localhost.localdomain>
 <20180517105907.GC22493@localhost.localdomain>
 <20180517150418.GF22493@localhost.localdomain>
 <1526571692.11765.10.camel@linux.intel.com>
 <20180517161649.GX12217@hirez.programming.kicks-ass.net>
 <1526575358.11765.14.camel@linux.intel.com>
 <CAJZ5v0j82sm94iCpLOVMBwoSksKx1Y49RfJv=nhhJiKhenZykg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j82sm94iCpLOVMBwoSksKx1Y49RfJv=nhhJiKhenZykg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 06:56:37PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 17, 2018 at 6:42 PM, Srinivas Pandruvada

> > What will happen if we look at all core turbo as max and cap any
> > utilization above this to 1024?
> 
> I was going to suggest that.

To the basic premise behind all our frequency scaling is that there's a
linear relation between utilization and frequency, where u=1 gets us the
fastest.

Now, we all know this is fairly crude, but it is what we work with.

OTOH, the whole premise of turbo is that you don't in fact know what the
fastest is, and in that respect setting u=1 at the guaranteed or
sustainable frequency makes sense.

The direct concequence of allowing clipping is that u=1 doesn't select
the highest frequency, but since we don't select anything anyway
(p-code does that for us) all we really need is to have u=1 above that
turbo activation point you mentioned.

For parts where we have to directly select frequency this obviously
comes apart.

However; what happens when the sustainable freq drops below our initial
'max'? Imagine us dropping below the all-core-turbo because of AVX. Then
we're back to running at u<1 at full tilt.

Or for mobile parts, the sustainable frequency could drop because of
severe thermal limits. Now I _think_ we have the possibility for getting
interrupts and reading the new guaranteed frequency, so we could
re-guage.

So in theory I think it works, in practise we need to always be able to
find the actual max -- be it all-core turbo, AVX or thermal constrained
frequency. Can we do that in all cases?


I need to go back to see what the complains against Vincent's proposal
were, because I really liked the fact that it did away with all this.
