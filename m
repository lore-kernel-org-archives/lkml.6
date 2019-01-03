Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E633C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEF0208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfACOaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:30:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfACOaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:30:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40E257F40E;
        Thu,  3 Jan 2019 14:30:03 +0000 (UTC)
Received: from redhat.com (ovpn-123-124.rdu2.redhat.com [10.10.123.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E882D5D961;
        Thu,  3 Jan 2019 14:30:01 +0000 (UTC)
Date:   Thu, 3 Jan 2019 09:29:59 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Initialise mmu_notifier_range correctly
Message-ID: <20190103142959.GA3395@redhat.com>
References: <20190103002126.GM6310@bombadil.infradead.org>
 <20190103015654.GB15619@redhat.com>
 <785af237-eb67-c304-595d-9080a2f48102@nvidia.com>
 <20190103041833.GN6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103041833.GN6310@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 03 Jan 2019 14:30:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 08:18:33PM -0800, Matthew Wilcox wrote:
> On Wed, Jan 02, 2019 at 07:32:08PM -0800, John Hubbard wrote:
> > Having the range struct declared in separate places from the mmu_notifier_range_init()
> > calls is not great. But I'm not sure I see a way to make it significantly cleaner, given
> > that __follow_pte_pmd uses the range pointer as a way to decide to issue the mmn calls.
> 
> Yeah, I don't think there's anything we can do.  But I started reviewing
> the comments, and they don't make sense together:
> 
>                 /*
>                  * Note because we provide range to follow_pte_pmd it will
>                  * call mmu_notifier_invalidate_range_start() on our behalf
>                  * before taking any lock.
>                  */
>                 if (follow_pte_pmd(vma->vm_mm, address, &range,
>                                    &ptep, &pmdp, &ptl))
>                         continue;
> 
>                 /*
>                  * No need to call mmu_notifier_invalidate_range() as we are
>                  * downgrading page table protection not changing it to point
>                  * to a new page.
>                  *
>                  * See Documentation/vm/mmu_notifier.rst
>                  */
> 
> So if we don't call mmu_notifier_invalidate_range, why are we calling
> mmu_notifier_invalidate_range_start and mmu_notifier_invalidate_range_end?
> ie, why not this ...

Thus comments looks wrong to me ... we need to call
mmu_notifier_invalidate_range() those are use by
IOMMU. I might be to blame for those comments thought.


> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 6959837cc465..905340149924 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -777,7 +777,6 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
>  
>  	i_mmap_lock_read(mapping);
>  	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
> -		struct mmu_notifier_range range;
>  		unsigned long address;
>  
>  		cond_resched();
> @@ -787,12 +786,7 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
>  
>  		address = pgoff_address(index, vma);
>  
> -		/*
> -		 * Note because we provide start/end to follow_pte_pmd it will
> -		 * call mmu_notifier_invalidate_range_start() on our behalf
> -		 * before taking any lock.
> -		 */
> -		if (follow_pte_pmd(vma->vm_mm, address, &range,
> +		if (follow_pte_pmd(vma->vm_mm, address, NULL,
>  				   &ptep, &pmdp, &ptl))
>  			continue;
>  
> @@ -834,8 +828,6 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
>  unlock_pte:
>  			pte_unmap_unlock(ptep, ptl);
>  		}
> -
> -		mmu_notifier_invalidate_range_end(&range);
>  	}
>  	i_mmap_unlock_read(mapping);
>  }
