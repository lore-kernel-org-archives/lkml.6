Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E17C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E828724E2D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E828724E2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeGCABs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:01:48 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:35939 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753639AbeGCABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:01:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T3rk.0Y_1530576073;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3rk.0Y_1530576073)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Jul 2018 08:01:21 +0800
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
 <20180629183501.9e30c26135f11853245c56c7@linux-foundation.org>
 <084aeccb-2c54-2299-8bf0-29a10cc0186e@linux.alibaba.com>
 <20180629201547.5322cfc4b52d19a0443daec2@linux-foundation.org>
 <ce2f93d3-fe0e-89c2-5465-94cfa974f1ea@linux.alibaba.com>
Message-ID: <06df816f-b8b7-f6c0-3710-baad99fb3213@linux.alibaba.com>
Date:   Mon, 2 Jul 2018 17:01:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ce2f93d3-fe0e-89c2-5465-94cfa974f1ea@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/18 9:26 PM, Yang Shi wrote:
>
>
> On 6/29/18 8:15 PM, Andrew Morton wrote:
>> On Fri, 29 Jun 2018 19:28:15 -0700 Yang Shi 
>> <yang.shi@linux.alibaba.com> wrote:
>>
>>>
>>>> we're adding a bunch of code to 32-bit kernels which will never be
>>>> executed.
>>>>
>>>> I'm thinking it would be better to be much more explicit with "#ifdef
>>>> CONFIG_64BIT" in this code, rather than relying upon the above magic.
>>>>
>>>> But I tend to think that the fact that we haven't solved anything on
>>>> locked vmas or on uprobed mappings is a shostopper for the whole
>>>> approach :(
>>> I agree it is not that perfect. But, it still could improve the most 
>>> use
>>> cases.
>> Well, those unaddressed usecases will need to be fixed at some point.
>
> Yes, definitely.
>
>> What's our plan for that?
>
> As I mentioned in the earlier email, locked and hugetlb cases might be 
> able to be solved by separating vm_flags update and actual unmap. I 
> will look into it further later.

By looking into this further， I think both mlocked and hugetlb vmas can 
be handled.

For mlocked vmas, it is easy since we acquires write mmap_sem before 
unmapping, so VM_LOCK flags can be cleared here then unmap, just like 
what the regular path does.

For hugetlb vmas, the VM_MAYSHARE flag is just checked by 
huge_pmd_share() in hugetlb_fault()->huge_pte_alloc(), another call site 
is dup_mm()->copy_page_range()->copy_hugetlb_page_range(), we don't care 
this call chain in this case.

So we may expand VM_DEAD to hugetlb_fault().  Michal suggested to check 
VM_DEAD in check_stable_address_space(), so it would be called in 
hugetlb_fault() too (not in current code), then the page fault handler 
would bail out before huge_pte_alloc() is called.

With this trick, we don't have to care about when the vm_flags is 
updated, we can unmap hugetlb vmas in read mmap_sem critical section, 
then update the vm_flags with write mmap_sem held or before the unmap.

Yang

>
> From my point of view, uprobe mapping sounds not that vital.
>
>>
>> Would one of your earlier designs have addressed all usecases? I
>> expect the dumb unmap-a-little-bit-at-a-time approach would have?
>
> Yes. The v1 design does unmap with holding write map_sem. So, the 
> vm_flags update is not a problem.
>
> Thanks,
> Yang
>
>>
>>> For the locked vmas and hugetlb vmas, unmapping operations need modify
>>> vm_flags. But, I'm wondering we might be able to separate unmap and
>>> vm_flags update. Because we know they will be unmapped right away, the
>>> vm_flags might be able to be updated in write mmap_sem critical section
>>> before the actual unmap is called or after it. This is just off the top
>>> of my head.
>>>
>>> For uprobed mappings, I'm not sure how vital it is to this case.
>>>
>>> Thanks,
>>> Yang
>>>
>

