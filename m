Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1614BC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4372087A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4372087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755532AbeF3C2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 22:28:32 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40437 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755481AbeF3C2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 22:28:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T3dwYc9_1530325696;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3dwYc9_1530325696)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 Jun 2018 10:28:22 +0800
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
 <20180629183501.9e30c26135f11853245c56c7@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <084aeccb-2c54-2299-8bf0-29a10cc0186e@linux.alibaba.com>
Date:   Fri, 29 Jun 2018 19:28:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180629183501.9e30c26135f11853245c56c7@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/18 6:35 PM, Andrew Morton wrote:
> On Sat, 30 Jun 2018 06:39:44 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
> And...
>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 87dcf83..d61e08b 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2763,6 +2763,128 @@ static int munmap_lookup_vma(struct mm_struct *mm, struct vm_area_struct **vma,
>>   	return 1;
>>   }
>>   
>> +/* Consider PUD size or 1GB mapping as large mapping */
>> +#ifdef HPAGE_PUD_SIZE
>> +#define LARGE_MAP_THRESH	HPAGE_PUD_SIZE
>> +#else
>> +#define LARGE_MAP_THRESH	(1 * 1024 * 1024 * 1024)
>> +#endif
> So this assumes that 32-bit machines cannot have 1GB mappings (fair
> enough) and this is the sole means by which we avoid falling into the
> "len >= LARGE_MAP_THRESH" codepath, which will behave very badly, at
> least because for such machines, VM_DEAD is zero.
>
> This is rather ugly and fragile.  And, I guess, explains why we can't
> give all mappings this treatment: 32-bit machines can't do it.  And
> we're adding a bunch of code to 32-bit kernels which will never be
> executed.
>
> I'm thinking it would be better to be much more explicit with "#ifdef
> CONFIG_64BIT" in this code, rather than relying upon the above magic.
>
> But I tend to think that the fact that we haven't solved anything on
> locked vmas or on uprobed mappings is a shostopper for the whole
> approach :(

I agree it is not that perfect. But, it still could improve the most use 
cases.

For the locked vmas and hugetlb vmas, unmapping operations need modify 
vm_flags. But, I'm wondering we might be able to separate unmap and 
vm_flags update. Because we know they will be unmapped right away, the 
vm_flags might be able to be updated in write mmap_sem critical section 
before the actual unmap is called or after it. This is just off the top 
of my head.

For uprobed mappings, I'm not sure how vital it is to this case.

Thanks,
Yang

>

