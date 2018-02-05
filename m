Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeBELK1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:10:27 -0500
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:48403 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752498AbeBELKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:10:20 -0500
Date: Mon, 5 Feb 2018 11:10:18 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180205111018.pwm7nlt6rgulyfbt@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180201091104.GW2269@hirez.programming.kicks-ass.net>
 <1517491092.18051.52.camel@linux.intel.com>
 <2447536.u3g27UoP4q@aspire.rjw.lan>
 <1517583264.18051.60.camel@linux.intel.com>
 <20180202194801.mhvuwzbz6pauf63f@techsingularity.net>
 <1517601697.83171.361.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1517601697.83171.361.camel@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 12:01:37PM -0800, Srinivas Pandruvada wrote:
> > Sure, but the lack on detection when tasks are low utilisation but
> > still
> > latency/throughput sensitive is problematic. Users shouldn't have to
> > know they need to disable HWP or set performance goernor out of the
> > box.
> > It's only going to get worse as sockets get larger.
>
> I am not saying that we shouldn't do anything. Can you give me some
> workloads which you care the most?
> 

The proprietary workloads I'm aware of are useless to the discussion
as they cannot be trivially reproduced and are typically only available
under NDA. However, hints can be gotten by looking at the number of cases
where recommended tunings limits C-states, set the performance governor,
alter intel_pstate setpoint (if not HWP) etc.

For the purposes of illustration, dbench at low thread counts does
a reasonable job even though it's not that interesting a workload in
general. With ext4 in particular, the journalling thread interactions
bounce tasks around the machine and the short sleeps for IO both combine
to have relatively low utilisation on individual CPUs. It's less pronounced
on xfs as it bounces less due to using kworkers instead of kthreads.

> > 
> > > There are totally different way HWP is handled in client an
> > > servers.
> > > If you set desired all heuristics they collected will be dumped, so
> > > they suggest don't set desired when you are in autonomous mode. If
> > > we
> > > really want a boost set the EPP. We know that EPP makes lots of
> > > measurable difference.
> > > 
> > 
> > Sure boosting EPP makes a difference -- it's essentially what the
> > performance
> > goveror does and I know that can be done by a user but it's still
> > basically a
> > cop-out. Default performance for low utilisation or lightly loaded
> > machines
> > is poor. Maybe it should be set based on the ACPI preferred profile
> > but
> > that information is not always available. It would be nice if *some*
> > sort of hint about new migrations or tasks waking from IO would be
> > desirable.
> EPP is a range not a single value. So you don't need to make EPP=0 as a
> performance governor. PeterZ gave me some scheduler change to
> experiment, which can be used as hint to play with EPP. 
> 

I know EPP is a range, default from bios usually appear to be 6 or 7 but
I didn't do much experiementation to see if there is another value that
works better. Even if there is, the default may need to change as not many
people even know what EPP is or how it should be tuned.

-- 
Mel Gorman
SUSE Labs
