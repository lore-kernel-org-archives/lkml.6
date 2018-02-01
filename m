Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeBANSR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:18:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:39087 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbeBANSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:18:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="16181448"
Message-ID: <1517491092.18051.52.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Date: Thu, 01 Feb 2018 05:18:12 -0800
In-Reply-To: <20180201091104.GW2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
         <4353713.vEOq6OHvJN@aspire.rjw.lan>
         <20180131101710.GM2269@hirez.programming.kicks-ass.net>
         <3838689.GpfBVtfPr0@aspire.rjw.lan>
         <20180201091104.GW2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2 (3.18.5.2-1.fc23) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 10:11 +0100, Peter Zijlstra wrote:
> On Thu, Feb 01, 2018 at 08:50:28AM +0100, Rafael J. Wysocki wrote:
> > 
> > On Wednesday, January 31, 2018 11:17:10 AM CET Peter Zijlstra
> > wrote:
> > > 
> > > On Wed, Jan 31, 2018 at 10:22:49AM +0100, Rafael J. Wysocki
> > > wrote:
> > > > 
> > > > On Tuesday, January 30, 2018 2:15:31 PM CET Peter Zijlstra
> > > > wrote:
> > > > 
> > > > > 
> > > > > IA32_HWP_REQUEST has "Minimum_Performance",
> > > > > "Maximum_Performance" and
> > > > > "Desired_Performance" fields which can be used to give
> > > > > explicit
> > > > > frequency hints. And we really _should_ be doing that.
> > > > > 
> > > > > Because, esp. in this scenario; a task migrating; the
> > > > > hardware really
> > > > > can't do anything sensible, whereas the OS _knows_.
> > > > But IA32_HWP_REQUEST is not a cheap MSR to write to.
> > > That just means we might need to throttle writing to it, like it
> > > already
> > > does for the regular pstate (PERF_CTRL) msr in any case (also, is
> > > that a
> > > cheap msr?)
> > > 
> > > Not touching it at all seems silly.
> > OK
> > 
> > So what field precisely would you touch?  "desired"?  If so, does
> > that actually
> > guarantee anything to happen?
> No idea, desired would be the one I would start with, it matches with
> the intent here. But I've no idea what our current HWP implementation
> actually does with it.
Desired !=0 will disable HWP autonomous mode of frequency selection.
