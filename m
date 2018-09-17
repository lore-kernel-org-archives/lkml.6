Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33415ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E70214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E70214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeIQN3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:29:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:51850 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbeIQN3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:29:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 01:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,384,1531810800"; 
   d="scan'208";a="81009465"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2018 01:02:57 -0700
Date:   Mon, 17 Sep 2018 16:07:57 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/mm: Expand static page table for fixmap space
Message-ID: <20180917080757.psvvv3xuue5leaoq@shbuild888>
References: <20180917073449.20693-1-feng.tang@intel.com>
 <6f3d7b9e-f635-befb-0fa8-74ceaaa1dea0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f3d7b9e-f635-befb-0fa8-74ceaaa1dea0@suse.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

On Mon, Sep 17, 2018 at 09:48:05AM +0200, Juergen Gross wrote:
> On 17/09/18 09:34, Feng Tang wrote:
> > We met a kernel panic when enabling earlycon, which is due to
> > the fixmap address of earlycon is not statically setup.
> > 
> > Currently the static fixmap setup in head_64.S only covers 2M
> > virtual address space, while it acutually could be in 4M space
> > with different kernel configurations.
> > 
> > So increase the static space to 4M for now by defining FIXMAP_PMD_NUM
> > to 2, and add a build time check for future possible overflow so that
> > the macro could be increased accordingly.
> > 
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  arch/x86/include/asm/fixmap.h     |  3 +++
> >  arch/x86/include/asm/pgtable_64.h |  3 ++-
> >  arch/x86/kernel/head_64.S         | 16 ++++++++++++----
> >  arch/x86/mm/pgtable.c             | 10 ++++++++++
> >  arch/x86/xen/mmu_pv.c             |  4 +++-
> >  5 files changed, 30 insertions(+), 6 deletions(-)
> > 
> 
> ...
> 
> > diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> > index 2fe5c9b..19077f9 100644
> > --- a/arch/x86/xen/mmu_pv.c
> > +++ b/arch/x86/xen/mmu_pv.c
> > @@ -1952,7 +1952,9 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
> >  	set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
> >  	set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
> >  	set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
> > -	set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
> > +
> > +	for (i = 0; i < FIXMAP_PMD_NUM; i++)
> > +		set_page_prot(level1_fixmap_pgt + i * 512, PAGE_KERNEL_RO);
> 
> Please use PTRS_PER_PTE instead of the literal 512.
> 
> Some lines further up level1_fixmap_pgt is mentioned in a comment.
> Please update that, too:
> 
> -	/* L3_k[511][506] -> level1_fixmap_pgt */
> +	/* L3_k[511][506, ...] -> level1_fixmap_pgt */

Thanks for the suggestions, will handle them in v2.

- Feng

> 
> 
> Juergen
