Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4680AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DF82170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DF82170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389997AbeHGUWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:22:05 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49607 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732383AbeHGUWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:22:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T6CQQEE_1533665165;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T6CQQEE_1533665165)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Aug 2018 02:06:08 +0800
Subject: Re: [RFC v6 PATCH 1/2] mm: refactor do_munmap() to extract the common
 part
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1532628614-111702-1-git-send-email-yang.shi@linux.alibaba.com>
 <1532628614-111702-2-git-send-email-yang.shi@linux.alibaba.com>
 <0289d239-80f1-23e1-331d-6d83f762aeb4@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3d9a9eba-97a4-f317-5ee9-369349c108df@linux.alibaba.com>
Date:   Tue, 7 Aug 2018 11:06:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0289d239-80f1-23e1-331d-6d83f762aeb4@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/18 7:59 AM, Vlastimil Babka wrote:
> On 07/26/2018 08:10 PM, Yang Shi wrote:
>> Introduces three new helper functions:
>>    * munmap_addr_sanity()
>>    * munmap_lookup_vma()
>>    * munmap_mlock_vma()
>>
>> They will be used by do_munmap() and the new do_munmap with zapping
>> large mapping early in the later patch.
>>
>> There is no functional change, just code refactor.
>>
>> Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/mmap.c | 120 ++++++++++++++++++++++++++++++++++++++++++--------------------
>>   1 file changed, 82 insertions(+), 38 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index d1eb87e..2504094 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2686,34 +2686,44 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
>>   	return __split_vma(mm, vma, addr, new_below);
>>   }
>>   
>> -/* Munmap is split into 2 main parts -- this part which finds
>> - * what needs doing, and the areas themselves, which do the
>> - * work.  This now handles partial unmappings.
>> - * Jeremy Fitzhardinge <jeremy@goop.org>
>> - */
>> -int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>> -	      struct list_head *uf)
>> +static inline bool munmap_addr_sanity(unsigned long start, size_t len)
> Since it's returning bool, the proper naming scheme would be something
> like "munmap_addr_ok()". I don't know how I would replace the "munmap_"
> prefix myself though.

OK, thanks for the suggestion.

>
>>   {
>> -	unsigned long end;
>> -	struct vm_area_struct *vma, *prev, *last;
>> -
>>   	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
>> -		return -EINVAL;
>> +		return false;
>>   
>> -	len = PAGE_ALIGN(len);
>> -	if (len == 0)
>> -		return -EINVAL;
>> +	if (PAGE_ALIGN(len) == 0)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +/*
>> + * munmap_lookup_vma: find the first overlap vma and split overlap vmas.
>> + * @mm: mm_struct
>> + * @vma: the first overlapping vma
>> + * @prev: vma's prev
>> + * @start: start address
>> + * @end: end address
>> + *
>> + * returns 1 if successful, 0 or errno otherwise
>> + */
>> +static int munmap_lookup_vma(struct mm_struct *mm, struct vm_area_struct **vma,
>> +			     struct vm_area_struct **prev, unsigned long start,
>> +			     unsigned long end)
> Agree with Michal that you could simply return vma, NULL, or error.
> Caller can easily find out prev from that, it's not like we have to
> count each cpu cycle here. It will be a bit less tricky code as well,
> which is a plus.
>
> ...
>> +static inline void munmap_mlock_vma(struct vm_area_struct *vma,
>> +				    unsigned long end)
> This function does munlock, not mlock. You could call it e.g.
> munlock_vmas().

OK

>
>> +{
>> +	struct vm_area_struct *tmp = vma;
>> +
>> +	while (tmp && tmp->vm_start < end) {
>> +		if (tmp->vm_flags & VM_LOCKED) {
>> +			vma->vm_mm->locked_vm -= vma_pages(tmp);
> You keep 'vma' just for the vm_mm? Better extract mm pointer first and
> then you don't need the 'tmp'.

OK

Thanks,
Yang

>
>> +			munlock_vma_pages_all(tmp);
>> +		}
>> +		tmp = tmp->vm_next;
>> +	}
>> +}

