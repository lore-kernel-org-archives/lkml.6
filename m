Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E08C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F160620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nV3AJ2yS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfBTKzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:55:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41738 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3bhsLBuKCRyniv8xa/iQpLENJCU4eXVL7iXAnhBZsps=; b=nV3AJ2ySG31wC5+DdiuX4ZEOm
        qK6mhogjeYEfK+c5a76UHt1wEM+l+3nJg5sS/sQd59d7+dG9RhyaO0a5oezlUIRAwUXltnbeXqIIe
        nHvB9hVDcMQbI2vQ13XhpbcN2LcIqRXT5auXgTjox4UMLhbkmtSzljbhu8n8IYGM7r4jY+RmUZGK1
        rB3SyPOT7oWVOqRkQTXSSJK/qbsOYNF8Cmu4kQ0e854UQ2xtgoXZ4BHHBld5gaaRI8ydH+tTkOGCn
        DAlTSwIU8hU/C9E+WVxAr2NkXSQXmqGqc4vKHmxHhzdiArrrKFQNdZAh0O6FLqXhy/tlgJQaIOWpu
        uC7v1nCFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwPXW-0006H2-Nm; Wed, 20 Feb 2019 10:55:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7494202BC402; Wed, 20 Feb 2019 11:55:42 +0100 (CET)
Date:   Wed, 20 Feb 2019 11:55:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package
 support
Message-ID: <20190220105542.GB17969@hirez.programming.kicks-ass.net>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:40:05PM -0500, Len Brown wrote:
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

It would've been nice to have the CPUID instruction 1F leaf reference
3B-3.9 in the SDM, and maybe mention this here too.

Also, figure 8-6 uses Q,R ID, without prior mention.

> +/*
> + * Check if given CPUID extended toplogy "leaf" is implemented
> + */
> +static int check_extended_topology_leaf(int leaf)
> +{
>  	unsigned int eax, ebx, ecx, edx;
>  
> +	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
> +
> +	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
>  		return -1;
>  
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

Coding-style requires { } on the outer if-stmt.

>  
> +	if (c->cpuid_level >= 0xb)
> +		if (check_extended_topology_leaf(0xb) == 0)
> +			return 0xb;

idem.

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
>  		return -1;
>  
>  	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
>  
> +	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
>  	/*
>  	 * initial apic id, which also represents 32-bit extended x2apic id.
>  	 */
> @@ -52,7 +80,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
>  }
>  
>  /*
> + * Check for extended topology enumeration cpuid leaf, and if it
>   * exists, use it for populating initial_apicid and cpu topology
>   * detection.
>   */
> @@ -60,46 +88,62 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
>  {
>  #ifdef CONFIG_SMP
>  	unsigned int eax, ebx, ecx, edx, sub_index;
> +	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
>  	unsigned int core_select_mask, core_level_siblings;
> +	unsigned int die_select_mask, die_level_siblings;
> +	int leaf;
>  
> +	leaf = detect_extended_topology_leaf(c);
> +	if (leaf  < 0)

s/  / /

>  		return -1;
>  
>  	/*
>  	 * Populate HT related information from sub-leaf level 0.
>  	 */
> +	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
> +	c->initial_apicid = edx;
>  	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
>  	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
> +	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +	die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
>  
>  	sub_index = 1;
>  	do {
> +		cpuid_count(leaf, sub_index, &eax, &ebx, &ecx, &edx);
>  
>  		/*
>  		 * Check for the Core type in the implemented sub leaves.
>  		 */
>  		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
>  			core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +			die_level_siblings = core_level_siblings;
>  			core_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
> -			break;
> +		}
> +		if (LEAFB_SUBTYPE(ecx) == DIE_TYPE) {
> +			die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
>  		}
>  
>  		sub_index++;
>  	} while (LEAFB_SUBTYPE(ecx) != INVALID_TYPE);

Personally I much prefer union based decoding of cpuid leafs over this
macro magic (git grep cpuid10_):

union cpuid1f_eax {
	struct {
		unsigned int x2apic_shift : 5;
	} split;
	unsigned int full;
};

union cpuid1f_ebx {
	struct {
		unsigned int nr_cpus : 16;
	} split;
	unsigned int full;
};

enum level_type_enum {
	invalid_type = 0,
	smt_type,
	core_type,
	module_type,
	tile_type,
	die_type,
};

union cpuid1f_ecx {
	struct {
		unsigned int subleaf : 8;
		unsigned int level_type : 8;
	} split;
	unsigned int full;
};

>  	core_select_mask = (~(-1 << core_plus_mask_width)) >> ht_mask_width;
> +	die_select_mask = (~(-1 << die_plus_mask_width)) >>
> +				core_plus_mask_width;
> +
> +	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid,
> +				ht_mask_width) & core_select_mask;
> +	c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
> +				core_plus_mask_width) & die_select_mask;
> +	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
> +				die_plus_mask_width);
>  	/*
>  	 * Reinit the apicid, now that we have extended initial_apicid.
>  	 */
>  	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
>  
>  	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
> +	c->x86_max_dies = (die_level_siblings / core_level_siblings);
>  #endif
>  	return 0;
>  }


> @@ -461,7 +463,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>   */
>  static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>  {
> -	if (c->phys_proc_id == o->phys_proc_id)
> +	if (c->cpu_die_id == o->cpu_die_id)
>  		return true;
>  	return false;
>  }

You haven't explained, and I can't readily find it in the SDM either,
how these topology bits relate to caches and interconnects.

Will these die thingies share LLC, or will LLC be per die. Will NUMA
span dies or not.


