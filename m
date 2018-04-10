Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeDJTh2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:37:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbeDJTh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:37:27 -0400
Date: Tue, 10 Apr 2018 21:37:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2] cpufreq/schedutil: Cleanup, document and fix iowait
 boost
Message-ID: <20180410193708.GE4043@hirez.programming.kicks-ass.net>
References: <20180410155931.31973-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410155931.31973-1-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 04:59:31PM +0100, Patrick Bellasi wrote:
> The iowait boosting code has been recently updated to add a progressive
> boosting behavior which allows to be less aggressive in boosting tasks
> doing only sporadic IO operations, thus being more energy efficient for
> example on mobile platforms.
> 
> The current code is now however a bit convoluted. Some functionalities
> (e.g. iowait boost reset) are replicated in different paths and their
> documentation is slightly misaligned.

While your patch does seem to improve things, it still has duplicated
bits in. Eg. the TICK_NSEC clearing exists in both functions.

> - sugov_set_iowait_boost: is now in charge only to set/increase the IO
>      wait boost, every time a task wakes up from an IO wait.
> 
> - sugov_iowait_boost: is now in charge to reset/reduce the IO wait
>      boost, every time a sugov update is triggered, as well as
>      to (eventually) enforce the currently required IO boost value.

I'm not sold on those function names; feels like we can do better,
although I'm struggling to come up with anything sensible just now.


>  
>  		if (delta_ns > TICK_NSEC) {
> +			sg_cpu->iowait_boost = iowait
> +				? sg_cpu->sg_policy->policy->min : 0;
> +			sg_cpu->iowait_boost_pending = iowait;
> +			return;
>  		}

> +	if (delta_ns > TICK_NSEC) {
> +		sg_cpu->iowait_boost = 0;
> +		sg_cpu->iowait_boost_pending = false;
> +		return;
> +	}

Looks like something we can maybe put in a helper or something.
