Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeCRMCr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:02:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39093 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeCRMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:02:45 -0400
X-Google-Smtp-Source: AG47ELst1a3iAab0TIIW0y2D9LQ6PG0cw+TQv596B64GJ8u4MyIu3CtudX6ihNakSDtCZ5Tnd5PTnQ==
Subject: Re: [PATCH v2] Revert "mm/page_alloc: fix memmap_init_zone pageblock
 alignment"
To: shankerd@codeaurora.org, Jan Glauber <jglauber@cavium.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: mark.rutland@arm.com, Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@imgtec.com>, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Vacek <neelx@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
References: <20180314192937.12888-1-ard.biesheuvel@linaro.org>
 <20180314222530.GA6300@wintermute>
 <4c31c5ed-9f68-10c3-c73f-5b6f34dd82c9@codeaurora.org>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <72c94b30-f837-91ac-ac3a-86d7846dfb23@baylibre.com>
Date: Sun, 18 Mar 2018 13:02:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4c31c5ed-9f68-10c3-c73f-5b6f34dd82c9@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2018 23:53, Shanker Donthineni wrote:
> 
> Hi Ard,
> 
> On 03/14/2018 05:25 PM, Jan Glauber wrote:
>> On Wed, Mar 14, 2018 at 07:29:37PM +0000, Ard Biesheuvel wrote:
>>> This reverts commit 864b75f9d6b0100bb24fdd9a20d156e7cda9b5ae.
>>
>> FWIW, the revert fixes the boot hang I'm seeing on ThunderX1.
>>
>> --Jan
>>
> 
> Thanks for this patch, it fixes the boot hang on QDF2400 platform.

For the record, this also fixes boot on Amlogic S905X (and for the whole GX family I presume).

Thanks,
Neil

> 
> 
>>> Commit 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock
>>> alignment") modified the logic in memmap_init_zone() to initialize
>>> struct pages associated with invalid PFNs, to appease a VM_BUG_ON()
>>> in move_freepages(), which is redundant by its own admission, and
>>> dereferences struct page fields to obtain the zone without checking
>>> whether the struct pages in question are valid to begin with.
>>>
>>> Commit 864b75f9d6b0 only makes it worse, since the rounding it does
>>> may cause pfn assume the same value it had in a prior iteration of
>>> the loop, resulting in an infinite loop and a hang very early in the
>>> boot. Also, since it doesn't perform the same rounding on start_pfn
>>> itself but only on intermediate values following an invalid PFN, we
>>> may still hit the same VM_BUG_ON() as before.
>>>
>>> So instead, let's fix this at the core, and ensure that the BUG
>>> check doesn't dereference struct page fields of invalid pages.
>>>
>>> Fixes: 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
>>> Cc: Daniel Vacek <neelx@redhat.com>
>>> Cc: Mel Gorman <mgorman@techsingularity.net>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Paul Burton <paul.burton@imgtec.com>
>>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>  mm/page_alloc.c | 13 +++++--------
>>>  1 file changed, 5 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 3d974cb2a1a1..635d7dd29d7f 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1910,7 +1910,9 @@ static int move_freepages(struct zone *zone,
>>>  	 * Remove at a later date when no bug reports exist related to
>>>  	 * grouping pages by mobility
>>>  	 */
>>> -	VM_BUG_ON(page_zone(start_page) != page_zone(end_page));
>>> +	VM_BUG_ON(pfn_valid(page_to_pfn(start_page)) &&
>>> +	          pfn_valid(page_to_pfn(end_page)) &&
>>> +	          page_zone(start_page) != page_zone(end_page));
>>>  #endif
>>>  
>>>  	if (num_movable)
>>> @@ -5359,14 +5361,9 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>>  			/*
>>>  			 * Skip to the pfn preceding the next valid one (or
>>>  			 * end_pfn), such that we hit a valid pfn (or end_pfn)
>>> -			 * on our next iteration of the loop. Note that it needs
>>> -			 * to be pageblock aligned even when the region itself
>>> -			 * is not. move_freepages_block() can shift ahead of
>>> -			 * the valid region but still depends on correct page
>>> -			 * metadata.
>>> +			 * on our next iteration of the loop.
>>>  			 */
>>> -			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>>> -					~(pageblock_nr_pages-1)) - 1;
>>> +			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
>>>  #endif
>>>  			continue;
>>>  		}
>>> -- 
>>> 2.15.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
