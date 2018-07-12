Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B91C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA37C20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA37C20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbeGLBtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:49:06 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49866 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387807AbeGLBtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:49:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T4SG70u_1531359620;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T4SG70u_1531359620)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Jul 2018 09:40:23 +0800
Subject: Re: [PATCH] thp: fix data loss when splitting a file pmd
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ashwin Chaugule <ashwinch@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.LSU.2.11.1807111741430.1106@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <769d0c1d-120a-9a0b-28e3-477830b4606a@linux.alibaba.com>
Date:   Wed, 11 Jul 2018 18:40:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1807111741430.1106@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/18 5:48 PM, Hugh Dickins wrote:
> __split_huge_pmd_locked() must check if the cleared huge pmd was dirty,
> and propagate that to PageDirty: otherwise, data may be lost when a huge
> tmpfs page is modified then split then reclaimed.
>
> How has this taken so long to be noticed?  Because there was no problem
> when the huge page is written by a write system call (shmem_write_end()
> calls set_page_dirty()), nor when the page is allocated for a write fault
> (fault_dirty_shared_page() calls set_page_dirty()); but when allocated
> for a read fault (which MAP_POPULATE simulates), no set_page_dirty().

Sounds good to me. Reviewed-by: Yang Shi <yang.shi@linux.alibaba.com>

> Fixes: d21b9e57c74c ("thp: handle file pages in split_huge_pmd()")
> Reported-by: Ashwin Chaugule <ashwinch@google.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: <stable@vger.kernel.org> # v4.8+
> ---
>
>   mm/huge_memory.c |    2 ++
>   1 file changed, 2 insertions(+)
>
> --- 4.18-rc4/mm/huge_memory.c	2018-06-16 18:48:22.029173363 -0700
> +++ linux/mm/huge_memory.c	2018-07-10 20:11:29.991011603 -0700
> @@ -2084,6 +2084,8 @@ static void __split_huge_pmd_locked(stru
>   		if (vma_is_dax(vma))
>   			return;
>   		page = pmd_page(_pmd);
> +		if (!PageDirty(page) && pmd_dirty(_pmd))
> +			set_page_dirty(page);
>   		if (!PageReferenced(page) && pmd_young(_pmd))
>   			SetPageReferenced(page);
>   		page_remove_rmap(page, true);

