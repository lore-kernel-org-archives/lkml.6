Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5185C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6693D2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6693D2157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeHXMPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:15:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:60316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbeHXMPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:15:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C631FAFC6;
        Fri, 24 Aug 2018 08:41:57 +0000 (UTC)
Date:   Fri, 24 Aug 2018 10:41:57 +0200
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
Message-ID: <20180824084157.GD29735@dhcp22.suse.cz>
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
> The page migration code employs try_to_unmap() to try and unmap the
> source page.  This is accomplished by using rmap_walk to find all
> vmas where the page is mapped.  This search stops when page mapcount
> is zero.  For shared PMD huge pages, the page map count is always 1
> no matter the number of mappings.  Shared mappings are tracked via
> the reference count of the PMD page.  Therefore, try_to_unmap stops
> prematurely and does not completely unmap all mappings of the source
> page.
> 
> This problem can result is data corruption as writes to the original
> source page can happen after contents of the page are copied to the
> target page.  Hence, data is lost.
> 
> This problem was originally seen as DB corruption of shared global
> areas after a huge page was soft offlined due to ECC memory errors.
> DB developers noticed they could reproduce the issue by (hotplug)
> offlining memory used to back huge pages.  A simple testcase can
> reproduce the problem by creating a shared PMD mapping (note that
> this must be at least PUD_SIZE in size and PUD_SIZE aligned (1GB on
> x86)), and using migrate_pages() to migrate process pages between
> nodes while continually writing to the huge pages being migrated.
> 
> To fix, have the try_to_unmap_one routine check for huge PMD sharing
> by calling huge_pmd_unshare for hugetlbfs huge pages.  If it is a
> shared mapping it will be 'unshared' which removes the page table
> entry and drops the reference on the PMD page.  After this, flush
> caches and TLB.
> 
> mmu notifiers are called before locking page tables, but we can not
> be sure of PMD sharing until page tables are locked.  Therefore,
> check for the possibility of PMD sharing before locking so that
> notifiers can prepare for the worst possible case.
> 
> Fixes: 39dde65c9940 ("shared page table for hugetlb page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

One nit below.

[...]
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3103099f64fd..a73c5728e961 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4548,6 +4548,9 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
>  	return saddr;
>  }
>  
> +#define _range_in_vma(vma, start, end) \
> +	((vma)->vm_start <= (start) && (end) <= (vma)->vm_end)
> +

static inline please. Macros and potential side effects on given
arguments are just not worth the risk. I also think this is something
for more general use. We have that pattern at many places. So I would
stick that to linux/mm.h

Thanks!
-- 
Michal Hocko
SUSE Labs
