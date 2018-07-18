Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFC5ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754A620693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754A620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeGRBfO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:35:14 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:55491 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbeGRBfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:35:14 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6I0xo9V032702
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Jul 2018 09:59:50 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6I0xork032223;
        Wed, 18 Jul 2018 09:59:50 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6I0xVdm014807;
        Wed, 18 Jul 2018 09:59:50 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-2045699; Wed, 18 Jul 2018 09:55:31 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Wed,
 18 Jul 2018 09:55:30 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Topic: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Index: AQHUHY+ZfA+YF2+Ff02zwneBkDT4a6SS4qaAgACvZYA=
Date:   Wed, 18 Jul 2018 00:55:29 +0000
Message-ID: <20180718005528.GA12184@hori1.linux.bs1.fc.nec.co.jp>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1531805552-19547-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180717142743.GJ7193@dhcp22.suse.cz>
In-Reply-To: <20180717142743.GJ7193@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6FFDF45C1E8AD64E88E9A9492850100B@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:27:43PM +0200, Michal Hocko wrote:
> On Tue 17-07-18 14:32:31, Naoya Horiguchi wrote:
> > There's a race condition between soft offline and hugetlb_fault which
> > causes unexpected process killing and/or hugetlb allocation failure.
> > 
> > The process killing is caused by the following flow:
> > 
> >   CPU 0               CPU 1              CPU 2
> > 
> >   soft offline
> >     get_any_page
> >     // find the hugetlb is free
> >                       mmap a hugetlb file
> >                       page fault
> >                         ...
> >                           hugetlb_fault
> >                             hugetlb_no_page
> >                               alloc_huge_page
> >                               // succeed
> >       soft_offline_free_page
> >       // set hwpoison flag
> >                                          mmap the hugetlb file
> >                                          page fault
> >                                            ...
> >                                              hugetlb_fault
> >                                                hugetlb_no_page
> >                                                  find_lock_page
> >                                                    return VM_FAULT_HWPOISON
> >                                            mm_fault_error
> >                                              do_sigbus
> >                                              // kill the process
> > 
> > 
> > The hugetlb allocation failure comes from the following flow:
> > 
> >   CPU 0                          CPU 1
> > 
> >                                  mmap a hugetlb file
> >                                  // reserve all free page but don't fault-in
> >   soft offline
> >     get_any_page
> >     // find the hugetlb is free
> >       soft_offline_free_page
> >       // set hwpoison flag
> >         dissolve_free_huge_page
> >         // fail because all free hugepages are reserved
> >                                  page fault
> >                                    ...
> >                                      hugetlb_fault
> >                                        hugetlb_no_page
> >                                          alloc_huge_page
> >                                            ...
> >                                              dequeue_huge_page_node_exact
> >                                              // ignore hwpoisoned hugepage
> >                                              // and finally fail due to no-mem
> > 
> > The root cause of this is that current soft-offline code is written
> > based on an assumption that PageHWPoison flag should beset at first to
> > avoid accessing the corrupted data.  This makes sense for memory_failure()
> > or hard offline, but does not for soft offline because soft offline is
> > about corrected (not uncorrected) error and is safe from data lost.
> > This patch changes soft offline semantics where it sets PageHWPoison flag
> > only after containment of the error page completes successfully.
> 
> Could you please expand on the worklow here please? The code is really
> hard to grasp. I must be missing something because the thing shouldn't
> be really complicated. Either the page is in the free pool and you just
> remove it from the allocator (with hugetlb asking for a new hugeltb page
> to guaratee reserves) or it is used and you just migrate the content to
> a new page (again with the hugetlb reserves consideration). Why should
> PageHWPoison flag ordering make any relevance?

(Considering soft offlining free hugepage,)
PageHWPoison is set at first before this patch, which is racy with
hugetlb fault code because it's not protected by hugetlb_lock.

Originally this was written in the similar manner as hard-offline, where
the race is accepted and a PageHWPoison flag is set as soon as possible.
But actually that's found not necessary/correct because soft offline is
supposed to be less aggressive and failure is OK.

So this patch is suggesting to make soft-offline less aggressive by
moving SetPageHWPoison into the lock.

> 
> Do I get it right that the only difference between the hard and soft
> offlining is that hugetlb reserves might break for the former while not
> for the latter

Correct.

> and that the failed migration kills all owners for the
> former while not for latter?

Hard-offline doesn't cause any page migration because the data is already
lost, but yes it can kill the owners.
Soft-offline never kills processes even if it fails (due to migration failrue
or some other reasons.)

I listed below some common points and differences between hard-offline
and soft-offline.

  common points
    - they are both contained by PageHWPoison flag,
    - error is injected via simliar interfaces.

  differences
    - the data on the page is considered lost in hard offline, but is not
      in soft offline,
    - hard offline likely kills the affected processes, but soft offline
      never kills processes,
    - soft offline causes page migration, but hard offline does not,
    - hard offline prioritizes to prevent consumption of broken data with
      accepting some race, and soft offline prioritizes not to impact
      userspace with accepting failure.

Looks to me that there're more differences rather than commont points.

Thanks,
Naoya Horiguchi

>  
> > Reported-by: Xishi Qiu <xishi.qiuxishi@alibaba-inc.com>
> > Suggested-by: Xishi Qiu <xishi.qiuxishi@alibaba-inc.com>
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > ---
> > changelog v1->v2:
> > - don't use set_hwpoison_free_buddy_page() (not defined yet)
> > - updated comment in soft_offline_huge_page()
> > ---
> >  mm/hugetlb.c        | 11 +++++------
> >  mm/memory-failure.c | 24 ++++++++++++++++++------
> >  mm/migrate.c        |  2 --
> >  3 files changed, 23 insertions(+), 14 deletions(-)
> > 
> > diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/hugetlb.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/hugetlb.c
> > index 430be42..937c142 100644
> > --- v4.18-rc4-mmotm-2018-07-10-16-50/mm/hugetlb.c
> > +++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/hugetlb.c
> > @@ -1479,22 +1479,20 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> >  /*
> >   * Dissolve a given free hugepage into free buddy pages. This function does
> >   * nothing for in-use (including surplus) hugepages. Returns -EBUSY if the
> > - * number of free hugepages would be reduced below the number of reserved
> > - * hugepages.
> > + * dissolution fails because a give page is not a free hugepage, or because
> > + * free hugepages are fully reserved.
> >   */
> >  int dissolve_free_huge_page(struct page *page)
> >  {
> > -	int rc = 0;
> > +	int rc = -EBUSY;
> >  
> >  	spin_lock(&hugetlb_lock);
> >  	if (PageHuge(page) && !page_count(page)) {
> >  		struct page *head = compound_head(page);
> >  		struct hstate *h = page_hstate(head);
> >  		int nid = page_to_nid(head);
> > -		if (h->free_huge_pages - h->resv_huge_pages == 0) {
> > -			rc = -EBUSY;
> > +		if (h->free_huge_pages - h->resv_huge_pages == 0)
> >  			goto out;
> > -		}
> >  		/*
> >  		 * Move PageHWPoison flag from head page to the raw error page,
> >  		 * which makes any subpages rather than the error page reusable.
> > @@ -1508,6 +1506,7 @@ int dissolve_free_huge_page(struct page *page)
> >  		h->free_huge_pages_node[nid]--;
> >  		h->max_huge_pages--;
> >  		update_and_free_page(h, head);
> > +		rc = 0;
> >  	}
> >  out:
> >  	spin_unlock(&hugetlb_lock);
> > diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
> > index 9d142b9..9b77f85 100644
> > --- v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c
> > +++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
> > @@ -1598,8 +1598,20 @@ static int soft_offline_huge_page(struct page *page, int flags)
> >  		if (ret > 0)
> >  			ret = -EIO;
> >  	} else {
> > -		if (PageHuge(page))
> > -			dissolve_free_huge_page(page);
> > +		/*
> > +		 * We set PG_hwpoison only when the migration source hugepage
> > +		 * was successfully dissolved, because otherwise hwpoisoned
> > +		 * hugepage remains on free hugepage list. The allocator ignores
> > +		 * such a hwpoisoned page so it's never allocated, but it could
> > +		 * kill a process because of no-memory rather than hwpoison.
> > +		 * Soft-offline never impacts the userspace, so this is
> > +		 * undesired.
> > +		 */
> > +		ret = dissolve_free_huge_page(page);
> > +		if (!ret) {
> > +			if (!TestSetPageHWPoison(page))
> > +				num_poisoned_pages_inc();
> > +		}
> >  	}
> >  	return ret;
> >  }
> > @@ -1715,13 +1727,13 @@ static int soft_offline_in_use_page(struct page *page, int flags)
> >  
> >  static void soft_offline_free_page(struct page *page)
> >  {
> > +	int rc = 0;
> >  	struct page *head = compound_head(page);
> >  
> > -	if (!TestSetPageHWPoison(head)) {
> > +	if (PageHuge(head))
> > +		rc = dissolve_free_huge_page(page);
> > +	if (!rc && !TestSetPageHWPoison(page))
> >  		num_poisoned_pages_inc();
> > -		if (PageHuge(head))
> > -			dissolve_free_huge_page(page);
> > -	}
> >  }
> >  
> >  /**
> > diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/migrate.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/migrate.c
> > index 198af42..3ae213b 100644
> > --- v4.18-rc4-mmotm-2018-07-10-16-50/mm/migrate.c
> > +++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/migrate.c
> > @@ -1318,8 +1318,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >  out:
> >  	if (rc != -EAGAIN)
> >  		putback_active_hugepage(hpage);
> > -	if (reason == MR_MEMORY_FAILURE && !test_set_page_hwpoison(hpage))
> > -		num_poisoned_pages_inc();
> >  
> >  	/*
> >  	 * If migration was not successful and there's a freeing callback, use
> > -- 
> > 2.7.0
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
