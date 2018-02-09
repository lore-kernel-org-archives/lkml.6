Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeBIDmu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 22:42:50 -0500
Received: from mout.gmx.net ([212.227.17.21]:50531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbeBIDmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 22:42:49 -0500
Message-ID: <1518147735.24350.26.camel@gmx.de>
Subject: Re: [RFC 1/2] sched: reduce migration cost between faster caches
 for idle_balance
From: Mike Galbraith <efault@gmx.de>
To: Rohit Jain <rohit.k.jain@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        joelaf@google.com, jbacik@fb.com, riel@redhat.com,
        juri.lelli@redhat.com, dhaval.giani@oracle.com
Date: Fri, 09 Feb 2018 04:42:15 +0100
In-Reply-To: <1518128395-14606-2-git-send-email-rohit.k.jain@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
         <1518128395-14606-2-git-send-email-rohit.k.jain@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:8JpYxf1EggyA4Ni32dLBZ8rKz1PWb2OME+t1wj7CuwDKtf029g6
 VzJvU1Lx90lgbeb7FB3UowMBvAYMQvY6jZViJthXF/59zrvwuW3KWryXU39ErgZdMvZ3kbN
 lYUFOsX+LZA/WD8jUgF8ulRWBemH/kL+BmyaXijJYBzctbd4rKniM/IQABAB/+LbqKbxqfO
 APt8BmtPVZ2PXW7n0Xb0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8cKTKQVnSmQ=:QIwBtQA3vTHLs+aitrttus
 06KmAXl6YeNzIc/jr9gqZdVcZOfcbp1Wm4U/t87vneWBDqbGLAmU3t++TdQ5iQxDQwG2o0eko
 gjQXY9jQnUHERukGyPRUG5BoHrDxz5/kyzdfokeroWBzUoFE7IAw63Hla3mNGEjP58D+prQpE
 NhT4SRZ5zyRMb1wonUGCfXoxP0LW4sxJlEVjfrVN5DF6rzSZ6wt8A1CNJy6SWJSnQ5hE5OtN/
 I+QxHzAFb3Fz9AC4FpXrBbdOeROOAfz4OdFbfxyw/KsvYpgtWNzKD1I5tQtmkEh5zR28cAIOD
 EHelOsx5DV1tT/c4Ufd+sBXEtJX8X0VfT5KsRLYvbs+ib9UNh4wW0PjvWOHA87yXcUPztcglh
 joe5Vv6ZZO2JPpN8yLwGxlgo6v91D4br7FveI4iLGZ/QHf/lRAZvkENEoWto/X9kXeT/SAZ5z
 B9j7ByHW8F0G52Fy/3XwMcJLPTBK4FW9FTH+7a5OGoc8VvDh72lYHfFiRSE4a0mNFdX9nG8+a
 3JWByvufpc15zcE+Ku6u0+RNQwjRm5Iwi1Rh39KudD/zYPQhSgRfasFoB/IfCpHGEqnlajBpr
 ksjj4LkCPr3apXQtEtk7GlUxiPG7zSulC/H6+TXbljfzdE5zutNWtNs6m5oOPRTR0+I8XJMl4
 DKQuCqGSFsflxBX9BdoF88IPwMFXSVjDlymn73zCvJRidp+4IePcei6QtvIH2vQTIRLkdd+LM
 Y7/wlHx4qCHjRsIvrA883YoQCLx+CdrHOGhf33Er+if7ndBvrZv7prMZoTDXvr3QmQvXEZ0KE
 dElLXyh3GokIE8w6o7EfXcqyLGgs4jLyJYxo+rz8MzTQmLQ+lw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-08 at 14:19 -0800, Rohit Jain wrote:
> This patch makes idle_balance more dynamic as the sched_migration_cost
> is now accounted on a sched_domain level. This in turn is done in
> sd_init when we know what the topology relationships are.
> 
> For introduction sakes cost of migration within the same core is set as
> 0, across cores is 50 usec and across sockets is 500 usec. sysctl for
> these variables are introduced in patch 2.
> 
> Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
> ---
>  include/linux/sched/topology.h | 1 +
>  kernel/sched/fair.c            | 6 +++---
>  kernel/sched/topology.c        | 5 +++++
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index cf257c2..bcb4db2 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -104,6 +104,7 @@ struct sched_domain {
>  	u64 max_newidle_lb_cost;
>  	unsigned long next_decay_max_lb_cost;
>  
> +	u64 sched_migration_cost;
>  	u64 avg_scan_cost;		/* select_idle_sibling */
>  
>  #ifdef CONFIG_SCHEDSTATS
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2fe3aa8..61d3508 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8782,8 +8782,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	 */
>  	rq_unpin_lock(this_rq, rf);
>  
> -	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> -	    !this_rq->rd->overload) {
> +	if (!this_rq->rd->overload) {
>  		rcu_read_lock();
>  		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  		if (sd)

Unexplained/unrelated change.

> @@ -8804,7 +8803,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>  		if (!(sd->flags & SD_LOAD_BALANCE))
>  			continue;
>  
> -		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> +		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost +
> +		    sd->sched_migration_cost) {
>  			update_next_balance(sd, &next_balance);
>  			break;
>  		}

Ditto.

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 034cbed..bcd8c64 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1148,12 +1148,14 @@ sd_init(struct sched_domain_topology_level *tl,
>  		sd->flags |= SD_PREFER_SIBLING;
>  		sd->imbalance_pct = 110;
>  		sd->smt_gain = 1178; /* ~15% */
> +		sd->sched_migration_cost = 0;
>  
>  	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
>  		sd->flags |= SD_PREFER_SIBLING;
>  		sd->imbalance_pct = 117;
>  		sd->cache_nice_tries = 1;
>  		sd->busy_idx = 2;
> +		sd->sched_migration_cost = 500000UL;
>  
>  #ifdef CONFIG_NUMA
>  	} else if (sd->flags & SD_NUMA) {
> @@ -1162,6 +1164,7 @@ sd_init(struct sched_domain_topology_level *tl,
>  		sd->idle_idx = 2;
>  
>  		sd->flags |= SD_SERIALIZE;
> +		sd->sched_migration_cost = 5000000UL;

That's not 500us.

	-Mike
