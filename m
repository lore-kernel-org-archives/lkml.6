Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59799ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F45B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F45B2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeGRCEK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:04:10 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:55901 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbeGRCEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:04:10 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6I1Scg6018671
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Jul 2018 10:28:38 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6I1Scmp030165;
        Wed, 18 Jul 2018 10:28:38 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6I1QbLD006221;
        Wed, 18 Jul 2018 10:28:38 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-2012317; Wed, 18 Jul 2018 10:28:18 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0319.002; Wed,
 18 Jul 2018 10:28:17 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Topic: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Index: AQHUHY+ZfA+YF2+Ff02zwneBkDT4a6SS4qaAgABf0YCAAFi/gA==
Date:   Wed, 18 Jul 2018 01:28:17 +0000
Message-ID: <20180718012817.GB12184@hori1.linux.bs1.fc.nec.co.jp>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1531805552-19547-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180717142743.GJ7193@dhcp22.suse.cz>
 <773a2f4e-c420-e973-cadd-4144730d28e8@oracle.com>
In-Reply-To: <773a2f4e-c420-e973-cadd-4144730d28e8@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <FD920B7331243C4CBAFDBF37FFBCA01A@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:10:39PM -0700, Mike Kravetz wrote:
> On 07/17/2018 07:27 AM, Michal Hocko wrote:
> > On Tue 17-07-18 14:32:31, Naoya Horiguchi wrote:
> >> There's a race condition between soft offline and hugetlb_fault which
> >> causes unexpected process killing and/or hugetlb allocation failure.
> >>
> >> The process killing is caused by the following flow:
> >>
> >>   CPU 0               CPU 1              CPU 2
> >>
> >>   soft offline
> >>     get_any_page
> >>     // find the hugetlb is free
> >>                       mmap a hugetlb file
> >>                       page fault
> >>                         ...
> >>                           hugetlb_fault
> >>                             hugetlb_no_page
> >>                               alloc_huge_page
> >>                               // succeed
> >>       soft_offline_free_page
> >>       // set hwpoison flag
> >>                                          mmap the hugetlb file
> >>                                          page fault
> >>                                            ...
> >>                                              hugetlb_fault
> >>                                                hugetlb_no_page
> >>                                                  find_lock_page
> >>                                                    return VM_FAULT_HWPOISON
> >>                                            mm_fault_error
> >>                                              do_sigbus
> >>                                              // kill the process
> >>
> >>
> >> The hugetlb allocation failure comes from the following flow:
> >>
> >>   CPU 0                          CPU 1
> >>
> >>                                  mmap a hugetlb file
> >>                                  // reserve all free page but don't fault-in
> >>   soft offline
> >>     get_any_page
> >>     // find the hugetlb is free
> >>       soft_offline_free_page
> >>       // set hwpoison flag
> >>         dissolve_free_huge_page
> >>         // fail because all free hugepages are reserved
> >>                                  page fault
> >>                                    ...
> >>                                      hugetlb_fault
> >>                                        hugetlb_no_page
> >>                                          alloc_huge_page
> >>                                            ...
> >>                                              dequeue_huge_page_node_exact
> >>                                              // ignore hwpoisoned hugepage
> >>                                              // and finally fail due to no-mem
> >>
> >> The root cause of this is that current soft-offline code is written
> >> based on an assumption that PageHWPoison flag should beset at first to
> >> avoid accessing the corrupted data.  This makes sense for memory_failure()
> >> or hard offline, but does not for soft offline because soft offline is
> >> about corrected (not uncorrected) error and is safe from data lost.
> >> This patch changes soft offline semantics where it sets PageHWPoison flag
> >> only after containment of the error page completes successfully.
> > 
> > Could you please expand on the worklow here please? The code is really
> > hard to grasp. I must be missing something because the thing shouldn't
> > be really complicated. Either the page is in the free pool and you just
> > remove it from the allocator (with hugetlb asking for a new hugeltb page
> > to guaratee reserves) or it is used and you just migrate the content to
> > a new page (again with the hugetlb reserves consideration). Why should
> > PageHWPoison flag ordering make any relevance?
> 
> My understanding may not be corect, but just looking at the current code
> for soft_offline_free_page helps me understand:
> 
> static void soft_offline_free_page(struct page *page)
> {
> 	struct page *head = compound_head(page);
> 
> 	if (!TestSetPageHWPoison(head)) {
> 		num_poisoned_pages_inc();
> 		if (PageHuge(head))
> 			dissolve_free_huge_page(page);
> 	}
> }
> 
> The HWPoison flag is set before even checking to determine if the huge
> page can be dissolved.  So, someone could could attempt to pull the page
> off the free list (if free) or fault/map it (if already associated with
> a file) which leads to the  failures described above.  The patches ensure
> that we only set HWPoison after successfully dissolving the page. At least
> that is how I understand it.

Thanks for elaborating, this is correct.

> 
> It seems that soft_offline_free_page can be called for in use pages.
> Certainly, that is the case in the first workflow above.  With the
> suggested changes, I think this is OK for huge pages.  However, it seems
> that setting HWPoison on a in use non-huge page could cause issues?

Just after dissolve_free_huge_page() returns, the target page is just a
free buddy page without PageHWPoison set. If this page is allocated
immediately, that's "migration succeeded, but soft offline failed" case,
so no problem.
Certainly, there also is a race between cheking TestSetPageHWPoison and
page allocation, so this issue is handled in patch 2/2.

> While looking at the code, I noticed this comment in __get_any_page()
>         /*
>          * When the target page is a free hugepage, just remove it
>          * from free hugepage list.
>          */
> Did that apply to some code that was removed?  It does not seem to make
> any sense in that routine.

This comment is completely obsolete, I'll remove this one.

Thanks,
Naoya Horiguchi
