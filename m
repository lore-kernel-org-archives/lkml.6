Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DC0ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB10420883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB10420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeIPUHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 16:07:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53001 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeIPUHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 16:07:10 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1YHE-00009e-5F; Sun, 16 Sep 2018 16:43:56 +0200
Date:   Sun, 16 Sep 2018 16:43:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
In-Reply-To: <20180916143549.zmnlcviyn67fbxwh@shbuild888>
Message-ID: <alpine.DEB.2.21.1809161633160.1650@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de> <20180831133659.pkmscqpudjnkujbg@shbuild888> <20180907081716.bxw3hmcl6w7gqvax@shbuild888> <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de> <20180910093938.ka732apzy3d3a5ip@shbuild888>
 <alpine.DEB.2.21.1809101147500.1402@nanos.tec.linutronix.de> <20180911061413.redy4oxia3hqifkh@shbuild888> <alpine.DEB.2.21.1809151226130.1650@nanos.tec.linutronix.de> <20180915164731.3zrdxijuwkgdi25p@shbuild888> <alpine.DEB.2.21.1809151923270.1650@nanos.tec.linutronix.de>
 <20180916143549.zmnlcviyn67fbxwh@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2018, Feng Tang wrote:
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index e848a4811785..a927f5f39bee 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -637,6 +637,16 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
>  {
>  	unsigned long address = __fix_to_virt(idx);
>  
> +#ifdef CONFIG_X86_64
> +       /*
> +        * In arch/x86/kernel/head_64.S, the static page table has
> +	* been setup for fixmap. Add a sanity compiling check
> +	* whether fixmap space has exceeded the capacity.
> +        */
> +       BUILD_BUG_ON((__end_of_permanent_fixed_addresses + 511)/512
> +                       > FIXMAP_PMD_NUM);

There exist macros for rounding up and doing this in the header file is
perfectly fine.

> +#endif
> +
>  	if (idx >= __end_of_fixed_addresses) {
>  		BUG();
>  		return;
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 45b700ac5fe7..b0aa2364a3c6 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -1953,7 +1953,10 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
>  	set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
>  	set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
>  	set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
> -	set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
> +
> +	for (i = 0; i < FIXMAP_PMD_NUM; i++)
> +		set_page_prot(level1_fixmap_pgt + i * 512,
> +				PAGE_KERNEL_RO);

The line break is there because?

Thanks,

	tglx
