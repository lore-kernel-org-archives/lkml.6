Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35930C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A97220839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QRGOLGrd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OVAALX3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A97220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeILTOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:14:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:14:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1F076083E; Wed, 12 Sep 2018 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536761367;
        bh=DRIe1HTR507OMAPE4kLMiDMFdZSRXxQIgeXau95325A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QRGOLGrd/o8nWcmPxLgNcoVLrY/Io+6AvbHaF59ynEJsIspOeGzh91LPoC0XqaAYn
         TAFNX2LLJWpzlftyH/bab8kOzmLNOi62gvZvvjG7UvJb1mK7631Xy955Bf3eJfNwHv
         83p5M7m3D6hJf5ygbqLVnX0SMtCr3uKljNbOXFRE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6D8136029D;
        Wed, 12 Sep 2018 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536761366;
        bh=DRIe1HTR507OMAPE4kLMiDMFdZSRXxQIgeXau95325A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OVAALX3PX8/loDE1tre6Tk8lbDLX0lOukjrbreJo5eg/UNrVzWIdNWvSp62yhv8qn
         ikrkbglNmuX7lMrB8UQgxf5CqYn8vgOSYSKi+LdNY1K5eICQMCHgAJHQ63+/8DILz4
         xX7+qRtKyMjw367ZSmrHNVigCOaLLTE4gnHtflj0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Sep 2018 19:39:26 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, vbabka@suse.cz,
        pasha.tatashin@oracle.com, iamjoonsoo.kim@lge.com,
        osalvador@suse.de, malat@debian.org, gregkh@linuxfoundation.org,
        yasu.isimatu@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arunks.linux@gmail.com,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [RFC] memory_hotplug: Free pages as pageblock_order
In-Reply-To: <20180912125743.GB8537@350D>
References: <1536744405-16752-1-git-send-email-arunks@codeaurora.org>
 <20180912103853.GC10951@dhcp22.suse.cz> <20180912125743.GB8537@350D>
Message-ID: <4b2f53342b68535b5635a3e46783163a@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal and Balbir,

Thanks for reviewing.

On 2018-09-12 18:27, Balbir Singh wrote:
> On Wed, Sep 12, 2018 at 12:38:53PM +0200, Michal Hocko wrote:
>> On Wed 12-09-18 14:56:45, Arun KS wrote:
>> > When free pages are done with pageblock_order, time spend on
>> > coalescing pages by buddy allocator can be reduced. With
>> > section size of 256MB, hot add latency of a single section
>> > shows improvement from 50-60 ms to less than 1 ms, hence
>> > improving the hot add latency by 60%.
>> 
>> Where does the improvement come from? You are still doing the same
>> amount of work except that the number of callbacks is lower. Is this 
>> the
>> real source of 60% improvement?
>> 
> 
> It looks like only the first page of the pageblock is initialized, is
> some of the cost amortized in terms of doing one initialization for
> the page with order (order) and then relying on split_page and helpers
> to do the rest? Of course the number of callbacks reduce by a 
> significant
> number as well.
Currently, order zero pages are freed one by one, they goes to pcp list 
and later when pcp->count >= pcp->high, kernel calls __free_one_page() 
in a loop. __free_one_page() tries to merge these pages to create bigger 
order page.

But when we free with higher order page(pageblock_order), this merging 
is not done. AFAIU, this is the reason for improvement in hot add 
latency.

> 
> 
>> >
>> > If this looks okey, I'll modify users of set_online_page_callback
>> > and resend clean patch.
>> 
>> [...]
>> 
>> > +static int generic_online_pages(struct page *page, unsigned int order);
>> > +static online_pages_callback_t online_pages_callback = generic_online_pages;
>> > +
>> > +static int generic_online_pages(struct page *page, unsigned int order)
>> > +{
>> > +	unsigned long nr_pages = 1 << order;
>> > +	struct page *p = page;
>> > +	unsigned int loop;
>> > +
>> > +	for (loop = 0 ; loop < nr_pages ; loop++, p++) {
>> > +		__ClearPageReserved(p);
>> > +		set_page_count(p, 0);
>> > +	}
>> > +	adjust_managed_page_count(page, nr_pages);
>> > +	init_page_count(page);
>> > +	__free_pages(page, order);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static int online_pages_blocks(unsigned long start_pfn, unsigned long nr_pages)
>> > +{
>> > +	unsigned long pages_per_block = (1 << pageblock_order);
>> > +	unsigned long nr_pageblocks = nr_pages / pages_per_block;
>> > +//	unsigned long rem_pages = nr_pages % pages_per_block;
>> > +	int i, ret, onlined_pages = 0;
>> > +	struct page *page;
>> > +
>> > +	for (i = 0 ; i < nr_pageblocks ; i++) {
>> > +		page = pfn_to_page(start_pfn + (i * pages_per_block));
>> > +		ret = (*online_pages_callback)(page, pageblock_order);
>> > +		if (!ret)
>> > +			onlined_pages += pages_per_block;
>> > +		else if (ret > 0)
>> > +			onlined_pages += ret;
>> > +	}
>> 
>> Could you explain why does the pages_per_block step makes any sense? 
>> Why
>> don't you simply apply handle the full nr_pages worth of memory range
>> instead?
Yes. We can move the this loop to generic_online_pages and do 
__free_pages() of pageblock_order.

>> 
>> > +/*
>> > +	if (rem_pages)
>> > +		onlined_pages += online_page_single(start_pfn + i, rem_pages);
>> > +*/
> 
> Do we expect no rem_pages with this patch?
I ll remove this code, in assumption that section size will be always 
multiple of pageblock_order.

Regards,
Arun
> 
>> > +
>> > +	return onlined_pages;
>> > +}
>> > +
>> >  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
>> >  			void *arg)
>> >  {
>> > -	unsigned long i;
>> >  	unsigned long onlined_pages = *(unsigned long *)arg;
>> > -	struct page *page;
>> >
>> >  	if (PageReserved(pfn_to_page(start_pfn)))
>> > -		for (i = 0; i < nr_pages; i++) {
>> > -			page = pfn_to_page(start_pfn + i);
>> > -			(*online_page_callback)(page);
>> > -			onlined_pages++;
>> > -		}
>> > +		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
>> >
>> >  	online_mem_sections(start_pfn, start_pfn + nr_pages);
> 
> 
> Balbir Singh.
