Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA35C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED32218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfBAOSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:18:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfBAOSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:18:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61FBA81DE9;
        Fri,  1 Feb 2019 14:18:14 +0000 (UTC)
Received: from [10.36.118.43] (unknown [10.36.118.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32038381B6;
        Fri,  1 Feb 2019 14:18:07 +0000 (UTC)
Subject: Re: [PATCH v2 for-4.4-stable] mm: migrate: don't rely on
 __PageMovable() of newpage after unlocking it
To:     Greg KH <greg@kroah.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vratislav Bendel <vbendel@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
        Minchan Kim <minchan@kernel.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20190131020448.072FE218AF@mail.kernel.org>
 <20190201134347.11166-1-david@redhat.com> <20190201140918.GB20335@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <518dd92f-f017-707a-ea36-bcb97e67168e@redhat.com>
Date:   Fri, 1 Feb 2019 15:18:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190201140918.GB20335@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 01 Feb 2019 14:18:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.19 15:09, Greg KH wrote:
> On Fri, Feb 01, 2019 at 02:43:47PM +0100, David Hildenbrand wrote:
>> This is the backport for 4.4-stable.
>>
>> We had a race in the old balloon compaction code before commit b1123ea6d3b3
>> ("mm: balloon: use general non-lru movable page feature") refactored it
>> that became visible after backporting commit 195a8c43e93d
>> ("virtio-balloon: deflate via a page list") without the refactoring.
>>
>> The bug existed from commit d6d86c0a7f8d ("mm/balloon_compaction: redesign
>> ballooned pages management") till commit b1123ea6d3b3 ("mm: balloon: use
>> general non-lru movable page feature"). commit d6d86c0a7f8d
>> ("mm/balloon_compaction: redesign ballooned pages management") was
>> backported to 3.12, so the broken kernels are stable kernels [3.12 - 4.7].
>>
>> There was a subtle race between dropping the page lock of the newpage
>> in __unmap_and_move() and checking for
>> __is_movable_balloon_page(newpage).
>>
>> Just after dropping this page lock, virtio-balloon could go ahead and
>> deflate the newpage, effectively dequeueing it and clearing PageBalloon,
>> in turn making __is_movable_balloon_page(newpage) fail.
>>
>> This resulted in dropping the reference of the newpage via
>> putback_lru_page(newpage) instead of put_page(newpage), leading to
>> page->lru getting modified and a !LRU page ending up in the LRU lists.
>> With commit 195a8c43e93d ("virtio-balloon: deflate via a page list")
>> backported, one would suddenly get corrupted lists in
>> release_pages_balloon():
>> - WARNING: CPU: 13 PID: 6586 at lib/list_debug.c:59 __list_del_entry+0xa1/0xd0
>> - list_del corruption. prev->next should be ffffe253961090a0, but was dead000000000100
>>
>> Nowadays this race is no longer possible, but it is hidden behind very
>> ugly handling of __ClearPageMovable() and __PageMovable().
>>
>> __ClearPageMovable() will not make __PageMovable() fail, only
>> PageMovable(). So the new check (__PageMovable(newpage)) will still hold
>> even after newpage was dequeued by virtio-balloon.
>>
>> If anybody would ever change that special handling, the BUG would be
>> introduced again. So instead, make it explicit and use the information
>> of the original isolated page before migration.
>>
>> This patch can be backported fairly easy to stable kernels (in contrast
>> to the refactoring).
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Vratislav Bendel <vbendel@redhat.com>
>> Cc: Rafael Aquini <aquini@redhat.com>
>> Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Sasha Levin <sashal@kernel.org>
>> Cc: stable@vger.kernel.org # 3.12 - 4.7
>> Fixes: d6d86c0a7f8d ("mm/balloon_compaction: redesign ballooned pages management")
>> Reported-by: Vratislav Bendel <vbendel@redhat.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Acked-by: Rafael Aquini <aquini@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/migrate.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> What is the git commit id of this patch in Linus's tree?

It's still in Andrew's tree as far as I know. I just wanted to share the
backport right away (to show that it is easy :) ). Will resend it again
(with proper commit idea) once upstream.

> 
> thanks,
> 
> greg k-h
> 


-- 

Thanks,

David / dhildenb
