Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078D6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC92820859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfAIQJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:09:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:12599 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732027AbfAIQJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:09:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 08:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="116778211"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga003.jf.intel.com with ESMTP; 09 Jan 2019 08:09:11 -0800
Message-ID: <fa89d216da811e97428ad155770bcca5eddecc37.camel@linux.intel.com>
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as
 higher order
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Arun KS <arunks@codeaurora.org>
Cc:     arunks.linux@gmail.com, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        getarunks@gmail.com
Date:   Wed, 09 Jan 2019 08:09:11 -0800
In-Reply-To: <fdc656df7c54819f60d9a1682c84b14f@codeaurora.org>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
         <7c81c8bc741819e87e9a2a39a8b1b6d2f8d3423a.camel@linux.intel.com>
         <fdc656df7c54819f60d9a1682c84b14f@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 11:51 +0530, Arun KS wrote:
> On 2019-01-09 03:47, Alexander Duyck wrote:
> > On Fri, 2019-01-04 at 10:31 +0530, Arun KS wrote:
> > > When freeing pages are done with higher order, time spent on 
> > > coalescing
> > > pages by buddy allocator can be reduced.  With section size of 256MB, 
> > > hot
> > > add latency of a single section shows improvement from 50-60 ms to 
> > > less
> > > than 1 ms, hence improving the hot add latency by 60 times.  Modify
> > > external providers of online callback to align with the change.
> > > 
> > > Signed-off-by: Arun KS <arunks@codeaurora.org>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > 
> > Sorry, ended up encountering a couple more things that have me a bit
> > confused.
> > 
> > [...]
> > 
> > > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > > index 5301fef..211f3fe 100644
> > > --- a/drivers/hv/hv_balloon.c
> > > +++ b/drivers/hv/hv_balloon.c
> > > @@ -771,7 +771,7 @@ static void hv_mem_hot_add(unsigned long start, 
> > > unsigned long size,
> > >  	}
> > >  }
> > > 
> > > -static void hv_online_page(struct page *pg)
> > > +static int hv_online_page(struct page *pg, unsigned int order)
> > >  {
> > >  	struct hv_hotadd_state *has;
> > >  	unsigned long flags;
> > > @@ -783,10 +783,12 @@ static void hv_online_page(struct page *pg)
> > >  		if ((pfn < has->start_pfn) || (pfn >= has->end_pfn))
> > >  			continue;
> > > 
> > > -		hv_page_online_one(has, pg);
> > > +		hv_bring_pgs_online(has, pfn, (1UL << order));
> > >  		break;
> > >  	}
> > >  	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> > > +
> > > +	return 0;
> > >  }
> > > 
> > >  static int pfn_covered(unsigned long start_pfn, unsigned long 
> > > pfn_cnt)
> > 
> > So the question I have is why was a return value added to these
> > functions? They were previously void types and now they are int. What
> > is the return value expected other than 0?
> 
> Earlier with returning a void there was now way for an arch code to 
> denying onlining of this particular page. By using an int as return 
> type, we can implement this. In one of the boards I was using, there are 
> some pages which should not be onlined because they are used for other 
> purposes(like secure trust zone or hypervisor).

So where is the code using that? I don't see any functions in the
kernel that are returning anything other than 0. Maybe you should hold
off on changing the return type and make that a separate patch to be
enabled when you add the new functions that can return non-zero values.

That way if someone wants to backport this they are just getting the
bits needed to enable the improved hot-plug times without adding the
extra overhead for changing the return type.


