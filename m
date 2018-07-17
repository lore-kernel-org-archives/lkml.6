Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029DBECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E8E20850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E8E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeGQA6Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:58:25 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45609 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbeGQA6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:58:25 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6H0SNjO014334
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 09:28:23 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H0SNcS023566;
        Tue, 17 Jul 2018 09:28:23 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H0RLRQ027190;
        Tue, 17 Jul 2018 09:28:23 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-2018866; Tue, 17 Jul 2018 09:25:20 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Tue,
 17 Jul 2018 09:25:19 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] mm: fix race on soft-offlining free huge pages
Thread-Topic: [PATCH v1 1/2] mm: fix race on soft-offlining free huge pages
Thread-Index: AQHUGllLa36hs3TAokS/QccRcBkI+6SNBpOAgAT3I4A=
Date:   Tue, 17 Jul 2018 00:25:19 +0000
Message-ID: <20180717002518.GA4673@hori1.linux.bs1.fc.nec.co.jp>
References: <1531452366-11661-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1531452366-11661-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180713133545.658173ca953e7d2a8a4ee6bd@linux-foundation.org>
In-Reply-To: <20180713133545.658173ca953e7d2a8a4ee6bd@linux-foundation.org>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.83]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <F871C069B6AEFB418A4EB07B3710BAA6@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 01:35:45PM -0700, Andrew Morton wrote:
> On Fri, 13 Jul 2018 12:26:05 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:
> 
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
> > 
> > ...
> >
> > --- v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c
> > +++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
> > @@ -1598,8 +1598,18 @@ static int soft_offline_huge_page(struct page *page, int flags)
> >  		if (ret > 0)
> >  			ret = -EIO;
> >  	} else {
> > -		if (PageHuge(page))
> > -			dissolve_free_huge_page(page);
> > +		/*
> > +		 * We set PG_hwpoison only when the migration source hugepage
> > +		 * was successfully dissolved, because otherwise hwpoisoned
> > +		 * hugepage remains on free hugepage list, then userspace will
> > +		 * find it as SIGBUS by allocation failure. That's not expected
> > +		 * in soft-offlining.
> > +		 */
> 
> This comment is unclear.  What happens if there's a hwpoisoned page on
> the freelist?  The allocator just skips it and looks for another page? 

Yes, this is what the allocator does.

> Or does the allocator return the poisoned page, it gets mapped and
> userspace gets a SIGBUS when accessing it?  If the latter (or the
> former!), why does the comment mention allocation failure?

The mention to allocation failure was unclear, I'd like to replace
with below, is it clearer?

+		/*
+		 * We set PG_hwpoison only when the migration source hugepage
+		 * was successfully dissolved, because otherwise hwpoisoned
+		 * hugepage remains on free hugepage list. The allocator ignores
+		 * such a hwpoisoned page so it's never allocated, but it could
+		 * kill a process because of no-memory rather than hwpoison.
+		 * Soft-offline never impacts the userspace, so this is undesired.
+		 */

Thanks,
Naoya Horiguchi
