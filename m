Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeBTQBG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:01:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44852 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbeBTQBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:01:05 -0500
Date: Tue, 20 Feb 2018 16:01:01 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] sched/fair: Add group_misfit_task load-balance type
Message-ID: <20180220160101.GB4589@e105550-lin.cambridge.arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-3-git-send-email-morten.rasmussen@arm.com>
 <20180219135644.GG25181@hirez.programming.kicks-ass.net>
 <20180219135842.GM25235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219135842.GM25235@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 02:58:42PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 19, 2018 at 02:56:44PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 15, 2018 at 04:20:49PM +0000, Morten Rasmussen wrote:
> > > @@ -6733,9 +6758,12 @@ done: __maybe_unused
> > >  	if (hrtick_enabled(rq))
> > >  		hrtick_start_fair(rq, p);
> > >  
> > > +	update_misfit_status(p, rq);
> > > +
> > >  	return p;
> > >  
> > >  idle:
> > > +	update_misfit_status(NULL, rq);
> > >  	new_tasks = idle_balance(rq, rf);
> > >  
> > >  	/*
> > 
> > So we set a point when picking a task (or tick). We clear said pointer
> > when idle.
> 
> N/m, I can't read today. You only store the load, not the actual task.

It is a very valid question though.

Storing the load of the misfit task isn't the perfect solution as there
is no guarantee that we actually end up pulling the misfit task if some
other task happens to be on the rq when we balance. However, as I think
you are hinting, we will get into all sorts of interesting races if we
store a pointer to the actual task.

In most real scenarios it appears to be 'good enough'. The typical
misfit scenario is one always-running task and potentially a few small
tasks showing up periodically. In that case we are most likely to see
the always-running task when we are balancing.
