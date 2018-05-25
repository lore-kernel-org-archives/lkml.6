Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966422AbeEYLfi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:35:38 -0400
Received: from foss.arm.com ([217.140.101.70]:60414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966235AbeEYLfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:35:37 -0400
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] kernel/sched/topology: Clarify root domain(s) debug
 string
To: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
References: <20180524152936.17611-1-juri.lelli@redhat.com>
Message-ID: <ba17ff9c-d687-2099-eec5-211fd195efd0@arm.com>
Date: Fri, 25 May 2018 13:35:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524152936.17611-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 05:29 PM, Juri Lelli wrote:
> When scheduler debug is enabled, building scheduling domains outputs
> information about how the domains are laid out and to which root domain
> each CPU (or sets of CPUs) belongs, e.g.:
> 
>   CPU0 attaching sched-domain(s):
>    domain-0: span=0-5 level=MC
>     groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
>   CPU1 attaching sched-domain(s):
>    domain-0: span=0-5 level=MC
>     groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }
> 
>   [...]
> 
>   span: 0-5 (max cpu_capacity = 1024)
> 
> The fact that latest line refers to CPUs 0-5 root domain doesn't however look
> immediately obvious to me: one might wonder why span 0-5 is reported "again".
> 
> Make it more clear by adding "root domain" to it, as to end with the
> following.
> 
>   CPU0 attaching sched-domain(s):
>    domain-0: span=0-5 level=MC
>     groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
>   CPU1 attaching sched-domain(s):
>    domain-0: span=0-5 level=MC
>     groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }
> 
>   [...]
> 
>   root domain span: 0-5 (max cpu_capacity = 1024)
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>   kernel/sched/topology.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 64cc564f5255..61a1125c1ae4 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1708,7 +1708,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>   	rcu_read_unlock();
>   
>   	if (rq && sched_debug_enabled) {
> -		pr_info("span: %*pbl (max cpu_capacity = %lu)\n",
> +		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
>   			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
>   	}
>   
> 

Looks good to me. Probably especially helpful when setting up exclusive 
cpusets.

Juno with big and little exclusive cpuset:

...
[  124.231333] CPU1 attaching sched-domain(s):
[  124.235482]  domain-0: span=1-2 level=MC
[  124.239382]   groups: 1:{ span=1 }, 2:{ span=2 }
[  124.243969] CPU2 attaching sched-domain(s):
[  124.248112]  domain-0: span=1-2 level=MC
[  124.251998]   groups: 2:{ span=2 }, 1:{ span=1 }
[  124.256585] root domain span: 1-2 (max cpu_capacity = 1024)
[  124.262150] CPU0 attaching sched-domain(s):
[  124.266307]  domain-0: span=0,3-5 level=MC
[  124.270366]   groups: 0:{ span=0 cap=446 }, 3:{ span=3 cap=446 }, 4:{ 
span=4 cap=446 }, 5:{ span=5 cap=446 }
[  124.280131] CPU3 attaching sched-domain(s):
[  124.284273]  domain-0: span=0,3-5 level=MC
[  124.288334]   groups: 3:{ span=3 cap=446 }, 4:{ span=4 cap=446 }, 5:{ 
span=5 cap=446 }, 0:{ span=0 cap=446 }
[  124.298096] CPU4 attaching sched-domain(s):
[  124.302239]  domain-0: span=0,3-5 level=MC
[  124.306298]   groups: 4:{ span=4 cap=446 }, 5:{ span=5 cap=446 }, 0:{ 
span=0 cap=446 }, 3:{ span=3 cap=446 }
[  124.316063] CPU5 attaching sched-domain(s):
[  124.320205]  domain-0: span=0,3-5 level=MC
[  124.324265]   groups: 5:{ span=5 cap=446 }, 0:{ span=0 cap=446 }, 3:{ 
span=3 cap=446 }, 4:{ span=4 cap=446 }
[  124.334031] root domain span: 0,3-5 (max cpu_capacity = 446)
