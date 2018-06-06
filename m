Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C1DD601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeFFKFq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:05:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752343AbeFFKFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:05:43 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, Will.Deacon@arm.com,
        Catalin.Marinas@arm.com, Robin.Murphy@arm.com,
        Morten.Rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-acpi@vger.kernel.org, ard.biesheuvel@linaro.org
Subject: Re: [PATCH] arm64: topology: Avoid checking numa mask for scheduler
 MC selection
To: Jeremy Linton <jeremy.linton@arm.com>
References: <20180605190837.493505-1-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <3c8a541d-78a1-389a-112c-494f7c1a543d@arm.com>
Date: Wed, 6 Jun 2018 11:05:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605190837.493505-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/18 20:08, Jeremy Linton wrote:
> The numa mask subset check has problems if !CONFIG_NUMA, over hotplug
> operations or during early boot. Lets disable the NUMA siblings checks
> for the time being, as NUMA in socket machines have LLC's that will
> assure that the scheduler topology isn't "borken".
> 

^ broken ? (not sure if usage of borken is intentional :))

> Futher, as a defensive mechanism during hotplug, lets assure that the

^ Further

> LLC siblings are also masked.
>

Also add the symptoms of the issue we say as Geert suggested me.
Something like:
" This often leads to system hang or crash during CPU hotplug and system
suspend operation. This is mostly observed on HMP systems where the
CPU compute capacities are different and ends up in different scheduler
domains. Since cpumask_of_node is returned instead core_sibling, the
scheduler is confused with incorrect cpumasks(e.g. one CPU in two
different sched domains at the same time) on CPU hotplug."

You can add Reported-by: Geert... ?

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/topology.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 7415c166281f..f845a8617812 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -215,13 +215,8 @@ EXPORT_SYMBOL_GPL(cpu_topology);
>  
>  const struct cpumask *cpu_coregroup_mask(int cpu)
>  {
> -	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
> +	const cpumask_t *core_mask = &cpu_topology[cpu].core_sibling;
>  
> -	/* Find the smaller of NUMA, core or LLC siblings */
> -	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
> -		/* not numa in package, lets use the package siblings */
> -		core_mask = &cpu_topology[cpu].core_sibling;
> -	}
>  	if (cpu_topology[cpu].llc_id != -1) {
>  		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
>  			core_mask = &cpu_topology[cpu].llc_siblings;
> @@ -239,8 +234,10 @@ static void update_siblings_masks(unsigned int cpuid)
>  	for_each_possible_cpu(cpu) {
>  		cpu_topo = &cpu_topology[cpu];
>  
> -		if (cpuid_topo->llc_id == cpu_topo->llc_id)
> +		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
>  			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
> +			cpumask_set_cpu(cpuid, &cpu_topo->llc_siblings);
> +		}
>  
>  		if (cpuid_topo->package_id != cpu_topo->package_id)
>  			continue;
> 

Looks good to me for now. I might need to tweek it a bit when I add the
support to update topology on hotplug. But that's for latter. For now,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
