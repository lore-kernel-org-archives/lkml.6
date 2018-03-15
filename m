Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCOCcw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:32:52 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36454 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeCOCcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:32:50 -0400
X-Google-Smtp-Source: AG47ELvzXZRXHoFlx7b0chQsdKSRSTENnVu5NI+J6J+Fu32fOvQEmU4vtOuXmgygX+/6e0vkp9XvDB0rg50NhTmsfCw=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_ubc0RomckZbH5-fEUYeOOqziAQM96uCecoKfWy_mCfQ@mail.gmail.com>
References: <20180314134431.13241-1-ard.biesheuvel@linaro.org>
 <20180314141323.GD23100@dhcp22.suse.cz> <CAKv+Gu9hrZnX6pmiCaT=S30KQ11tY4kv=qvdSPPZ2nYDC7P7eQ@mail.gmail.com>
 <20180314145450.GI23100@dhcp22.suse.cz> <CAKv+Gu8qguR0tFWZxecQDTPS3_Eyt_E6_YA1ivyAAqNuaaR9-g@mail.gmail.com>
 <CAKv+Gu8U9U1ThYxXWU6AuoF5s4uAGps_-T+2tksjc4nGNdX2_w@mail.gmail.com> <CAKv+Gu_ubc0RomckZbH5-fEUYeOOqziAQM96uCecoKfWy_mCfQ@mail.gmail.com>
From: Daniel Vacek <neelx@redhat.com>
Date: Thu, 15 Mar 2018 03:32:49 +0100
Message-ID: <CACjP9X9feHuQTZhGw9XbPkTZLWuQjZ9z_O9=6xga7Sw1LC_r+Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm/page_alloc: fix memmap_init_zone pageblock alignment"
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Michal Hocko <mhocko@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 6:36 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 14 March 2018 at 16:41, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 14 March 2018 at 15:54, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> On 14 March 2018 at 14:54, Michal Hocko <mhocko@kernel.org> wrote:
>>>> On Wed 14-03-18 14:35:12, Ard Biesheuvel wrote:
>>>>> On 14 March 2018 at 14:13, Michal Hocko <mhocko@kernel.org> wrote:
>>>>> > Does http://lkml.kernel.org/r/20180313224240.25295-1-neelx@redhat.com
>>>>> > fix your issue? From the debugging info you provided it should because
>>>>> > the patch prevents jumping backwards.
>>>>> >
>>>>>
>>>>> The patch does fix the boot hang.
>>>>>
>>>>> But I am concerned that we are papering over a fundamental flaw in
>>>>> memblock_next_valid_pfn().
>>>>
>>>> It seems that memblock_next_valid_pfn is doing the right thing here. It
>>>> is the alignment which moves the pfn back AFAICS. I am not really
>>>> impressed about the original patch either, to be completely honest.
>>>> It just looks awfully tricky. I still didn't manage to wrap my head
>>>> around the original issue though so I do not have much better ideas to
>>>> be honest.
>>>
>>> So first of all, memblock_next_valid_pfn() never refers to its max_pfn
>>> argument, which is odd nut easily fixed.
>>> Then, the whole idea of substracting one so that the pfn++ will
>>> produce the expected value is rather hacky,
>>>
>>> But the real problem is that rounding down pfn for the next iteration
>>> is dodgy, because early_pfn_valid() isn't guaranteed to return true
>>> for the rounded down value. I know it is probably fine in reality, but
>>> dodgy as hell. The same applies to the call to early_pfn_in_nid() btw
>>>
>>> So how about something like this (apologies on Gmail's behalf for the
>>> whitespace damage, I can resend it as a proper patch)
>>>
>>>
>>> ---------8<-----------
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 3d974cb2a1a1..b89ca999ee3b 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5352,28 +5352,29 @@
>>>                  * function.  They do not exist on hotplugged memory.
>>>                  */
>>>                 if (context != MEMMAP_EARLY)
>>>                         goto not_early;
>>>
>>> -               if (!early_pfn_valid(pfn)) {
>>> +               if (!early_pfn_valid(pfn) || !early_pfn_in_nid(pfn, nid)) {
>>>  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>>>                         /*
>>>                          * Skip to the pfn preceding the next valid one (or
>>>                          * end_pfn), such that we hit a valid pfn (or end_pfn)
>>>                          * on our next iteration of the loop. Note that it needs
>>>                          * to be pageblock aligned even when the region itself
>>>                          * is not. move_freepages_block() can shift ahead of
>>>                          * the valid region but still depends on correct page
>>>                          * metadata.
>>>                          */
>>> -                       pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>>> -                                       ~(pageblock_nr_pages-1)) - 1;
>>> -#endif
>>> +                       pfn = memblock_next_valid_pfn(pfn, end_pfn);
>>> +                       if (pfn >= end_pfn)
>>> +                               break;
>>> +                       pfn &= ~(pageblock_nr_pages - 1);
>>> +#else
>>>                         continue;
>>> +#endif
>>>                 }
>>> -               if (!early_pfn_in_nid(pfn, nid))
>>> -                       continue;
>>>                 if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
>>>                         break;
>>>
>>>  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>>>                 /*
>>> ---------8<-----------
>>>
>>> This ensures that we enter the remainder of the loop with a properly
>>> aligned pfn, rather than tweaking the value of pfn so it assumes the
>>> expected value after 'pfn++'
>>
>> Um, this does not actually solve the issue. I guess this is due to the
>> fact that a single pageblock size chunk could have both valid and
>> invalid PFNs, and so rounding down the first PFN of the second valid
>> chunk moves you back to the first chunk.
>
> OK, so the original patch attempted to ensure that of each pageblock,
> at least the first struct page gets initialized, even though the PFN
> may not be valid. Unfortunately, this code is not complete, given that
> start_pfn itself may be misaligned, and so the issue it attempts to
> solve may still occur.

You're wrong here.

> Then, I think it is absolutely dodgy to settle for only initializing
> the first struct page, rather than all of them, only because a
> specific VM_BUG_ON() references the flag field of the first struct
> page.
> IMO, we should fix this by initializing all struct page entries for
> each pageblock sized chunk that has any valid PFNs.

That's precisely what my patch does. At least with
CONFIG_HAVE_ARCH_PFN_VALID disabled. And it looks only arm implements
arch pfn_valid() which I was not testing with and I am not sure it's
correct. Check my other email

--nX
