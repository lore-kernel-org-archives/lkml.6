Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755451AbeDZKbl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:31:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42204 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754723AbeDZKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:31:37 -0400
X-Google-Smtp-Source: AIpwx48EWXwJTzzj1++/yPTeVjrXR6D10I16JmBie5XtdvuHoDypgSctu2zj4NlLp4u+wIgFV+FMwQ==
Date: Thu, 26 Apr 2018 12:31:33 +0200
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
Message-ID: <20180426103133.GA6953@linaro.org>
References: <20180412091822.GG12256@bigcity.dyn.berto.se>
 <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
 <20180412111519.GH12256@bigcity.dyn.berto.se>
 <20180412133031.GA551@linaro.org>
 <20180412223904.GJ12256@bigcity.dyn.berto.se>
 <CAKfTPtDRtto7w806gYgdS_bCJ77EY0RRtszycB+TnG6aQ6ve4Q@mail.gmail.com>
 <20180420160013.GA13769@linaro.org>
 <20180422221827.GB27674@bigcity.dyn.berto.se>
 <20180423095420.GA23995@linaro.org>
 <20180425225603.GA26177@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180425225603.GA26177@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

Le Thursday 26 Apr 2018 à 00:56:03 (+0200), Niklas Söderlund a écrit :
> Hi Vincent,
> 
> Here are the result, sorry for the delay.
> 
> On 2018-04-23 11:54:20 +0200, Vincent Guittot wrote:
> 
> [snip]
> 
> > 
> > Thanks for the report. Can you re run with the following trace-cmd sequence ? My previous sequence disables ftrace events
> > 
> > trace-cmd reset > /dev/null
> > trace-cmd start -b 40000 -p function -l dump_backtrace:traceoff -e sched -e cpu_idle -e cpu_frequency -e timer -e ipi -e irq -e printk
> > trace-cmd start -b 40000 -p function -l dump_backtrace -e sched -e cpu_idle -e cpu_frequency -e timer -e ipi -e irq -e printk
> > 
> > I have updated the patch and added traces to check that scheduler returns from idle_balance function and doesn't stay stuck
> 
> Once more I applied the change bellow on-top of c18bb396d3d261eb ("Merge 
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
> 
> This time the result of 'trace-cmd report' is so large I do not include 
> it here, but I attach the trace.dat file. Not sure why but the timing of 
> sending the NMI to the backtrace print is different (but content the 
> same AFIK) so in the odd change it can help figure this out:
> 

Thanks for the trace, I have been able to catch a problem with it.
Could you test the patch below to confirm that the problem is solved ?
The patch apply on-top of
c18bb396d3d261eb ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")

From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Apr 2018 12:19:32 +0200
Subject: [PATCH] sched/fair: fix the update of blocked load when newly idle
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle"),
we release the rq->lock when updating blocked load of idle CPUs. This open
a time window during which another CPU can add a task to this CPU's cfs_rq.
The check for newly added task of idle_balance() is not in the common path.
Move the out label to include this check.

Fixes: 31e77c93e432 ("sched/fair: Update blocked load when newly idle")
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Reported-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0951d1c..15a9f5e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9847,6 +9847,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
+out:
 	/*
 	 * While browsing the domains, we released the rq lock, a task could
 	 * have been enqueued in the meantime. Since we're not going idle,
@@ -9855,7 +9856,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->cfs.h_nr_running && !pulled_task)
 		pulled_task = 1;
 
-out:
 	/* Move the next balance forward */
 	if (time_after(this_rq->next_balance, next_balance))
 		this_rq->next_balance = next_balance;
-- 
2.7.4



[snip]
