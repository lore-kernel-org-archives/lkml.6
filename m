Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933934AbeEILDg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:03:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeEILDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:03:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1787360C66
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vinmenon@codeaurora.org
Subject: Re: [PATCH 6/7] psi: pressure stall information for CPU, memory, and
 IO
To: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>, Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>, Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-7-hannes@cmpxchg.org>
From: Vinayak Menon <vinmenon@codeaurora.org>
Message-ID: <87060553-2e09-2e2a-13a2-a91345d6df30@codeaurora.org>
Date: Wed, 9 May 2018 16:33:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507210135.1823-7-hannes@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/8/2018 2:31 AM, Johannes Weiner wrote:
> +static void psi_group_update(struct psi_group *group, int cpu, u64 now,
> +			     unsigned int clear, unsigned int set)
> +{
> +	enum psi_state state = PSI_NONE;
> +	struct psi_group_cpu *groupc;
> +	unsigned int *tasks;
> +	unsigned int to, bo;
> +
> +	groupc = per_cpu_ptr(group->cpus, cpu);
> +	tasks = groupc->tasks;
> +
> +	/* Update task counts according to the set/clear bitmasks */
> +	for (to = 0; (bo = ffs(clear)); to += bo, clear >>= bo) {
> +		int idx = to + (bo - 1);
> +
> +		if (tasks[idx] == 0 && !psi_bug) {
> +			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d idx=%d tasks=[%u %u %u %u]\n",
> +					cpu, idx, tasks[0], tasks[1],
> +					tasks[2], tasks[3]);
> +			psi_bug = 1;
> +		}
> +		tasks[idx]--;
> +	}
> +	for (to = 0; (bo = ffs(set)); to += bo, set >>= bo)
> +		tasks[to + (bo - 1)]++;
> +
> +	/* Time in which tasks wait for the CPU */
> +	state = PSI_NONE;
> +	if (tasks[NR_RUNNING] > 1)
> +		state = PSI_SOME;
> +	time_state(&groupc->res[PSI_CPU], state, now);
> +
> +	/* Time in which tasks wait for memory */
> +	state = PSI_NONE;
> +	if (tasks[NR_MEMSTALL]) {
> +		if (!tasks[NR_RUNNING] ||
> +		    (cpu_curr(cpu)->flags & PF_MEMSTALL))
> +			state = PSI_FULL;
> +		else
> +			state = PSI_SOME;
> +	}
> +	time_state(&groupc->res[PSI_MEM], state, now);
> +
> +	/* Time in which tasks wait for IO */
> +	state = PSI_NONE;
> +	if (tasks[NR_IOWAIT]) {
> +		if (!tasks[NR_RUNNING])
> +			state = PSI_FULL;
> +		else
> +			state = PSI_SOME;
> +	}
> +	time_state(&groupc->res[PSI_IO], state, now);
> +
> +	/* Time in which tasks are non-idle, to weigh the CPU in summaries */
> +	if (groupc->nonidle)
> +		groupc->nonidle_time += now - groupc->nonidle_start;
> +	groupc->nonidle = tasks[NR_RUNNING] ||
> +		tasks[NR_IOWAIT] || tasks[NR_MEMSTALL];
> +	if (groupc->nonidle)
> +		groupc->nonidle_start = now;
> +
> +	/* Kick the stats aggregation worker if it's gone to sleep */
> +	if (!delayed_work_pending(&group->clock_work))

This causes a crash when the work is scheduled before system_wq is up. In my case when the first
schedule was called from kthreadd. And I had to do this to make it work.
if (keventd_up() && !delayed_work_pending(&group->clock_work))

> +		schedule_delayed_work(&group->clock_work, MY_LOAD_FREQ);
> +}
> +
> +void psi_task_change(struct task_struct *task, u64 now, int clear, int set)
> +{
> +	struct cgroup *cgroup, *parent;

unused variables

Thanks,
Vinayak
