Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeA3NPi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:15:38 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:53203 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeA3NPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:15:37 -0500
Date: Tue, 30 Jan 2018 14:15:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180130131531.GD2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130104555.4125-5-mgorman@techsingularity.net>
 <20180130115054.GA2269@hirez.programming.kicks-ass.net>
 <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 12:57:18PM +0000, Mel Gorman wrote:
> On Tue, Jan 30, 2018 at 12:50:54PM +0100, Peter Zijlstra wrote:

> > Not saying this patch is bad; but Rafael / Srinivas we really should do
> > better. Why isn't cpufreq (esp. sugov) fixing this? HWP or not, we can
> > still give it hints, and it looks like we're not doing that.
> > 
> 
> I'm not sure if HWP can fix it because of the per-cpu nature of its
> decisions. I believe it can only give the most basic of hints to hardware
> like an energy performance profile or bias (EPP and EPB respectively).
> Of course HWP can be turned off but not many people can detect that it's
> an appropriate decision, or even desirable, and there is always the caveat
> that disabling it increases the system CPU footprint.

IA32_HWP_REQUEST has "Minimum_Performance", "Maximum_Performance" and
"Desired_Performance" fields which can be used to give explicit
frequency hints. And we really _should_ be doing that.

Because, esp. in this scenario; a task migrating; the hardware really
can't do anything sensible, whereas the OS _knows_.
