Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbeAaRoV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:44:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:40101 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753460AbeAaRoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:44:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,441,1511856000";
   d="scan'208";a="170644054"
Message-ID: <1517420658.83171.208.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Date: Wed, 31 Jan 2018 09:44:18 -0800
In-Reply-To: <20180131101710.GM2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
         <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
         <20180130131531.GD2269@hirez.programming.kicks-ass.net>
         <4353713.vEOq6OHvJN@aspire.rjw.lan>
         <20180131101710.GM2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-31 at 11:17 +0100, Peter Zijlstra wrote:
> On Wed, Jan 31, 2018 at 10:22:49AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, January 30, 2018 2:15:31 PM CET Peter Zijlstra wrote:
> > > IA32_HWP_REQUEST has "Minimum_Performance", "Maximum_Performance"
> > > and
> > > "Desired_Performance" fields which can be used to give explicit
> > > frequency hints. And we really _should_ be doing that.
> > > 
> > > Because, esp. in this scenario; a task migrating; the hardware
> > > really
> > > can't do anything sensible, whereas the OS _knows_.
> > 
> > But IA32_HWP_REQUEST is not a cheap MSR to write to.
> 
> That just means we might need to throttle writing to it, like it
> already
> does for the regular pstate (PERF_CTRL) msr in any case (also, is
> that a
> cheap msr?)
Much more throttling required compared to PERF_CTL. MSR_HWP_REQUEST is
much slower compared to PERF_CTL (as high as 10:1). 

> 
> Not touching it at all seems silly.
> 
> But now that you made me look, intel_pstate_hwp_set() is horrible
> crap.
> You should _never_ do things like:
> 
>   rdmsr_on_cpu()
>   /* frob value */
>   wrmsr_on_cpu()
> 
> That's insane.

Since the cpufreq callback is not guaranteed to be called on the same
CPU, we have to use rd/wrmsr_on_cpu().
But we can use smp_call_function_single() and optimize this.
This function is called only during init, when usermode changes
frequency limits and from thermal, so very few times.

Thanks,
Srinivas
