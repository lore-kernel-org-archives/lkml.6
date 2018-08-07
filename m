Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C843DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF132174C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF132174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389803AbeHGRNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:13:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:60066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389481AbeHGRNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:13:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AEEBAE04;
        Tue,  7 Aug 2018 14:59:03 +0000 (UTC)
Date:   Tue, 7 Aug 2018 16:59:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     osalvador@techadventures.net, akpm@linux-foundation.org,
        dan.j.williams@intel.com, pasha.tatashin@oracle.com,
        david@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180807145900.GH10003@dhcp22.suse.cz>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807135221.GA3301@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-08-18 09:52:21, Jerome Glisse wrote:
> On Tue, Aug 07, 2018 at 03:37:56PM +0200, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> 
> [...]
> 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 9bd629944c91..e33555651e46 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> 
> [...]
> 
> >  /**
> >   * __remove_pages() - remove sections of pages from a zone
> > - * @zone: zone from which pages need to be removed
> > + * @nid: node which pages belong to
> >   * @phys_start_pfn: starting pageframe (must be aligned to start of a section)
> >   * @nr_pages: number of pages to remove (must be multiple of section size)
> >   * @altmap: alternative device page map or %NULL if default memmap is used
> > @@ -548,7 +557,7 @@ static int __remove_section(struct zone *zone, struct mem_section *ms,
> >   * sure that pages are marked reserved and zones are adjust properly by
> >   * calling offline_pages().
> >   */
> > -int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> > +int __remove_pages(int nid, unsigned long phys_start_pfn,
> >  		 unsigned long nr_pages, struct vmem_altmap *altmap)
> >  {
> >  	unsigned long i;
> > @@ -556,10 +565,9 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> >  	int sections_to_remove, ret = 0;
> >  
> >  	/* In the ZONE_DEVICE case device driver owns the memory region */
> > -	if (is_dev_zone(zone)) {
> > -		if (altmap)
> > -			map_offset = vmem_altmap_offset(altmap);
> > -	} else {
> > +	if (altmap)
> > +		map_offset = vmem_altmap_offset(altmap);
> > +	else {
> 
> This will break ZONE_DEVICE at least for HMM. While i think that
> altmap -> ZONE_DEVICE (ie altmap imply ZONE_DEVICE) the reverse
> is not true ie ZONE_DEVICE does not necessarily imply altmap. So
> with the above changes you change the expected behavior.

Could you be more specific what is the expected behavior here?
Is this about calling release_mem_region_adjustable? Why does is it not
suitable for zone device ranges?
-- 
Michal Hocko
SUSE Labs
