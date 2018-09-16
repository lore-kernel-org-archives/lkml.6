Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56609ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B5120883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B5120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeIPUY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 16:24:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:24399 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeIPUY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 16:24:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2018 08:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,381,1531810800"; 
   d="scan'208";a="86540491"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga002.fm.intel.com with ESMTP; 16 Sep 2018 08:01:42 -0700
Date:   Sun, 16 Sep 2018 23:06:41 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180916150641.qvlfseyeue5vij4w@shbuild888>
References: <20180907081716.bxw3hmcl6w7gqvax@shbuild888>
 <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de>
 <20180910093938.ka732apzy3d3a5ip@shbuild888>
 <alpine.DEB.2.21.1809101147500.1402@nanos.tec.linutronix.de>
 <20180911061413.redy4oxia3hqifkh@shbuild888>
 <alpine.DEB.2.21.1809151226130.1650@nanos.tec.linutronix.de>
 <20180915164731.3zrdxijuwkgdi25p@shbuild888>
 <alpine.DEB.2.21.1809151923270.1650@nanos.tec.linutronix.de>
 <20180916143549.zmnlcviyn67fbxwh@shbuild888>
 <alpine.DEB.2.21.1809161633160.1650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809161633160.1650@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sun, Sep 16, 2018 at 04:43:55PM +0200, Thomas Gleixner wrote:
> On Sun, 16 Sep 2018, Feng Tang wrote:
> > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > index e848a4811785..a927f5f39bee 100644
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -637,6 +637,16 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
> >  {
> >  	unsigned long address = __fix_to_virt(idx);
> >  
> > +#ifdef CONFIG_X86_64
> > +       /*
> > +        * In arch/x86/kernel/head_64.S, the static page table has
> > +	* been setup for fixmap. Add a sanity compiling check
> > +	* whether fixmap space has exceeded the capacity.
> > +        */
> > +       BUILD_BUG_ON((__end_of_permanent_fixed_addresses + 511)/512
> > +                       > FIXMAP_PMD_NUM);
> 
> There exist macros for rounding up and doing this in the header file is
> perfectly fine.

I'll find the sample for the round up.

And for the header file check, I initially put this check directly in
the fixmap.h like:

#if ((__end_of_permanent_fixed_addresses + 511)/512 > FIXMAP_PMD_NUM)
#erro "some warning...."
#endif

But failed to compile, I got the warning
 warning: "__end_of_permanent_fixed_addresses" is not defined

 I guess the header file preprocessing can't handle it.

> 
> > +#endif
> > +
> >  	if (idx >= __end_of_fixed_addresses) {
> >  		BUG();
> >  		return;
> > diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> > index 45b700ac5fe7..b0aa2364a3c6 100644
> > --- a/arch/x86/xen/mmu_pv.c
> > +++ b/arch/x86/xen/mmu_pv.c
> > @@ -1953,7 +1953,10 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
> >  	set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
> >  	set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
> >  	set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
> > -	set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
> > +
> > +	for (i = 0; i < FIXMAP_PMD_NUM; i++)
> > +		set_page_prot(level1_fixmap_pgt + i * 512,
> > +				PAGE_KERNEL_RO);
> 
> The line break is there because?
Will fix it. I used a MACRO before changing to 512  and forgot to remove
the line break :) 

Thanks,
Feng
