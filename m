Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258212147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258212147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388837AbeHPJIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:08:01 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44995 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387491AbeHPJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:08:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0T6i6Xc2_1534399883;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T6i6Xc2_1534399883)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Aug 2018 14:11:32 +0800
Subject: Re: [RFC v8 PATCH 3/5] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
 <1534358990-85530-4-git-send-email-yang.shi@linux.alibaba.com>
 <20180815191606.GA4201@bombadil.infradead.org>
 <20180815210946.GA28919@bombadil.infradead.org>
 <78e658dd-bdb0-09ca-9af5-b523c7ff529f@linux.alibaba.com>
 <20180816024652.GA11808@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b286c2f8-d3a5-89f8-954b-608a26c28a22@linux.alibaba.com>
Date:   Wed, 15 Aug 2018 23:11:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180816024652.GA11808@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/18 7:46 PM, Matthew Wilcox wrote:
> On Wed, Aug 15, 2018 at 02:54:13PM -0700, Yang Shi wrote:
>>
>> On 8/15/18 2:09 PM, Matthew Wilcox wrote:
>>> On Wed, Aug 15, 2018 at 12:16:06PM -0700, Matthew Wilcox wrote:
>>>> (not even compiled, and I can see a good opportunity for combining the
>>>> VM_LOCKED loop with the has_uprobes loop)
>>> I was rushing to get that sent earlier.  Here it is tidied up to
>>> actually compile.
>> Thanks for the example. Yes, I believe the code still can be compacted to
>> save some lines. However, the cover letter and the commit log of this patch
>> has elaborated the discussion in the earlier reviews about why we do it in
>> this way.
> You mean the other callers which need to hold mmap_sem write-locked for
> longer?  I hadn't really considered those; how about this?

Thanks. Yes, this is the other potential implementation. My rationale 
about a separate function for the optimized path is I would prefer 
optimize this step by step by starting with some relatively simple way, 
then add enhancement on top of it.

And, I would prefer keep the current implementation of do_munmap since 
it is called somewhere else and it might be called by the optimized path 
for some reason until we are confident enough that the optimization 
doesn't have regression.

This sounds like separate function vs an extra parameter. We do save 
some lines with extra parameter instead of a separate function.

Thanks,
Yang

>
>   mmap.c |   47 +++++++++++++++++++++++++++++------------------
>   1 file changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index de699523c0b7..06dc31d1da8c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2798,11 +2798,11 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
>    * work.  This now handles partial unmappings.
>    * Jeremy Fitzhardinge <jeremy@goop.org>
>    */
> -int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> -	      struct list_head *uf)
> +static int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> +	      struct list_head *uf, bool downgrade)
>   {
>   	unsigned long end;
> -	struct vm_area_struct *vma, *prev, *last;
> +	struct vm_area_struct *vma, *prev, *last, *tmp;
>   
>   	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
>   		return -EINVAL;
> @@ -2816,7 +2816,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>   	if (!vma)
>   		return 0;
>   	prev = vma->vm_prev;
> -	/* we have  start < vma->vm_end  */
> +	/* we have start < vma->vm_end  */
>   
>   	/* if it doesn't overlap, we have nothing.. */
>   	end = start + len;
> @@ -2873,18 +2873,22 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>   
>   	/*
>   	 * unlock any mlock()ed ranges before detaching vmas
> +	 * and check to see if there's any reason we might have to hold
> +	 * the mmap_sem write-locked while unmapping regions.
>   	 */
> -	if (mm->locked_vm) {
> -		struct vm_area_struct *tmp = vma;
> -		while (tmp && tmp->vm_start < end) {
> -			if (tmp->vm_flags & VM_LOCKED) {
> -				mm->locked_vm -= vma_pages(tmp);
> -				munlock_vma_pages_all(tmp);
> -			}
> -			tmp = tmp->vm_next;
> +	for (tmp = vma; tmp && tmp->vm_start < end; tmp = tmp->vm_next) {
> +		if (tmp->vm_flags & VM_LOCKED) {
> +			mm->locked_vm -= vma_pages(tmp);
> +			munlock_vma_pages_all(tmp);
>   		}
> +		if (tmp->vm_file &&
> +				has_uprobes(tmp, tmp->vm_start, tmp->vm_end))
> +			downgrade = false;
>   	}
>   
> +	if (downgrade)
> +		downgrade_write(&mm->mmap_sem);
> +
>   	/*
>   	 * Remove the vma's, and unmap the actual pages
>   	 */
> @@ -2896,7 +2900,13 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>   	/* Fix up all other VM information */
>   	remove_vma_list(mm, vma);
>   
> -	return 0;
> +	return downgrade ? 1 : 0;
> +}
> +
> +int do_unmap(struct mm_struct *mm, unsigned long start, size_t len,
> +		struct list_head *uf)
> +{
> +	return __do_munmap(mm, start, len, uf, false);
>   }
>   
>   int vm_munmap(unsigned long start, size_t len)
> @@ -2905,11 +2915,12 @@ int vm_munmap(unsigned long start, size_t len)
>   	struct mm_struct *mm = current->mm;
>   	LIST_HEAD(uf);
>   
> -	if (down_write_killable(&mm->mmap_sem))
> -		return -EINTR;
> -
> -	ret = do_munmap(mm, start, len, &uf);
> -	up_write(&mm->mmap_sem);
> +	down_write(&mm->mmap_sem);
> +	ret = __do_munmap(mm, start, len, &uf, true);
> +	if (ret == 1)
> +		up_read(&mm->mmap_sem);
> +	else
> +		up_write(&mm->mmap_sem);
>   	userfaultfd_unmap_complete(mm, &uf);
>   	return ret;
>   }

