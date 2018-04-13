Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754154AbeDMKpe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:45:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51828 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeDMKpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:45:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D94096079B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH] mm: vmalloc: Remove double execution of vunmap_page_range
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, vbabka@suse.cz,
        labbott@redhat.com, catalin.marinas@arm.com, hannes@cmpxchg.org,
        f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1523611019-17679-1-git-send-email-cpandya@codeaurora.org>
 <a623e12b-bb5e-58fa-c026-de9ea53c5bd9@linux.vnet.ibm.com>
 <8da9f826-2a3d-e618-e512-4fc8d45c16f2@codeaurora.org>
 <bbef0a92-f81b-5ba8-c5c1-d8c08444955b@linux.vnet.ibm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <fa104cc6-c32a-9081-280f-2e03e4279f65@codeaurora.org>
Date: Fri, 13 Apr 2018 16:15:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <bbef0a92-f81b-5ba8-c5c1-d8c08444955b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2018 4:10 PM, Anshuman Khandual wrote:
> On 04/13/2018 03:47 PM, Chintan Pandya wrote:
>>
>>
>> On 4/13/2018 3:29 PM, Anshuman Khandual wrote:
>>> On 04/13/2018 02:46 PM, Chintan Pandya wrote:
>>>> Unmap legs do call vunmap_page_range() irrespective of
>>>> debug_pagealloc_enabled() is enabled or not. So, remove
>>>> redundant check and optional vunmap_page_range() routines.
>>>
>>> vunmap_page_range() tears down the page table entries and does
>>> not really flush related TLB entries normally unless page alloc
>>> debug is enabled where it wants to make sure no stale mapping is
>>> still around for debug purpose. Deferring TLB flush improves
>>> performance. This patch will force TLB flush during each page
>>> table tear down and hence not desirable.
>>>
>> Deferred TLB invalidation will surely improve performance. But force
>> flush can help in detecting invalid access right then and there. I
> 
> Deferred TLB invalidation was a choice made some time ago with the
> commit db64fe02258f1507e ("mm: rewrite vmap layer") as these vmalloc
> mappings wont be used other than inside the kernel and TLB gets
> flushed when they are reused. This way it can still avail the benefit
> of deferred TLB flushing without exposing itself to invalid accesses.
> 
>> chose later. May be I should have clean up the vmap tear down code
>> as well where it actually does the TLB invalidation.
>>
>> Or make TLB invalidation in free_unmap_vmap_area() be dependent upon
>> debug_pagealloc_enabled().
> 
> Immediate TLB invalidation needs to be dependent on debug_pagealloc_
> enabled() and should be done only for debug purpose. Contrary to that
> is not desirable.
> 
Okay. I will raise v2 for that.

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
