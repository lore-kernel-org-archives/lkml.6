Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167AEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C1621773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfBSQtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:49:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:58146 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBSQtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:49:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 08:49:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="135501899"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 19 Feb 2019 08:49:09 -0800
Received: from [10.254.80.103] (kliang2-mobl1.ccr.corp.intel.com [10.254.80.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A5223580310;
        Tue, 19 Feb 2019 08:49:08 -0800 (PST)
Subject: Re: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package
 support
To:     Len Brown <lenb@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2e7fd7b3-9013-d05f-233b-9cd2110f3c73@linux.intel.com>
Date:   Tue, 19 Feb 2019 11:49:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2019 10:40 PM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Some new systems have multiple software-visible die within each package.
> The new CPUID.1F leaf can enumerate this multi-die/package topology.
> 
> CPUID.1F a super-set of the CPUID.B "Extended Toplogy Leaf",
> and a common updated routine can parse either leaf.
> 
> Legacy systems without CPUID.1F, and systems without multi-die/package
> hardware, will see no functional change from this patch series.
> 
> Multi-die/package systems will use CPUID.B before this patch,
> and CPUID.1F after this patch.  In the CPUID.B case, all die appear
> (incorrectly) to software as individual packages.  In the CPUID.1F case,
> the package id's reflect reality, and die_id's become meaningful.
> 
> Subsequent patches in this series update the kernel to be multi-die aware.
> In particular, some software needs to know the difference between
> a die-scope MSR and a package-scope MSR.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>   Documentation/x86/topology.txt   |  4 ++
>   arch/x86/include/asm/processor.h |  4 +-
>   arch/x86/kernel/cpu/topology.c   | 82 ++++++++++++++++++++++++--------
>   arch/x86/kernel/smpboot.c        |  4 +-
>   4 files changed, 73 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
> index 06b3cdbc4048..8107b6cfc9ea 100644
> --- a/Documentation/x86/topology.txt
> +++ b/Documentation/x86/topology.txt
> @@ -46,6 +46,10 @@ The topology of a system is described in the units of:
>   
>       The number of cores in a package. This information is retrieved via CPUID.
>   
> +  - cpuinfo_x86.x86_max_dies:
> +
> +    The number of dies in a package. This information is retrieved via CPUID.
> +
>     - cpuinfo_x86.phys_proc_id:
>   
>       The physical ID of the package. This information is retrieved via CPUID
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 33051436c864..f2856fe03715 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -105,7 +105,8 @@ struct cpuinfo_x86 {
>   	int			x86_power;
>   	unsigned long		loops_per_jiffy;
>   	/* cpuid returned max cores value: */
> -	u16			 x86_max_cores;
> +	u16			x86_max_cores;
> +	u16			x86_max_dies;
>   	u16			apicid;
>   	u16			initial_apicid;
>   	u16			x86_clflush_size;
> @@ -117,6 +118,7 @@ struct cpuinfo_x86 {
>   	u16			logical_proc_id;
>   	/* Core id: */
>   	u16			cpu_core_id;
> +	u16			cpu_die_id;
>   	/* Index into per_cpu list: */
>   	u16			cpu_index;
>   	u32			microcode;
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 8f6c784141d1..6dce6ee77849 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -15,33 +15,61 @@
>   /* leaf 0xb SMT level */
>   #define SMT_LEVEL	0
>   
> -/* leaf 0xb sub-leaf types */
> +/* extended topology sub-leaf types */
>   #define INVALID_TYPE	0
>   #define SMT_TYPE	1
>   #define CORE_TYPE	2
> +#define DIE_TYPE	5
>   
>   #define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
>   #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
>   #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
>   
> -int detect_extended_topology_early(struct cpuinfo_x86 *c)
> -{
>   #ifdef CONFIG_SMP
> +/*
> + * Check if given CPUID extended toplogy "leaf" is implemented
> + */
> +static int check_extended_topology_leaf(int leaf)
> +{
>   	unsigned int eax, ebx, ecx, edx;
>   
> -	if (c->cpuid_level < 0xb)
> +	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
> +
> +	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
>   		return -1;
>   
> -	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
> +	return 0;
> +}
> +/*
> + * Return best CPUID Extended Toplogy Leaf supported
> + */
> +static int detect_extended_topology_leaf(struct cpuinfo_x86 *c)
> +{
> +	if (c->cpuid_level >= 0x1f)
> +		if (check_extended_topology_leaf(0x1f) == 0)
> +			return 0x1f;
>   
> -	/*
> -	 * check if the cpuid leaf 0xb is actually implemented.
> -	 */
> -	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
> +	if (c->cpuid_level >= 0xb)
> +		if (check_extended_topology_leaf(0xb) == 0)
> +			return 0xb;
> +
> +	return -1;
> +}
> +#endif
> +
> +int detect_extended_topology_early(struct cpuinfo_x86 *c)
> +{
> +#ifdef CONFIG_SMP
> +	unsigned int eax, ebx, ecx, edx;
> +	int leaf;
> +
> +	leaf = detect_extended_topology_leaf(c);
> +	if (leaf < 0)
>   		return -1;
>   
>   	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
>   
> +	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
>   	/*
>   	 * initial apic id, which also represents 32-bit extended x2apic id.
>   	 */
> @@ -52,7 +80,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
>   }
>   
>   /*
> - * Check for extended topology enumeration cpuid leaf 0xb and if it
> + * Check for extended topology enumeration cpuid leaf, and if it
>    * exists, use it for populating initial_apicid and cpu topology
>    * detection.
>    */
> @@ -60,46 +88,62 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
>   {
>   #ifdef CONFIG_SMP
>   	unsigned int eax, ebx, ecx, edx, sub_index;
> -	unsigned int ht_mask_width, core_plus_mask_width;
> +	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
>   	unsigned int core_select_mask, core_level_siblings;
> +	unsigned int die_select_mask, die_level_siblings;
> +	int leaf;
>   
> -	if (detect_extended_topology_early(c) < 0)
> +	leaf = detect_extended_topology_leaf(c);
> +	if (leaf  < 0)
>   		return -1;
>   
>   	/*
>   	 * Populate HT related information from sub-leaf level 0.
>   	 */
> -	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
> +	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
> +	c->initial_apicid = edx;
>   	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
>   	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
> +	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +	die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
>   
>   	sub_index = 1;
>   	do {
> -		cpuid_count(0xb, sub_index, &eax, &ebx, &ecx, &edx);
> +		cpuid_count(leaf, sub_index, &eax, &ebx, &ecx, &edx);
>   
>   		/*
>   		 * Check for the Core type in the implemented sub leaves.
>   		 */
>   		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
>   			core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +			die_level_siblings = core_level_siblings;
>   			core_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
> -			break;
> +		}
> +		if (LEAFB_SUBTYPE(ecx) == DIE_TYPE) {
> +			die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
>   		}
>   
>   		sub_index++;
>   	} while (LEAFB_SUBTYPE(ecx) != INVALID_TYPE);
>   
>   	core_select_mask = (~(-1 << core_plus_mask_width)) >> ht_mask_width;
> -
> -	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid, ht_mask_width)
> -						 & core_select_mask;
> -	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid, core_plus_mask_width);
> +	die_select_mask = (~(-1 << die_plus_mask_width)) >>
> +				core_plus_mask_width;
> +
> +	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid,
> +				ht_mask_width) & core_select_mask;
> +	c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
> +				core_plus_mask_width) & die_select_mask;
> +	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
> +				die_plus_mask_width);
>   	/*
>   	 * Reinit the apicid, now that we have extended initial_apicid.
>   	 */
>   	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
>   
>   	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
> +	c->x86_max_dies = (die_level_siblings / core_level_siblings);
>   #endif
>   	return 0;
>   }
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ccd1f2a8e557..4250a87f57db 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -393,6 +393,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>   		int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
>   
>   		if (c->phys_proc_id == o->phys_proc_id &&
> +		    c->cpu_die_id == o->cpu_die_id &&
>   		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
>   			if (c->cpu_core_id == o->cpu_core_id)
>   				return topology_sane(c, o, "smt");
> @@ -404,6 +405,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>   		}
>   
>   	} else if (c->phys_proc_id == o->phys_proc_id &&
> +		   c->cpu_die_id == o->cpu_die_id &&
>   		   c->cpu_core_id == o->cpu_core_id) {
>   		return topology_sane(c, o, "smt");
>   	}
> @@ -461,7 +463,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>    */
>   static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>   {
> -	if (c->phys_proc_id == o->phys_proc_id)
> +	if (c->cpu_die_id == o->cpu_die_id)
>   		return true;
>   	return false;
>   }

Shouldn't we check the unique_die_id here?
Die from different package can have the same cpu_die_id.

Thanks,
Kan

