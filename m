Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E6C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C422242C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C422242C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeHJUzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:55:15 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33745 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727570AbeHJUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:55:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0T6QQEkV_1533925426;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T6QQEkV_1533925426)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Aug 2018 02:23:54 +0800
Subject: Re: [RFC v7 PATCH 1/4] mm: refactor do_munmap() to extract the common
 part
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1533857763-43527-1-git-send-email-yang.shi@linux.alibaba.com>
 <1533857763-43527-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180810174150.GA6487@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <30ee3dd0-a794-1c93-dd22-5c643a9037a6@linux.alibaba.com>
Date:   Fri, 10 Aug 2018 11:23:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180810174150.GA6487@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/18 10:41 AM, Matthew Wilcox wrote:
> On Fri, Aug 10, 2018 at 07:36:00AM +0800, Yang Shi wrote:
>> +static inline bool addr_ok(unsigned long start, size_t len)
> Maybe munmap_range_ok()?  Otherwise some of the conditions here don't make
> sense for such a generic sounding function.

I don't know. I think the argument is about munmap_ prefix should be used.

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
>> + * @start: start address
>> + * @end: end address
>> + *
>> + * returns the pointer to vma, NULL or err ptr when spilt_vma returns error.
> kernel-doc prefers:
>
>   * Return: %NULL if no VMA overlaps this range.  An ERR_PTR if an
>   * overlapping VMA could not be split.  Otherwise a pointer to the first
>   * VMA which overlaps the range.

Ok, will fix it.

>
>> + */
>> +static struct vm_area_struct *munmap_lookup_vma(struct mm_struct *mm,
>> +			unsigned long start, unsigned long end)
>> +{
>> +	struct vm_area_struct *vma, *prev, *last;
>>   
>>   	/* Find the first overlapping VMA */
>>   	vma = find_vma(mm, start);
>>   	if (!vma)
>> -		return 0;
>> -	prev = vma->vm_prev;
>> -	/* we have  start < vma->vm_end  */
>> +		return NULL;
>>   
>> +	/* we have  start < vma->vm_end  */
> Can you remove the duplicate spaces here?

Sure

Thanks,
Yang


