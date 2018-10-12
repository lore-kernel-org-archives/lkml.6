Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD0C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BBC21477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hECjA8pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BBC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeJMGGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 02:06:12 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6324 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeJMGGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 02:06:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc120c30000>; Fri, 12 Oct 2018 15:31:31 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 15:31:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Oct 2018 15:31:36 -0700
Received: from [10.2.173.107] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 22:31:36 +0000
Subject: Re: [PATCH 2/6] mm: introduce put_user_page*(), placeholder versions
To:     Balbir Singh <bsingharora@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-3-jhubbard@nvidia.com> <20181012073521.GJ8537@350D>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <faaac34e-c358-9675-5287-15398bc6828b@nvidia.com>
Date:   Fri, 12 Oct 2018 15:31:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012073521.GJ8537@350D>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539383491; bh=9vPuc2FQ/2WpBktGxSKAVnGVnxX5otrFMXF1Vg9i6wk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hECjA8pG5wPp+3zAeE8wzZz/k3BYDUPHg03dXd3Mt6Qy6Rdj6onAs7wvr9lQfZIZ/
         nPCavfFy9haOF/NPgMwZu3vbqbWU3CEmTbNGmwC6I3Br9bcj0Q3wxpZECm1wG+vhh1
         3RCxWQp3I65sFUuo5cXDCTUQecUclrLN4FhYwUDny3RDbavJ3+Q8lXnnjuGtQmpCEl
         P5C71gnu0CbNfO8ByG5mHcPgVI6wuhyGGplKsFrWMft9PgGcXQmM5MK9Ly62y9EvI6
         oUrzhXvoYYOsuk9bXwtJuNm16cMzCHUdXpaWXfyA0xsjYf9hgpBgTDRRD54Mzl2Qep
         NIcNW/fkWMkDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 12:35 AM, Balbir Singh wrote:
> On Thu, Oct 11, 2018 at 11:00:10PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
[...]>> +/*
>> + * put_user_pages_dirty() - for each page in the @pages array, make
>> + * that page (or its head page, if a compound page) dirty, if it was
>> + * previously listed as clean. Then, release the page using
>> + * put_user_page().
>> + *
>> + * Please see the put_user_page() documentation for details.
>> + *
>> + * set_page_dirty(), which does not lock the page, is used here.
>> + * Therefore, it is the caller's responsibility to ensure that this is
>> + * safe. If not, then put_user_pages_dirty_lock() should be called instead.
>> + *
>> + * @pages:  array of pages to be marked dirty and released.
>> + * @npages: number of pages in the @pages array.
>> + *
>> + */
>> +void put_user_pages_dirty(struct page **pages, unsigned long npages)
>> +{
>> +	unsigned long index;
>> +
>> +	for (index = 0; index < npages; index++) {
> Do we need any checks on npages, npages <= (PUD_SHIFT - PAGE_SHIFT)?
> 

Hi Balbir,

Thanks for combing through this series.

I'd go with "probably not", because the only check that can be done is
what you showed above: "did someone crazy pass in more pages than are
possible for this system?". I don't think checking for that helps here,
as that will show up loud and clear, in other ways.

The release_pages() implementation made the same judgment call to not 
check npages, which also influenced me.

A VM_BUG_ON could be added but I'd prefer not to, as it seems to have 
not enough benefit to be worth it.


>> +		struct page *page = compound_head(pages[index]);
>> +
>> +		if (!PageDirty(page))
>> +			set_page_dirty(page);
>> +
>> +		put_user_page(page);
>> +	}
>> +}
>> +EXPORT_SYMBOL(put_user_pages_dirty);
>> +
>> +/*
>> + * put_user_pages_dirty_lock() - for each page in the @pages array, make
>> + * that page (or its head page, if a compound page) dirty, if it was
>> + * previously listed as clean. Then, release the page using
>> + * put_user_page().
>> + *
>> + * Please see the put_user_page() documentation for details.
>> + *
>> + * This is just like put_user_pages_dirty(), except that it invokes
>> + * set_page_dirty_lock(), instead of set_page_dirty().
>> + *
>> + * @pages:  array of pages to be marked dirty and released.
>> + * @npages: number of pages in the @pages array.
>> + *
>> + */
>> +void put_user_pages_dirty_lock(struct page **pages, unsigned long npages)
>> +{
>> +	unsigned long index;
>> +
>> +	for (index = 0; index < npages; index++) {
>> +		struct page *page = compound_head(pages[index]);
>> +
>> +		if (!PageDirty(page))
>> +			set_page_dirty_lock(page);
>> +
>> +		put_user_page(page);
>> +	}
>> +}
>> +EXPORT_SYMBOL(put_user_pages_dirty_lock);
>> +
> 
> This can be collapsed w.r.t put_user_pages_dirty, a function pointer indirection
> for the locked vs unlocked case, not sure how that affects function optimization.
> 

OK, good point. I initially wanted to avoid the overhead of a function 
pointer, but considering that there are lots of other operations 
happening, I think you're right: best to just get rid of the code 
duplication. If later on we find that changing it back actually helps 
any benchmarks, that can always be done.

See below for how I'm planning on fixing it, and it is a nice little 
cleanup, so thanks for pointing that out.

>> +/*
>> + * put_user_pages() - for each page in the @pages array, release the page
>> + * using put_user_page().
>> + *
>> + * Please see the put_user_page() documentation for details.
>> + *
>> + * This is just like put_user_pages_dirty(), except that it invokes
>> + * set_page_dirty_lock(), instead of set_page_dirty().
> 
> The comment is incorrect.

Yes, it sure is! Jan spotted it before, and I fixed it once, then 
rebased off of the version right *before* the fix, so now I have to 
delete that sentence again.  It's hard to kill! :)

> 
>> + *
>> + * @pages:  array of pages to be marked dirty and released.
>> + * @npages: number of pages in the @pages array.
>> + *
>> + */
>> +void put_user_pages(struct page **pages, unsigned long npages)
>> +{
>> +	unsigned long index;
>> +
>> +	for (index = 0; index < npages; index++)
>> +		put_user_page(pages[index]);
>> +}
> 
> Ditto in terms of code duplication
> 

Here, I think you'll find that the end result, is sufficiently 
de-duplicated, after applying the function pointer above. Here's what it 
looks like without the comment blocks, below. I don't want to go any 
further than this, because the only thing left is the "for" loops, and 
macro-izing such a trivial thing is not really a win:


typedef int (*set_dirty_func)(struct page *page);

static void __put_user_pages_dirty(struct page **pages,
				   unsigned long npages,
				   set_dirty_func sdf)
{
	unsigned long index;

	for (index = 0; index < npages; index++) {
		struct page *page = compound_head(pages[index]);

		if (!PageDirty(page))
			sdf(page);

		put_user_page(page);
	}
}

void put_user_pages_dirty(struct page **pages, unsigned long npages)
{
	__put_user_pages_dirty(pages, npages, set_page_dirty);
}
EXPORT_SYMBOL(put_user_pages_dirty);

void put_user_pages_dirty_lock(struct page **pages, unsigned long npages)
{
	__put_user_pages_dirty(pages, npages, set_page_dirty_lock);
}
EXPORT_SYMBOL(put_user_pages_dirty_lock);

void put_user_pages(struct page **pages, unsigned long npages)
{
	unsigned long index;

	for (index = 0; index < npages; index++)
		put_user_page(pages[index]);
}
EXPORT_SYMBOL(put_user_pages);

-- 
thanks,
John Hubbard
NVIDIA


