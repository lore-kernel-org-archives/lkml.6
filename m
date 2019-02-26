Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF63A217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551205012;
	bh=bbdcYEZABB59j9mLpW3DzSADuN6+wInChoQdQj2tRAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hEtqDgNr813UIRsvMlJX4P7nWB1CQrKDdH6VkiRrNDVNbHtNw2i1HOvbwTIy6RXj/
	 X4bAfGCLnFkyABIC2n8iwUPYLPPIZjQw2p2SNGsMxiP91D0jRdsh3nOdqaBkPZaXP7
	 TGdn1c8T92jVUlNq1K7u820RuzXx4NP1t35ihJv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfBZSQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:16:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:49772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728793AbfBZSQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:16:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0C86AD05;
        Tue, 26 Feb 2019 18:16:49 +0000 (UTC)
Date:   Tue, 26 Feb 2019 19:16:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
Message-ID: <20190226181648.GG10588@dhcp22.suse.cz>
References: <20190225191710.48131-1-cai@lca.pw>
 <20190226123521.GZ10588@dhcp22.suse.cz>
 <4d4d3140-6d83-6d22-efdb-370351023aea@lca.pw>
 <20190226142352.GC10588@dhcp22.suse.cz>
 <1551203585.6911.47.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551203585.6911.47.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-02-19 12:53:05, Qian Cai wrote:
> On Tue, 2019-02-26 at 15:23 +0100, Michal Hocko wrote:
> > On Tue 26-02-19 09:16:30, Qian Cai wrote:
> > > 
> > > 
> > > On 2/26/19 7:35 AM, Michal Hocko wrote:
> > > > On Mon 25-02-19 14:17:10, Qian Cai wrote:
> > > > > When onlining memory pages, it calls kernel_unmap_linear_page(),
> > > > > However, it does not call kernel_map_linear_page() while offlining
> > > > > memory pages. As the result, it triggers a panic below while onlining on
> > > > > ppc64le as it checks if the pages are mapped before unmapping,
> > > > > Therefore, let it call kernel_map_linear_page() when setting all pages
> > > > > as reserved.
> > > > 
> > > > This really begs for much more explanation. All the pages should be
> > > > unmapped as they get freed AFAIR. So why do we need a special handing
> > > > here when this path only offlines free pages?
> > > > 
> > > 
> > > It sounds like this is exact the point to explain the imbalance. When
> > > offlining,
> > > every page has already been unmapped and marked reserved. When onlining, it
> > > tries to free those reserved pages via __online_page_free(). Since those
> > > pages
> > > are order 0, it goes free_unref_page() which in-turn call
> > > kernel_unmap_linear_page() again without been mapped first.
> > 
> > How is this any different from an initial page being freed to the
> > allocator during the boot?
> > 
> 
> As least for IBM POWER8, it does this during the boot,
> 
> early_setup
>   early_init_mmu
>     harsh__early_init_mmu
>       htab_initialize [1]
>         htab_bolt_mapping [2]
> 
> where it effectively map all memblock regions just like
> kernel_map_linear_page(), so later mem_init() -> memblock_free_all() will unmap
> them just fine.
> 
> [1]
> for_each_memblock(memory, reg) {
> 	base = (unsigned long)__va(reg->base);
> 	size = reg->size;
> 
> 	DBG("creating mapping for region: %lx..%lx (prot: %lx)\n",
> 		base, size, prot);
> 
> 	BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
> 		prot, mmu_linear_psize, mmu_kernel_ssize));
> 	}
> 
> [2] linear_map_hash_slots[paddr >> PAGE_SHIFT] = ret | 0x80;

Thanks for the clarification. I would have expected that there is a
generic path to do kernel_map_pages from an appropriate place. I am also
wondering whether blowing up is actually the right thing to do. Is the
ppc specific code correct? Isn't your patch simply working around a
bogus condition?

-- 
Michal Hocko
SUSE Labs
