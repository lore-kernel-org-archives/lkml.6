Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D81320865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D81320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390223AbeKVUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:00:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbeKVUAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:00:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 508634E33B;
        Thu, 22 Nov 2018 09:21:30 +0000 (UTC)
Received: from [10.36.116.206] (ovpn-116-206.ams2.redhat.com [10.36.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F63E16EFA;
        Thu, 22 Nov 2018 09:21:25 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] mm, memory_hotplug: allocate memmap from hotadded
 memory
To:     Oscar Salvador <osalvador@suse.com>, linux-mm@kvack.org
Cc:     mhocko@suse.com, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, arunks@codeaurora.org, bhe@redhat.com,
        dan.j.williams@intel.com, Pavel.Tatashin@microsoft.com,
        Jonathan.Cameron@huawei.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org
References: <20181116101222.16581-1-osalvador@suse.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <2571308d-0460-e8b9-ad40-75d6b13b2d09@redhat.com>
Date:   Thu, 22 Nov 2018 10:21:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116101222.16581-1-osalvador@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 22 Nov 2018 09:21:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.18 11:12, Oscar Salvador wrote:
> Hi,
> 
> this patchset is based on Michal's patchset [1].
> Patch#1, patch#2 and patch#4 are quite the same.
> They just needed little changes to adapt it to current codestream,
> so it seemed fair to leave them.
> 
> ---------
> Original cover:
> 
> This is another step to make the memory hotplug more usable. The primary
> goal of this patchset is to reduce memory overhead of the hot added
> memory (at least for SPARSE_VMEMMAP memory model). Currently we use
> kmalloc to poppulate memmap (struct page array) which has two main
> drawbacks a) it consumes an additional memory until the hotadded memory
> itslef is onlined and b) memmap might end up on a different numa node
> which is especially true for movable_node configuration.

I haven't looked at the patches but have some questions.

1. How are we going to present such memory to the system statistics?

In my opinion, this vmemmap memory should
a) still account to total memory
b) show up as allocated

So just like before.


2. Is this optional, in other words, can a device driver decide to not
to it like that?

You mention ballooning. Now, both XEN and Hyper-V (the only balloon
drivers that add new memory as of now), usually add e.g. a 128MB segment
to only actually some part of it (e.g. 64MB, but could vary). Now, going
ahead and assuming that all memory of a section can be read/written is
wrong. A device driver will indicate which pages may actually be used
via set_online_page_callback() when new memory is added. But at that
point you already happily accessed some memory for vmmap - which might
lead to crashes.

For now the rule was: Memory that was not onlined will not be
read/written, that's why it works for XEN and Hyper-V.

It *could* work for them if they could know and communicate to
add_memory() which part of a newly added memory block is definitely usable.

So, especially for the case of balloning that you describe, things are
more tricky than a simple "let's just use some memory of the memory
block we're adding" unfortunately. For DIMMs it can work.

> 
> a) is problem especially for memory hotplug based memory "ballooning"
> solutions when the delay between physical memory hotplug and the
> onlining can lead to OOM and that led to introduction of hacks like auto
> onlining (see 31bc3858ea3e ("memory-hotplug: add automatic onlining
> policy for the newly added memory")).
> b) can have performance drawbacks.
> 
> One way to mitigate both issues is to simply allocate memmap array
> (which is the largest memory footprint of the physical memory hotplug)
> from the hotadded memory itself. VMEMMAP memory model allows us to map
> any pfn range so the memory doesn't need to be online to be usable
> for the array. See patch 3 for more details. In short I am reusing an
> existing vmem_altmap which wants to achieve the same thing for nvdim
> device memory.
> 
> There is also one potential drawback, though. If somebody uses memory
> hotplug for 1G (gigantic) hugetlb pages then this scheme will not work
> for them obviously because each memory block will contain reserved
> area. Large x86 machines will use 2G memblocks so at least one 1G page
> will be available but this is still not 2G...

Yes, I think this is a possible use case. So it would have to be
configurable somewehere - opt-in most probably. But related to
ballooning, they will usually add the minimum possible granularity (e.g.
128MB) and that seems to work for these setups. DIMMs are probably
different.

> 
> I am not really sure somebody does that and how reliable that can work
> actually. Nevertheless, I _believe_ that onlining more memory into
> virtual machines is much more common usecase. Anyway if there ever is a
> strong demand for such a usecase we have basically 3 options a) enlarge
> memory blocks even more b) enhance altmap allocation strategy and reuse
> low memory sections to host memmaps of other sections on the same NUMA
> node c) have the memmap allocation strategy configurable to fallback to
> the current allocation.
> 
> ---------
> 
> Old version of this patchset would blow up because we were clearing the
> pmds while we still had to reference pages backed by that memory.
> I picked another approach which does not force us to touch arch specific code
> in that regard.
> 
> Overall design:
> 
> With the preface of:
> 
>     1) Whenever you hot-add a range, this is the same range that will be hot-removed.
>        This is just because you can't remove half of a DIMM, in the same way you can't
>        remove half of a device in qemu.
>        A device/DIMM are added/removed as a whole.
> 
>     2) Every add_memory()->add_memory_resource()->arch_add_memory()->__add_pages()
>        will use a new altmap because it is a different hot-added range.
> 
>     3) When you hot-remove a range, the sections will be removed sequantially
>        starting from the first section of the range and ending with the last one.
> 
>     4) hot-remove operations are protected by hotplug lock, so no parallel operations
>        can take place.
> 
>     The current design is as follows:
> 
>     hot-remove operation)
> 
>     - __kfree_section_memmap will be called for every section to be removed.
>     - We catch the first vmemmap_page and we pin it to a global variable.
>     - Further calls to __kfree_section_memmap will decrease refcount of
>       the vmemmap page without calling vmemmap_free().
>       We defer the call to vmemmap_free() untill all sections are removed
>     - If the refcount drops to 0, we know that we hit the last section.
>     - We clear the global variable.
>     - We call vmemmap_free for [last_section, current_vmemmap_page)
> 
>     In case we are hot-removing a range that used altmap, the call to
>     vmemmap_free must be done backwards, because the beginning of memory
>     is used for the pagetables.
>     Doing it this way, we ensure that by the time we remove the pagetables,
>     those pages will not have to be referenced anymore.
> 
>     An example:
> 
>     (qemu) object_add memory-backend-ram,id=ram0,size=10G
>     (qemu) device_add pc-dimm,id=dimm0,memdev=ram0,node=1
> 
>     - This has added: ffffea0004000000 - ffffea000427ffc0 (refcount: 80)
> 
>     When refcount of ffffea0004000000 drops to 0, vmemmap_free()
>     will be called in this way:
> 
>     vmemmap_free: start/end: ffffea000de00000 - ffffea000e000000
>     vmemmap_free: start/end: ffffea000dc00000 - ffffea000de00000
>     vmemmap_free: start/end: ffffea000da00000 - ffffea000dc00000
>     vmemmap_free: start/end: ffffea000d800000 - ffffea000da00000
>     vmemmap_free: start/end: ffffea000d600000 - ffffea000d800000
>     vmemmap_free: start/end: ffffea000d400000 - ffffea000d600000
>     vmemmap_free: start/end: ffffea000d200000 - ffffea000d400000
>     vmemmap_free: start/end: ffffea000d000000 - ffffea000d200000
>     vmemmap_free: start/end: ffffea000ce00000 - ffffea000d000000
>     vmemmap_free: start/end: ffffea000cc00000 - ffffea000ce00000
>     vmemmap_free: start/end: ffffea000ca00000 - ffffea000cc00000
>     vmemmap_free: start/end: ffffea000c800000 - ffffea000ca00000
>     vmemmap_free: start/end: ffffea000c600000 - ffffea000c800000
>     vmemmap_free: start/end: ffffea000c400000 - ffffea000c600000
>     vmemmap_free: start/end: ffffea000c200000 - ffffea000c400000
>     vmemmap_free: start/end: ffffea000c000000 - ffffea000c200000
>     vmemmap_free: start/end: ffffea000be00000 - ffffea000c000000
>     ...
>     ...
>     vmemmap_free: start/end: ffffea0004000000 - ffffea0004200000
> 
> 
>     [Testing]
> 
>     - Tested ony on x86_64
>     - Several tests were carried out with memblocks of different sizes.
>     - Tests were performed adding different memory-range sizes
>       from 512M to 60GB.
> 
>     [Todo]
>     - Look into hotplug gigantic pages case
> 
> Before investing more effort, I would like to hear some opinions/thoughts/ideas.
> 
> [1] https://lore.kernel.org/lkml/20170801124111.28881-1-mhocko@kernel.org/
> 
> Michal Hocko (3):
>   mm, memory_hotplug: cleanup memory offline path
>   mm, memory_hotplug: provide a more generic restrictions for memory
>     hotplug
>   mm, sparse: rename kmalloc_section_memmap, __kfree_section_memmap
> 
> Oscar Salvador (1):
>   mm, memory_hotplug: allocate memmap from the added memory range for
>     sparse-vmemmap
> 
>  arch/arm64/mm/mmu.c            |   5 +-
>  arch/ia64/mm/init.c            |   5 +-
>  arch/powerpc/mm/init_64.c      |   2 +
>  arch/powerpc/mm/mem.c          |   6 +-
>  arch/s390/mm/init.c            |  12 +++-
>  arch/sh/mm/init.c              |   6 +-
>  arch/x86/mm/init_32.c          |   6 +-
>  arch/x86/mm/init_64.c          |  17 ++++--
>  include/linux/memory_hotplug.h |  35 ++++++++---
>  include/linux/memremap.h       |  65 +++++++++++++++++++-
>  include/linux/page-flags.h     |  18 ++++++
>  kernel/memremap.c              |  12 ++--
>  mm/compaction.c                |   3 +
>  mm/hmm.c                       |   6 +-
>  mm/memory_hotplug.c            | 133 ++++++++++++++++++++++++++++-------------
>  mm/page_alloc.c                |  33 ++++++++--
>  mm/page_isolation.c            |  13 +++-
>  mm/sparse.c                    |  62 ++++++++++++++++---
>  18 files changed, 345 insertions(+), 94 deletions(-)
> 


-- 

Thanks,

David / dhildenb
