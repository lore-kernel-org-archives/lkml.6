Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeA3M5W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:57:22 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:50700 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751932AbeA3M5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:57:20 -0500
Date: Tue, 30 Jan 2018 12:57:18 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130104555.4125-5-mgorman@techsingularity.net>
 <20180130115054.GA2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180130115054.GA2269@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 12:50:54PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 30, 2018 at 10:45:55AM +0000, Mel Gorman wrote:
> > The select_idle_sibling (SIS) rewrite in commit 10e2f1acd010 ("sched/core:
> > Rewrite and improve select_idle_siblings()") replaced a domain iteration
> > with a search that broadly speaking does a wrapped walk of the scheduler
> > domain sharing a last-level-cache. While this had a number of improvements,
> > one consequence is that two tasks that share a waker/wakee relationship push
> > each other around a socket. Even though two tasks may be active, all cores
> > are evenly used. This is great from a search perspective and spreads a load
> > across individual cores but it has adverse consequences for cpufreq. As each
> > CPU has relatively low utilisation, cpufreq may decide the utilisation is
> > too low to used a higher P-state and overall computation throughput suffers.
> 
> > While individual cpufreq and cpuidle drivers may compensate by artifically
> > boosting P-state (at c0) or avoiding lower C-states (during idle), it does
> > not help if hardware-based cpufreq (e.g. HWP) is used.
> 
> Not saying this patch is bad; but Rafael / Srinivas we really should do
> better. Why isn't cpufreq (esp. sugov) fixing this? HWP or not, we can
> still give it hints, and it looks like we're not doing that.
> 

I'm not sure if HWP can fix it because of the per-cpu nature of its
decisions. I believe it can only give the most basic of hints to hardware
like an energy performance profile or bias (EPP and EPB respectively).
Of course HWP can be turned off but not many people can detect that it's
an appropriate decision, or even desirable, and there is always the caveat
that disabling it increases the system CPU footprint.

> Mel, what hardware are you testing this on?

The primary one was a single socket skylake machine with 8 threads (HT
enabled). However, 11 machines were used in total across multiple
generations to reduce the chance of a regression slipping in that was
machine-specific.


-- 
Mel Gorman
SUSE Labs
