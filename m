Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E7920875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E7920875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbeGWO1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:27:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33872 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387968AbeGWO1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:27:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF404ED1;
        Mon, 23 Jul 2018 06:25:45 -0700 (PDT)
Received: from [10.4.12.120] (e107158-lin.emea.arm.com [10.4.12.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67B843F73C;
        Mon, 23 Jul 2018 06:25:44 -0700 (PDT)
Subject: Re: [PATCH 1/4] sched/topology: SD_ASYM_CPUCAPACITY flag detection
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
 <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
From:   Qais Yousef <qais.yousef@arm.com>
Message-ID: <dbd8deec-a79d-5697-0c50-ea1a9ab7e5c9@arm.com>
Date:   Mon, 23 Jul 2018 14:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morten

On 20/07/18 14:32, Morten Rasmussen wrote:
> The SD_ASYM_CPUCAPACITY sched_domain flag is supposed to mark the
> sched_domain in the hierarchy where all cpu capacities are visible for
> any cpu's point of view on asymmetric cpu capacity systems. The
> scheduler can then take to take capacity asymmetry into account when

Did you mean "s/take to take/try to take/"?

> balancing at this level. It also serves as an indicator for how wide
> task placement heuristics have to search to consider all available cpu
> capacities as asymmetric systems might often appear symmetric at
> smallest level(s) of the sched_domain hierarchy.
>
> The flag has been around for while but so far only been set by
> out-of-tree code in Android kernels. One solution is to let each
> architecture provide the flag through a custom sched_domain topology
> array and associated mask and flag functions. However,
> SD_ASYM_CPUCAPACITY is special in the sense that it depends on the
> capacity and presence of all cpus in the system, i.e. when hotplugging
> all cpus out except those with one particular cpu capacity the flag
> should disappear even if the sched_domains don't collapse. Similarly,
> the flag is affected by cpusets where load-balancing is turned off.
> Detecting when the flags should be set therefore depends not only on
> topology information but also the cpuset configuration and hotplug
> state. The arch code doesn't have easy access to the cpuset
> configuration.
>
> Instead, this patch implements the flag detection in generic code where
> cpusets and hotplug state is already taken care of. All the arch is
> responsible for is to implement arch_scale_cpu_capacity() and force a
> full rebuild of the sched_domain hierarchy if capacities are updated,
> e.g. later in the boot process when cpufreq has initialized.
>
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
>
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---
>   include/linux/sched/topology.h |  2 +-
>   kernel/sched/topology.c        | 81 ++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 76 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 26347741ba50..4fe2e49ab13b 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -23,7 +23,7 @@
>   #define SD_BALANCE_FORK		0x0008	/* Balance on fork, clone */
>   #define SD_BALANCE_WAKE		0x0010  /* Balance on wakeup */
>   #define SD_WAKE_AFFINE		0x0020	/* Wake task to waking CPU */
> -#define SD_ASYM_CPUCAPACITY	0x0040  /* Groups have different max cpu capacities */
> +#define SD_ASYM_CPUCAPACITY	0x0040  /* Domain members have different cpu capacities */
>   #define SD_SHARE_CPUCAPACITY	0x0080	/* Domain members share cpu capacity */
>   #define SD_SHARE_POWERDOMAIN	0x0100	/* Domain members share power domain */
>   #define SD_SHARE_PKG_RESOURCES	0x0200	/* Domain members share cpu pkg resources */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05a831427bc7..b8f41d557612 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1061,7 +1061,6 @@ static struct cpumask		***sched_domains_numa_masks;
>    *   SD_SHARE_PKG_RESOURCES - describes shared caches
>    *   SD_NUMA                - describes NUMA topologies
>    *   SD_SHARE_POWERDOMAIN   - describes shared power domain
> - *   SD_ASYM_CPUCAPACITY    - describes mixed capacity topologies
>    *
>    * Odd one out, which beside describing the topology has a quirk also
>    * prescribes the desired behaviour that goes along with it:
> @@ -1073,13 +1072,12 @@ static struct cpumask		***sched_domains_numa_masks;
>   	 SD_SHARE_PKG_RESOURCES |	\
>   	 SD_NUMA		|	\
>   	 SD_ASYM_PACKING	|	\
> -	 SD_ASYM_CPUCAPACITY	|	\
>   	 SD_SHARE_POWERDOMAIN)
>   
>   static struct sched_domain *
>   sd_init(struct sched_domain_topology_level *tl,
>   	const struct cpumask *cpu_map,
> -	struct sched_domain *child, int cpu)
> +	struct sched_domain *child, int dflags, int cpu)
>   {
>   	struct sd_data *sdd = &tl->data;
>   	struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
> @@ -1100,6 +1098,9 @@ sd_init(struct sched_domain_topology_level *tl,
>   			"wrong sd_flags in topology description\n"))
>   		sd_flags &= ~TOPOLOGY_SD_FLAGS;
>   
> +	/* Apply detected topology flags */
> +	sd_flags |= dflags;
> +
>   	*sd = (struct sched_domain){
>   		.min_interval		= sd_weight,
>   		.max_interval		= 2*sd_weight,
> @@ -1607,9 +1608,9 @@ static void __sdt_free(const struct cpumask *cpu_map)
>   
>   static struct sched_domain *build_sched_domain(struct sched_domain_topology_level *tl,
>   		const struct cpumask *cpu_map, struct sched_domain_attr *attr,
> -		struct sched_domain *child, int cpu)
> +		struct sched_domain *child, int dflags, int cpu)
>   {
> -	struct sched_domain *sd = sd_init(tl, cpu_map, child, cpu);
> +	struct sched_domain *sd = sd_init(tl, cpu_map, child, dflags, cpu);
>   
>   	if (child) {
>   		sd->level = child->level + 1;
> @@ -1636,6 +1637,65 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>   }
>   
>   /*
> + * Find the sched_domain_topology_level where all cpu capacities are visible
> + * for all cpus.
> + */
> +static struct sched_domain_topology_level
> +*asym_cpu_capacity_level(const struct cpumask *cpu_map)
> +{
> +	int i, j, asym_level = 0;
> +	bool asym = false;
> +	struct sched_domain_topology_level *tl, *asym_tl = NULL;
> +	unsigned long cap;
> +
> +	/* Is there any asymmetry? */
> +	cap = arch_scale_cpu_capacity(NULL, cpumask_first(cpu_map));
> +
> +	for_each_cpu(i, cpu_map) {
> +		if (arch_scale_cpu_capacity(NULL, i) != cap) {
> +			asym = true;
> +			break;
> +		}
> +	}
> +
> +	if (!asym)
> +		return NULL;
> +
> +	/*
> +	 * Examine topology from all cpu's point of views to detect the lowest
> +	 * sched_domain_topology_level where a highest capacity cpu is visible
> +	 * to everyone.
> +	 */
> +	for_each_cpu(i, cpu_map) {
> +		unsigned long max_capacity = arch_scale_cpu_capacity(NULL, i);
> +		int tl_id = 0;
> +
> +		for_each_sd_topology(tl) {
> +			if (tl_id < asym_level)
> +				goto next_level;
> +

I think if you increment and then continue here you might save the extra 
branch. I didn't look at any disassembly though to verify the generated 
code.

I wonder if we can introduce for_each_sd_topology_from(tl, 
starting_level) so that you can start searching from a provided level - 
which will make this skipping logic unnecessary? So the code will look like

             for_each_sd_topology_from(tl, asymc_level) {
                 ...
             }

> +			for_each_cpu_and(j, tl->mask(i), cpu_map) {
> +				unsigned long capacity;
> +
> +				capacity = arch_scale_cpu_capacity(NULL, j);
> +
> +				if (capacity <= max_capacity)
> +					continue;
> +
> +				max_capacity = capacity;
> +				asym_level = tl_id;
> +				asym_tl = tl;
> +			}
> +next_level:
> +			tl_id++;
> +		}
> +	}
> +
> +	return asym_tl;
> +}
> +
> +
> +/*
>    * Build sched domains for a given set of CPUs and attach the sched domains
>    * to the individual CPUs
>    */
> @@ -1647,18 +1707,27 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>   	struct s_data d;
>   	struct rq *rq = NULL;
>   	int i, ret = -ENOMEM;
> +	struct sched_domain_topology_level *tl_asym;
>   
>   	alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
>   	if (alloc_state != sa_rootdomain)
>   		goto error;
>   
> +	tl_asym = asym_cpu_capacity_level(cpu_map);
> +

Or maybe this is not a hot path and we don't care that much about 
optimizing the search since you call it unconditionally here even for 
systems that don't care?

>   	/* Set up domains for CPUs specified by the cpu_map: */
>   	for_each_cpu(i, cpu_map) {
>   		struct sched_domain_topology_level *tl;
>   
>   		sd = NULL;
>   		for_each_sd_topology(tl) {
> -			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
> +			int dflags = 0;
> +
> +			if (tl == tl_asym)
> +				dflags |= SD_ASYM_CPUCAPACITY;
> +
> +			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
> +
>   			if (tl == sched_domain_topology)
>   				*per_cpu_ptr(d.sd, i) = sd;
>   			if (tl->flags & SDTL_OVERLAP)


-- 
Qais Yousef

