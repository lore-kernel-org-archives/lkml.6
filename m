Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933744AbeBLKpq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:45:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43784 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeBLKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:45:44 -0500
Date: Mon, 12 Feb 2018 11:45:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@foss.arm.com,
        brendan.jackman@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180212104537.GH25181@hirez.programming.kicks-ass.net>
References: <1518422874-13216-1-git-send-email-vincent.guittot@linaro.org>
 <1518422874-13216-2-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518422874-13216-2-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 09:07:52AM +0100, Vincent Guittot wrote:
> @@ -9383,11 +9450,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  		 * work being done for other cpus. Next load
>  		 * balancing owner will pick it up.
>  		 */
> -		if (need_resched())
> -			break;
> +		if (need_resched()) {
> +			has_blocked_load = true;
> +			goto abort;
> +		}
>  
>  		rq = cpu_rq(balance_cpu);
>  
> +		update_blocked_averages(rq->cpu);

Does that want to be update_nohz_stats() ?

> +		has_blocked_load |= rq->has_blocked_load;
> +
>  		/*
>  		 * If time for next balance is due,
>  		 * do the balance.
