Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981C7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8F220693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8F220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbeGRCYq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:24:46 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:60042 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeGRCYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:24:46 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6I1nDY8002657
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Jul 2018 10:49:13 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6I1nDVf011247;
        Wed, 18 Jul 2018 10:49:13 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6I1kcpG022628;
        Wed, 18 Jul 2018 10:49:13 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-2060329; Wed, 18 Jul 2018 10:41:08 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Wed,
 18 Jul 2018 10:41:07 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Topic: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Index: AQHUHY+ZfA+YF2+Ff02zwneBkDT4a6SS4qaAgACvZYCAAAy/AA==
Date:   Wed, 18 Jul 2018 01:41:06 +0000
Message-ID: <20180718014106.GC12184@hori1.linux.bs1.fc.nec.co.jp>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1531805552-19547-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180717142743.GJ7193@dhcp22.suse.cz>
 <20180718005528.GA12184@hori1.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20180718005528.GA12184@hori1.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <17B3499424B95046AD437A3299570E4B@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:55:29AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> On Tue, Jul 17, 2018 at 04:27:43PM +0200, Michal Hocko wrote:
> > On Tue 17-07-18 14:32:31, Naoya Horiguchi wrote:
> > > There's a race condition between soft offline and hugetlb_fault which
> > > causes unexpected process killing and/or hugetlb allocation failure.
> > > 
> > > The process killing is caused by the following flow:
> > > 
> > >   CPU 0               CPU 1              CPU 2
> > > 
> > >   soft offline
> > >     get_any_page
> > >     // find the hugetlb is free
> > >                       mmap a hugetlb file
> > >                       page fault
> > >                         ...
> > >                           hugetlb_fault
> > >                             hugetlb_no_page
> > >                               alloc_huge_page
> > >                               // succeed
> > >       soft_offline_free_page
> > >       // set hwpoison flag
> > >                                          mmap the hugetlb file
> > >                                          page fault
> > >                                            ...
> > >                                              hugetlb_fault
> > >                                                hugetlb_no_page
> > >                                                  find_lock_page
> > >                                                    return VM_FAULT_HWPOISON
> > >                                            mm_fault_error
> > >                                              do_sigbus
> > >                                              // kill the process
> > > 
> > > 
> > > The hugetlb allocation failure comes from the following flow:
> > > 
> > >   CPU 0                          CPU 1
> > > 
> > >                                  mmap a hugetlb file
> > >                                  // reserve all free page but don't fault-in
> > >   soft offline
> > >     get_any_page
> > >     // find the hugetlb is free
> > >       soft_offline_free_page
> > >       // set hwpoison flag
> > >         dissolve_free_huge_page
> > >         // fail because all free hugepages are reserved
> > >                                  page fault
> > >                                    ...
> > >                                      hugetlb_fault
> > >                                        hugetlb_no_page
> > >                                          alloc_huge_page
> > >                                            ...
> > >                                              dequeue_huge_page_node_exact
> > >                                              // ignore hwpoisoned hugepage
> > >                                              // and finally fail due to no-mem
> > > 
> > > The root cause of this is that current soft-offline code is written
> > > based on an assumption that PageHWPoison flag should beset at first to
> > > avoid accessing the corrupted data.  This makes sense for memory_failure()
> > > or hard offline, but does not for soft offline because soft offline is
> > > about corrected (not uncorrected) error and is safe from data lost.
> > > This patch changes soft offline semantics where it sets PageHWPoison flag
> > > only after containment of the error page completes successfully.
> > 
> > Could you please expand on the worklow here please? The code is really
> > hard to grasp. I must be missing something because the thing shouldn't
> > be really complicated. Either the page is in the free pool and you just
> > remove it from the allocator (with hugetlb asking for a new hugeltb page
> > to guaratee reserves) or it is used and you just migrate the content to
> > a new page (again with the hugetlb reserves consideration). Why should
> > PageHWPoison flag ordering make any relevance?
> 
> (Considering soft offlining free hugepage,)
> PageHWPoison is set at first before this patch, which is racy with
> hugetlb fault code because it's not protected by hugetlb_lock.
> 
> Originally this was written in the similar manner as hard-offline, where
> the race is accepted and a PageHWPoison flag is set as soon as possible.
> But actually that's found not necessary/correct because soft offline is
> supposed to be less aggressive and failure is OK.
> 
> So this patch is suggesting to make soft-offline less aggressive


> by moving SetPageHWPoison into the lock.

My apology, this part of reasoning was incorrect.  What patch 1/2 actually
does is transforming the issue into the normal page's similar race issue
which is solved by patch 2/2.  After patch 1/2, soft offline never sets
PageHWPoison on hugepage.

Thanks,
Naoya Horiguchi

> 
> > 
> > Do I get it right that the only difference between the hard and soft
> > offlining is that hugetlb reserves might break for the former while not
> > for the latter
> 
> Correct.
> 
> > and that the failed migration kills all owners for the
> > former while not for latter?
> 
> Hard-offline doesn't cause any page migration because the data is already
> lost, but yes it can kill the owners.
> Soft-offline never kills processes even if it fails (due to migration failrue
> or some other reasons.)
> 
> I listed below some common points and differences between hard-offline
> and soft-offline.
> 
>   common points
>     - they are both contained by PageHWPoison flag,
>     - error is injected via simliar interfaces.
> 
>   differences
>     - the data on the page is considered lost in hard offline, but is not
>       in soft offline,
>     - hard offline likely kills the affected processes, but soft offline
>       never kills processes,
>     - soft offline causes page migration, but hard offline does not,
>     - hard offline prioritizes to prevent consumption of broken data with
>       accepting some race, and soft offline prioritizes not to impact
>       userspace with accepting failure.
> 
> Looks to me that there're more differences rather than commont points.
