Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ABDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76CA2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76CA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeGSP7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:59:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730521AbeGSP7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:59:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1ECCAFC8;
        Thu, 19 Jul 2018 15:15:57 +0000 (UTC)
Date:   Thu, 19 Jul 2018 17:15:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/5] mm/page_alloc: Optimize free_area_init_core
Message-ID: <20180719151555.GH7193@dhcp22.suse.cz>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-4-osalvador@techadventures.net>
 <20180719134417.GC7193@dhcp22.suse.cz>
 <20180719140327.GB10988@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719140327.GB10988@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 16:03:27, Oscar Salvador wrote:
> On Thu, Jul 19, 2018 at 03:44:17PM +0200, Michal Hocko wrote:
> > On Thu 19-07-18 15:27:38, osalvador@techadventures.net wrote:
> > > From: Oscar Salvador <osalvador@suse.de>
> > > 
> > > In free_area_init_core we calculate the amount of managed pages
> > > we are left with, by substracting the memmap pages and the pages
> > > reserved for dma.
> > > With the values left, we also account the total of kernel pages and
> > > the total of pages.
> > > 
> > > Since memmap pages are calculated from zone->spanned_pages,
> > > let us only do these calculcations whenever zone->spanned_pages is greather
> > > than 0.
> > 
> > But why do we care? How do we test this? In other words, why is this
> > worth merging?
>  
> Uhm, unless the values are going to be updated, why do we want to go through all
> comparasions/checks?
> I thought it was a nice thing to have the chance to skip that block unless we are going to
> update the counters.
> 
> Again, if you think this only adds complexity and no good, I can drop it.

Your changelog doesn't really explain the motivation. Does the change
help performance? Is this a pure cleanup?

The function is certainly not an example of beauty. It is more an
example of changes done on top of older ones without much thinking. But
I do not see your change would make it so much better. I would consider
it a much nicer cleanup if it was split into logical units each doing
one specific thing.

Btw. are you sure this change is correct? E.g.
		/*
		 * Set an approximate value for lowmem here, it will be adjusted
		 * when the bootmem allocator frees pages into the buddy system.
		 * And all highmem pages will be managed by the buddy system.
		 */
		zone->managed_pages = is_highmem_idx(j) ? realsize : freesize;

expects freesize to be calculated properly and just from quick reading
the code I do not see why skipping other adjustments is ok for size > 0.
Maybe this is OK, I dunno and my brain is already heading few days off
but a real cleanup wouldn't even make me think what the heck is going on
here.

-- 
Michal Hocko
SUSE Labs
