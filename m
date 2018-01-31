Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeAaKRZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:17:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44576 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeAaKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:17:23 -0500
Date: Wed, 31 Jan 2018 11:17:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180131101710.GM2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
 <20180130131531.GD2269@hirez.programming.kicks-ass.net>
 <4353713.vEOq6OHvJN@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4353713.vEOq6OHvJN@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 10:22:49AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, January 30, 2018 2:15:31 PM CET Peter Zijlstra wrote:

> > IA32_HWP_REQUEST has "Minimum_Performance", "Maximum_Performance" and
> > "Desired_Performance" fields which can be used to give explicit
> > frequency hints. And we really _should_ be doing that.
> > 
> > Because, esp. in this scenario; a task migrating; the hardware really
> > can't do anything sensible, whereas the OS _knows_.
> 
> But IA32_HWP_REQUEST is not a cheap MSR to write to.

That just means we might need to throttle writing to it, like it already
does for the regular pstate (PERF_CTRL) msr in any case (also, is that a
cheap msr?)

Not touching it at all seems silly.

But now that you made me look, intel_pstate_hwp_set() is horrible crap.
You should _never_ do things like:

  rdmsr_on_cpu()
  /* frob value */
  wrmsr_on_cpu()

That's insane.
