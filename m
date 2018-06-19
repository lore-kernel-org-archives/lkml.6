Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA05C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D5420652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D5420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757188AbeFSVNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:13:30 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39681 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755280AbeFSVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:13:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0T3.ut0h_1529442786;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3.ut0h_1529442786)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jun 2018 05:13:10 +0800
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
 <20180619100218.GN2458@hirez.programming.kicks-ass.net>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <f78924fc-ea81-9ddd-ebb2-28241d5721c8@linux.alibaba.com>
Date:   Tue, 19 Jun 2018 14:13:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619100218.GN2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/18 3:02 AM, Peter Zijlstra wrote:
> On Tue, Jun 19, 2018 at 07:34:16AM +0800, Yang Shi wrote:
>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index fc41c05..e84f80c 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2686,6 +2686,141 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
>>   	return __split_vma(mm, vma, addr, new_below);
>>   }
>>   
>> +/* Consider PUD size or 1GB mapping as large mapping */
>> +#ifdef HPAGE_PUD_SIZE
>> +#define LARGE_MAP_THRESH	HPAGE_PUD_SIZE
>> +#else
>> +#define LARGE_MAP_THRESH	(1 * 1024 * 1024 * 1024)
>> +#endif
>> +
>> +/* Unmap large mapping early with acquiring read mmap_sem */
>> +static int do_munmap_zap_early(struct mm_struct *mm, unsigned long start,
>> +			       size_t len, struct list_head *uf)
>> +{
>> +	unsigned long end = 0;
>> +	struct vm_area_struct *vma = NULL, *prev, *last, *tmp;
>> +	bool success = false;
>> +	int ret = 0;
>> +
>> +	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE - start)
>> +		return -EINVAL;
>> +
>> +	len = (PAGE_ALIGN(len));
>> +	if (len == 0)
>> +		return -EINVAL;
>> +
>> +	/* Just deal with uf in regular path */
>> +	if (unlikely(uf))
>> +		goto regular_path;
>> +
>> +	if (len >= LARGE_MAP_THRESH) {
>> +		down_read(&mm->mmap_sem);
>> +		vma = find_vma(mm, start);
>> +		if (!vma) {
>> +			up_read(&mm->mmap_sem);
>> +			return 0;
>> +		}
>> +
>> +		prev = vma->vm_prev;
>> +
>> +		end = start + len;
>> +		if (vma->vm_start > end) {
>> +			up_read(&mm->mmap_sem);
>> +			return 0;
>> +		}
>> +
>> +		if (start > vma->vm_start) {
>> +			int error;
>> +
>> +			if (end < vma->vm_end &&
>> +			    mm->map_count > sysctl_max_map_count) {
>> +				up_read(&mm->mmap_sem);
>> +				return -ENOMEM;
>> +			}
>> +
>> +			error = __split_vma(mm, vma, start, 0);
>> +			if (error) {
>> +				up_read(&mm->mmap_sem);
>> +				return error;
>> +			}
>> +			prev = vma;
>> +		}
>> +
>> +		last = find_vma(mm, end);
>> +		if (last && end > last->vm_start) {
>> +			int error = __split_vma(mm, last, end, 1);
>> +
>> +			if (error) {
>> +				up_read(&mm->mmap_sem);
>> +				return error;
>> +			}
>> +		}
>> +		vma = prev ? prev->vm_next : mm->mmap;
> Hold up, two things: you having to copy most of do_munmap() didn't seem
> to suggest a helper function? And second, since when are we allowed to

Yes, they will be extracted into a helper function in the next version.

May bad, I don't think it is allowed. We could reform this to:

acquire write mmap_sem
vma lookup (split vmas)
release write mmap_sem

acquire read mmap_sem
zap pages
release read mmap_sem

I'm supposed this is safe as what Michal said before.

Thanks,
Yang

> split VMAs under a read lock?

