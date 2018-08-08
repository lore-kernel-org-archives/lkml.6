Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A363C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DAB2178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DAB2178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbeHHUQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:16:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728471AbeHHUQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:16:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89DC040241C7;
        Wed,  8 Aug 2018 17:56:02 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F4177C3D;
        Wed,  8 Aug 2018 17:56:00 +0000 (UTC)
Date:   Wed, 8 Aug 2018 13:55:59 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808175558.GD3429@redhat.com>
References: <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
 <20180807204834.GA6844@techadventures.net>
 <20180807221345.GD3301@redhat.com>
 <20180808073835.GA9568@techadventures.net>
 <44f74b58-aae0-a44c-3b98-7b1aac186f8e@redhat.com>
 <20180808075614.GB9568@techadventures.net>
 <7a64e67d-1df9-04ab-cc49-99a39aa90798@redhat.com>
 <20180808134233.GA10946@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180808134233.GA10946@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 17:56:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 17:56:02 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:42:33PM +0200, Oscar Salvador wrote:
> On Wed, Aug 08, 2018 at 10:08:41AM +0200, David Hildenbrand wrote:
> > Then it is maybe time to cleary distinguish both types of memory, as
> > they are fundamentally different when it comes to online/offline behavior.
> > 
> > Ordinary ram:
> >  add_memory ...
> >  online_pages ...
> >  offline_pages
> >  remove_memory
> > 
> > Device memory
> >  add_device_memory ...
> >  remove_device_memory
> > 
> > So adding/removing from the zone and stuff can be handled there.
> 
> Uhm, I have been thinking about this.
> Maybe we could do something like (completely untested):
> 
> 
> == memory_hotplug code ==
> 
> int add_device_memory(int nid, unsigned long start, unsigned long size,
>                                 struct vmem_altmap *altmap, bool mapping)
> {
>         int ret;
>         unsigned long start_pfn = PHYS_PFN(start);
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> 
>         mem_hotplug_begin();
>         if (mapping)
>                 ret = arch_add_memory(nid, start, size, altmap, false)
>         else
>                 ret = add_pages(nid, start_pfn, nr_pages, altmap, false):
> 
>         if (!ret) {
>                 pgdata_t *pgdata = NODE_DATA(nid);
>                 struct zone *zone = pgdata->node_zones[ZONE_DEVICE];
> 
>                 online_mem_sections(start_pfn, start_pfn + nr_pages);
>                 move_pfn_range_to_zone(zone, start_pfn, nr_pages, altmap);
>         }
>         mem_hotplug_done();
> 
>         return ret;
> }
> 
> int del_device_memory(int nid, unsigned long start, unsigned long size,
>                                 struct vmem_altmap *altmap, bool mapping)
> {
>         int ret;
>         unsigned long start_pfn = PHYS_PFN(start);
>         unsigned long nr_pages = size >> PAGE_SHIFT;
>         pgdata_t *pgdata = NODE_DATA(nid);
>         struct zone *zone = pgdata->node_zones[ZONE_DEVICE];
> 
>         mem_hotplug_begin();
> 
>         offline_mem_sections(start_pfn, start_pfn + nr_pages);
>         __shrink_pages(zone, start_pfn, start_pfn + nr_pages, nr_pages);
> 
>         if (mapping)
>                 ret = arch_remove_memory(nid, start, size, altmap)
>         else
>                 ret = __remove_pages(nid, start_pfn, nr_pages, altmap)
> 
>         mem_hotplug_done();
> 
>         return ret;
> }
> 
> ===
> 
> And then, HMM/devm code could use it.
> 
> For example:
> 
> hmm_devmem_pages_create():
> 
> ...
> ...
> if (devmem->pagemap.type == MEMORY_DEVICE_PUBLIC)
> 	linear_mapping = true;
> else
> 	linear_mapping = false;
> 
> ret = add_device_memory(nid, align_start, align_size, NULL, linear_mapping);
> if (ret)
> 	goto error_add_memory;
> ...
> ...
> 
> 
> hmm_devmem_release:
> 
> ...
> ...
> if (resource->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY)
> 	mapping = false;
> else
> 	mapping = true;
> 
> del_device_memory(nid, start_pfn << PAGE_SHIFT, npages << PAGE_SHIFT,
> 								NULL,
> 								mapping);
> ...
> ...
> 
> 
> In this way, we do not need to play tricks in HMM/devm code, we just need to
> call those functions when adding/removing memory.

Note that Dan did post patches that already go in that direction (unifying
code between devm and HMM). I think they are in Andrew queue, looks for

mm: Rework hmm to use devm_memremap_pages and other fixes

> 
> We would still have to figure out a way to go for the release_mem_region_adjustable() stuff though.

Yes.

Cheers,
Jérôme
