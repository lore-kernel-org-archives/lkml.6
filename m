Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4641EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF3521738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XXPGp+/O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QF8+zXg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfAJEjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:39:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfAJEjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:39:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB5CD6089D; Thu, 10 Jan 2019 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547095181;
        bh=13gljG04Gs24G+6XztrK3OG1JYxHjRdrkLNLK2e8w9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XXPGp+/OtEKJb8EcZej7D21xTY47/gxZOo73tR5MIp0/GIjCZ3JZ7bFVmTOXFMwnc
         y1K01nSwFVReG9wxiEbPV7ehbjAwsiO9lNS08dqDi2111KsKrxLt55Z3u/d8sy0a1e
         Ou0127Gjm7PZqjfzbx85Ai5UgdhckfGXcCaBbTUA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7F1C560247;
        Thu, 10 Jan 2019 04:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547095180;
        bh=13gljG04Gs24G+6XztrK3OG1JYxHjRdrkLNLK2e8w9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QF8+zXg6VTQ2pNIBrsgyGXoN5T4xwMXyM55gN1lATOAoffSD+uYffvY+H4CQHwYJk
         GEzKmvwz1oflv9ANOfGIsfQ1HL2j01sZcbT7G6eBDMIU53v9uMShqNuZ9WEKlTD3Ug
         ZveV7t0sB0H6tcWWQiTpsckLDhJ6ymSspwweqUrY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jan 2019 10:09:40 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     arunks.linux@gmail.com, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
In-Reply-To: <fa89d216da811e97428ad155770bcca5eddecc37.camel@linux.intel.com>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
 <7c81c8bc741819e87e9a2a39a8b1b6d2f8d3423a.camel@linux.intel.com>
 <fdc656df7c54819f60d9a1682c84b14f@codeaurora.org>
 <fa89d216da811e97428ad155770bcca5eddecc37.camel@linux.intel.com>
Message-ID: <210ea658c3bdd074febbe90b19e88615@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-09 21:39, Alexander Duyck wrote:
> On Wed, 2019-01-09 at 11:51 +0530, Arun KS wrote:
>> On 2019-01-09 03:47, Alexander Duyck wrote:
>> > On Fri, 2019-01-04 at 10:31 +0530, Arun KS wrote:
>> > > When freeing pages are done with higher order, time spent on
>> > > coalescing
>> > > pages by buddy allocator can be reduced.  With section size of 256MB,
>> > > hot
>> > > add latency of a single section shows improvement from 50-60 ms to
>> > > less
>> > > than 1 ms, hence improving the hot add latency by 60 times.  Modify
>> > > external providers of online callback to align with the change.
>> > >
>> > > Signed-off-by: Arun KS <arunks@codeaurora.org>
>> > > Acked-by: Michal Hocko <mhocko@suse.com>
>> > > Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> >
>> > Sorry, ended up encountering a couple more things that have me a bit
>> > confused.
>> >
>> > [...]
>> >
>> > > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> > > index 5301fef..211f3fe 100644
>> > > --- a/drivers/hv/hv_balloon.c
>> > > +++ b/drivers/hv/hv_balloon.c
>> > > @@ -771,7 +771,7 @@ static void hv_mem_hot_add(unsigned long start,
>> > > unsigned long size,
>> > >  	}
>> > >  }
>> > >
>> > > -static void hv_online_page(struct page *pg)
>> > > +static int hv_online_page(struct page *pg, unsigned int order)
>> > >  {
>> > >  	struct hv_hotadd_state *has;
>> > >  	unsigned long flags;
>> > > @@ -783,10 +783,12 @@ static void hv_online_page(struct page *pg)
>> > >  		if ((pfn < has->start_pfn) || (pfn >= has->end_pfn))
>> > >  			continue;
>> > >
>> > > -		hv_page_online_one(has, pg);
>> > > +		hv_bring_pgs_online(has, pfn, (1UL << order));
>> > >  		break;
>> > >  	}
>> > >  	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>> > > +
>> > > +	return 0;
>> > >  }
>> > >
>> > >  static int pfn_covered(unsigned long start_pfn, unsigned long
>> > > pfn_cnt)
>> >
>> > So the question I have is why was a return value added to these
>> > functions? They were previously void types and now they are int. What
>> > is the return value expected other than 0?
>> 
>> Earlier with returning a void there was now way for an arch code to
>> denying onlining of this particular page. By using an int as return
>> type, we can implement this. In one of the boards I was using, there 
>> are
>> some pages which should not be onlined because they are used for other
>> purposes(like secure trust zone or hypervisor).
> 
> So where is the code using that? I don't see any functions in the
> kernel that are returning anything other than 0. Maybe you should hold
> off on changing the return type and make that a separate patch to be
> enabled when you add the new functions that can return non-zero values.
> 
> That way if someone wants to backport this they are just getting the
> bits needed to enable the improved hot-plug times without adding the
> extra overhead for changing the return type.

The implementation was in our downstream code. I thought this might be 
useful for someone else in similar situations.
Considering the above mentioned reasons, I ll remove changing the return 
type.

Regards,
Arun
