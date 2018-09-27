Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF97FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D07A216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D07A216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeI0WY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:24:58 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45181 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbeI0WY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:24:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T9a0AL0_1538064340;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9a0AL0_1538064340)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Sep 2018 00:05:43 +0800
Subject: Re: [v2 PATCH 2/2 -mm] mm: brk: dwongrade mmap_sem to read when
 shrinking
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        kirill@shutemov.name, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1537985434-22655-1-git-send-email-yang.shi@linux.alibaba.com>
 <1537985434-22655-2-git-send-email-yang.shi@linux.alibaba.com>
 <33d52132-546f-3c8a-3445-cdbc9068589a@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <4bcdb16d-902e-55ed-5f5d-12c5ba7cbdfd@linux.alibaba.com>
Date:   Thu, 27 Sep 2018 09:05:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <33d52132-546f-3c8a-3445-cdbc9068589a@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/18 5:14 AM, Vlastimil Babka wrote:
> On 9/26/18 8:10 PM, Yang Shi wrote:
>
> Again, "downgrade" in the subject
>
>> brk might be used to shinrk memory mapping too other than munmap().
>                         ^ shrink
>
>> So, it may hold write mmap_sem for long time when shrinking large
>> mapping, as what commit ("mm: mmap: zap pages with read mmap_sem in
>> munmap") described.
>>
>> The brk() will not manipulate vmas anymore after __do_munmap() call for
>> the mapping shrink use case. But, it may set mm->brk after
>> __do_munmap(), which needs hold write mmap_sem.
>>
>> However, a simple trick can workaround this by setting mm->brk before
>> __do_munmap(). Then restore the original value if __do_munmap() fails.
>> With this trick, it is safe to downgrade to read mmap_sem.
>>
>> So, the same optimization, which downgrades mmap_sem to read for
>> zapping pages, is also feasible and reasonable to this case.
>>
>> The period of holding exclusive mmap_sem for shrinking large mapping
>> would be reduced significantly with this optimization.
>>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Same nit for the "bool downgrade" name as for patch 1/2.

Will solve in next version.

Thanks,
Yang

>
> Thanks,
> Vlastimil

