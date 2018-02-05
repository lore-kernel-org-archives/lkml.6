Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBEWI5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:08:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36752 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBEWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:08:49 -0500
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202171708.GN2269@hirez.programming.kicks-ass.net>
 <93db4b69-5ec6-732f-558e-5e64d9ba0cf9@oracle.com>
 <20180205121947.GW2269@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <930364e4-bbfe-8c8f-d095-0dd4256a5104@oracle.com>
Date: Mon, 5 Feb 2018 14:09:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180205121947.GW2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8796 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802050272
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2018 04:19 AM, Peter Zijlstra wrote:
> On Fri, Feb 02, 2018 at 09:37:02AM -0800, Subhra Mazumdar wrote:
>> In the scheme of SMT balance, if the idle cpu search is done _not_ in the
>> last run core, then we need a random cpu to start from. If the idle cpu
>> search is done in the last run core we can start the search from last run
>> cpu. Since we need the random index for the first case I just did it for
>> both.
> That shouldn't be too hard to fix. I think we can simply transpose the
> CPU number. That is, something like:
>
>    cpu' = core'_id + (cpu - core_id)
>
> should work for most sane cases. We don't give any guarantees this will
> in fact work, but (almost) all actual CPU enumeration schemes I've seen
> this should work for.
>
> And if it doesn't work, we're not worse of than we are now.
>
> I just couldn't readily find a place where we need to do this for cores
> with the current code. But I think we have one place between LLCs where
> it can be done:
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7b6535987500..eb8b8d0a026c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6109,7 +6109,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>   	if (!static_branch_likely(&sched_smt_present))
>   		return -1;
>   
> -	for_each_cpu(cpu, cpu_smt_mask(target)) {
> +	for_each_cpu_wrap(cpu, cpu_smt_mask(target), target) {
>   		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>   			continue;
>   		if (idle_cpu(cpu))
> @@ -6357,8 +6357,17 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>   		if (cpu == prev_cpu)
>   			goto pick_cpu;
>   
> -		if (wake_affine(affine_sd, p, prev_cpu, sync))
> -			new_cpu = cpu;
> +		if (wake_affine(affine_sd, p, prev_cpu, sync)) {
> +			/*
> +			 * Transpose prev_cpu's offset into this cpu's
> +			 * LLC domain to retain the 'random' search offset
> +			 * for for_each_cpu_wrap().
> +			 */
> +			new_cpu = per_cpu(sd_llc_id, cpu) +
> +				  (prev_cpu - per_cpu(sd_llc_id, prev_cpu));
> +			if (unlikely(!cpus_share_cache(new_cpu, cpu)))
> +				new_cpu = cpu;
> +		}
>   	}
>   
>   	if (sd && !(sd_flag & SD_BALANCE_FORK)) {
The pseudo random is also used for choosing a random core to compare 
with, how will transposing achieve that?

Thanks,
Subhra
