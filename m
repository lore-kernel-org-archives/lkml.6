Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933247AbeDXMyA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:54:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933168AbeDXMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:53:54 -0400
Date: Tue, 24 Apr 2018 14:53:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: subhra mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
Subject: Re: [PATCH 3/3] sched: limit cpu search and rotate search window for
 scalability
Message-ID: <20180424125349.GU4082@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-4-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424004116.28151-4-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:41:16PM -0700, subhra mazumdar wrote:
> Lower the lower limit of idle cpu search in select_idle_cpu() and also put
> an upper limit. This helps in scalability of the search by restricting the
> search window. 

> @@ -6297,15 +6297,24 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  
>  	if (sched_feat(SIS_PROP)) {
>  		u64 span_avg = sd->span_weight * avg_idle;
> -		if (span_avg > 4*avg_cost)
> +		if (span_avg > 2*avg_cost) {
>  			nr = div_u64(span_avg, avg_cost);
> -		else
> -			nr = 4;
> +			if (nr > 4)
> +				nr = 4;
> +		} else {
> +			nr = 2;
> +		}
>  	}

Why do you need to put a max on? Why isn't the proportional thing
working as is? (is the average no good because of big variance or what)

Again, why do you need to lower the min; what's wrong with 4?

The reason I picked 4 is that many laptops have 4 CPUs and desktops
really want to avoid queueing if at all possible.
