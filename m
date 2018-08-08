Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17CBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7417E21A33
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7417E21A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeHHTSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:18:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727062AbeHHTSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:18:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D749C8315E;
        Wed,  8 Aug 2018 16:58:19 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5112D1017D4A;
        Wed,  8 Aug 2018 16:58:16 +0000 (UTC)
Date:   Wed, 8 Aug 2018 12:58:15 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     osalvador@techadventures.net, akpm@linux-foundation.org,
        dan.j.williams@intel.com, pasha.tatashin@oracle.com,
        david@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808165814.GB3429@redhat.com>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <20180807145900.GH10003@dhcp22.suse.cz>
 <20180807151810.GB3301@redhat.com>
 <20180808064758.GB27972@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180808064758.GB27972@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 08 Aug 2018 16:58:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 08 Aug 2018 16:58:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 08:47:58AM +0200, Michal Hocko wrote:
> On Tue 07-08-18 11:18:10, Jerome Glisse wrote:
> > On Tue, Aug 07, 2018 at 04:59:00PM +0200, Michal Hocko wrote:
> > > On Tue 07-08-18 09:52:21, Jerome Glisse wrote:
> > > > On Tue, Aug 07, 2018 at 03:37:56PM +0200, osalvador@techadventures.net wrote:
> > > > > From: Oscar Salvador <osalvador@suse.de>
> > > > 
> > > > [...]
> > > > 
> > > > > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > > > > index 9bd629944c91..e33555651e46 100644
> > > > > --- a/mm/memory_hotplug.c
> > > > > +++ b/mm/memory_hotplug.c
> > > > 
> > > > [...]
> > > > 
> > > > >  /**
> > > > >   * __remove_pages() - remove sections of pages from a zone
> > > > > - * @zone: zone from which pages need to be removed
> > > > > + * @nid: node which pages belong to
> > > > >   * @phys_start_pfn: starting pageframe (must be aligned to start of a section)
> > > > >   * @nr_pages: number of pages to remove (must be multiple of section size)
> > > > >   * @altmap: alternative device page map or %NULL if default memmap is used
> > > > > @@ -548,7 +557,7 @@ static int __remove_section(struct zone *zone, struct mem_section *ms,
> > > > >   * sure that pages are marked reserved and zones are adjust properly by
> > > > >   * calling offline_pages().
> > > > >   */
> > > > > -int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> > > > > +int __remove_pages(int nid, unsigned long phys_start_pfn,
> > > > >  		 unsigned long nr_pages, struct vmem_altmap *altmap)
> > > > >  {
> > > > >  	unsigned long i;
> > > > > @@ -556,10 +565,9 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> > > > >  	int sections_to_remove, ret = 0;
> > > > >  
> > > > >  	/* In the ZONE_DEVICE case device driver owns the memory region */
> > > > > -	if (is_dev_zone(zone)) {
> > > > > -		if (altmap)
> > > > > -			map_offset = vmem_altmap_offset(altmap);
> > > > > -	} else {
> > > > > +	if (altmap)
> > > > > +		map_offset = vmem_altmap_offset(altmap);
> > > > > +	else {
> > > > 
> > > > This will break ZONE_DEVICE at least for HMM. While i think that
> > > > altmap -> ZONE_DEVICE (ie altmap imply ZONE_DEVICE) the reverse
> > > > is not true ie ZONE_DEVICE does not necessarily imply altmap. So
> > > > with the above changes you change the expected behavior.
> > > 
> > > Could you be more specific what is the expected behavior here?
> > > Is this about calling release_mem_region_adjustable? Why does is it not
> > > suitable for zone device ranges?
> > 
> > Correct, you should not call release_mem_region_adjustable() the device
> > region is not part of regular iomem resource as it might not necessarily
> > be enumerated through known ways to the kernel (ie only the device driver
> > can discover the region and core kernel do not know about it).
> 
> If there is no region registered with the range then the call should be
> mere nop, no? So why do we have to special case?

IIRC this is because you can not release the resource ie the resource
is still own by the device driver even if you hotremove the memory.
The device driver might still be using the resource without struct page.

> 
> [...]
> 
> > Also in the case they do exist in iomem resource it is as PCIE BAR so
> > as IORESOURCE_IO (iirc) and thus release_mem_region_adjustable() would
> > return -EINVAL. Thought nothing bad happens because of that, only a
> > warning message that might confuse the user.
> 
> I am not sure I have understood this correctly. Are you referring to the
> current state when we would call release_mem_region_adjustable
> unconditionally or the case that the resource would be added also for
> zone device ranges?
> 
> If the former then I do not see any reason why we couldn't simply
> refactor the code to expect a failure and drop the warning in that path.

Referring to newer case ie calling release_mem_region_adjustable() for
ZONE_DEVICE too. It seems i got my recollection wrong in the sense that
the resource is properly register as MEM but still we do not want to
release it because the device driver might still be using the resource
without struct page. The lifetime of the resource as memory with struct
page and the lifetime of the resource as something use by the device
driver are not tie together. The latter can outlive the former.

So when we hotremove ZONE_DEVICE we do not want to release the resource
yet just to be on safe side and avoid some other driver/kernel component
to decide to use that resource.

Cheers,
Jérôme
