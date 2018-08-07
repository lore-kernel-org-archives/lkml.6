Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28311C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9533217B9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9533217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389906AbeHGReu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:34:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389271AbeHGRet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:34:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2FD240241D5;
        Tue,  7 Aug 2018 15:19:59 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 826DD2166BA2;
        Tue,  7 Aug 2018 15:19:58 +0000 (UTC)
Date:   Tue, 7 Aug 2018 11:19:57 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     osalvador@techadventures.net, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@oracle.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180807151957.GC3301@redhat.com>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 15:20:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 15:20:00 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 04:54:57PM +0200, David Hildenbrand wrote:
> On 07.08.2018 15:52, Jerome Glisse wrote:
> > On Tue, Aug 07, 2018 at 03:37:56PM +0200, osalvador@techadventures.net wrote:
> >> From: Oscar Salvador <osalvador@suse.de>
> > 
> > [...]
> > 
> >> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >> index 9bd629944c91..e33555651e46 100644
> >> --- a/mm/memory_hotplug.c
> >> +++ b/mm/memory_hotplug.c
> > 
> > [...]
> > 
> >>  /**
> >>   * __remove_pages() - remove sections of pages from a zone
> >> - * @zone: zone from which pages need to be removed
> >> + * @nid: node which pages belong to
> >>   * @phys_start_pfn: starting pageframe (must be aligned to start of a section)
> >>   * @nr_pages: number of pages to remove (must be multiple of section size)
> >>   * @altmap: alternative device page map or %NULL if default memmap is used
> >> @@ -548,7 +557,7 @@ static int __remove_section(struct zone *zone, struct mem_section *ms,
> >>   * sure that pages are marked reserved and zones are adjust properly by
> >>   * calling offline_pages().
> >>   */
> >> -int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> >> +int __remove_pages(int nid, unsigned long phys_start_pfn,
> >>  		 unsigned long nr_pages, struct vmem_altmap *altmap)
> >>  {
> >>  	unsigned long i;
> >> @@ -556,10 +565,9 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> >>  	int sections_to_remove, ret = 0;
> >>  
> >>  	/* In the ZONE_DEVICE case device driver owns the memory region */
> >> -	if (is_dev_zone(zone)) {
> >> -		if (altmap)
> >> -			map_offset = vmem_altmap_offset(altmap);
> >> -	} else {
> >> +	if (altmap)
> >> +		map_offset = vmem_altmap_offset(altmap);
> >> +	else {
> > 
> > This will break ZONE_DEVICE at least for HMM. While i think that
> > altmap -> ZONE_DEVICE (ie altmap imply ZONE_DEVICE) the reverse
> > is not true ie ZONE_DEVICE does not necessarily imply altmap. So
> > with the above changes you change the expected behavior. You do
> > need the zone to know if it is a ZONE_DEVICE. You could also lookup
> > one of the struct page but my understanding is that this is what
> > you want to avoid in the first place.
> 
> I wonder if we could instead forward from the callers whether we are
> dealing with ZONE_DEVICE memory (is_device ...), at least that seems
> feasible in hmm code. Not having looked at details yet.
> 

Yes i believe this is doable, this add one more argument, to me it
looked like passing down the zone was good idea, i think with the
struct zone you can even remove the altmap argument.

Is there a reason why you do not want to pass down the struct zone ?

Cheers,
Jérôme
