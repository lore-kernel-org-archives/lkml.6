Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B17CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63B320839
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63B320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeHXM7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:59:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:39994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726676AbeHXM7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:59:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 553AFAD0C;
        Fri, 24 Aug 2018 09:25:30 +0000 (UTC)
Date:   Fri, 24 Aug 2018 11:25:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180824092529.GG29735@dhcp22.suse.cz>
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823205917.16297-2-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-08-18 13:59:16, Mike Kravetz wrote:
[...]
> @@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
>  		address = pvmw.address;
>  
> +		if (PageHuge(page)) {
> +			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
> +				/*
> +				 * huge_pmd_unshare unmapped an entire PMD
> +				 * page.  There is no way of knowing exactly
> +				 * which PMDs may be cached for this mm, so
> +				 * we must flush them all.  start/end were
> +				 * already adjusted above to cover this range.
> +				 */
> +				flush_cache_range(vma, start, end);
> +				flush_tlb_range(vma, start, end);
> +				mmu_notifier_invalidate_range(mm, start, end);
> +
> +				/*
> +				 * The ref count of the PMD page was dropped
> +				 * which is part of the way map counting
> +				 * is done for shared PMDs.  Return 'true'
> +				 * here.  When there is no other sharing,
> +				 * huge_pmd_unshare returns false and we will
> +				 * unmap the actual page and drop map count
> +				 * to zero.
> +				 */
> +				page_vma_mapped_walk_done(&pvmw);
> +				break;
> +			}
> +		}

Wait a second. This is not correct, right? You have to call the
notifiers after page_vma_mapped_walk_done because they might be
sleepable and we are still holding the pte lock. This is btw. a problem
for other users of mmu_notifier_invalidate_range in try_to_unmap_one,
unless I am terribly confused. This would suggest 369ea8242c0fb is
incorrect.
-- 
Michal Hocko
SUSE Labs
