Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeA3OGu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:06:50 -0500
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:33358 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752676AbeA3OGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:06:49 -0500
Date: Tue, 30 Jan 2018 14:06:47 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180130140647.6uv7gwdvf3o67su2@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130104555.4125-5-mgorman@techsingularity.net>
 <20180130115054.GA2269@hirez.programming.kicks-ass.net>
 <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
 <20180130131531.GD2269@hirez.programming.kicks-ass.net>
 <20180130132527.tjc6vea76sm5zm76@techsingularity.net>
 <20180130134049.GU2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180130134049.GU2249@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 02:40:49PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 30, 2018 at 01:25:27PM +0000, Mel Gorman wrote:
> > > Because, esp. in this scenario; a task migrating; the hardware really
> > > can't do anything sensible, whereas the OS _knows_.
> > 
> > Potentially yes. One option without HWP would be to track utilisation
> > for a task or artifically boost it for a short period after migration so
> > a higher p-state is potentially selected. With HWP, a hint would have to
> > be given to the hardware to try select a higher frequency but I've no idea
> > how expensive that is or how it would behave on different implementations
> > of HWP. It may also be a game of whack-a-mole trying to get every cpufreq
> > configuration correct.
> 
> We have much of this infrastructure and have been working on improving
> it [1]. We already track per task utilization and feed it into a cpufreq
> governor (schedutil).
> 

Which is potentially great without HWP but ...

> > One advantage of using fewer cores is that it should
> > work regardless of cpufreq driver.
> 
> Sure, and I started out by saying this patch isn't necessarily bad; but
> I think our 'use' [2] of HWP _is_.
> 

This is where we get caught -- HWP means we had full responsibility to
the hardware with limited feedback options. As far as I can tell, any
recent intel CPU is going to have HWP and we've enabled it by default if
available since 4.6. 

Even if further hints can be given from the OS, it does not necessarily
mean this patch is unhelpful. On low utilisation, it's still somewhat
sensible to use the minimum number of CPUs necessary (less cache traffic,
higher p-states, maybe beneficial to turbo boost etc).

-- 
Mel Gorman
SUSE Labs
