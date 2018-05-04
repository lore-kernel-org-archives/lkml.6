Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeEDFzj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 01:55:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDFzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 01:55:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C83966055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 2/2] mm: vmalloc: Pass proper vm_start into
 debugobjects
To: Andrew Morton <akpm@linux-foundation.org>
Cc: vbabka@suse.cz, labbott@redhat.com, catalin.marinas@arm.com,
        hannes@cmpxchg.org, f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, khandual@linux.vnet.ibm.com,
        mhocko@kernel.org
References: <1523961828-9485-1-git-send-email-cpandya@codeaurora.org>
 <1523961828-9485-3-git-send-email-cpandya@codeaurora.org>
 <20180503144222.bcb5c63bb96309bc3b37fb6f@linux-foundation.org>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <26e3342d-b518-1e16-25ca-3c2f0ef077d4@codeaurora.org>
Date: Fri, 4 May 2018 11:25:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503144222.bcb5c63bb96309bc3b37fb6f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2018 3:12 AM, Andrew Morton wrote:
> On Tue, 17 Apr 2018 16:13:48 +0530 Chintan Pandya <cpandya@codeaurora.org> wrote:
> 
>> Client can call vunmap with some intermediate 'addr'
>> which may not be the start of the VM area. Entire
>> unmap code works with vm->vm_start which is proper
>> but debug object API is called with 'addr'. This
>> could be a problem within debug objects.
>>
>> Pass proper start address into debug object API.
>>
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -1124,15 +1124,15 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>>   	BUG_ON(addr > VMALLOC_END);
>>   	BUG_ON(!PAGE_ALIGNED(addr));
>>   
>> -	debug_check_no_locks_freed(mem, size);
>> -
>>   	if (likely(count <= VMAP_MAX_ALLOC)) {
>> +		debug_check_no_locks_freed(mem, size);
>>   		vb_free(mem, size);
>>   		return;
>>   	}
>>   
>>   	va = find_vmap_area(addr);
>>   	BUG_ON(!va);
>> +	debug_check_no_locks_freed(va->va_start, (va->va_end - va->va_start));
>>   	free_unmap_vmap_area(va);
>>   }
>>   EXPORT_SYMBOL(vm_unmap_ram);
> 
> hm, how did this sneak through?
My bad. I had tested them but missed bringing these compile fixes to the
patch file. Will be careful next time.

> 
> mm/vmalloc.c:1139:29: warning: passing argument 1 of debug_check_no_locks_freed makes pointer from integer without a cast [-Wint-conversion]
>    debug_check_no_locks_freed(va->va_start, (va->va_end - va->va_start));
> 
> --- a/mm/vmalloc.c~mm-vmalloc-pass-proper-vm_start-into-debugobjects-fix
> +++ a/mm/vmalloc.c
> @@ -1136,7 +1136,8 @@ void vm_unmap_ram(const void *mem, unsig
>   
>   	va = find_vmap_area(addr);
>   	BUG_ON(!va);
> -	debug_check_no_locks_freed(va->va_start, (va->va_end - va->va_start));
> +	debug_check_no_locks_freed((void *)va->va_start,
> +				    (va->va_end - va->va_start));
>   	free_unmap_vmap_area(va);
>   }
>   EXPORT_SYMBOL(vm_unmap_ram);
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
