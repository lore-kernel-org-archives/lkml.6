Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D054C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455D320C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455D320C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390035AbeGKRKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:10:31 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51374 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387415AbeGKRKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:10:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T4QoNh6_1531328689;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T4QoNh6_1531328689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Jul 2018 01:04:52 +0800
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for large
 mapping
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180711111052.hbyukcwetmjjpij2@kshutemo-mobl1>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3d4c69c9-dd2b-30d2-5bf2-d5b108a76758@linux.alibaba.com>
Date:   Wed, 11 Jul 2018 10:04:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180711111052.hbyukcwetmjjpij2@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/18 4:10 AM, Kirill A. Shutemov wrote:
> On Wed, Jul 11, 2018 at 07:34:06AM +0800, Yang Shi wrote:
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
>>
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
>>
>> Define large mapping size thresh as PUD size, just zap pages with read mmap_sem
>> for mappings which are >= PUD_SIZE. So, unmapping less than PUD_SIZE area still
>> goes with the regular path.
>>
>> All vmas which will be zapped soon will have VM_DEAD flag set. Since PF may race
>> with munmap, may just return the right content or SIGSEGV before the optimization,
>> but with the optimization, it may return a zero page. Here use this flag to mark
>> PF to this area is unstable, will trigger SIGSEGV, in order to prevent from the
>> unexpected 3rd state.
>>
>> If the vma has VM_LOCKED | VM_HUGETLB | VM_PFNMAP or uprobe, they are considered
>> as special mappings. They will be dealt with before zapping pages with write
>> mmap_sem held. Basically, just update vm_flags. The actual unmapping is still
>> done with read mmap_sem.
>>
>> And, since they are also manipulated by unmap_single_vma() which is called by
>> zap_page_range() with read mmap_sem held in this case, to prevent from updating
>> vm_flags in read critical section and considering the complexity of coding, just
>> check if VM_DEAD is set, then skip any VM_DEAD area since they should be handled
>> before.
>>
>> When cleaning up vmas, just call do_munmap() without carrying vmas from the above
>> to avoid race condition, since the address space might be already changed under
>> our feet after retaking exclusive lock.
>>
>> For the time being, just do this in munmap syscall path. Other vm_munmap() or
>> do_munmap() call sites (i.e mmap, mremap, etc) remain intact for stability reason.
>> And, make this 64 bit only explicitly per akpm's suggestion.
> I still see VM_DEAD as unnecessary complication. We should be fine without it.
> But looks like I'm in the minority :/
>
> It's okay. I have another suggestion that also doesn't require VM_DEAD
> trick too :)
>
> 1. Take mmap_sem for write;
> 2. Adjust VMA layout (split/remove). After the step all memory we try to
>     unmap is outside any VMA.
> 3. Downgrade mmap_sem to read.
> 4. Zap the page range.
> 5. Drop mmap_sem.
>
> I believe it should be safe.


Yes, it looks so. But, a further question is all the vmas have been 
removed, how zap_page_range could do its job? It depends on the vmas.

One approach is to save all the vmas on a separate list, then 
zap_page_range does unmap with this list.

Yang

>
> The pages in the range cannot be re-faulted after step 3 as find_vma()
> will not see the corresponding VMA and deliver SIGSEGV.
>
> New VMAs cannot be created in the range before step 5 since we hold the
> semaphore at least for read the whole time.
>
> Do you see problem in this approach?
>

