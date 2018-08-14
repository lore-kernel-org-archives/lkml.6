Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E389C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DD221533
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DD221533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbeHNLex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:34:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:59103 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeHNLex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:34:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 01:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,237,1531810800"; 
   d="scan'208";a="254665983"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2018 01:48:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A4279F5; Tue, 14 Aug 2018 11:48:37 +0300 (EEST)
Date:   Tue, 14 Aug 2018 11:48:37 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: migration: fix migration of huge PMD shared pages
Message-ID: <20180814084837.nl7dkea7aov2pzao@black.fi.intel.com>
References: <20180813034108.27269-1-mike.kravetz@oracle.com>
 <20180813105821.j4tg6iyrdxgwyr3y@kshutemo-mobl1>
 <d4cf0f85-e010-36f2-3fae-f7983e4f6505@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4cf0f85-e010-36f2-3fae-f7983e4f6505@oracle.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 11:21:41PM +0000, Mike Kravetz wrote:
> On 08/13/2018 03:58 AM, Kirill A. Shutemov wrote:
> > On Sun, Aug 12, 2018 at 08:41:08PM -0700, Mike Kravetz wrote:
> >> The page migration code employs try_to_unmap() to try and unmap the
> >> source page.  This is accomplished by using rmap_walk to find all
> >> vmas where the page is mapped.  This search stops when page mapcount
> >> is zero.  For shared PMD huge pages, the page map count is always 1
> >> not matter the number of mappings.  Shared mappings are tracked via
> >> the reference count of the PMD page.  Therefore, try_to_unmap stops
> >> prematurely and does not completely unmap all mappings of the source
> >> page.
> >>
> >> This problem can result is data corruption as writes to the original
> >> source page can happen after contents of the page are copied to the
> >> target page.  Hence, data is lost.
> >>
> >> This problem was originally seen as DB corruption of shared global
> >> areas after a huge page was soft offlined.  DB developers noticed
> >> they could reproduce the issue by (hotplug) offlining memory used
> >> to back huge pages.  A simple testcase can reproduce the problem by
> >> creating a shared PMD mapping (note that this must be at least
> >> PUD_SIZE in size and PUD_SIZE aligned (1GB on x86)), and using
> >> migrate_pages() to migrate process pages between nodes.
> >>
> >> To fix, have the try_to_unmap_one routine check for huge PMD sharing
> >> by calling huge_pmd_unshare for hugetlbfs huge pages.  If it is a
> >> shared mapping it will be 'unshared' which removes the page table
> >> entry and drops reference on PMD page.  After this, flush caches and
> >> TLB.
> >>
> >> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >> ---
> >> I am not %100 sure on the required flushing, so suggestions would be
> >> appreciated.  This also should go to stable.  It has been around for
> >> a long time so still looking for an appropriate 'fixes:'.
> > 
> > I believe we need flushing. And huge_pmd_unshare() usage in
> > __unmap_hugepage_range() looks suspicious: I don't see how we flush TLB in
> > that case.
> 
> Thanks Kirill,
> 
> __unmap_hugepage_range() has two callers:
> 1) unmap_hugepage_range, which wraps the call with tlb_gather_mmu and
>    tlb_finish_mmu on the range.  IIUC, this should cause an appropriate
>    TLB flush.
> 2) __unmap_hugepage_range_final via unmap_single_vma.  unmap_single_vma
>   has three callers:
>   - unmap_vmas which assumes the caller will flush the whole range after
>     return.
>   - zap_page_range wraps the call with tlb_gather_mmu/tlb_finish_mmu
>   - zap_page_range_single wraps the call with tlb_gather_mmu/tlb_finish_mmu
> 
> So, it appears we are covered.  But, I could be missing something.

My problem here is that the mapping that moved by huge_pmd_unshare() in
not accounted into mmu_gather and can be missed on tlb_finish_mmu().

-- 
 Kirill A. Shutemov
