Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeBBOyc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:54:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:35745 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbeBBOy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:54:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="28307141"
Message-ID: <1517583264.18051.60.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Date: Fri, 02 Feb 2018 06:54:24 -0800
In-Reply-To: <2447536.u3g27UoP4q@aspire.rjw.lan>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
         <20180201091104.GW2269@hirez.programming.kicks-ass.net>
         <1517491092.18051.52.camel@linux.intel.com>
         <2447536.u3g27UoP4q@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2 (3.18.5.2-1.fc23) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 12:00 +0100, Rafael J. Wysocki wrote:
> On Thursday, February 1, 2018 2:18:12 PM CET Srinivas Pandruvada
> wrote:
> > 
> > On Thu, 2018-02-01 at 10:11 +0100, Peter Zijlstra wrote:
> > > 
> > > On Thu, Feb 01, 2018 at 08:50:28AM +0100, Rafael J. Wysocki
> > > wrote:
> > > > 
> > > > 
> > > > On Wednesday, January 31, 2018 11:17:10 AM CET Peter Zijlstra
> > > > wrote:
> > > > > 
> > > > > 
> > > > > On Wed, Jan 31, 2018 at 10:22:49AM +0100, Rafael J. Wysocki
> > > > > wrote:
> > > > > > 
> > > > > > 
> > > > > > On Tuesday, January 30, 2018 2:15:31 PM CET Peter Zijlstra
> > > > > > wrote:
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > IA32_HWP_REQUEST has "Minimum_Performance",
> > > > > > > "Maximum_Performance" and
> > > > > > > "Desired_Performance" fields which can be used to give
> > > > > > > explicit
> > > > > > > frequency hints. And we really _should_ be doing that.
> > > > > > > 
> > > > > > > Because, esp. in this scenario; a task migrating; the
> > > > > > > hardware really
> > > > > > > can't do anything sensible, whereas the OS _knows_.
> > > > > > But IA32_HWP_REQUEST is not a cheap MSR to write to.
> > > > > That just means we might need to throttle writing to it, like
> > > > > it
> > > > > already
> > > > > does for the regular pstate (PERF_CTRL) msr in any case
> > > > > (also, is
> > > > > that a
> > > > > cheap msr?)
> > > > > 
> > > > > Not touching it at all seems silly.
> > > > OK
> > > > 
> > > > So what field precisely would you touch?  "desired"?  If so,
> > > > does
> > > > that actually
> > > > guarantee anything to happen?
> > > No idea, desired would be the one I would start with, it matches
> > > with
> > > the intent here. But I've no idea what our current HWP
> > > implementation
> > > actually does with it.
> > Desired !=0 will disable HWP autonomous mode of frequency
> > selection.
> But I don't think it will just run at "desired" then, will it?
HWP all are these hints only not a guarantee.
There are totally different way HWP is handled in client an servers.
If you set desired all heuristics they collected will be dumped, so
they suggest don't set desired when you are in autonomous mode. If we
really want a boost set the EPP. We know that EPP makes lots of
measurable difference.
