Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B5BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA9621990
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA9621990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbeHIRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:35:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731432AbeHIRfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:35:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DF59AEC6;
        Thu,  9 Aug 2018 15:09:52 +0000 (UTC)
Date:   Thu, 9 Aug 2018 17:09:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     osalvador@techadventures.net, akpm@linux-foundation.org,
        dan.j.williams@intel.com, pasha.tatashin@oracle.com,
        david@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180809150950.GB15611@dhcp22.suse.cz>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <20180807145900.GH10003@dhcp22.suse.cz>
 <20180807151810.GB3301@redhat.com>
 <20180808064758.GB27972@dhcp22.suse.cz>
 <20180808165814.GB3429@redhat.com>
 <20180809082415.GB24884@dhcp22.suse.cz>
 <20180809142709.GA3386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809142709.GA3386@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-08-18 10:27:09, Jerome Glisse wrote:
> On Thu, Aug 09, 2018 at 10:24:15AM +0200, Michal Hocko wrote:
> > On Wed 08-08-18 12:58:15, Jerome Glisse wrote:
> > > On Wed, Aug 08, 2018 at 08:47:58AM +0200, Michal Hocko wrote:
> > > > On Tue 07-08-18 11:18:10, Jerome Glisse wrote:
> > > > > On Tue, Aug 07, 2018 at 04:59:00PM +0200, Michal Hocko wrote:
> > > > > > On Tue 07-08-18 09:52:21, Jerome Glisse wrote:
> > > > > > > On Tue, Aug 07, 2018 at 03:37:56PM +0200, osalvador@techadventures.net wrote:
> > > > > > > > From: Oscar Salvador <osalvador@suse.de>
> > > > > > > 
> > > > > > > [...]
> > > > > > > 
> > > > > > > > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > > > > > > > index 9bd629944c91..e33555651e46 100644
> > > > > > > > --- a/mm/memory_hotplug.c
> > > > > > > > +++ b/mm/memory_hotplug.c
> > > > > > > 
> > > > > > > [...]
> > > > > > > 
> > > > > > > >  /**
> > > > > > > >   * __remove_pages() - remove sections of pages from a zone
> > > > > > > > - * @zone: zone from which pages need to be removed
> > > > > > > > + * @nid: node which pages belong to
> > > > > > > >   * @phys_start_pfn: starting pageframe (must be aligned to start of a section)
> > > > > > > >   * @nr_pages: number of pages to remove (must be multiple of section size)
> > > > > > > >   * @altmap: alternative device page map or %NULL if default memmap is used
> > > > > > > > @@ -548,7 +557,7 @@ static int __remove_section(struct zone *zone, struct mem_section *ms,
> > > > > > > >   * sure that pages are marked reserved and zones are adjust properly by
> > > > > > > >   * calling offline_pages().
> > > > > > > >   */
> > > > > > > > -int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> > > > > > > > +int __remove_pages(int nid, unsigned long phys_start_pfn,
> > > > > > > >  		 unsigned long nr_pages, struct vmem_altmap *altmap)
> > > > > > > >  {
> > > > > > > >  	unsigned long i;
> > > > > > > > @@ -556,10 +565,9 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> > > > > > > >  	int sections_to_remove, ret = 0;
> > > > > > > >  
> > > > > > > >  	/* In the ZONE_DEVICE case device driver owns the memory region */
> > > > > > > > -	if (is_dev_zone(zone)) {
> > > > > > > > -		if (altmap)
> > > > > > > > -			map_offset = vmem_altmap_offset(altmap);
> > > > > > > > -	} else {
> > > > > > > > +	if (altmap)
> > > > > > > > +		map_offset = vmem_altmap_offset(altmap);
> > > > > > > > +	else {
> > > > > > > 
> > > > > > > This will break ZONE_DEVICE at least for HMM. While i think that
> > > > > > > altmap -> ZONE_DEVICE (ie altmap imply ZONE_DEVICE) the reverse
> > > > > > > is not true ie ZONE_DEVICE does not necessarily imply altmap. So
> > > > > > > with the above changes you change the expected behavior.
> > > > > > 
> > > > > > Could you be more specific what is the expected behavior here?
> > > > > > Is this about calling release_mem_region_adjustable? Why does is it not
> > > > > > suitable for zone device ranges?
> > > > > 
> > > > > Correct, you should not call release_mem_region_adjustable() the device
> > > > > region is not part of regular iomem resource as it might not necessarily
> > > > > be enumerated through known ways to the kernel (ie only the device driver
> > > > > can discover the region and core kernel do not know about it).
> > > > 
> > > > If there is no region registered with the range then the call should be
> > > > mere nop, no? So why do we have to special case?
> > > 
> > > IIRC this is because you can not release the resource ie the resource
> > > is still own by the device driver even if you hotremove the memory.
> > > The device driver might still be using the resource without struct page.
> > 
> > But then it seems to be a property of a device rather than zone_device,
> > no? If there are devices which want to preserve the resource then they
> > should tell that. Doing that unconditionally for all zone_device users
> > seems just wrong.
> 
> I am fine with changing that, i did not do that and at the time i did
> not have any feeling on that matter.

I would really prefer to be explicit about these requirements rather
than having subtle side effects quite deep in the memory hotplug code
and checks for zone device sprinkled at places for special handling.
-- 
Michal Hocko
SUSE Labs
