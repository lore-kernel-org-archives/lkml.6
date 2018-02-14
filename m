Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031079AbeBNOw4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:52:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030675AbeBNOwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:52:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D6420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Wed, 14 Feb 2018 15:52:50 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 6/6] sched/isolation: Tick offload documentation
Message-ID: <20180214145248.GA2456@lerouge>
References: <1518112779-30196-1-git-send-email-frederic@kernel.org>
 <1518112779-30196-7-git-send-email-frederic@kernel.org>
 <20180209070649.kuk3dbwsycnqugsd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209070649.kuk3dbwsycnqugsd@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 08:06:49AM +0100, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > Update the documentation to reflect the 1Hz tick offload changes.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Chris Metcalf <cmetcalf@mellanox.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Luiz Capitulino <lcapitulino@redhat.com>
> > Cc: Mike Galbraith <efault@gmx.de>
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Rik van Riel <riel@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Wanpeng Li <kernellwp@gmail.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 39ac9d4..c851e41 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1762,7 +1762,11 @@
> >  			specified in the flag list (default: domain):
> >  
> >  			nohz
> > -			  Disable the tick when a single task runs.
> > +			  Disable the tick when a single task runs. A residual 1Hz
> > +			  tick is offloaded to workqueues that you need to affine
> > +			  to housekeeping through the sysfs file
> > +			  /sys/devices/virtual/workqueue/cpumask or using the below
> > +			  domain flag.
> 
> This is pretty ambiguous and somewhat confusing, I'd suggest something like:
> 
> 			nohz
> 			  Disable the tick when a single task runs.
> 
> 			  A residual 1Hz tick is offloaded to workqueues, which you 
> 			  need to affine to housekeeping through the global 
> 			  workqueue's affinity configured via the 
> 			  /sys/devices/virtual/workqueue/cpumask sysfs file, or 
> 			  by using the 'domain' flag described below.
> 
> 			  NOTE: by default the global workqueue runs on all CPUs, 
> 			  so to protect individual CPUs the 'cpumask' file has to 
> 			  be configured manually after bootup.
> 
> Assuming what I wrote is correct - the CPU isolation config space is pretty 
> confusing all around and should be made a lot more human friendly ...

That's right. In fact "nohz_full=" affines the workqueues and it involves much
more: unbound timers affinity, RCU threads, etc...

So "nohz_full=" is the friendly interface as it does all in one.

Now the use of "isolcpus=" is supposed to be more finegrained and allow for more control.
Ideally I would like to have an "unbound" flag which affines all these unbound works. And
why not a "per_cpu" flag to disable or offload per cpu work such as watchdog.

So we would only need to do:

     isolcpus=nohz,unbound,per_cpu

Or even just:

     isolcpus=all

But before extending further isolcpus=, I would like to make sure I can make it mutable
later through cpusets. So this is work in progress.

Thanks.
