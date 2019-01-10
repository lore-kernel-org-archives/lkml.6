Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7462CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA572075C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfAJBmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:42:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfAJBmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:42:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 083AE811AC;
        Thu, 10 Jan 2019 01:42:09 +0000 (UTC)
Received: from redhat.com (ovpn-123-7.rdu2.redhat.com [10.10.123.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 900AF18341;
        Thu, 10 Jan 2019 01:42:04 +0000 (UTC)
Date:   Wed, 9 Jan 2019 20:42:02 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        leozinho29_eu@hotmail.com, Mike Galbraith <efault@gmx.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/mmu_notifier: mm/rmap.c: Fix a mmu_notifier range bug
 in try_to_unmap_one
Message-ID: <20190110014200.GA4317@redhat.com>
References: <20190110005117.18282-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190110005117.18282-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 10 Jan 2019 01:42:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 04:51:17PM -0800, Sean Christopherson wrote:
> The conversion to use a structure for mmu_notifier_invalidate_range_*()
> unintentionally changed the usage in try_to_unmap_one() to init the
> 'struct mmu_notifier_range' with vma->vm_start instead of @address,
> i.e. it invalidates the wrong address range.  Revert to the correct
> address range.
> 
> Manifests as KVM use-after-free WARNINGs and subsequent "BUG: Bad page
> state in process X" errors when reclaiming from a KVM guest due to KVM
> removing the wrong pages from its own mappings.
> 
> Reported-by: leozinho29_eu@hotmail.com
> Reported-by: Mike Galbraith <efault@gmx.de>
> Reported-by: Adam Borowski <kilobyte@angband.pl>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> Cc: Christian König <christian.koenig@amd.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: ac46d4f3c432 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> FWIW, I looked through all other calls to mmu_notifier_range_init() in
> the patch and didn't spot any other unintentional functional changes.
> 
>  mm/rmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 68a1a5b869a5..0454ecc29537 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1371,8 +1371,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  	 * Note that the page can not be free in this function as call of
>  	 * try_to_unmap() must hold a reference on the page.
>  	 */
> -	mmu_notifier_range_init(&range, vma->vm_mm, vma->vm_start,
> -				min(vma->vm_end, vma->vm_start +
> +	mmu_notifier_range_init(&range, vma->vm_mm, address,
> +				min(vma->vm_end, address +
>  				    (PAGE_SIZE << compound_order(page))));
>  	if (PageHuge(page)) {
>  		/*
> -- 
> 2.19.2
> 
