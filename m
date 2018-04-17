Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeDQI2j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:28:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:44636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeDQI2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:28:37 -0400
Date: Tue, 17 Apr 2018 10:28:15 +0200
From: Borislav Petkov <bp@suse.de>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH 4/4] x86/CPU/AMD: Calculate LLC ID from number of sharing
 threads
Message-ID: <20180417082814.GB18808@pd.tnic>
References: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1522046116-22578-5-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522046116-22578-5-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 01:35:16AM -0500, Suravee Suthikulpanit wrote:
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 54d04d5..67f4790 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -637,6 +637,43 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
>  	return i;
>  }
>  
> +void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
> +{
> +	/*
> +	 * We may have multiple LLCs if L3 caches exist, so check if we
> +	 * have an L3 cache by looking at the L3 cache CPUID leaf.
> +	 */
> +	if (!cpuid_edx(0x80000006))
> +		return;
> +
> +	if (c->x86 < 0x17) {
> +		/* LLC is at the node level. */
> +		per_cpu(cpu_llc_id, cpu) = node_id;
> +	} else if (c->x86 == 0x17 &&
> +		   c->x86_model >= 0 && c->x86_model <= 0x1F) {
> +		/*
> +		 * LLC is at the core complex level.
> +		 * Core complex id is ApicId[3] for these processors.
> +		 */
> +		per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
> +	} else {
> +		/* LLC ID is calculated from the number of thread sharing. */
> +		u32 eax, ebx, ecx, edx, num_sharing_cache = 0;
> +		u32 llc_index = find_num_cache_leaves(c) - 1;
> +
> +		cpuid_count(0x8000001d, llc_index, &eax, &ebx, &ecx, &edx);
> +		if (eax)
> +			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
> +
> +		if (num_sharing_cache) {
> +			int bits = get_count_order(num_sharing_cache) - 1;
> +
> +			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(cacheinfo_amd_init_llc_id);

That function needs to be exported to modules because...?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
