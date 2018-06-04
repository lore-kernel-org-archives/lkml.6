Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeFDMXn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:23:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeFDMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:23:42 -0400
Date: Mon, 4 Jun 2018 14:23:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/19] sched/numa: Set preferred_node based on best_cpu
Message-ID: <20180604122336.GS12217@hirez.programming.kicks-ass.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-5-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528106428-19992-5-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:30:13PM +0530, Srikar Dronamraju wrote:
> @@ -1785,15 +1786,13 @@ static int task_numa_migrate(struct task_struct *p)
>  	 * trying for a better one later. Do not set the preferred node here.
>  	 */
>  	if (p->numa_group) {
> -		struct numa_group *ng = p->numa_group;
> -
>  		if (env.best_cpu == -1)
>  			nid = env.src_nid;
>  		else
> -			nid = env.dst_nid;
> +			nid = cpu_to_node(env.best_cpu);

OK, the above matches the description, but I'm puzzled by the remainder:

>  
> -		if (ng->active_nodes > 1 && numa_is_active_node(env.dst_nid, ng))
> -			sched_setnuma(p, env.dst_nid);
> +		if (nid != p->numa_preferred_nid)
> +			sched_setnuma(p, nid);
>  	}

That seems to entirely loose the active_node thing, or are you saying
best_cpu already includes that? (Changelog could use a little help there
I suppose)
