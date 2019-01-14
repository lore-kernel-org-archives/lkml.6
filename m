Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5B7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E568220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfANNR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:17:58 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:33129 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfANNR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:17:57 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 51C423F27; Mon, 14 Jan 2019 14:17:56 +0100 (CET)
Date:   Mon, 14 Jan 2019 14:17:56 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Oscar Salvador <osalvador@suse.com>, linux-mm@kvack.org,
        david@redhat.com, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, arunks@codeaurora.org, bhe@redhat.com,
        dan.j.williams@intel.com, Pavel.Tatashin@microsoft.com,
        Jonathan.Cameron@huawei.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] mm, memory_hotplug: provide a more generic
 restrictions for memory hotplug
Message-ID: <20190114131742.neivbac3lmsszkzc@d104.suse.de>
References: <20181116101222.16581-1-osalvador@suse.com>
 <20181116101222.16581-3-osalvador@suse.com>
 <20181123130043.GM8625@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123130043.GM8625@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 02:00:43PM +0100, Michal Hocko wrote:
> One note here as well. In the retrospect the API I have come up
> with here is quite hackish. Considering the recent discussion about
> special needs ZONE_DEVICE has for both initialization and struct page
> allocations with Alexander Duyck I believe we wanted a more abstracted
> API with allocator and constructor callbacks. This would allow different
> usecases to fine tune their needs without specialcasing deep in the core
> hotplug code paths.

Hi all,

so, now that vacation is gone, I wanted to come back to this.
I kind of get what you mean with this more abstacted API, but I am not really
sure how we could benefit from it (or maybe I am just short-sighted here).

Right now, struct mhp_restrictions would look like:

struct mhp_restrictions {
        unsigned long flags;
        struct vmem_altmap *altmap;
};

where flags tell us whether we want a memblock device and whether we should
allocate the memmap array from the hot-added range.
And altmap is the altmap we would use for it.

Indeed, we could add two callbacks, set_up() and construct() (random naming).

When talking about memmap-from-hot_added-range, set_up() could be called
to construct the altmap, i.e:

<--
struct vmem_altmap __memblk_altmap;

__memblk_altmap.base_pfn = phys_start_pfn;
__memblk_altmap.alloc = 0;
__memblk_altmap.align = 0;
__memblk_altmap.free = nr_pages;
-->

and construct() would be called at the very end of __add_pages(), which
basically would be mark_vmemmap_pages().

Now, looking at devm_memremap_pages(ZONE_DEVICE stuff), it does:

hotplug_lock();
 arch_add_memory
  add_pages
 move_pfn_range_to_zone
hotplug_lock();
memmap_init_zone_device

For the ZONE_DEVICE case, move_pfn_range_to_zone() only initializes the pages
containing the memory mapping, while all the remaining pages all initialized later on
in memmap_init_zone_device().
Besides initializing pages, memmap_init_zone_device() also sets page->pgmap field.
So you could say that memmap_init_zone_device would be the construct part.

Anyway, I am currently working on the patch3 of this series to improve it and make it less
complex, but it would be great to sort out this API thing.

Maybe Alexander or you, can provide some suggestions/ideas here.

Thanks

Oscar Salvador
-- 
Oscar Salvador
SUSE L3
