Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeA3NZa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:25:30 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:50948 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752053AbeA3NZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:25:29 -0500
Date: Tue, 30 Jan 2018 13:25:27 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180130132527.tjc6vea76sm5zm76@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130104555.4125-5-mgorman@techsingularity.net>
 <20180130115054.GA2269@hirez.programming.kicks-ass.net>
 <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
 <20180130131531.GD2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180130131531.GD2269@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 02:15:31PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 30, 2018 at 12:57:18PM +0000, Mel Gorman wrote:
> > On Tue, Jan 30, 2018 at 12:50:54PM +0100, Peter Zijlstra wrote:
> 
> > > Not saying this patch is bad; but Rafael / Srinivas we really should do
> > > better. Why isn't cpufreq (esp. sugov) fixing this? HWP or not, we can
> > > still give it hints, and it looks like we're not doing that.
> > > 
> > 
> > I'm not sure if HWP can fix it because of the per-cpu nature of its
> > decisions. I believe it can only give the most basic of hints to hardware
> > like an energy performance profile or bias (EPP and EPB respectively).
> > Of course HWP can be turned off but not many people can detect that it's
> > an appropriate decision, or even desirable, and there is always the caveat
> > that disabling it increases the system CPU footprint.
> 
> IA32_HWP_REQUEST has "Minimum_Performance", "Maximum_Performance" and
> "Desired_Performance" fields which can be used to give explicit
> frequency hints. And we really _should_ be doing that.
> 

They can be although these are usually set by the bios or setup early
in boot and then left alone. It's not clear how or if these should be
tuned on the fly or what variables would drive dynamic tuning. The data
collected would still be per-cpu so if all CPUs have low utilisation,
the decisions will still be poor except maybe for things like IO boosting.

> Because, esp. in this scenario; a task migrating; the hardware really
> can't do anything sensible, whereas the OS _knows_.
> 

Potentially yes. One option without HWP would be to track utilisation
for a task or artifically boost it for a short period after migration so
a higher p-state is potentially selected. With HWP, a hint would have to
be given to the hardware to try select a higher frequency but I've no idea
how expensive that is or how it would behave on different implementations
of HWP. It may also be a game of whack-a-mole trying to get every cpufreq
configuration correct. One advantage of using fewer cores is that it should
work regardless of cpufreq driver.


-- 
Mel Gorman
SUSE Labs
