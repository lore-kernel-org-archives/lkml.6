Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54446C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011422174C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011422174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbeHNJOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:14:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeHNJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:14:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E49413EE;
        Tue, 14 Aug 2018 06:28:15 +0000 (UTC)
Date:   Tue, 14 Aug 2018 08:28:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: migration: fix migration of huge PMD shared pages
Message-ID: <20180814062813.GA22413@kroah.com>
References: <201808131221.zDDttbc8%fengguang.wu@intel.com>
 <20180814003058.19732-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814003058.19732-1-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 05:30:58PM -0700, Mike Kravetz wrote:
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
> Fixes: 39dde65c9940 ("shared page table for hugetlb page")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
> v2: Fixed build issue for !CONFIG_HUGETLB_PAGE and typos in comment
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
