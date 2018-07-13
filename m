Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA531ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8947D2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8947D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeGMUwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:52:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbeGMUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:51:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73DFCAE0;
        Fri, 13 Jul 2018 20:35:46 +0000 (UTC)
Date:   Fri, 13 Jul 2018 13:35:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm: fix race on soft-offlining free huge pages
Message-Id: <20180713133545.658173ca953e7d2a8a4ee6bd@linux-foundation.org>
In-Reply-To: <1531452366-11661-2-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1531452366-11661-1-git-send-email-n-horiguchi@ah.jp.nec.com>
        <1531452366-11661-2-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 12:26:05 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:

> There's a race condition between soft offline and hugetlb_fault which
> causes unexpected process killing and/or hugetlb allocation failure.
> 
> The process killing is caused by the following flow:
> 
>   CPU 0               CPU 1              CPU 2
> 
>   soft offline
>     get_any_page
>     // find the hugetlb is free
>                       mmap a hugetlb file
>                       page fault
>                         ...
>                           hugetlb_fault
>                             hugetlb_no_page
>                               alloc_huge_page
>                               // succeed
>       soft_offline_free_page
>       // set hwpoison flag
>                                          mmap the hugetlb file
>                                          page fault
>                                            ...
>                                              hugetlb_fault
>                                                hugetlb_no_page
>                                                  find_lock_page
>                                                    return VM_FAULT_HWPOISON
>                                            mm_fault_error
>                                              do_sigbus
>                                              // kill the process
> 
> 
> The hugetlb allocation failure comes from the following flow:
> 
>   CPU 0                          CPU 1
> 
>                                  mmap a hugetlb file
>                                  // reserve all free page but don't fault-in
>   soft offline
>     get_any_page
>     // find the hugetlb is free
>       soft_offline_free_page
>       // set hwpoison flag
>         dissolve_free_huge_page
>         // fail because all free hugepages are reserved
>                                  page fault
>                                    ...
>                                      hugetlb_fault
>                                        hugetlb_no_page
>                                          alloc_huge_page
>                                            ...
>                                              dequeue_huge_page_node_exact
>                                              // ignore hwpoisoned hugepage
>                                              // and finally fail due to no-mem
> 
> The root cause of this is that current soft-offline code is written
> based on an assumption that PageHWPoison flag should beset at first to
> avoid accessing the corrupted data.  This makes sense for memory_failure()
> or hard offline, but does not for soft offline because soft offline is
> about corrected (not uncorrected) error and is safe from data lost.
> This patch changes soft offline semantics where it sets PageHWPoison flag
> only after containment of the error page completes successfully.
> 
> ...
>
> --- v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c
> +++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
> @@ -1598,8 +1598,18 @@ static int soft_offline_huge_page(struct page *page, int flags)
>  		if (ret > 0)
>  			ret = -EIO;
>  	} else {
> -		if (PageHuge(page))
> -			dissolve_free_huge_page(page);
> +		/*
> +		 * We set PG_hwpoison only when the migration source hugepage
> +		 * was successfully dissolved, because otherwise hwpoisoned
> +		 * hugepage remains on free hugepage list, then userspace will
> +		 * find it as SIGBUS by allocation failure. That's not expected
> +		 * in soft-offlining.
> +		 */

This comment is unclear.  What happens if there's a hwpoisoned page on
the freelist?  The allocator just skips it and looks for another page? 
Or does the allocator return the poisoned page, it gets mapped and
userspace gets a SIGBUS when accessing it?  If the latter (or the
former!), why does the comment mention allocation failure?



