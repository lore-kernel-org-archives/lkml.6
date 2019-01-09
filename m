Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78636C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4745C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X8c1lStH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NJ+Dbzs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfAIKmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:42:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfAIKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:42:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91916608CB; Wed,  9 Jan 2019 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547030569;
        bh=4ROxClo7OpeZ05cXtSSbd1BAyvMDmM/TSjIBDv7XHh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X8c1lStH+fNjWxjlARio7kqw9T5k9XCc5/epo4OhaAwD4izdbhwLgpwczuXrSzT9R
         Hh0xenKA2/XujBnSjchvfb7yRF+7b8T5Q+tffTUgIPbSDDu9YBy4ebwiW5oelL352c
         UMYInsF3iRQm8BiyMJXnID5O4lbDnsmyrzFgxDjc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DB0F66050D;
        Wed,  9 Jan 2019 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547030568;
        bh=4ROxClo7OpeZ05cXtSSbd1BAyvMDmM/TSjIBDv7XHh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NJ+Dbzs7FK16MRjwbLc+IsUnVuq65DxSpCPsfgZbx7jRf1EaPQcpcHM4j7b8x7zmy
         /tBS5BxdZ7YylUUOoFY/hy1V+VLSDmrMUZ+Cj/eHetWHd1FHZA6ch/P1MJQ8aqua5C
         BINTrm3NXYMyZz12DB4sDQvurpZI09osjEfQcEq0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Jan 2019 16:12:48 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
In-Reply-To: <20190109084031.GN31793@dhcp22.suse.cz>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
 <fb6465c99b3ada2c6af587a7eb00016d96d56f77.camel@linux.intel.com>
 <20190108181352.GI31793@dhcp22.suse.cz>
 <bfb543b6e343c21c3e263a110f234e08@codeaurora.org>
 <20190109073718.GM31793@dhcp22.suse.cz>
 <a053bd9b93e71baae042cdfc3432f945@codeaurora.org>
 <20190109084031.GN31793@dhcp22.suse.cz>
Message-ID: <e005e71b125b9b8ddee668d1df9ad5ec@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-09 14:10, Michal Hocko wrote:
> On Wed 09-01-19 13:58:50, Arun KS wrote:
>> On 2019-01-09 13:07, Michal Hocko wrote:
>> > On Wed 09-01-19 11:28:52, Arun KS wrote:
>> > > On 2019-01-08 23:43, Michal Hocko wrote:
>> > > > On Tue 08-01-19 09:56:09, Alexander Duyck wrote:
>> > > > > On Fri, 2019-01-04 at 10:31 +0530, Arun KS wrote:
>> > > > [...]
>> > > > > >  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
>> > > > > >  			void *arg)
>> > > > > >  {
>> > > > > > -	unsigned long i;
>> > > > > >  	unsigned long onlined_pages = *(unsigned long *)arg;
>> > > > > > -	struct page *page;
>> > > > > >
>> > > > > >  	if (PageReserved(pfn_to_page(start_pfn)))
>> > > > > > -		for (i = 0; i < nr_pages; i++) {
>> > > > > > -			page = pfn_to_page(start_pfn + i);
>> > > > > > -			(*online_page_callback)(page);
>> > > > > > -			onlined_pages++;
>> > > > > > -		}
>> > > > > > +		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
>> > > > >
>> > > > > Shouldn't this be a "+=" instead of an "="? It seems like you are
>> > > > > going
>> > > > > to lose your count otherwise.
>> > > >
>> > > > You are right of course. I should have noticed during the review.
>> > > > Thanks!
>> > >
>> > > I think we don't need to. The caller function is setting
>> > > onlined_pages = 0
>> > > before calling online_pages_range().
>> > > And there are no other reference to online_pages_range other than from
>> > > online_pages().
>> >
>> > Are you missing that we accumulate onlined_pages via
>> > 	*(unsigned long *)arg = onlined_pages;
>> > in online_pages_range?
>> 
>> In my testing I didn't find any problem. To match the code being 
>> replaced
>> and to avoid any corner cases, it is better to use +=
>> Will update the patch.
> 
> Have you checked that the number of present pages both in the zone and
> the node is correct because I fail to see how that would be possible.

Yes they are showing correct values.

Previous value of cat /proc/zoneinfo,

Node 0, zone   Normal
   pages free     65492
         min      300
         low      375
         high     450
         spanned  65536
         present  65536
         managed  65536

Value after hotadd,

Node 0, zone   Normal
   pages free     129970
         min      518
         low      649
         high     780
         spanned  983040
         present  131072
         managed  131072

I added prints in online_pages_range function.
It will be called once per online of a section and the arg value is 
always set to 0 while entering online_pages_range.

/sys/devices/system/memory # echo online > memory16/state
[   52.956558] online_pages_range start_pfn = 100000 nr_pages = 65536 
arg = 0
[   52.964104] Built 1 zonelists, mobility grouping on.  Total pages: 
187367
[   52.964828] Policy zone: Normal

But still I'll change to += to match with the previous code.

Regards,
Arun
