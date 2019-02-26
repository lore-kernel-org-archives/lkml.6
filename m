Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47942173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfBZOel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:34:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40912 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfBZOel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:34:41 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 84FAC77CDBC0C7823188;
        Tue, 26 Feb 2019 22:34:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Feb 2019
 22:34:33 +0800
Message-ID: <5C754E78.4050804@huawei.com>
Date:   Tue, 26 Feb 2019 22:34:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <n-horiguchi@ah.jp.nec.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mhocko@suse.com>, <hughd@google.com>, <mhocko@kernel.org>
Subject: Re: [PATCH] mm: hwpoison: fix thp split handing in soft_offline_in_use_page()
References: <1551179880-65331-1-git-send-email-zhongjiang@huawei.com> <20190226135156.mifspmbdyr6m3hff@kshutemo-mobl1>
In-Reply-To: <20190226135156.mifspmbdyr6m3hff@kshutemo-mobl1>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/26 21:51, Kirill A. Shutemov wrote:
> On Tue, Feb 26, 2019 at 07:18:00PM +0800, zhong jiang wrote:
>> From: zhongjiang <zhongjiang@huawei.com>
>>
>> When soft_offline_in_use_page() runs on a thp tail page after pmd is plit,
> s/plit/split/
>
>> we trigger the following VM_BUG_ON_PAGE():
>>
>> Memory failure: 0x3755ff: non anonymous thp
>> __get_any_page: 0x3755ff: unknown zero refcount page type 2fffff80000000
>> Soft offlining pfn 0x34d805 at process virtual address 0x20fff000
>> page:ffffea000d360140 count:0 mapcount:0 mapping:0000000000000000 index:0x1
>> flags: 0x2fffff80000000()
>> raw: 002fffff80000000 ffffea000d360108 ffffea000d360188 0000000000000000
>> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>> ------------[ cut here ]------------
>> kernel BUG at ./include/linux/mm.h:519!
>>
>> soft_offline_in_use_page() passed refcount and page lock from tail page to
>> head page, which is not needed because we can pass any subpage to
>> split_huge_page().
> I don't see a description of what is going wrong and why change will fixed
> it. From the description, it appears as it's cosmetic-only change.
>
> Please elaborate.
When soft_offline_in_use_page runs on a thp tail page after pmd is split,  
and we pass the head page to split_huge_page, Unfortunately, the tail page
can be free or count turn into zero.

Thanks,
zhong jiang



