Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeBDIkb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 03:40:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58628 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeBDIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 03:40:26 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle candidate and the basis for SIS
Date: Sun, 04 Feb 2018 09:38:47 +0100
Message-ID: <4761571.IWmCqhUQku@aspire.rjw.lan>
In-Reply-To: <1517583264.18051.60.camel@linux.intel.com>
References: <20180130104555.4125-1-mgorman@techsingularity.net> <2447536.u3g27UoP4q@aspire.rjw.lan> <1517583264.18051.60.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 2, 2018 3:54:24 PM CET Srinivas Pandruvada wrote:
> On Fri, 2018-02-02 at 12:00 +0100, Rafael J. Wysocki wrote:
> > On Thursday, February 1, 2018 2:18:12 PM CET Srinivas Pandruvada
> > wrote:
> > > 
> > > On Thu, 2018-02-01 at 10:11 +0100, Peter Zijlstra wrote:
> > > > 
> > > > On Thu, Feb 01, 2018 at 08:50:28AM +0100, Rafael J. Wysocki
> > > > wrote:
> > > > > 
> > > > > 
> > > > > On Wednesday, January 31, 2018 11:17:10 AM CET Peter Zijlstra
> > > > > wrote:
> > > > > > 
> > > > > > 
> > > > > > On Wed, Jan 31, 2018 at 10:22:49AM +0100, Rafael J. Wysocki
> > > > > > wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On Tuesday, January 30, 2018 2:15:31 PM CET Peter Zijlstra
> > > > > > > wrote:
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > IA32_HWP_REQUEST has "Minimum_Performance",
> > > > > > > > "Maximum_Performance" and
> > > > > > > > "Desired_Performance" fields which can be used to give
> > > > > > > > explicit
> > > > > > > > frequency hints. And we really _should_ be doing that.
> > > > > > > > 
> > > > > > > > Because, esp. in this scenario; a task migrating; the
> > > > > > > > hardware really
> > > > > > > > can't do anything sensible, whereas the OS _knows_.
> > > > > > > But IA32_HWP_REQUEST is not a cheap MSR to write to.
> > > > > > That just means we might need to throttle writing to it, like
> > > > > > it
> > > > > > already
> > > > > > does for the regular pstate (PERF_CTRL) msr in any case
> > > > > > (also, is
> > > > > > that a
> > > > > > cheap msr?)
> > > > > > 
> > > > > > Not touching it at all seems silly.
> > > > > OK
> > > > > 
> > > > > So what field precisely would you touch?  "desired"?  If so,
> > > > > does
> > > > > that actually
> > > > > guarantee anything to happen?
> > > > No idea, desired would be the one I would start with, it matches
> > > > with
> > > > the intent here. But I've no idea what our current HWP
> > > > implementation
> > > > actually does with it.
> > > Desired !=0 will disable HWP autonomous mode of frequency
> > > selection.
> > But I don't think it will just run at "desired" then, will it?
> HWP all are these hints only not a guarantee.
> There are totally different way HWP is handled in client an servers.
> If you set desired all heuristics they collected will be dumped, so
> they suggest don't set desired when you are in autonomous mode. If we
> really want a boost set the EPP. We know that EPP makes lots of
> measurable difference.

Yeah, we've been consistently told to use EPP rather than "desired" for hints
like that.
