Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934384AbeDXNeD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:34:03 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37423 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934443AbeDXNd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:33:27 -0400
X-Google-Smtp-Source: AIpwx4/cIaCVaTvziXSRCB+FOqkA5Bw8b0iuGRVMO8BNC2CZ7efqZaF2gz+9N048NA7TSZ3adJG/LQ==
Date: Tue, 24 Apr 2018 14:33:25 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180424133325.GA3179@codeblueprint.co.uk>
References: <20180417142119.GA4511@codeblueprint.co.uk>
 <20180420095005.GH4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420095005.GH4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24+42 (6e565710a064) (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr, at 11:50:05AM, Peter Zijlstra wrote:
> On Tue, Apr 17, 2018 at 03:21:19PM +0100, Matt Fleming wrote:
> > Hi guys,
> > 
> > We've seen a bug in one of our SLE kernels where the cpu stopper
> > thread ("migration/15") is entering idle balance. This then triggers
> > active load balance.
> > 
> > At the same time, a task on another CPU triggers a page fault and NUMA
> > balancing kicks in to try and migrate the task closer to the NUMA node
> > for that page (we're inside stop_two_cpus()). This faulting task is
> > spinning in try_to_wake_up() (inside smp_cond_load_acquire(&p->on_cpu,
> > !VAL)), waiting for "migration/15" to context switch.
> > 
> > Unfortunately, because "migration/15" is doing active load balance
> > it's spinning waiting for the NUMA-page-faulting CPU's stopper lock,
> > which is already held (since it's inside stop_two_cpus()).
> > 
> > Deadlock ensues.
> 
> 
> So if I read that right, something like the following happens:
> 
> CPU0					CPU1
> 
> schedule(.prev=migrate/0)		<fault>
>   pick_next_task			  ...
>     idle_balance			    migrate_swap()
>       active_balance			      stop_two_cpus()
> 						spin_lock(stopper0->lock)
> 						spin_lock(stopper1->lock)
> 						ttwu(migrate/0)
> 						  smp_cond_load_acquire() -- waits for schedule()
>         stop_one_cpu(1)
> 	  spin_lock(stopper1->lock) -- waits for stopper lock

Yep, that's exactly right.

> Fix _this_ deadlock by taking out the wakeups from under stopper->lock.
> I'm not entirely sure there isn't more dragons here, but this particular
> one seems fixable by doing that.
> 
> Is there any way you can reproduce/test this?

I'm afraid I don't have any way to test this, but I can ask the
customer that reported it if they can.

Either way, this fix looks good to me.
