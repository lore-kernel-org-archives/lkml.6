Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FFEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFA0216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFA0216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeI0WYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:24:20 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45286 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727541AbeI0WYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:24:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T9aPzPi_1538064298;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9aPzPi_1538064298)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Sep 2018 00:05:01 +0800
Subject: Re: [v2 PATCH 1/2 -mm] mm: mremap: dwongrade mmap_sem to read when
 shrinking
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        kirill@shutemov.name, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1537985434-22655-1-git-send-email-yang.shi@linux.alibaba.com>
 <8c04afa9-45c2-be18-c084-058add73c978@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <60c0544d-917f-89e1-2806-80c1beb830a0@linux.alibaba.com>
Date:   Thu, 27 Sep 2018 09:04:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8c04afa9-45c2-be18-c084-058add73c978@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/18 4:50 AM, Vlastimil Babka wrote:
> On 9/26/18 8:10 PM, Yang Shi wrote:
>> Subject: [v2 PATCH 1/2 -mm] mm: mremap: dwongrade mmap_sem to read
> when shrinking
>
> "downgrade" in the subject

Will fix in the next version.

Thanks,
Yang

>
>> Other than munmap, mremap might be used to shrink memory mapping too.
>> So, it may hold write mmap_sem for long time when shrinking large
>> mapping, as what commit ("mm: mmap: zap pages with read mmap_sem in
>> munmap") described.
>>
>> The mremap() will not manipulate vmas anymore after __do_munmap() call for
>> the mapping shrink use case, so it is safe to downgrade to read mmap_sem.
>>
>> So, the same optimization, which downgrades mmap_sem to read for zapping
>> pages, is also feasible and reasonable to this case.
>>
>> The period of holding exclusive mmap_sem for shrinking large mapping
>> would be reduced significantly with this optimization.
>>
>> MREMAP_FIXED and MREMAP_MAYMOVE are more complicated to adopt this
>> optimization since they need manipulate vmas after do_munmap(),
>> downgrading mmap_sem may create race window.
>>
>> Simple mapping shrink is the low hanging fruit, and it may cover the
>> most cases of unmap with munmap together.
>>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Looks fine,
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Nit:
>
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2687,8 +2687,8 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
>>    * work.  This now handles partial unmappings.
>>    * Jeremy Fitzhardinge <jeremy@goop.org>
>>    */
>> -static int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>> -		       struct list_head *uf, bool downgrade)
>> +int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>> +		struct list_head *uf, bool downgrade)
>>   {
>>   	unsigned long end;
>>   	struct vm_area_struct *vma, *prev, *last;
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 5c2e185..8f1ec2b 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -525,6 +525,7 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
>>   	unsigned long ret = -EINVAL;
>>   	unsigned long charged = 0;
>>   	bool locked = false;
>> +	bool downgrade = false;
> Maybe "downgraded" is more accurate here, or even "downgraded_mmap_sem".

