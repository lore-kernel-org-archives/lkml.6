Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CEEC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05AC245F0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05AC245F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934415AbeFVQok (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:44:40 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36766 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934385AbeFVQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:44:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0T3Ac.rU_1529685868;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3Ac.rU_1529685868)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 23 Jun 2018 00:44:30 +0800
Subject: Re: [v2 PATCH 1/2] mm: thp: register mm for khugepaged when merging
 vma for shmem
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     hughd@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1529622949-75504-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180622075958.mzagr2ayufiuokea@black.fi.intel.com>
 <cce4aa50-f8b7-8626-31ae-12464a30f884@linux.alibaba.com>
 <20180622161912.sq32cnhfxo5ctgdp@black.fi.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6e59a56d-7bb3-76d3-201a-8a4ad4638602@linux.alibaba.com>
Date:   Fri, 22 Jun 2018 09:44:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180622161912.sq32cnhfxo5ctgdp@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/18 9:19 AM, Kirill A. Shutemov wrote:
> On Fri, Jun 22, 2018 at 04:04:12PM +0000, yang.shi@linux.alibaba.com wrote:
>>
>> On 6/22/18 12:59 AM, Kirill A. Shutemov wrote:
>>> On Thu, Jun 21, 2018 at 11:15:48PM +0000, yang.shi@linux.alibaba.com wrote:
>>>> When merging anonymous page vma, if the size of vma can fit in at least
>>>> one hugepage, the mm will be registered for khugepaged for collapsing
>>>> THP in the future.
>>>>
>>>> But, it skips shmem vma. Doing so for shmem too, but not file-private
>>>> mapping, when merging vma in order to increase the odd to collapse
>>>> hugepage by khugepaged.
>>>>
>>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>>> ---
>>>> v1 --> 2:
>>>> * Exclude file-private mapping per Kirill's comment
>>>>
>>>>    mm/khugepaged.c | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index d7b2a4b..9b0ec30 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -440,8 +440,12 @@ int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>>>>    		 * page fault if needed.
>>>>    		 */
>>>>    		return 0;
>>>> -	if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
>>>> -		/* khugepaged not yet working on file or special mappings */
>>>> +	if ((vma->vm_ops && (!shmem_file(vma->vm_file) || vma->anon_vma)) ||
>>>> +	    (vm_flags & VM_NO_KHUGEPAGED))
>>>> +		/*
>>>> +		 * khugepaged not yet working on non-shmem file or special
>>>> +		 * mappings. And, file-private shmem THP is not supported.
>>>> +		 */
>>>>    		return 0;
>>> My point was that vma->anon_vma check above this one should not prevent
>>> collapse for shmem.
>>>
>>> Looking into this more, I think we should just replace all these checks
>>> with hugepage_vma_check() call.
>> I got a little bit confused here. I thought the condition to *not* collapse
>> file-private shmem mapping should be:
>>
>> shmem_file(vma->vm_file) && vma->anon_vma
>>
>> Is this right?
> No, if shmem_file(vma->vm_file) is true, vma->anon_vma doesn't matter.
> We don't care about anon_vma in such VMA as we don't touch file-private
> pages.

Thanks, I misunderstood that. hugepage_vma_check() sounds reasonable. 
Will fix in v3 soon.

Yang

>

