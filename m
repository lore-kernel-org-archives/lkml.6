Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeBEREc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:04:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:29493 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753292AbeBEREZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:04:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,465,1511856000";
   d="scan'208";a="28936544"
Message-ID: <1517850265.2754.1.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 05 Feb 2018 09:04:25 -0800
In-Reply-To: <20180205111018.pwm7nlt6rgulyfbt@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
         <20180201091104.GW2269@hirez.programming.kicks-ass.net>
         <1517491092.18051.52.camel@linux.intel.com>
         <2447536.u3g27UoP4q@aspire.rjw.lan>
         <1517583264.18051.60.camel@linux.intel.com>
         <20180202194801.mhvuwzbz6pauf63f@techsingularity.net>
         <1517601697.83171.361.camel@linux.intel.com>
         <20180205111018.pwm7nlt6rgulyfbt@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-05 at 11:10 +0000, Mel Gorman wrote:
> On Fri, Feb 02, 2018 at 12:01:37PM -0800, Srinivas Pandruvada wrote:
> > > Sure, but the lack on detection when tasks are low utilisation
> > > but
> > > still
> > > latency/throughput sensitive is problematic. Users shouldn't have
> > > to
> > > know they need to disable HWP or set performance goernor out of
> > > the
> > > box.
> > > It's only going to get worse as sockets get larger.
> > 
> > I am not saying that we shouldn't do anything. Can you give me some
> > workloads which you care the most?
> > 
> 
> The proprietary workloads I'm aware of are useless to the discussion
> as they cannot be trivially reproduced and are typically only
> available
> under NDA. However, hints can be gotten by looking at the number of
> cases
> where recommended tunings limits C-states, set the performance
> governor,
> alter intel_pstate setpoint (if not HWP) etc.
> 
> For the purposes of illustration, dbench at low thread counts does
> a reasonable job even though it's not that interesting a workload in
> general. With ext4 in particular, the journalling thread interactions
> bounce tasks around the machine and the short sleeps for IO both
> combine
> to have relatively low utilisation on individual CPUs. It's less
> pronounced
> on xfs as it bounces less due to using kworkers instead of kthreads.
> 
> > > 
> > > > There are totally different way HWP is handled in client an
> > > > servers.
> > > > If you set desired all heuristics they collected will be
> > > > dumped, so
> > > > they suggest don't set desired when you are in autonomous mode.
> > > > If
> > > > we
> > > > really want a boost set the EPP. We know that EPP makes lots of
> > > > measurable difference.
> > > > 
> > > 
> > > Sure boosting EPP makes a difference -- it's essentially what the
> > > performance
> > > goveror does and I know that can be done by a user but it's still
> > > basically a
> > > cop-out. Default performance for low utilisation or lightly
> > > loaded
> > > machines
> > > is poor. Maybe it should be set based on the ACPI preferred
> > > profile
> > > but
> > > that information is not always available. It would be nice if
> > > *some*
> > > sort of hint about new migrations or tasks waking from IO would
> > > be
> > > desirable.
> > 
> > EPP is a range not a single value. So you don't need to make EPP=0
> > as a
> > performance governor. PeterZ gave me some scheduler change to
> > experiment, which can be used as hint to play with EPP. 
> > 
> 
> I know EPP is a range, default from bios usually appear to be 6 or 7
> but
> I didn't do much experiementation to see if there is another value
> that
> works better. Even if there is, the default may need to change as not
> many
> people even know what EPP is or how it should be tuned.
I think you are talking about EPB not EPP because of ranges you
mentioned here. EPP is a value from 0 to 255. EPP is part of
HWP_REQUEST MSR.
EPB with HWP is used only in Broadwell server. I think you are using
Skylake here.

Thanks,
Srinivas
