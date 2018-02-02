Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeBBLoN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 06:44:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50790 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBLoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 06:44:06 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle candidate and the basis for SIS
Date: Fri, 02 Feb 2018 12:42:29 +0100
Message-ID: <8930678.7E2iWGoJnn@aspire.rjw.lan>
In-Reply-To: <20180201091104.GW2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net> <3838689.GpfBVtfPr0@aspire.rjw.lan> <20180201091104.GW2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 1, 2018 10:11:04 AM CET Peter Zijlstra wrote:
> On Thu, Feb 01, 2018 at 08:50:28AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, January 31, 2018 11:17:10 AM CET Peter Zijlstra wrote:
> > > On Wed, Jan 31, 2018 at 10:22:49AM +0100, Rafael J. Wysocki wrote:
> > > > On Tuesday, January 30, 2018 2:15:31 PM CET Peter Zijlstra wrote:
> > > 
> > > > > IA32_HWP_REQUEST has "Minimum_Performance", "Maximum_Performance" and
> > > > > "Desired_Performance" fields which can be used to give explicit
> > > > > frequency hints. And we really _should_ be doing that.
> > > > > 
> > > > > Because, esp. in this scenario; a task migrating; the hardware really
> > > > > can't do anything sensible, whereas the OS _knows_.
> > > > 
> > > > But IA32_HWP_REQUEST is not a cheap MSR to write to.
> > > 
> > > That just means we might need to throttle writing to it, like it already
> > > does for the regular pstate (PERF_CTRL) msr in any case (also, is that a
> > > cheap msr?)
> > > 
> > > Not touching it at all seems silly.
> > 
> > OK
> > 
> > So what field precisely would you touch?  "desired"?  If so, does that actually
> > guarantee anything to happen?
> 
> No idea, desired would be the one I would start with, it matches with
> the intent here. But I've no idea what our current HWP implementation
> actually does with it.
> 
> > > But now that you made me look, intel_pstate_hwp_set() is horrible crap.
> > > You should _never_ do things like:
> > > 
> > >   rdmsr_on_cpu()
> > >   /* frob value */
> > >   wrmsr_on_cpu()
> > > 
> > > That's insane.
> > 
> > I guess you mean it does too many IPIs?  Or that it shouldn't do any IPIs
> > at all?
> 
> Yes, too many synchronous IPIs, which themselves are typically already
> more expensive than the MSR access.

We could do all of the updates in one IPI (as Srinivas said), but it would be
more code, and custom code for that matter.

Is this really worth it for a slow path like this one?

> At one point I looked to getting rid of the *msr_on_cpu() crud entirely,
> but there's just too much users out there I didn't feel like touching.
> 
> If you really care you can do async IPIs and do a custom serialization
> that only waits when you do back-to-back things, which should be fairly
> uncommon I'd think.

In this particular case we don't want to return to user space before the
MSR is actually written with the new value.
