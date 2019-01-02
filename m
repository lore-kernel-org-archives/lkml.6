Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7400CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381172075B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfABKSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:18:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbfABKSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:18:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21B88C0495B8;
        Wed,  2 Jan 2019 10:18:14 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A54AE5C22C;
        Wed,  2 Jan 2019 10:18:06 +0000 (UTC)
Date:   Wed, 2 Jan 2019 18:18:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, kexec@lists.infradead.org,
        Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/memblock: extend the limit inferior of
 bottom-up after parsing hotplug attr
Message-ID: <20190102101804.GD1990@MiWiFi-R3L-srv>
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-2-git-send-email-kernelfans@gmail.com>
 <20181231084018.GA28478@rapoport-lnx>
 <CAFgQCTvQnj7zReFvH_gmfVJdPXE325o+z4Xx76fupvsLR_7H2A@mail.gmail.com>
 <20190102092749.GA22664@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102092749.GA22664@rapoport-lnx>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 02 Jan 2019 10:18:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/19 at 11:27am, Mike Rapoport wrote:
> On Wed, Jan 02, 2019 at 02:47:34PM +0800, Pingfan Liu wrote:
> > On Mon, Dec 31, 2018 at 4:40 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Fri, Dec 28, 2018 at 11:00:01AM +0800, Pingfan Liu wrote:
> > > > The bottom-up allocation style is introduced to cope with movable_node,
> > > > where the limit inferior of allocation starts from kernel's end, due to
> > > > lack of knowledge of memory hotplug info at this early time. But if later,
> > > > hotplug info has been got, the limit inferior can be extend to 0.
> > > > 'kexec -c' prefers to reuse this style to alloc mem at lower address,
> > > > since if the reserved region is beyond 4G, then it requires extra mem
> > > > (default is 16M) for swiotlb.
> > >
> > > I fail to understand why the availability of memory hotplug information
> > > would allow to extend the lower limit of bottom-up memblock allocations
> > > below the kernel. The memory in the physical range [0, kernel_start) can be
> > > allocated as soon as the kernel memory is reserved.
> > >
> > Yes, the  [0, kernel_start) can be allocated at this time by some func
> > e.g. memblock_reserve(). But there is trick. For the func like
> > memblock_find_in_range(), this is hotplug attr checking ,,it will
> > check the hotmovable attr in __next_mem_range()
> > {
> > if (movable_node_is_enabled() && memblock_is_hotpluggable(m))
> > continue
> > }.  So the movable memory can be safely skipped.
> 
> I still don't see the connection between allocating memory below
> kernel_start and the hotplug info.
> 
> The check for 'end > kernel_end' in
> 
>  	if (memblock_bottom_up() && end > kernel_end)
> 
> does not protect against allocation in a hotplugable area.
> If memblock_find_in_range() is called before hotplug info is parsed it can
> return a range in a hotplugable area.
> 
> The point I'd like to clarify is why allocating memory in the range [0,
> kernel_start) cannot be done before hotplug info is available and why it is
> safe to allocate that memory afterwards?

Well, I think that's because we have KASLR. Before KASLR was introdueced,
kernel is put at a low and fixed physical address. Allocating memblock
bottom-up after kernel can make sure those kernel data is in the same node
as kernel text itself before SRAT parsed. While [0, kernel_start) is a
very small range, e.g on x86, it was 16 MB, which is very possibly used
up.

But now, with KASLR enabled by default, this bottom-up after kernel text
allocation has potential issue. E.g we have node0 (including normal zone),
node1(including movable zone), if KASLR put kernel at top of node0, the
next memblock allocation before SRAT parsed will stamp into movable zone
of node1, hotplug doesn't work well any more consequently. I had
considered this issue previously, but haven't thought of a way to fix
it.

While it's not related to this patch. About this patchset, I didn't
check it carefully in v2 post, and acked it. In fact the current way is
not good, Pingfan should call __memblock_find_range_bottom_up() directly
for crashkernel reserving. Reasons are:
1)SRAT parsing is done, system restore to take top-down way to do
memblock allocat.
2)we do need to find range bottom-up if user specify crashkernel=xxM
(without a explicit base address).

Thanks
Baoquan

> 
> > Thanks for your kindly review.
> > 
> > Regards,
> > Pingfan
> > 
> > > The extents of the memory node hosting the kernel image can be used to
> > > limit memblok allocations from that particular node, even in top-down mode.
> > >
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Tang Chen <tangchen@cn.fujitsu.com>
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Len Brown <lenb@kernel.org>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > > Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> > > > Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> > > > Cc: Nicholas Piggin <npiggin@gmail.com>
> > > > Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > > > Cc: Daniel Vacek <neelx@redhat.com>
> > > > Cc: Mathieu Malaterre <malat@debian.org>
> > > > Cc: Stefan Agner <stefan@agner.ch>
> > > > Cc: Dave Young <dyoung@redhat.com>
> > > > Cc: Baoquan He <bhe@redhat.com>
> > > > Cc: yinghai@kernel.org,
> > > > Cc: vgoyal@redhat.com
> > > > Cc: linux-kernel@vger.kernel.org
> > > > ---
> > > >  drivers/acpi/numa.c      |  4 ++++
> > > >  include/linux/memblock.h |  1 +
> > > >  mm/memblock.c            | 58 +++++++++++++++++++++++++++++-------------------
> > > >  3 files changed, 40 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > > > index 2746994..3eea4e4 100644
> > > > --- a/drivers/acpi/numa.c
> > > > +++ b/drivers/acpi/numa.c
> > > > @@ -462,6 +462,10 @@ int __init acpi_numa_init(void)
> > > >
> > > >               cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
> > > >                                           acpi_parse_memory_affinity, 0);
> > > > +
> > > > +#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> > > > +             mark_mem_hotplug_parsed();
> > > > +#endif
> > > >       }
> > > >
> > > >       /* SLIT: System Locality Information Table */
> > > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > > index aee299a..d89ed9e 100644
> > > > --- a/include/linux/memblock.h
> > > > +++ b/include/linux/memblock.h
> > > > @@ -125,6 +125,7 @@ int memblock_reserve(phys_addr_t base, phys_addr_t size);
> > > >  void memblock_trim_memory(phys_addr_t align);
> > > >  bool memblock_overlaps_region(struct memblock_type *type,
> > > >                             phys_addr_t base, phys_addr_t size);
> > > > +void mark_mem_hotplug_parsed(void);
> > > >  int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
> > > >  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
> > > >  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> > > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > > index 81ae63c..a3f5e46 100644
> > > > --- a/mm/memblock.c
> > > > +++ b/mm/memblock.c
> > > > @@ -231,6 +231,12 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
> > > >       return 0;
> > > >  }
> > > >
> > > > +static bool mem_hotmovable_parsed __initdata_memblock;
> > > > +void __init_memblock mark_mem_hotplug_parsed(void)
> > > > +{
> > > > +     mem_hotmovable_parsed = true;
> > > > +}
> > > > +
> > > >  /**
> > > >   * memblock_find_in_range_node - find free area in given range and node
> > > >   * @size: size of free area to find
> > > > @@ -259,7 +265,7 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
> > > >                                       phys_addr_t end, int nid,
> > > >                                       enum memblock_flags flags)
> > > >  {
> > > > -     phys_addr_t kernel_end, ret;
> > > > +     phys_addr_t kernel_end, ret = 0;
> > > >
> > > >       /* pump up @end */
> > > >       if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
> > > > @@ -270,34 +276,40 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
> > > >       end = max(start, end);
> > > >       kernel_end = __pa_symbol(_end);
> > > >
> > > > -     /*
> > > > -      * try bottom-up allocation only when bottom-up mode
> > > > -      * is set and @end is above the kernel image.
> > > > -      */
> > > > -     if (memblock_bottom_up() && end > kernel_end) {
> > > > -             phys_addr_t bottom_up_start;
> > > > +     if (memblock_bottom_up()) {
> > > > +             phys_addr_t bottom_up_start = start;
> > > >
> > > > -             /* make sure we will allocate above the kernel */
> > > > -             bottom_up_start = max(start, kernel_end);
> > > > -
> > > > -             /* ok, try bottom-up allocation first */
> > > > -             ret = __memblock_find_range_bottom_up(bottom_up_start, end,
> > > > -                                                   size, align, nid, flags);
> > > > -             if (ret)
> > > > +             if (mem_hotmovable_parsed) {
> > > > +                     ret = __memblock_find_range_bottom_up(
> > > > +                             bottom_up_start, end, size, align, nid,
> > > > +                             flags);
> > > >                       return ret;
> > > >
> > > >               /*
> > > > -              * we always limit bottom-up allocation above the kernel,
> > > > -              * but top-down allocation doesn't have the limit, so
> > > > -              * retrying top-down allocation may succeed when bottom-up
> > > > -              * allocation failed.
> > > > -              *
> > > > -              * bottom-up allocation is expected to be fail very rarely,
> > > > -              * so we use WARN_ONCE() here to see the stack trace if
> > > > -              * fail happens.
> > > > +              * if mem hotplug info is not parsed yet, try bottom-up
> > > > +              * allocation with @end above the kernel image.
> > > >                */
> > > > -             WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
> > > > +             } else if (!mem_hotmovable_parsed && end > kernel_end) {
> > > > +                     /* make sure we will allocate above the kernel */
> > > > +                     bottom_up_start = max(start, kernel_end);
> > > > +                     ret = __memblock_find_range_bottom_up(
> > > > +                             bottom_up_start, end, size, align, nid,
> > > > +                             flags);
> > > > +                     if (ret)
> > > > +                             return ret;
> > > > +                     /*
> > > > +                      * we always limit bottom-up allocation above the
> > > > +                      * kernel, but top-down allocation doesn't have
> > > > +                      * the limit, so retrying top-down allocation may
> > > > +                      * succeed when bottom-up allocation failed.
> > > > +                      *
> > > > +                      * bottom-up allocation is expected to be fail
> > > > +                      * very rarely, so we use WARN_ONCE() here to see
> > > > +                      * the stack trace if fail happens.
> > > > +                      */
> > > > +                     WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
> > > >                         "memblock: bottom-up allocation failed, memory hotremove may be affected\n");
> > > > +             }
> > > >       }
> > > >
> > > >       return __memblock_find_range_top_down(start, end, size, align, nid,
> > > > --
> > > > 2.7.4
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
> > >
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
