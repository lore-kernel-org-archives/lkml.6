Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeBBOfc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:35:32 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34016 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBBOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:35:26 -0500
X-Google-Smtp-Source: AH8x224MHzHeWuvOpzFJsVDN2sT41zv9pylk5aHtRU/UJ5gPi7/qm/cZ8jo4cFFmOYOYuD0Qp28GPg==
Date: Fri, 2 Feb 2018 15:35:21 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, lizefan@huawei.com, mingo@redhat.com,
        rostedt@goodmis.org, claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, luca.abeni@santannapisa.it,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/7] sched/deadline: Keep new DL task within root
 domain's boundary
Message-ID: <20180202143521.GU19535@localhost.localdomain>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
 <1517503869-3179-4-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517503869-3179-4-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 01/02/18 09:51, Mathieu Poirier wrote:
> When considering to move a task to the DL policy we need to make sure
> the CPUs it is allowed to run on matches the CPUs of the root domains of
> the runqueue it is currently assigned to.  Otherwise the task will be
> allowed to roam on CPUs outside of this root domain, something that will
> skew system deadline statistics and potentially lead to over selling DL
> bandwidth.
> 
> For example say we have a 4 core system split in 2 cpuset: set1 has CPU 0
> and 1 while set2 has CPU 2 and 3.  This results in 3 cpuset - the default
> set that has all 4 CPUs along with set1 and set2 as just depicted.  We also
> have task A that hasn't been assigned to any CPUset and as such, is part of
> the default CPUset.
> 
> At the time we want to move task A to a DL policy it has been assigned to
> CPU1.  Since CPU1 is part of set1 the root domain will have 2 CPUs in it
> and the bandwidth constraint checked against the current DL bandwidth
> allotment of those 2 CPUs.

Wait.. I'm confused. :)

Do you disabled cpuset.sched_load_balance in the root (default) cpuset?
If yes, we would end up with 2 root domains and if task A happens to be
on root domain (0-1) checking its admission against 2 CPUs looks like
the right thing to do to me. If no, then there is a single root domain
(the root/deafult one) with 4 CPUs, and it indeed seems that we've
probably got a problem: it is possible for a DEADLINE task running on
root/default cpuset to be put in (for example) 0-1 cpuset, and so
restrict its affinity. Is it this that this patch cures?

Anyway, see more comments below..

[...]

>  	/*
> +	 * If setscheduling to SCHED_DEADLINE we need to make sure the task
> +	 * is constrained to run within the root domain it is associated with,
> +	 * something that isn't guaranteed when using cpusets.
> +	 *
> +	 * Speaking of cpusets, we also need to assert that a task's
> +	 * cpus_allowed mask equals its cpuset's cpus_allowed mask. Otherwise
> +	 * a DL task could be assigned to a cpuset that has more CPUs than the
> +	 * root domain it is associated with, a situation that yields no
> +	 * benefits and greatly complicate the management of DL task when
> +	 * cpusets are present.
> +	 */
> +	if (dl_policy(policy)) {
> +		struct root_domain *rd = cpu_rq(task_cpu(p))->rd;

I fear root_domain doesn't exist on UP.

Maybe this logic can be put above changing the check we already do
against the span?

https://elixir.free-electrons.com/linux/latest/source/kernel/sched/core.c#L4174

Best,

- Juri
