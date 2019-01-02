Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F5EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50791208E3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfABBB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:01:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:19308 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbfABBB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 20:01:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2019 17:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,429,1539673200"; 
   d="scan'208";a="106229491"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.161.32])
  by orsmga008.jf.intel.com with ESMTP; 01 Jan 2019 17:01:55 -0800
Date:   Wed, 2 Jan 2019 08:59:37 +0800
From:   Yuan Yao <yuan.yao@linux.intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Yao Yuan <yuan.yao@intel.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Fan Du <fan.du@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 11/21] kvm: allocate page table pages from DRAM
Message-ID: <20190102005936.GA12352@yy-desk-7060>
References: <20181226131446.330864849@intel.com>
 <20181226133351.703380444@intel.com>
 <87pntg7mv8.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pntg7mv8.fsf@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 02:53:07PM +0530, Aneesh Kumar K.V wrote:
> Fengguang Wu <fengguang.wu@intel.com> writes:
> 
> > From: Yao Yuan <yuan.yao@intel.com>
> >
> > Signed-off-by: Yao Yuan <yuan.yao@intel.com>
> > Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> > ---
> > arch/x86/kvm/mmu.c |   12 +++++++++++-
> > 1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > --- linux.orig/arch/x86/kvm/mmu.c	2018-12-26 20:54:48.846720344 +0800
> > +++ linux/arch/x86/kvm/mmu.c	2018-12-26 20:54:48.842719614 +0800
> > @@ -950,6 +950,16 @@ static void mmu_free_memory_cache(struct
> >  		kmem_cache_free(cache, mc->objects[--mc->nobjs]);
> >  }
> >  
> > +static unsigned long __get_dram_free_pages(gfp_t gfp_mask)
> > +{
> > +       struct page *page;
> > +
> > +       page = __alloc_pages(GFP_KERNEL_ACCOUNT, 0, numa_node_id());
> > +       if (!page)
> > +	       return 0;
> > +       return (unsigned long) page_address(page);
> > +}
> > +
> 
> May be it is explained in other patches. What is preventing the
> allocation from pmem here? Is it that we are not using the memory
> policy prefered node id and hence the zone list we built won't have the
> PMEM node?

That because the PMEM nodes are memory-only node in the patchset,
so numa_node_id() will always return the node id from DRAM nodes.

About the zone list, yes in patch 10/21 we build the PMEM nodes to
seperate zonelist, so DRAM nodes will not fall back to PMEM nodes.

> 
> >  static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
> >  				       int min)
> >  {
> > @@ -958,7 +968,7 @@ static int mmu_topup_memory_cache_page(s
> >  	if (cache->nobjs >= min)
> >  		return 0;
> >  	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
> > -		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
> > +		page = (void *)__get_dram_free_pages(GFP_KERNEL_ACCOUNT);
> >  		if (!page)
> >  			return cache->nobjs >= min ? 0 : -ENOMEM;
> >  		cache->objects[cache->nobjs++] = page;
> 
> -aneesh
> 
