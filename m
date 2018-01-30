Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeA3SLK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:11:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35778 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeA3SLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:11:09 -0500
X-Google-Smtp-Source: AH8x226HgFx5dAsmsLYRlL8Z2bIxJlPP52HwLUHW4/x9ZVuxCmbLbOXgC9TkfMpfYNegLrczDO0imEiXiHvFVFHGcSI=
MIME-Version: 1.0
In-Reply-To: <20180130101141.GW21609@dhcp22.suse.cz>
References: <20180130083006.GB1245@in.ibm.com> <20180130091600.GA26445@dhcp22.suse.cz>
 <20180130092815.GR21609@dhcp22.suse.cz> <20180130095345.GC1245@in.ibm.com> <20180130101141.GW21609@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 30 Jan 2018 13:11:06 -0500
X-Gmail-Original-Message-ID: <CAOAebxvAwuQfAErNJa2fwdWCe+yToCLn-vr0+SuyUcdb5corAw@mail.gmail.com>
Message-ID: <CAOAebxvAwuQfAErNJa2fwdWCe+yToCLn-vr0+SuyUcdb5corAw@mail.gmail.com>
Subject: Re: Memory hotplug not increasing the total RAM
To: Michal Hocko <mhocko@kernel.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=26 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801300222
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for taking care of the problem. The patch may introduce a
small performance regression during normal boot, as we add a branch
into a hot initialization path. But, it fixes a current problem, so:

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

However, I think we should change the hotplug code to also not to
touch the map area until struct pages are initialized.

Currently, we loop through "struct page"s several times during memory hotplug:

1. memset(0) in sparse_add_one_section()
2. loop in __add_section() to set do: set_page_node(page, nid); and
SetPageReserved(page);
3. loop in pages_correctly_reserved() to check that SetPageReserved is set.
4. loop in memmap_init_zone() to call __init_single_pfn()

Every time we have to loop through "struct page"s we lose the cached
data, as they are massive.

I suggest, getting rid of "1-3" loops, and only keep loop #4, and at
the end of memmap_init_zone()
after __init_single_pfn() calls do:

if (context == MEMMAP_HOTPLUG)
  SetPageReserved(page);

Hopefully, the compiler will optimize the above two lines into a
conditional move instruction, and therefore, not adding any new
branches.

Also, this change would enable a future optimization of multithreading
memory hotplugging, if that will ever be needed.

Thank you,
Pavel


On Tue, Jan 30, 2018 at 5:11 AM, Michal Hocko <mhocko@kernel.org> wrote:
> [Cc Andrew - thread starts here
>  http://lkml.kernel.org/r/20180130083006.GB1245@in.ibm.com]
>
> On Tue 30-01-18 15:23:45, Bharata B Rao wrote:
>> On Tue, Jan 30, 2018 at 10:28:15AM +0100, Michal Hocko wrote:
>> > On Tue 30-01-18 10:16:00, Michal Hocko wrote:
>> > > On Tue 30-01-18 14:00:06, Bharata B Rao wrote:
>> > > > Hi,
>> > > >
>> > > > With the latest upstream, I see that memory hotplug is not working
>> > > > as expected. The hotplugged memory isn't seen to increase the total
>> > > > RAM pages. This has been observed with both x86 and Power guests.
>> > > >
>> > > > 1. Memory hotplug code intially marks pages as PageReserved via
>> > > > __add_section().
>> > > > 2. Later the struct page gets cleared in __init_single_page().
>> > > > 3. Next online_pages_range() increments totalram_pages only when
>> > > >    PageReserved is set.
>> > >
>> > > You are right. I have completely forgot about this late struct page
>> > > initialization during onlining. memory hotplug really doesn't want
>> > > zeroying. Let me think about a fix.
>> >
>> > Could you test with the following please? Not an act of beauty but
>> > we are initializing memmap in sparse_add_one_section for memory
>> > hotplug. I hate how this is different from the initialization case
>> > but there is quite a long route to unify those two... So a quick
>> > fix should be as follows.
>>
>> Tested on Power guest, fixes the issue. I can now see the total memory
>> size increasing after hotplug.
>
> Thanks for your quick testing. Here we go with the fix.
>
> From d60b333d4048a84c3172829ec24706c761a7bd44 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Tue, 30 Jan 2018 11:02:18 +0100
> Subject: [PATCH] mm, memory_hotplug: fix memmap initialization
>
> Bharata has noticed that onlining a newly added memory doesn't increase
> the total memory, pointing to f7f99100d8d9 ("mm: stop zeroing memory
> during allocation in vmemmap") as a culprit. This commit has changed
> the way how the memory for memmaps is initialized and moves it from the
> allocation time to the initialization time. This works properly for the
> early memmap init path.
>
> It doesn't work for the memory hotplug though because we need to mark
> page as reserved when the sparsemem section is created and later
> initialize it completely during onlining. memmap_init_zone is called
> in the early stage of onlining. With the current code it calls
> __init_single_page and as such it clears up the whole stage and
> therefore online_pages_range skips those pages.
>
> Fix this by skipping mm_zero_struct_page in __init_single_page for
> memory hotplug path. This is quite uggly but unifying both early init
> and memory hotplug init paths is a large project. Make sure we plug the
> regression at least.
>
> Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")
> Cc: stable
> Reported-and-Tested-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6129f989223a..f548f50c1f3c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1178,9 +1178,10 @@ static void free_one_page(struct zone *zone,
>  }
>
>  static void __meminit __init_single_page(struct page *page, unsigned long pfn,
> -                               unsigned long zone, int nid)
> +                               unsigned long zone, int nid, bool zero)
>  {
> -       mm_zero_struct_page(page);
> +       if (zero)
> +               mm_zero_struct_page(page);
>         set_page_links(page, zone, nid, pfn);
>         init_page_count(page);
>         page_mapcount_reset(page);
> @@ -1195,9 +1196,9 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
>  }
>
>  static void __meminit __init_single_pfn(unsigned long pfn, unsigned long zone,
> -                                       int nid)
> +                                       int nid, bool zero)
>  {
> -       return __init_single_page(pfn_to_page(pfn), pfn, zone, nid);
> +       return __init_single_page(pfn_to_page(pfn), pfn, zone, nid, zero);
>  }
>
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> @@ -1218,7 +1219,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
>                 if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
>                         break;
>         }
> -       __init_single_pfn(pfn, zid, nid);
> +       __init_single_pfn(pfn, zid, nid, true);
>  }
>  #else
>  static inline void init_reserved_page(unsigned long pfn)
> @@ -1535,7 +1536,7 @@ static unsigned long  __init deferred_init_pages(int nid, int zid,
>                 } else {
>                         page++;
>                 }
> -               __init_single_page(page, pfn, zid, nid);
> +               __init_single_page(page, pfn, zid, nid, true);
>                 nr_pages++;
>         }
>         return (nr_pages);
> @@ -5400,15 +5401,20 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                  * can be created for invalid pages (for alignment)
>                  * check here not to call set_pageblock_migratetype() against
>                  * pfn out of zone.
> +                *
> +                * Please note that MEMMAP_HOTPLUG path doesn't clear memmap
> +                * because this is done early in sparse_add_one_section
>                  */
>                 if (!(pfn & (pageblock_nr_pages - 1))) {
>                         struct page *page = pfn_to_page(pfn);
>
> -                       __init_single_page(page, pfn, zone, nid);
> +                       __init_single_page(page, pfn, zone, nid,
> +                                       context != MEMMAP_HOTPLUG);
>                         set_pageblock_migratetype(page, MIGRATE_MOVABLE);
>                         cond_resched();
>                 } else {
> -                       __init_single_pfn(pfn, zone, nid);
> +                       __init_single_pfn(pfn, zone, nid,
> +                                       context != MEMMAP_HOTPLUG);
>                 }
>         }
>  }
> --
> 2.15.1
>
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
