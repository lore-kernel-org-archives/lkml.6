Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878D5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F9120C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F9120C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbeGKRDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:03:25 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47453 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388125AbeGKRDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:03:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T4R-8a5_1531328270;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T4R-8a5_1531328270)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Jul 2018 00:57:54 +0800
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for large
 mapping
To:     Michal Hocko <mhocko@kernel.org>
Cc:     willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180711103312.GH20050@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <d29a4e16-4094-4b3c-273f-596d3d5629f0@linux.alibaba.com>
Date:   Wed, 11 Jul 2018 09:57:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180711103312.GH20050@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/18 3:33 AM, Michal Hocko wrote:
> On Wed 11-07-18 07:34:06, Yang Shi wrote:
>> Background:
>> Recently, when we ran some vm scalability tests on machines with large memory,
>> we ran into a couple of mmap_sem scalability issues when unmapping large memory
>> space, please refer to https://lkml.org/lkml/2017/12/14/733 and
>> https://lkml.org/lkml/2018/2/20/576.
>>
>>
>> History:
>> Then akpm suggested to unmap large mapping section by section and drop mmap_sem
>> at a time to mitigate it (see https://lkml.org/lkml/2018/3/6/784).
>>
>> V1 patch series was submitted to the mailing list per Andrew's suggestion
>> (see https://lkml.org/lkml/2018/3/20/786). Then I received a lot great feedback
>> and suggestions.
>>
>> Then this topic was discussed on LSFMM summit 2018. In the summit, Michal Hocko
>> suggested (also in the v1 patches review) to try "two phases" approach. Zapping
>> pages with read mmap_sem, then doing via cleanup with write mmap_sem (for
>> discussion detail, see https://lwn.net/Articles/753269/)
>>
>>
>> Approach:
>> Zapping pages is the most time consuming part, according to the suggestion from
>> Michal Hocko [1], zapping pages can be done with holding read mmap_sem, like
>> what MADV_DONTNEED does. Then re-acquire write mmap_sem to cleanup vmas.
>>
>> But, we can't call MADV_DONTNEED directly, since there are two major drawbacks:
>>    * The unexpected state from PF if it wins the race in the middle of munmap.
>>      It may return zero page, instead of the content or SIGSEGV.
>>    * Can’t handle VM_LOCKED | VM_HUGETLB | VM_PFNMAP and uprobe mappings, which
>>      is a showstopper from akpm
> I do not really understand why this is a showstopper. This is a mere
> optimization. VM_LOCKED ranges are usually not that large. VM_HUGETLB
> can be quite large alright but this should be doable on top. Is there
> any reason to block any "cover most mappings first" patch?
>
>> And, some part may need write mmap_sem, for example, vma splitting. So, the
>> design is as follows:
>>          acquire write mmap_sem
>>          lookup vmas (find and split vmas)
>>          set VM_DEAD flags
>>          deal with special mappings
>>          downgrade_write
>>
>>          zap pages
>>          release mmap_sem
>>
>>          retake mmap_sem exclusively
>>          cleanup vmas
>>          release mmap_sem
> Please explain why dropping the lock and then ratake it to cleanup vmas
> is OK. This is really important because parallel thread could have
> changed the underlying address space range.

Yes, the address space could be changed after retaking the lock. 
Actually, here do_munmap() is called in the new patch to do the cleanup 
work as Kirill suggested, which will re-lookup vmas and deal with any 
address space change.

If there is no address space change, actually it just clean up vmas.

>
> Moreover
>
>>   include/linux/mm.h  |   8 +++
>>   include/linux/oom.h |  20 -------
>>   mm/huge_memory.c    |   4 +-
>>   mm/hugetlb.c        |   5 ++
>>   mm/memory.c         |  57 ++++++++++++++++---
>>   mm/mmap.c           | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
>>   mm/shmem.c          |   9 ++-
>>   7 files changed, 255 insertions(+), 69 deletions(-)
> this is not a small change for something that could be achieved
> from the userspace trivially (just call madvise before munmap - library
> can hide this). Most workloads will even not care about races because
> they simply do not play tricks with mmaps and userspace MM. So why do we
> want to put the additional complexity into the kernel?
>
> Note that I am _not_ saying this is a wrong idea, we just need some
> pretty sounds arguments to justify the additional complexity which is
> mostly based on our fear that somebody might be doing something
> (half)insane or dubious at best.

I agree with Kirill that we can't rely on sane userspace to handle 
kernel latency issue. Moreover, we even don't know if they are sane 
enough or not at all.

Yang

>

