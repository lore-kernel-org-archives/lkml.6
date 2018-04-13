Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbeDMIkd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:40:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeDMIka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:40:30 -0400
Date: Fri, 13 Apr 2018 10:40:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Message-ID: <20180413084019.GQ4043@hirez.programming.kicks-ass.net>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409165615.2326-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> +static inline void init_uclamp(void)

WTH is that inline?

> +{
> +	struct uclamp_cpu *uc_cpu;
> +	int clamp_id;
> +	int cpu;
> +
> +	mutex_init(&uclamp_mutex);
> +
> +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +		/* Init CPU's clamp groups */
> +		for_each_possible_cpu(cpu) {
> +			uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
> +			memset(uc_cpu, UCLAMP_NONE, sizeof(struct uclamp_cpu));
> +		}
> +	}

Those loops are the wrong way around, this shreds your cache. This is a
slow path so it doesn't much matter, but it is sloppy.

> +}
