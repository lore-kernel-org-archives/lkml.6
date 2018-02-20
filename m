Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeBTQk1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbeBTQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:40:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371B221748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Tue, 20 Feb 2018 17:40:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 6/6] sched/isolation: Update nohz documentation to
 explain tick offload
Message-ID: <20180220164021.GB13879@lerouge>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org>
 <1518655694-8057-7-git-send-email-frederic@kernel.org>
 <alpine.DEB.2.21.1802171152060.2087@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802171152060.2087@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 11:53:22AM +0100, Thomas Gleixner wrote:
> On Thu, 15 Feb 2018, Frederic Weisbecker wrote:
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
> >  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 1d1d53f..50b9837 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1766,6 +1766,17 @@
> >  
> >  			nohz
> >  			  Disable the tick when a single task runs.
> > +
> > +			  A residual 1Hz tick is offloaded to workqueues, which you
> > +			  need to affine to housekeeping through the global
> > +			  workqueue's affinity configured via the
> > +			  /sys/devices/virtual/workqueue/cpumask sysfs file, or
> > +			  by using the 'domain' flag described below.
> > +
> > +			  NOTE: by default the global workqueue runs on all CPUs,
> > +			  so to protect individual CPUs the 'cpumask' file has to
> > +			  be configured manually after bootup.
> 
> Hmm. Why don't you set that to the housekeeping cpus by default?

"nohz_full=" does affine to housekeeping by default but "isolcpus=nohz" doesn't
as it is designed for more finegrained settings.

In fact nohz_full= is what people want to use right now as isolcpus= is still
under construction. I'm waiting to be able to make its effects mutable through
cpusets before extending it further. But in the end I would like to have things
such as:

     isolcpus=nohz,async

This would affine the tick and everything that is async (workqueues, unbound timers,
unbound kthreads, etc...) to housekeeping.

And an even simpler toggle to fully isolate a CPU:

     isolcpus=all

This is to avoid that nohz alone implies side effects. For example if we affine
workqueues right now and later the 1hz offloaded tick isn't necessary anymore,
we'll stick with affined workqueues as a side effect without reason, and reverting
that would end up into regression.

Thanks.
