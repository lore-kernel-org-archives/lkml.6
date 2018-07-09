Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD51C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0AC20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0AC20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeGIMgb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:36:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932567AbeGIMg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:36:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50F8CADB5;
        Mon,  9 Jul 2018 12:36:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EAD401E3D3B; Mon,  9 Jul 2018 14:36:27 +0200 (CEST)
Date:   Mon, 9 Jul 2018 14:36:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, jack@suse.cz, hch@lst.de,
        yu.c.zhang@intel.com, linux-mm@kvack.org, rkrcmar@redhat.com,
        yi.z.zhang@intel.com
Subject: Re: [PATCH 3/3] kvm: add a function to check if page is from NVDIMM
 pmem.
Message-ID: <20180709123627.wtbrsrfgqwuq7x65@quack2.suse.cz>
References: <cover.1530716899.git.yi.z.zhang@linux.intel.com>
 <359fdf0103b61014bf811d88d4ce36bc793d18f2.1530716899.git.yi.z.zhang@linux.intel.com>
 <1efab832-8782-38f3-9fd5-7a8b45bde153@redhat.com>
 <a6049ab7-19f4-3cdb-a954-c8ad7a05ed37@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6049ab7-19f4-3cdb-a954-c8ad7a05ed37@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-07-18 21:19:30, Zhang,Yi wrote:
> 
> 
> On 2018年07月04日 23:25, Paolo Bonzini wrote:
> > On 04/07/2018 17:30, Zhang Yi wrote:
> >> For device specific memory space, when we move these area of pfn to
> >> memory zone, we will set the page reserved flag at that time, some of
> >> these reserved for device mmio, and some of these are not, such as
> >> NVDIMM pmem.
> >>
> >> Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
> >> backend, since these pages are reserved. the check of
> >> kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
> >> introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
> >> to indentify these pages are from NVDIMM pmem. and let kvm treat these
> >> as normal pages.
> >>
> >> Without this patch, Many operations will be missed due to this
> >> mistreatment to pmem pages. For example, a page may not have chance to
> >> be unpinned for KVM guest(in kvm_release_pfn_clean); not able to be
> >> marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.
> >>
> >> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> >> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
> >> ---
> >>  virt/kvm/kvm_main.c | 17 +++++++++++++++--
> >>  1 file changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> >> index afb2e6e..1365d18 100644
> >> --- a/virt/kvm/kvm_main.c
> >> +++ b/virt/kvm/kvm_main.c
> >> @@ -140,10 +140,23 @@ __weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> >>  {
> >>  }
> >>  
> >> +static bool kvm_is_nd_pfn(kvm_pfn_t pfn)
> >> +{
> >> +	struct page *page = pfn_to_page(pfn);
> >> +
> >> +	return is_zone_device_page(page) &&
> >> +		((page->pgmap->type == MEMORY_DEVICE_FS_DAX) ||
> >> +		 (page->pgmap->type == MEMORY_DEVICE_DEV_DAX));
> >> +}
> > If the mm people agree, I'd prefer something that takes a struct page *
> > and is exported by include/linux/mm.h.  Then KVM can just do something like
> >
> > 	struct page *page;
> > 	if (!pfn_valid(pfn))
> > 		return true;
> >
> > 	page = pfn_to_page(pfn);
> > 	return PageReserved(page) && !is_dax_page(page);
> >
> > Thanks,
> >
> > Paolo
> Yeah, that could be much better. Thanks for your comments Paolo.
> 
> Hi Kara, Do u have Any opinions/ideas to add such definition in mm?

What Paolo suggests sounds good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
