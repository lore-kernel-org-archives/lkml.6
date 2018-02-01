Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeBAJLQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:11:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52120 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeBAJLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:11:14 -0500
Date: Thu, 1 Feb 2018 10:11:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180201091104.GW2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <4353713.vEOq6OHvJN@aspire.rjw.lan>
 <20180131101710.GM2269@hirez.programming.kicks-ass.net>
 <3838689.GpfBVtfPr0@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3838689.GpfBVtfPr0@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 08:50:28AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, January 31, 2018 11:17:10 AM CET Peter Zijlstra wrote:
> > On Wed, Jan 31, 2018 at 10:22:49AM +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, January 30, 2018 2:15:31 PM CET Peter Zijlstra wrote:
> > 
> > > > IA32_HWP_REQUEST has "Minimum_Performance", "Maximum_Performance" and
> > > > "Desired_Performance" fields which can be used to give explicit
> > > > frequency hints. And we really _should_ be doing that.
> > > > 
> > > > Because, esp. in this scenario; a task migrating; the hardware really
> > > > can't do anything sensible, whereas the OS _knows_.
> > > 
> > > But IA32_HWP_REQUEST is not a cheap MSR to write to.
> > 
> > That just means we might need to throttle writing to it, like it already
> > does for the regular pstate (PERF_CTRL) msr in any case (also, is that a
> > cheap msr?)
> > 
> > Not touching it at all seems silly.
> 
> OK
> 
> So what field precisely would you touch?  "desired"?  If so, does that actually
> guarantee anything to happen?

No idea, desired would be the one I would start with, it matches with
the intent here. But I've no idea what our current HWP implementation
actually does with it.

> > But now that you made me look, intel_pstate_hwp_set() is horrible crap.
> > You should _never_ do things like:
> > 
> >   rdmsr_on_cpu()
> >   /* frob value */
> >   wrmsr_on_cpu()
> > 
> > That's insane.
> 
> I guess you mean it does too many IPIs?  Or that it shouldn't do any IPIs
> at all?

Yes, too many synchronous IPIs, which themselves are typically already
more expensive than the MSR access.

At one point I looked to getting rid of the *msr_on_cpu() crud entirely,
but there's just too much users out there I didn't feel like touching.

If you really care you can do async IPIs and do a custom serialization
that only waits when you do back-to-back things, which should be fairly
uncommon I'd think.
