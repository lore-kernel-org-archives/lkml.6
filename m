Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeCPOgD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:36:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeCPOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:36:02 -0400
Date: Fri, 16 Mar 2018 15:35:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        steven.sistare@oracle.com, joelaf@google.com, jbacik@fb.com,
        juri.lelli@redhat.com, dhaval.giani@oracle.com, efault@gmx.de,
        riel@surriel.com
Subject: Re: [RESEND PATCH v2] sched/fair: Remove check in idle_balance
 against migration_cost
Message-ID: <20180316143550.GH4064@hirez.programming.kicks-ass.net>
References: <1521052607-24622-1-git-send-email-rohit.k.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521052607-24622-1-git-send-email-rohit.k.jain@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 11:36:47AM -0700, Rohit Jain wrote:
> Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
> 
> Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>

Surely you only need a single on of those.

> ---
>  kernel/sched/fair.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5eb3ffc..569ea83 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8804,8 +8804,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	 */
>  	rq_unpin_lock(this_rq, rf);
>  
> -	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> -	    !this_rq->rd->overload) {
> +	if (!this_rq->rd->overload) {
>  		rcu_read_lock();
>  		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  		if (sd)

I don't think that actually works right on the current tree. In
particular look at commit:

  31e77c93e432 ("sched/fair: Update blocked load when newly idle")
