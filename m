Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032248AbeBPNrL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:47:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032212AbeBPNrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:47:09 -0500
Date: Fri, 16 Feb 2018 14:47:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] sched: Add static_key for asymmetric cpu capacity
 optimizations
Message-ID: <20180216134704.GE25201@hirez.programming.kicks-ass.net>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-2-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518711654-23503-2-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:20:48PM +0000, Morten Rasmussen wrote:
> +static void update_asym_cpucapacity(int cpu)
> +{
> +	if (!static_branch_unlikely(&sched_asym_cpucapacity) &&
> +	    lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
> +		static_branch_enable(&sched_asym_cpucapacity);
> +}

That looks odd, why not just:

	if (lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
		static_branch_enable(&sched_asym_cpucapacity);

? possibly with:

	else
		static_branch_disable(&sched_asym_cpucapacity);

if you want to play funny games :-)
