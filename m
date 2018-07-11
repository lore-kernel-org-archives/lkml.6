Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2749C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8169720652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8169720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbeGKMyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:54:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:38090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbeGKMyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:54:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3EF7ADAB;
        Wed, 11 Jul 2018 12:49:47 +0000 (UTC)
Date:   Wed, 11 Jul 2018 14:49:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, dmatlack@google.com,
        gthelen@google.com
Subject: Re: [PATCH] mm: hugetlb: don't zero 1GiB bootmem pages.
Message-ID: <20180711124947.GB20172@dhcp22.suse.cz>
References: <20180710184903.68239-1-cannonmatthews@google.com>
 <ad083425-c861-1a77-069d-23b0aa1c84c6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad083425-c861-1a77-069d-23b0aa1c84c6@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-07-18 13:46:57, Mike Kravetz wrote:
> On 07/10/2018 11:49 AM, Cannon Matthews wrote:
> > When using 1GiB pages during early boot, use the new
> > memblock_virt_alloc_try_nid_raw() function to allocate memory without
> > zeroing it.  Zeroing out hundreds or thousands of GiB in a single core
> > memset() call is very slow, and can make early boot last upwards of
> > 20-30 minutes on multi TiB machines.
> > 
> > To be safe, still zero the first sizeof(struct boomem_huge_page) bytes
> > since this is used a temporary storage place for this info until
> > gather_bootmem_prealloc() processes them later.
> > 
> > The rest of the memory does not need to be zero'd as the hugetlb pages
> > are always zero'd on page fault.
> > 
> > Tested: Booted with ~3800 1G pages, and it booted successfully in
> > roughly the same amount of time as with 0, as opposed to the 25+
> > minutes it would take before.
> > 
> 
> Nice improvement!
> 
> > Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
> > ---
> >  mm/hugetlb.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 3612fbb32e9d..c93a2c77e881 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2101,7 +2101,7 @@ int __alloc_bootmem_huge_page(struct hstate *h)
> >  	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
> >  		void *addr;
> > 
> > -		addr = memblock_virt_alloc_try_nid_nopanic(
> > +		addr = memblock_virt_alloc_try_nid_raw(
> >  				huge_page_size(h), huge_page_size(h),
> >  				0, BOOTMEM_ALLOC_ACCESSIBLE, node);
> >  		if (addr) {
> > @@ -2109,7 +2109,12 @@ int __alloc_bootmem_huge_page(struct hstate *h)
> >  			 * Use the beginning of the huge page to store the
> >  			 * huge_bootmem_page struct (until gather_bootmem
> >  			 * puts them into the mem_map).
> > +			 *
> > +			 * memblock_virt_alloc_try_nid_raw returns non-zero'd
> > +			 * memory so zero out just enough for this struct, the
> > +			 * rest will be zero'd on page fault.
> >  			 */
> > +			memset(addr, 0, sizeof(struct huge_bootmem_page));
> 
> This forced me to look at the usage of huge_bootmem_page.  It is defined as:
> struct huge_bootmem_page {
> 	struct list_head list;
> 	struct hstate *hstate;
> #ifdef CONFIG_HIGHMEM
> 	phys_addr_t phys;
> #endif
> };
> 
> The list and hstate fields are set immediately after allocating the memory
> block here and elsewhere.  However, I can't find any code that sets phys.
> Although, it is potentially used in gather_bootmem_prealloc().  It appears
> powerpc used this field at one time, but no longer does.
> 
> Am I missing something?

If yes, then I am missing it as well. phys is a cool name to grep for...
Anyway, does it really make any sense to allow gigantic pages on HIGHMEM
systems in the first place?

-- 
Michal Hocko
SUSE Labs
