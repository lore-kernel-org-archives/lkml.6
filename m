Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB7C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571B72082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571B72082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJ3PVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:21:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbeJ3PVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:21:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97A38ABB1;
        Tue, 30 Oct 2018 06:29:19 +0000 (UTC)
Date:   Tue, 30 Oct 2018 07:29:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        yi.z.zhang@linux.intel.com, osalvador@techadventures.net
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20181030062915.GT32673@dhcp22.suse.cz>
References: <20181017075257.GF18839@dhcp22.suse.cz>
 <971729e6-bcfe-a386-361b-d662951e69a7@linux.intel.com>
 <20181029141210.GJ32673@dhcp22.suse.cz>
 <84f09883c16608ddd2ba88103f43ec6a1c649e97.camel@linux.intel.com>
 <20181029163528.GL32673@dhcp22.suse.cz>
 <18dfc5a0db11650ff31433311da32c95e19944d9.camel@linux.intel.com>
 <20181029172415.GM32673@dhcp22.suse.cz>
 <8e7a4311a240b241822945c0bb4095c9ffe5a14d.camel@linux.intel.com>
 <20181029181827.GO32673@dhcp22.suse.cz>
 <3281f3044fa231bbc1b02d5c5efca3502a0d05a8.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3281f3044fa231bbc1b02d5c5efca3502a0d05a8.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-10-18 12:59:11, Alexander Duyck wrote:
> On Mon, 2018-10-29 at 19:18 +0100, Michal Hocko wrote:
[...]

I will try to get to your other points later.

> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 89d2a2ab3fe6..048e4cc72fdf 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5474,8 +5474,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >  	 * Honor reservation requested by the driver for this ZONE_DEVICE
> >  	 * memory
> >  	 */
> > -	if (altmap && start_pfn == altmap->base_pfn)
> > -		start_pfn += altmap->reserve;
> > +	if (pgmap && pgmap->get_memmap)
> > +		start_pfn = pgmap->get_memmap(pgmap, start_pfn);
> >  
> >  	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> >  		/*
> > 
> > [...]
> 
> The only reason why I hadn't bothered with these bits is that I was
> actually trying to leave this generic since I thought I had seen other
> discussions about hotplug scenerios where memory may want to change
> where the vmmemmap is initialized other than just the case of
> ZONE_DEVICE pages. So I was thinking at some point we may see altmap
> without the pgmap.

I wanted to abuse altmap to allocate struct pages from the physical
range to be added. In that case I would abstract the
allocation/initialization part of pgmap into a more abstract type.
Something trivially to be done without affecting end users of the
hotplug API.

[...]
> > Anyway we have gone into details while the primary problem here was that
> > the hotplug lock doesn't scale AFAIR. And my question was why cannot we
> > pull move_pfn_range_to_zone and what has to be done to achieve that.
> > That is a fundamental thing to address first. Then you can microptimize
> > on top.
> 
> Yes, the hotplug lock was part of the original issue. However that
> starts to drift into the area I believe Oscar was working on as a part
> of his patch set in encapsulating the move_pfn_range_to_zone and other
> calls that were contained in the hotplug lock into their own functions.

Well, I would really love to keep the external API as simple as
possible. That means that we need arch_add_memory/add_pages and 
move_pfn_range_to_zone to associate pages with a zone. The hotplug lock
should be preferably hidden from callers of those two and ideally it
shouldn't be a global lock. We should be good with a range lock.
 
> The patches Andrew pushed addressed the immediate issue so that now
> systems with nvdimm/DAX memory can at least initialize quick enough
> that systemd doesn't refuse to mount the root file system due to a
> timeout.

This is about the first time you actually mention that. I have re-read
the cover letter and all changelogs of patches in this serious. Unless I
have missed something there is nothing about real users hitting issues
out there. nvdimm is still considered a toy because there is no real HW
users can play with.

And hence my complains about half baked solutions rushed in just to fix
a performance regression. I can certainly understand that a pressing
problem might justify to rush things a bit but this should be always
carefuly justified.

> The next patch set I have refactors things to reduce code and
> allow us to reuse some of the hotplug code for the deferred page init, 
> https://lore.kernel.org/lkml/20181017235043.17213.92459.stgit@localhost.localdomain/
> . After that I was planning to work on dealing with the PageReserved
> flag and trying to get that sorted out.
> 
> I was hoping to wait until after Dan's HMM patches and Oscar's changes
> had been sorted before I get into any further refactor of this specific
> code.

Yes there is quite a lot going on here. I would really appreciate if we
all sit and actually try to come up with something robust rather than
hack here and there. I haven't yet seen your follow up series completely
so maybe you are indeed heading the correct direction.

-- 
Michal Hocko
SUSE Labs
