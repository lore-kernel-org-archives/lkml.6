Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeCOHhA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:37:00 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50263 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbeCOHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:36:58 -0400
X-Google-Smtp-Source: AG47ELsk7FDySjtCd+0sVM5SMS4Vl2ZD9URC3x/ySITtmcw82i3u8KUl/YhXo2MRzcKkWa9xeKVTPKrAEDjRDNcJ4o8=
MIME-Version: 1.0
In-Reply-To: <CACjP9X_A1VsprX20XfEi31XVrySkScZDJsxUTh3Lf_6xr70Mug@mail.gmail.com>
References: <20180314192937.12888-1-ard.biesheuvel@linaro.org> <CACjP9X_A1VsprX20XfEi31XVrySkScZDJsxUTh3Lf_6xr70Mug@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 15 Mar 2018 07:36:57 +0000
Message-ID: <CAKv+Gu-NfXm5YLWXAPsf6zycPs7Ti9qPLQ7FvpOrjdPz5hEP7Q@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mm/page_alloc: fix memmap_init_zone pageblock alignment"
To: Daniel Vacek <neelx@redhat.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 March 2018 at 02:23, Daniel Vacek <neelx@redhat.com> wrote:
> On Wed, Mar 14, 2018 at 8:29 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> This reverts commit 864b75f9d6b0100bb24fdd9a20d156e7cda9b5ae.
>>
>> Commit 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock
>> alignment") modified the logic in memmap_init_zone() to initialize
>> struct pages associated with invalid PFNs, to appease a VM_BUG_ON()
>> in move_freepages(), which is redundant by its own admission, and
>> dereferences struct page fields to obtain the zone without checking
>> whether the struct pages in question are valid to begin with.
>>
>> Commit 864b75f9d6b0 only makes it worse, since the rounding it does
>> may cause pfn assume the same value it had in a prior iteration of
>> the loop, resulting in an infinite loop and a hang very early in the
>> boot. Also, since it doesn't perform the same rounding on start_pfn
>> itself but only on intermediate values following an invalid PFN, we
>> may still hit the same VM_BUG_ON() as before.
>>
>> So instead, let's fix this at the core, and ensure that the BUG
>> check doesn't dereference struct page fields of invalid pages.
>>
>> Fixes: 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
>> Cc: Daniel Vacek <neelx@redhat.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Paul Burton <paul.burton@imgtec.com>
>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  mm/page_alloc.c | 13 +++++--------
>>  1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3d974cb2a1a1..635d7dd29d7f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1910,7 +1910,9 @@ static int move_freepages(struct zone *zone,
>>          * Remove at a later date when no bug reports exist related to
>>          * grouping pages by mobility
>>          */
>> -       VM_BUG_ON(page_zone(start_page) != page_zone(end_page));
>> +       VM_BUG_ON(pfn_valid(page_to_pfn(start_page)) &&
>> +                 pfn_valid(page_to_pfn(end_page)) &&
>> +                 page_zone(start_page) != page_zone(end_page));
>
> Hi, I am on vacation this week and I didn't have a chance to test this
> yet but I am not sure this is correct. Generic pfn_valid() unlike the
> arm{,64} arch specific versions returns true for all pfns in a section
> if there is at least some memory mapped in that section. So I doubt
> this prevents the crash I was targeting. I believe pfn_valid() does
> not change a thing here :(
>

If this is the case, memblock_next_valid_pfn() is broken since it
skips valid PFNs, and we should be fixing that instead.

> ------------------------
> include/linux/mmzone.h:
> pfn_valid(pfn)
>   valid_section(__nr_to_section(pfn_to_section_nr(pfn)))
>     return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP))
>
> arch/arm64/mm/init.c:
> #ifdef CONFIG_HAVE_ARCH_PFN_VALID
> int pfn_valid(unsigned long pfn)
> {
>     return memblock_is_map_memory(pfn << PAGE_SHIFT);
> }
> EXPORT_SYMBOL(pfn_valid);
> #endif
> ------------------------
>
> Also I already sent a fix to Andrew yesterday which was reported to
> fix the loop.
>
> Moreover, you also reported this:
>
>>    Early memory node ranges
>>      node   0: [mem 0x0000000080000000-0x00000000febeffff]
>>      node   0: [mem 0x00000000febf0000-0x00000000fefcffff]
>>      node   0: [mem 0x00000000fefd0000-0x00000000ff43ffff]
>>      node   0: [mem 0x00000000ff440000-0x00000000ff7affff]
>>      node   0: [mem 0x00000000ff7b0000-0x00000000ffffffff]
>>      node   0: [mem 0x0000000880000000-0x0000000fffffffff]
>>    Initmem setup node 0 [mem 0x0000000080000000-0x0000000fffffffff]
>>    pfn:febf0 oldnext:febf0 newnext:fe9ff
>>    pfn:febf0 oldnext:febf0 newnext:fe9ff
>>    pfn:febf0 oldnext:febf0 newnext:fe9ff
>>    etc etc
>
> I am wondering how come pfn_valid(0xfebf0) returns false here. Should
> it be true or do I miss something?
>
> --nX
