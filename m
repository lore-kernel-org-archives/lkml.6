Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966004AbeEYKuq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:50:46 -0400
Received: from ozlabs.org ([203.11.71.1]:53823 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965554AbeEYKup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:50:45 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, ego@linux.vnet.ibm.com,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv : init all present cpus for deep states
In-Reply-To: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 20:50:43 +1000
Message-ID: <87fu2gqa9o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:

> Init all present cpus for deep states instead of "all possible" cpus.
> Init fails if the possible cpu is gaurded. Resulting in making only
> non-deep states available for cpuidle/hotplug.

This is basically the opposite of what we just did for IMC.

There we switched from present to possible, to make it work when some
CPUs are guarded.

Which makes me think we need a better way of dealing with guarded CPUs,
because working out which code should use present or possible seems to
be basically trial-and-error.

I'm not actually sure why Guarded CPUs are showing up as possible but
not present, did we do that on purpose or is it just happening by
accident?

I can merge this, but we need to make this less bug prone in future.

cheers

> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 1f12ab1..1c5d067 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -79,7 +79,7 @@ static int pnv_save_sprs_for_deep_states(void)
>  	uint64_t msr_val = MSR_IDLE;
>  	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		uint64_t pir = get_hard_smp_processor_id(cpu);
>  		uint64_t hsprg0_val = (uint64_t)paca_ptrs[cpu];
>  
> @@ -814,7 +814,7 @@ static int __init pnv_init_idle_states(void)
>  		int cpu;
>  
>  		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
> -		for_each_possible_cpu(cpu) {
> +		for_each_present_cpu(cpu) {
>  			int base_cpu = cpu_first_thread_sibling(cpu);
>  			int idx = cpu_thread_in_core(cpu);
>  			int i;
> -- 
> 2.5.5
