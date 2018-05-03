Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeECMtw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:49:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41560 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeECMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:49:51 -0400
Date: Thu, 3 May 2018 14:49:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180503124943.GB12217@hirez.programming.kicks-ass.net>
References: <20180417142119.GA4511@codeblueprint.co.uk>
 <20180420095005.GH4064@hirez.programming.kicks-ass.net>
 <20180424133325.GA3179@codeblueprint.co.uk>
 <1525349542.9956.2.camel@gmx.de>
 <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
 <1525351221.9956.4.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525351221.9956.4.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 02:40:21PM +0200, Mike Galbraith wrote:
> On Thu, 2018-05-03 at 14:28 +0200, Peter Zijlstra wrote:
> > 
> > Hurm.. I don't see how this is 'new'. We moved the wakeup out from under
> > stopper lock, but that should not affect the RCU state.
> 
> No, not new, just an additional woes from same spot.

Ah, ok. Does somsething like this make it go away?


diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index f89014a2c238..a32518c2ba4a 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -650,8 +650,10 @@ int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
 	/* Schedule work on other CPUs and execute directly for local CPU */
 	set_state(&msdata, MULTI_STOP_PREPARE);
 	cpu_stop_init_done(&done, num_active_cpus());
-	queue_stop_cpus_work(cpu_active_mask, multi_cpu_stop, &msdata,
-			     &done);
+
+	RCU_NONIDLE(queue_stop_cpus_work(cpu_active_mask, multi_cpu_stop,
+				         &msdata, &done));
+
 	ret = multi_cpu_stop(&msdata);
 
 	/* Busy wait for completion. */
