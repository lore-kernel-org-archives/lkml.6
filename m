Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3860C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D1B214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qmw8yr1G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kXpB/Gds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfAIGVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:21:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfAIGVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:21:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 05604608A5; Wed,  9 Jan 2019 06:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547014862;
        bh=miqONhq/Mg6eo4l1CAoydxj1rmG3UAn+C7WxuNPSFqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qmw8yr1GfhVdjLLAwXT9kF4pqh4BAWpnou8ePJzDYM04E2pa/ArzzW2JmHhpR03/X
         0wXCTt4mt0H6NL9cWvXULP6ROd+DVfnQpofWDFXC4s/oZF+EtzNJpJvzYdjEUss7HW
         3iDCf52YTGitK5cnFV1nzPbiDACXkmp0s0sIfVQs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 98D6760265;
        Wed,  9 Jan 2019 06:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547014860;
        bh=miqONhq/Mg6eo4l1CAoydxj1rmG3UAn+C7WxuNPSFqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kXpB/GdsIngirTjM3cIF7ooA6ctYe2tNsSg1ohjhZmEWhHJQCBubCC5mX03SPGw19
         wj0eIH2XcZ00NalW+pR162NIWHfkPiI2QsamJcRJxHxJjbSAljpSkYcvOQkDJ/xcGz
         V3xa5ihFLllFT5bqSOBjSQ7yPS5jxYnuIDPrFmaU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Jan 2019 11:51:00 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     arunks.linux@gmail.com, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
In-Reply-To: <7c81c8bc741819e87e9a2a39a8b1b6d2f8d3423a.camel@linux.intel.com>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
 <7c81c8bc741819e87e9a2a39a8b1b6d2f8d3423a.camel@linux.intel.com>
Message-ID: <fdc656df7c54819f60d9a1682c84b14f@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-09 03:47, Alexander Duyck wrote:
> On Fri, 2019-01-04 at 10:31 +0530, Arun KS wrote:
>> When freeing pages are done with higher order, time spent on 
>> coalescing
>> pages by buddy allocator can be reduced.  With section size of 256MB, 
>> hot
>> add latency of a single section shows improvement from 50-60 ms to 
>> less
>> than 1 ms, hence improving the hot add latency by 60 times.  Modify
>> external providers of online callback to align with the change.
>> 
>> Signed-off-by: Arun KS <arunks@codeaurora.org>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> Sorry, ended up encountering a couple more things that have me a bit
> confused.
> 
> [...]
> 
>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> index 5301fef..211f3fe 100644
>> --- a/drivers/hv/hv_balloon.c
>> +++ b/drivers/hv/hv_balloon.c
>> @@ -771,7 +771,7 @@ static void hv_mem_hot_add(unsigned long start, 
>> unsigned long size,
>>  	}
>>  }
>> 
>> -static void hv_online_page(struct page *pg)
>> +static int hv_online_page(struct page *pg, unsigned int order)
>>  {
>>  	struct hv_hotadd_state *has;
>>  	unsigned long flags;
>> @@ -783,10 +783,12 @@ static void hv_online_page(struct page *pg)
>>  		if ((pfn < has->start_pfn) || (pfn >= has->end_pfn))
>>  			continue;
>> 
>> -		hv_page_online_one(has, pg);
>> +		hv_bring_pgs_online(has, pfn, (1UL << order));
>>  		break;
>>  	}
>>  	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>> +
>> +	return 0;
>>  }
>> 
>>  static int pfn_covered(unsigned long start_pfn, unsigned long 
>> pfn_cnt)
> 
> So the question I have is why was a return value added to these
> functions? They were previously void types and now they are int. What
> is the return value expected other than 0?

Earlier with returning a void there was now way for an arch code to 
denying onlining of this particular page. By using an int as return 
type, we can implement this. In one of the boards I was using, there are 
some pages which should not be onlined because they are used for other 
purposes(like secure trust zone or hypervisor).

> 
>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>> index ceb5048..95f888f 100644
>> --- a/drivers/xen/balloon.c
>> +++ b/drivers/xen/balloon.c
>> @@ -345,8 +345,8 @@ static enum bp_state 
>> reserve_additional_memory(void)
>> 
>>  	/*
>>  	 * add_memory_resource() will call online_pages() which in its turn
>> -	 * will call xen_online_page() callback causing deadlock if we don't
>> -	 * release balloon_mutex here. Unlocking here is safe because the
>> +	 * will call xen_bring_pgs_online() callback causing deadlock if we
>> +	 * don't release balloon_mutex here. Unlocking here is safe because 
>> the
>>  	 * callers drop the mutex before trying again.
>>  	 */
>>  	mutex_unlock(&balloon_mutex);
>> @@ -369,15 +369,22 @@ static enum bp_state 
>> reserve_additional_memory(void)
>>  	return BP_ECANCELED;
>>  }
>> 
>> -static void xen_online_page(struct page *page)
>> +static int xen_bring_pgs_online(struct page *pg, unsigned int order)
> 
> Why did we rename this function? I see it was added as a new function
> in v3, however in v4 we ended up replacing it completely. So why not
> just keep the same name and make it easier for us to identify that the
> is the Xen version of the XXX_online_pages callback?

Point taken. Will send a patch.

> 
> [...]
> 
>> +static int online_pages_blocks(unsigned long start, unsigned long 
>> nr_pages)
>> +{
>> +	unsigned long end = start + nr_pages;
>> +	int order, ret, onlined_pages = 0;
>> +
>> +	while (start < end) {
>> +		order = min(MAX_ORDER - 1,
>> +			get_order(PFN_PHYS(end) - PFN_PHYS(start)));
>> +
>> +		ret = (*online_page_callback)(pfn_to_page(start), order);
>> +		if (!ret)
>> +			onlined_pages += (1UL << order);
>> +		else if (ret > 0)
>> +			onlined_pages += ret;
>> +
> 
> So if the ret > 0 it is supposed to represent how many pages were
> onlined within a given block? What if the ret was negative? Really I am
> not a fan of adding a return value to the online functions unless we
> specifically document what the expected return values are supposed to
> be. If we don't have any return values other than 0 there isn't much
> point in having one anyway.

I ll document this.

Regards,
Arun

