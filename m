Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeBBN1Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:27:25 -0500
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:46175 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751470AbeBBN1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:27:19 -0500
Date: Fri, 2 Feb 2018 13:27:17 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180202132717.wftka5bnf25h5oxh@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <3838689.GpfBVtfPr0@aspire.rjw.lan>
 <20180201091104.GW2269@hirez.programming.kicks-ass.net>
 <8930678.7E2iWGoJnn@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <8930678.7E2iWGoJnn@aspire.rjw.lan>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 12:42:29PM +0100, Rafael J. Wysocki wrote:
> > > > But now that you made me look, intel_pstate_hwp_set() is horrible crap.
> > > > You should _never_ do things like:
> > > > 
> > > >   rdmsr_on_cpu()
> > > >   /* frob value */
> > > >   wrmsr_on_cpu()
> > > > 
> > > > That's insane.
> > > 
> > > I guess you mean it does too many IPIs?  Or that it shouldn't do any IPIs
> > > at all?
> > 
> > Yes, too many synchronous IPIs, which themselves are typically already
> > more expensive than the MSR access.
> 
> We could do all of the updates in one IPI (as Srinivas said), but it would be
> more code, and custom code for that matter.
> 
> Is this really worth it for a slow path like this one?
> 

Maybe it's a slow path at the moment but don't forget that one motivation
for this series is that HWP does not properly react when utilisation of a
CPU is artifically low because a task recently slept for IO or recently
migrated. In both cases, the task may be busy and sensitive to either
latency, throughput or both but HWP will use a low p-state. A standard
driver can do io-boost and while it currently does not do so, it could
also trivially do idle-boosting -- HWP does neither.

-- 
Mel Gorman
SUSE Labs
