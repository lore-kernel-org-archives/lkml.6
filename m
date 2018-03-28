Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeC1JMS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 05:12:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38550 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbeC1JMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 05:12:16 -0400
Date: Wed, 28 Mar 2018 10:12:26 +0100
From: Will Deacon <will.deacon@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH] sched: support dynamiQ cluster
Message-ID: <20180328091226.GD28871@arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 09:46:55AM +0200, Vincent Guittot wrote:
> Arm DynamiQ system can integrate cores with different micro architecture
> or max OPP under the same DSU so we can have cores with different compute
> capacity at the LLC (which was not the case with legacy big/LITTLE
> architecture). Such configuration is similar in some way to ITMT on intel
> platform which allows some cores to be boosted to higher turbo frequency
> than others and which uses SD_ASYM_PACKING feature to ensures that CPUs with
> highest capacity, will always be used in priortiy in order to provide
> maximum throughput.
> 
> Add arch_asym_cpu_priority() for arm64 as this function is used to
> differentiate CPUs in the scheduler. The CPU's capacity is used to order
> CPUs in the same DSU.
> 
> Create sched domain topolgy level for arm64 so we can set SD_ASYM_PACKING
> at MC level.
> 
> Some tests have been done on a hikey960 platform (quad cortex-A53,
> quad cortex-A73). For the test purpose, the CPUs topology of the hikey960
> has been modified so the 8 heterogeneous cores are described as being part
> of the same cluster and sharing resources (MC level) like with a DynamiQ DSU.
> 
> Results below show the time in seconds to run sysbench --test=cpu with an
> increasing number of threads. The sysbench test run 32 times
> 
>              without patch     with patch    diff
> 1 threads    11.04(+/- 30%)    8.86(+/- 0%)  -19%
> 2 threads     5.59(+/- 14%)    4.43(+/- 0%)  -20%
> 3 threads     3.80(+/- 13%)    2.95(+/- 0%)  -22%
> 4 threads     3.10(+/- 12%)    2.22(+/- 0%)  -28%
> 5 threads     2.47(+/-  5%)    1.95(+/- 0%)  -21%
> 6 threads     2.09(+/-  0%)    1.73(+/- 0%)  -17%
> 7 threads     1.64(+/-  0%)    1.56(+/- 0%)  - 7%
> 8 threads     1.42(+/-  0%)    1.42(+/- 0%)    0%
> 
> Results show a better and stable results across iteration with the patch
> compared to mainline because we are always using big cores in priority whereas
> with mainline, the scheduler randomly choose a big or a little cores when
> there are more cores than number of threads.
> With 1 thread, the test duration varies in the range [8.85 .. 15.86] for
> mainline whereas it stays in the range [8.85..8.87] with the patch
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> ---
> 
> The SD_ASYM_PACKING flag is disabled by default and I'm preparing another patch
> to enable this dynamically at boot time by detecting the system topology.
> 
>  arch/arm64/kernel/topology.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 2186853..cb6705e5 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -296,6 +296,33 @@ static void __init reset_cpu_topology(void)
>  	}
>  }
>  
> +#ifdef CONFIG_SCHED_MC
> +unsigned int __read_mostly arm64_sched_asym_enabled;
> +
> +int arch_asym_cpu_priority(int cpu)
> +{
> +	return topology_get_cpu_scale(NULL, cpu);
> +}
> +
> +static inline int arm64_sched_dynamiq(void)
> +{
> +	return arm64_sched_asym_enabled ? SD_ASYM_PACKING : 0;
> +}
> +
> +static int arm64_core_flags(void)
> +{
> +	return cpu_core_flags() | arm64_sched_dynamiq();
> +}
> +#endif
> +
> +static struct sched_domain_topology_level arm64_topology[] = {
> +#ifdef CONFIG_SCHED_MC
> +	{ cpu_coregroup_mask, arm64_core_flags, SD_INIT_NAME(MC) },

Maybe stick this in a macro to avoid the double #ifdef?

Will
