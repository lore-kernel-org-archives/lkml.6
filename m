Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbeDZLst (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:48:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753942AbeDZLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:48:45 -0400
Date: Thu, 26 Apr 2018 13:48:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
Message-ID: <20180426114835.GI4064@hirez.programming.kicks-ass.net>
References: <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
 <20180412111519.GH12256@bigcity.dyn.berto.se>
 <20180412133031.GA551@linaro.org>
 <20180412223904.GJ12256@bigcity.dyn.berto.se>
 <CAKfTPtDRtto7w806gYgdS_bCJ77EY0RRtszycB+TnG6aQ6ve4Q@mail.gmail.com>
 <20180420160013.GA13769@linaro.org>
 <20180422221827.GB27674@bigcity.dyn.berto.se>
 <20180423095420.GA23995@linaro.org>
 <20180425225603.GA26177@bigcity.dyn.berto.se>
 <20180426103133.GA6953@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426103133.GA6953@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:31:33PM +0200, Vincent Guittot wrote:
> From: Vincent Guittot <vincent.guittot@linaro.org>
> Date: Thu, 26 Apr 2018 12:19:32 +0200
> Subject: [PATCH] sched/fair: fix the update of blocked load when newly idle
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> With commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle"),
> we release the rq->lock when updating blocked load of idle CPUs. This open
> a time window during which another CPU can add a task to this CPU's cfs_rq.
> The check for newly added task of idle_balance() is not in the common path.
> Move the out label to include this check.

Ah quite so indeed. This could result in us running idle even though
there is a runnable task around -- which is bad.

> Fixes: 31e77c93e432 ("sched/fair: Update blocked load when newly idle")
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reported-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0951d1c..15a9f5e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9847,6 +9847,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	if (curr_cost > this_rq->max_idle_balance_cost)
>  		this_rq->max_idle_balance_cost = curr_cost;
>  
> +out:
>  	/*
>  	 * While browsing the domains, we released the rq lock, a task could
>  	 * have been enqueued in the meantime. Since we're not going idle,
> @@ -9855,7 +9856,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	if (this_rq->cfs.h_nr_running && !pulled_task)
>  		pulled_task = 1;
>  
> -out:
>  	/* Move the next balance forward */
>  	if (time_after(this_rq->next_balance, next_balance))
>  		this_rq->next_balance = next_balance;
