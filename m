Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D7720671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D7720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeGSHCw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:02:52 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:42873 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeGSHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:02:52 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6J6LC8t011911
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:21:12 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6J6LCso015786;
        Thu, 19 Jul 2018 15:21:12 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6J6LCeX030019;
        Thu, 19 Jul 2018 15:21:12 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-2103309; Thu, 19 Jul 2018 15:19:47 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0319.002; Thu,
 19 Jul 2018 15:19:46 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Topic: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Index: AQHUHY+ZfA+YF2+Ff02zwneBkDT4a6SS4qaAgACvZYCAAIS7AIABaDSA
Date:   Thu, 19 Jul 2018 06:19:45 +0000
Message-ID: <20180719061945.GB22154@hori1.linux.bs1.fc.nec.co.jp>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1531805552-19547-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180717142743.GJ7193@dhcp22.suse.cz>
 <20180718005528.GA12184@hori1.linux.bs1.fc.nec.co.jp>
 <20180718085032.GS7193@dhcp22.suse.cz>
In-Reply-To: <20180718085032.GS7193@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <FB5EB1D2E8136747813E9060FC5E5350@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:50:32AM +0200, Michal Hocko wrote:
> On Wed 18-07-18 00:55:29, Naoya Horiguchi wrote:
> > On Tue, Jul 17, 2018 at 04:27:43PM +0200, Michal Hocko wrote:
> > > On Tue 17-07-18 14:32:31, Naoya Horiguchi wrote:
> > > > There's a race condition between soft offline and hugetlb_fault which
> > > > causes unexpected process killing and/or hugetlb allocation failure.
> > > >
> > > > The process killing is caused by the following flow:
> > > >
> > > >   CPU 0               CPU 1              CPU 2
> > > >
> > > >   soft offline
> > > >     get_any_page
> > > >     // find the hugetlb is free
> > > >                       mmap a hugetlb file
> > > >                       page fault
> > > >                         ...
> > > >                           hugetlb_fault
> > > >                             hugetlb_no_page
> > > >                               alloc_huge_page
> > > >                               // succeed
> > > >       soft_offline_free_page
> > > >       // set hwpoison flag
> > > >                                          mmap the hugetlb file
> > > >                                          page fault
> > > >                                            ...
> > > >                                              hugetlb_fault
> > > >                                                hugetlb_no_page
> > > >                                                  find_lock_page
> > > >                                                    return VM_FAULT_HWPOISON
> > > >                                            mm_fault_error
> > > >                                              do_sigbus
> > > >                                              // kill the process
> > > >
> > > >
> > > > The hugetlb allocation failure comes from the following flow:
> > > >
> > > >   CPU 0                          CPU 1
> > > >
> > > >                                  mmap a hugetlb file
> > > >                                  // reserve all free page but don't fault-in
> > > >   soft offline
> > > >     get_any_page
> > > >     // find the hugetlb is free
> > > >       soft_offline_free_page
> > > >       // set hwpoison flag
> > > >         dissolve_free_huge_page
> > > >         // fail because all free hugepages are reserved
> > > >                                  page fault
> > > >                                    ...
> > > >                                      hugetlb_fault
> > > >                                        hugetlb_no_page
> > > >                                          alloc_huge_page
> > > >                                            ...
> > > >                                              dequeue_huge_page_node_exact
> > > >                                              // ignore hwpoisoned hugepage
> > > >                                              // and finally fail due to no-mem
> > > >
> > > > The root cause of this is that current soft-offline code is written
> > > > based on an assumption that PageHWPoison flag should beset at first to
> > > > avoid accessing the corrupted data.  This makes sense for memory_failure()
> > > > or hard offline, but does not for soft offline because soft offline is
> > > > about corrected (not uncorrected) error and is safe from data lost.
> > > > This patch changes soft offline semantics where it sets PageHWPoison flag
> > > > only after containment of the error page completes successfully.
> > >
> > > Could you please expand on the worklow here please? The code is really
> > > hard to grasp. I must be missing something because the thing shouldn't
> > > be really complicated. Either the page is in the free pool and you just
> > > remove it from the allocator (with hugetlb asking for a new hugeltb page
> > > to guaratee reserves) or it is used and you just migrate the content to
> > > a new page (again with the hugetlb reserves consideration). Why should
> > > PageHWPoison flag ordering make any relevance?
> >
> > (Considering soft offlining free hugepage,)
> > PageHWPoison is set at first before this patch, which is racy with
> > hugetlb fault code because it's not protected by hugetlb_lock.
> >
> > Originally this was written in the similar manner as hard-offline, where
> > the race is accepted and a PageHWPoison flag is set as soon as possible.
> > But actually that's found not necessary/correct because soft offline is
> > supposed to be less aggressive and failure is OK.
>
> OK
>
> > So this patch is suggesting to make soft-offline less aggressive by
> > moving SetPageHWPoison into the lock.
>
> I guess I still do not understand why we should even care about the
> ordering of the HWPoison flag setting. Why cannot we simply have the
> following code flow? Or maybe we are doing that already I just do not
> follow the code
>
> 	soft_offline
> 	  check page_count
> 	    - free - normal page - remove from the allocator
> 	           - hugetlb - allocate a new hugetlb page && remove from the pool
> 	    - used - migrate to a new page && never release the old one
>
> Why do we even need HWPoison flag here? Everything can be completely
> transparent to the application. It shouldn't fail from what I
> understood.

PageHWPoison flag is used to the 'remove from the allocator' part
which is like below:

  static inline
  struct page *rmqueue(
          ...
          do {
                  page = NULL;
                  if (alloc_flags & ALLOC_HARDER) {
                          page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
                          if (page)
                                  trace_mm_page_alloc_zone_locked(page, order, migratetype);
                  }
                  if (!page)
                          page = __rmqueue(zone, order, migratetype);
          } while (page && check_new_pages(page, order));

check_new_pages() returns true if the page taken from free list has
a hwpoison page so that the allocator iterates another round to get
another page.

There's no function that can be called from outside allocator to remove
a page in allocator.  So actual page removal is done at allocation time,
not at error handling time. That's the reason why we need PageHWPoison.

Thanks,
Naoya Horiguchi


> > > Do I get it right that the only difference between the hard and soft
> > > offlining is that hugetlb reserves might break for the former while not
> > > for the latter
> >
> > Correct.
> >
> > > and that the failed migration kills all owners for the
> > > former while not for latter?
> >
> > Hard-offline doesn't cause any page migration because the data is already
> > lost, but yes it can kill the owners.
> > Soft-offline never kills processes even if it fails (due to migration failrue
> > or some other reasons.)
> >
> > I listed below some common points and differences between hard-offline
> > and soft-offline.
> >
> >   common points
> >     - they are both contained by PageHWPoison flag,
> >     - error is injected via simliar interfaces.
> >
> >   differences
> >     - the data on the page is considered lost in hard offline, but is not
> >       in soft offline,
> >     - hard offline likely kills the affected processes, but soft offline
> >       never kills processes,
> >     - soft offline causes page migration, but hard offline does not,
> >     - hard offline prioritizes to prevent consumption of broken data with
> >       accepting some race, and soft offline prioritizes not to impact
> >       userspace with accepting failure.
> >
> > Looks to me that there're more differences rather than commont points.
>
> Thanks for the summary. It certainly helped me
> --
> Michal Hocko
> SUSE Labs
>
