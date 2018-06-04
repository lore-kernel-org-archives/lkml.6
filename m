Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeFDMSL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:18:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751933AbeFDMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:18:09 -0400
Date: Mon, 4 Jun 2018 14:18:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/19] sched/numa: Set preferred_node based on best_cpu
Message-ID: <20180604121800.GR12217@hirez.programming.kicks-ass.net>
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
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ea32a66..94091e6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1725,8 +1725,9 @@ static int task_numa_migrate(struct task_struct *p)
>  	 * Tasks that are "trapped" in such domains cannot be migrated
>  	 * elsewhere, so there is no point in (re)trying.
>  	 */
> -	if (unlikely(!sd)) {
> -		p->numa_preferred_nid = task_node(p);
> +	if (unlikely(!sd) && p->numa_preferred_nid != task_node(p)) {
> +		/* Set the new preferred node */
> +		sched_setnuma(p, task_node(p));
>  		return -EINVAL;
>  	}
>  

That looks dodgy.. this would allow things to continue with !sd.
