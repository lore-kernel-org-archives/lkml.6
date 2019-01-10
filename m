Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E024C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18E6206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfAJFwf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 00:52:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAJFwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 00:52:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10343C049DFC;
        Thu, 10 Jan 2019 05:52:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA031179CB;
        Thu, 10 Jan 2019 05:52:33 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 371CA3F7CB;
        Thu, 10 Jan 2019 05:52:33 +0000 (UTC)
Date:   Thu, 10 Jan 2019 00:52:32 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        leozinho29 eu <leozinho29_eu@hotmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Adam Borowski <kilobyte@angband.pl>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
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
Message-ID: <1861725446.61345592.1547099552878.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190110005117.18282-1-sean.j.christopherson@intel.com>
References: <20190110005117.18282-1-sean.j.christopherson@intel.com>
Subject: Re: [PATCH] mm/mmu_notifier: mm/rmap.c: Fix a mmu_notifier range
 bug in try_to_unmap_one
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.65.161.12, 10.4.195.7]
Thread-Topic: mm/mmu_notifier: mm/rmap.c: Fix a mmu_notifier range bug in try_to_unmap_one
Thread-Index: NxVIbboUSCe9zovHI7aboNWzdLjs1g==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 10 Jan 2019 05:52:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
> Cc: Jérôme Glisse <jglisse@redhat.com>
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
> Fixes: ac46d4f3c432 ("mm/mmu_notifier: use structure for
> invalidate_range_start/end calls v2")
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
> @@ -1371,8 +1371,8 @@ static bool try_to_unmap_one(struct page *page, struct
> vm_area_struct *vma,
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

I was suspecting this patch for some other issue. But could not spot this after 
in depth analyzing the changed "invalidate_range_start/end calls". 

Its indeed a good catch. 

Reviewed-by: Pankaj gupta <pagupta@redhat.com>

> 2.19.2
> 
> 
