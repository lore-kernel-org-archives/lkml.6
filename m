Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeCPJ1M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:27:12 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38444 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbeCPJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:27:10 -0400
X-Google-Smtp-Source: AG47ELtrzfc4IHlYryy2XWGrazbVmgKPU1Wm/S86RskDf0j7284Qt67YeWSx96TfGKJ+ThXH4z7oSg==
Subject: Re: [PATCH] Revert "mm/memblock.c: hardcode the end_pfn being -1"
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>, Daniel Vacek <neelx@redhat.com>,
        linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
References: <1521168966-5245-1-git-send-email-hejianet@gmail.com>
 <20180316090647.GC23100@dhcp22.suse.cz>
From: Jia He <hejianet@gmail.com>
Message-ID: <d0c53509-98b3-11a8-2bf2-b43cdd67b5de@gmail.com>
Date: Fri, 16 Mar 2018 17:26:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316090647.GC23100@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2018 5:06 PM, Michal Hocko Wrote:
> On Thu 15-03-18 19:56:06, Jia He wrote:
>> This reverts commit 379b03b7fa05f7db521b7732a52692448a3c34fe.
>>
>> Commit 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock
>> alignment") introduced boot hang issues in arm/arm64 machines, so
>> Ard Biesheuvel reverted in commit 3e04040df6d4. But there is a
>> preparation patch for commit 864b75f9d6b0. So just revert it for
>> the sake of caution.
> Why? Is there anything wrong with this one?
I don't think there might be anything wrong. Justin for the sake of caution.
Please ignore this patch if you prefer to keep 379b03b7fa.
But seems parameter *max_pfn* is useless and can be removed in this case?

Cheers,
Jia
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> ---
>>   mm/memblock.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index b6ba6b7..5a9ca2a 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1107,7 +1107,7 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
>>   	struct memblock_type *type = &memblock.memory;
>>   	unsigned int right = type->cnt;
>>   	unsigned int mid, left = 0;
>> -	phys_addr_t addr = PFN_PHYS(++pfn);
>> +	phys_addr_t addr = PFN_PHYS(pfn + 1);
>>   
>>   	do {
>>   		mid = (right + left) / 2;
>> @@ -1118,15 +1118,15 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
>>   				  type->regions[mid].size))
>>   			left = mid + 1;
>>   		else {
>> -			/* addr is within the region, so pfn is valid */
>> -			return pfn;
>> +			/* addr is within the region, so pfn + 1 is valid */
>> +			return min(pfn + 1, max_pfn);
>>   		}
>>   	} while (left < right);
>>   
>>   	if (right == type->cnt)
>> -		return -1UL;
>> +		return max_pfn;
>>   	else
>> -		return PHYS_PFN(type->regions[right].base);
>> +		return min(PHYS_PFN(type->regions[right].base), max_pfn);
>>   }
>>   
>>   /**
>> -- 
>> 2.7.4
>>
