Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AG47ELvqkADE13l+RgcRFpQk0LHAe7oVbQbtXCQBx5K+SamgOBUIxzujcHVhmZBeb7ASBu0CHLYp
ARC-Seal: i=1; a=rsa-sha256; t=1519919542; cv=none;
        d=google.com; s=arc-20160816;
        b=wp9zG3ox5Tzsj/VPEInrYbnFyr6xrWRrFPfwpEA8Qd5/aJFlp46KMRbqjTeukFmXMq
         Na2tqHWxS6apW0qhS/lnfm5FxK9YQf/mdyKBifJHbgk2pZa3dZ5jmZHMDRKBS/QwlGkb
         StFR5ehpDlbZz34P/Am1vZ5QPoEjJeGH4fr/2+rx08JNhhqQEwXItZ3RXjDYYlm7Tk8Q
         wmsr2liTIu+WdkivST0uE0Xih0SLKt28yQAQGCUzuwmRCBBnMj+RSojnh8BlvYCyC/cw
         nABmvz075PadvIFsH/XTrdFVpBBQxQcX8Q6jVV/X/6YVsuYHLMMQS5A5jmGoa+YPYNjQ
         Pwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=MyxSh93fOd8zW4niIgpOcRx3Z8lPekXY1p+5ICtcLjs=;
        b=WlYdtZElHV/HXKuXxde8bPkQYuDdaRLyTqQy6Vijp85XlJPfql2z1mo6CznmfjHrDc
         eZXie9HYV8VlLo2fkCRzTYanx8TVr2OezhEyANh3bnsdhRNuN6vCI5vIt5XHUfk33SRI
         YsMkKo+tHtnMRoGTQlKk0wDWJsi9MGyKy0S2iHiZbPPWOEgeeGDfNuCSM9/au/QFdS2j
         R2kDbhINvEpKBzD0DfZsUdVPZBVXf1Trn23gpk2e7csY98UZ4i0ODZiYK983wpAJ8eZv
         BUZrAn7jhefL5cWDfX7NNm9yPoxSFTDJ1bD8l26xS8lCneoKtWj/JkA1IJyZGyVpdTvo
         Y5og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Thu, 1 Mar 2018 15:52:16 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com, lorenzo.pieralisi@arm.com,
	hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com,
	catalin.marinas@arm.com, gregkh@linuxfoundation.org,
	mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org, ahs3@redhat.com, dietmar.eggemann@arm.com,
	palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com
Subject: Re: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
Message-ID: <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-14-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228220619.6992-14-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684162193428124?=
X-GMAIL-MSGID: =?utf-8?q?1593751154626394317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jeremy,

On Wed, Feb 28, 2018 at 04:06:19PM -0600, Jeremy Linton wrote:
> Now that we have an accurate view of the physical topology
> we need to represent it correctly to the scheduler. In the
> case of NUMA in socket, we need to assure that the sched domain
> we build for the MC layer isn't larger than the DIE above it.

MC shouldn't be larger than any of the NUMA domains either.

> To do this correctly, we should really base that on the cache
> topology immediately below the NUMA node (for NUMA in socket)
> or below the physical package for normal NUMA configurations.

That means we wouldn't support multi-die NUMA nodes?

> This patch creates a set of early cache_siblings masks, then
> when the scheduler requests the coregroup mask we pick the
> smaller of the physical package siblings, or the numa siblings
> and locate the largest cache which is an entire subset of
> those siblings. If we are unable to find a proper subset of
> cores then we retain the original behavior and return the
> core_sibling list.

IIUC, for numa-in-package it is a strict requirement that there is a
cache that span the entire NUMA node? For example, having a NUMA node
consisting of two clusters with per-cluster caches only wouldn't be
supported?

> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/topology.h |  5 +++
>  arch/arm64/kernel/topology.c      | 64 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index 6b10459e6905..08db3e4e44e1 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -4,12 +4,17 @@
>  
>  #include <linux/cpumask.h>
>  
> +#define MAX_CACHE_CHECKS 4
> +
>  struct cpu_topology {
>  	int thread_id;
>  	int core_id;
>  	int package_id;
> +	int cache_id[MAX_CACHE_CHECKS];
>  	cpumask_t thread_sibling;
>  	cpumask_t core_sibling;
> +	cpumask_t cache_siblings[MAX_CACHE_CHECKS];
> +	int cache_level;
>  };
>  
>  extern struct cpu_topology cpu_topology[NR_CPUS];
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index bd1aae438a31..1809dc9d347c 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -212,8 +212,42 @@ static int __init parse_dt_topology(void)
>  struct cpu_topology cpu_topology[NR_CPUS];
>  EXPORT_SYMBOL_GPL(cpu_topology);
>  
> +static void find_llc_topology_for_cpu(int cpu)

Isn't it more find core/node siblings? Or is it a requirement that the
last level cache spans exactly one NUMA node? For example, a package
level cache isn't allowed for numa-in-package?

> +{
> +	/* first determine if we are a NUMA in package */
> +	const cpumask_t *node_mask = cpumask_of_node(cpu_to_node(cpu));
> +	int indx;
> +
> +	if (!cpumask_subset(node_mask, &cpu_topology[cpu].core_sibling)) {
> +		/* not numa in package, lets use the package siblings */
> +		node_mask = &cpu_topology[cpu].core_sibling;
> +	}
> +
> +	/*
> +	 * node_mask should represent the smallest package/numa grouping
> +	 * lets search for the largest cache smaller than the node_mask.
> +	 */
> +	for (indx = 0; indx < MAX_CACHE_CHECKS; indx++) {
> +		cpumask_t *cache_sibs = &cpu_topology[cpu].cache_siblings[indx];
> +
> +		if (cpu_topology[cpu].cache_id[indx] < 0)
> +			continue;
> +
> +		if (cpumask_subset(cache_sibs, node_mask))
> +			cpu_topology[cpu].cache_level = indx;

I don't this guarantees that the cache level we found matches exactly
the NUMA node. Taking the two cluster NUMA node example from above, we
would set cache_level to point at the per-cluster cache as it is a
subset of the NUMA node but it would only span half of the node. Or am I
missing something?

> +	}
> +}
> +
>  const struct cpumask *cpu_coregroup_mask(int cpu)
>  {
> +	int *llc = &cpu_topology[cpu].cache_level;
> +
> +	if (*llc == -1)
> +		find_llc_topology_for_cpu(cpu);
> +
> +	if (*llc != -1)
> +		return &cpu_topology[cpu].cache_siblings[*llc];
> +
>  	return &cpu_topology[cpu].core_sibling;
>  }
>  
> @@ -221,6 +255,7 @@ static void update_siblings_masks(unsigned int cpuid)
>  {
>  	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
>  	int cpu;
> +	int idx;
>  
>  	/* update core and thread sibling masks */
>  	for_each_possible_cpu(cpu) {
> @@ -229,6 +264,16 @@ static void update_siblings_masks(unsigned int cpuid)
>  		if (cpuid_topo->package_id != cpu_topo->package_id)
>  			continue;
>  
> +		for (idx = 0; idx < MAX_CACHE_CHECKS; idx++) {
> +			cpumask_t *lsib;
> +			int cput_id = cpuid_topo->cache_id[idx];
> +
> +			if (cput_id == cpu_topo->cache_id[idx]) {
> +				lsib = &cpuid_topo->cache_siblings[idx];
> +				cpumask_set_cpu(cpu, lsib);
> +			}

Shouldn't the cache_id validity be checked here? I don't think it breaks
anything though.

Overall, I think this is more or less in line with the MC domain
shrinking I just mentioned in the v6 discussion. It is mostly the corner
cases and assumption about the system topology I'm not sure about.

Morten
