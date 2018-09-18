Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0BDC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319ED2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319ED2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbeISCxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:53:21 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41156 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISCxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:53:21 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so3160626oiw.8;
        Tue, 18 Sep 2018 14:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iY6ocZcyOP/p1/bvG5B59HAIPaVQDLpoBdapu7hxxwc=;
        b=nKdpb4Ya7LXSzwR+LXyVrPQMnBvkya6tIMbTuvlGUgu7r2cyEdOJVnof1dB1UPFx91
         5qtFHGqgv1zuXc6CZnKQhqZ4kjsvPde2cZ7rBLsdPloL0zNjlizskxaZ5cxR1fcWEKG7
         8oLPXKSFKegakBS8j1GmLcsKnALHBl1+tMpqPYhW87/ETcVd0x5O/yqU3q8x9e1gu0KR
         p9SQfi4700uCcwZpXCh+PxPsAj0zzbaOhRxoY6Az3mT08Cks3fF1h4rTiGgXp0AsUQy9
         d63RSVK+J8wC6FRyj8agtzA26a8jA0nnqXv/kb5yBF1XLIYxtVufneGmuJC0BZCSqy7g
         Fhfw==
X-Gm-Message-State: APzg51DaDycY5RYA186GhsjwboUQn2YCC6K7ZKj6KWSgtwepDVscCLwk
        uk4FMfgBuvD0dDkFzHxGLkf0sFKxeCXPfmPQIAs=
X-Google-Smtp-Source: ANB0VdYWIM2P8Y5fN4xgqP1iLsGXe0whTNbFMUQ2qwa4+5Ev3WSpGTcjWNCnnWgCaLiHOh07UNpD9/6+HlGUY/FE/Gw=
X-Received: by 2002:a54:4010:: with SMTP id x16-v6mr2601846oie.228.1537305533103;
 Tue, 18 Sep 2018 14:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180918114822.21926-1-david@redhat.com> <20180918114822.21926-2-david@redhat.com>
In-Reply-To: <20180918114822.21926-2-david@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Sep 2018 23:18:41 +0200
Message-ID: <CAJZ5v0gDDEvBrNCbB8E3Stq4QE_+6X72Pbu0Wyj8bQoSPXs3WA@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] mm/memory_hotplug: make remove_memory() take the device_hotplug_lock
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        xen-devel@lists.xenproject.org, devel@linuxdriverproject.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, rashmica.g@gmail.com,
        Michael Neuling <mikey@neuling.org>,
        Balbir Singh <bsingharora@gmail.com>, nfont@linux.vnet.ibm.com,
        jallen@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        osalvador@suse.de, yasu.isimatu@gmail.com, malat@debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 1:48 PM David Hildenbrand <david@redhat.com> wrote:
>
> remove_memory() is exported right now but requires the
> device_hotplug_lock, which is not exported. So let's provide a variant
> that takes the lock and only export that one.
>
> The lock is already held in
>         arch/powerpc/platforms/pseries/hotplug-memory.c
>         drivers/acpi/acpi_memhotplug.c
> So, let's use the locked variant.
>
> The lock is not held (but taken in)
>         arch/powerpc/platforms/powernv/memtrace.c
> So let's keep using the (now) locked variant.
>
> Apart from that, there are not other users in the tree.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: John Allen <jallen@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
> Cc: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/powernv/memtrace.c       | 2 --
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 6 +++---
>  drivers/acpi/acpi_memhotplug.c                  | 2 +-
>  include/linux/memory_hotplug.h                  | 3 ++-
>  mm/memory_hotplug.c                             | 9 ++++++++-
>  5 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index 51dc398ae3f7..8f1cd4f3bfd5 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -90,9 +90,7 @@ static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
>         walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
>                           change_memblock_state);
>
> -       lock_device_hotplug();
>         remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
> -       unlock_device_hotplug();
>
>         return true;
>  }
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index c1578f54c626..b3f54466e25f 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -334,7 +334,7 @@ static int pseries_remove_memblock(unsigned long base, unsigned int memblock_siz
>         nid = memory_add_physaddr_to_nid(base);
>
>         for (i = 0; i < sections_per_block; i++) {
> -               remove_memory(nid, base, MIN_MEMORY_BLOCK_SIZE);
> +               __remove_memory(nid, base, MIN_MEMORY_BLOCK_SIZE);
>                 base += MIN_MEMORY_BLOCK_SIZE;
>         }
>
> @@ -423,7 +423,7 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>         block_sz = pseries_memory_block_size();
>         nid = memory_add_physaddr_to_nid(lmb->base_addr);
>
> -       remove_memory(nid, lmb->base_addr, block_sz);
> +       __remove_memory(nid, lmb->base_addr, block_sz);
>
>         /* Update memory regions for memory remove */
>         memblock_remove(lmb->base_addr, block_sz);
> @@ -710,7 +710,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>
>         rc = dlpar_online_lmb(lmb);
>         if (rc) {
> -               remove_memory(nid, lmb->base_addr, block_sz);
> +               __remove_memory(nid, lmb->base_addr, block_sz);
>                 dlpar_remove_device_tree_lmb(lmb);
>         } else {
>                 lmb->flags |= DRCONF_MEM_ASSIGNED;
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 6b0d3ef7309c..811148415993 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -282,7 +282,7 @@ static void acpi_memory_remove_memory(struct acpi_memory_device *mem_device)
>                         nid = memory_add_physaddr_to_nid(info->start_addr);
>
>                 acpi_unbind_memory_blocks(info);
> -               remove_memory(nid, info->start_addr, info->length);
> +               __remove_memory(nid, info->start_addr, info->length);
>                 list_del(&info->list);
>                 kfree(info);
>         }
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 34a28227068d..1f096852f479 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -301,6 +301,7 @@ extern bool is_mem_section_removable(unsigned long pfn, unsigned long nr_pages);
>  extern void try_offline_node(int nid);
>  extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
>  extern void remove_memory(int nid, u64 start, u64 size);
> +extern void __remove_memory(int nid, u64 start, u64 size);
>
>  #else
>  static inline bool is_mem_section_removable(unsigned long pfn,
> @@ -317,6 +318,7 @@ static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  }
>
>  static inline void remove_memory(int nid, u64 start, u64 size) {}
> +static inline void __remove_memory(int nid, u64 start, u64 size) {}
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>
>  extern void __ref free_area_init_core_hotplug(int nid);
> @@ -330,7 +332,6 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>                 unsigned long nr_pages, struct vmem_altmap *altmap);
>  extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
>  extern bool is_memblock_offlined(struct memory_block *mem);
> -extern void remove_memory(int nid, u64 start, u64 size);
>  extern int sparse_add_one_section(struct pglist_data *pgdat,
>                 unsigned long start_pfn, struct vmem_altmap *altmap);
>  extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 38d94b703e9d..b8b1bd970322 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1873,7 +1873,7 @@ EXPORT_SYMBOL(try_offline_node);
>   * and online/offline operations before this call, as required by
>   * try_offline_node().
>   */
> -void __ref remove_memory(int nid, u64 start, u64 size)
> +void __ref __remove_memory(int nid, u64 start, u64 size)
>  {
>         int ret;
>
> @@ -1902,5 +1902,12 @@ void __ref remove_memory(int nid, u64 start, u64 size)
>
>         mem_hotplug_done();
>  }
> +
> +void remove_memory(int nid, u64 start, u64 size)
> +{
> +       lock_device_hotplug();
> +       __remove_memory(nid, start, size);
> +       unlock_device_hotplug();
> +}
>  EXPORT_SYMBOL_GPL(remove_memory);
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> --

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
