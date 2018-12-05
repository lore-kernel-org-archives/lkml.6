Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650BCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8102082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GVqVKte8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8102082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeLEBlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:41:04 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10155 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLEBlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:41:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c072cab0000>; Tue, 04 Dec 2018 17:40:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Dec 2018 17:41:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 17:41:00 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 01:40:59 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Mike Rapoport <rppt@linux.ibm.com>, <john.hubbard@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>, Tom Talpey <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <20181204001720.26138-2-jhubbard@nvidia.com>
 <20181204075323.GI26700@rapoport-lnx>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a34aca95-7372-4fd2-b72a-004731fc10ed@nvidia.com>
Date:   Tue, 4 Dec 2018 17:40:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204075323.GI26700@rapoport-lnx>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543974059; bh=y6Xwvnu8XjxkVeXMZSuda+QBJrSVAAziiUVKiHLR/ic=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GVqVKte8DiuPq7IeLR54HWjnRUS5cCq1yzIn431+XmKQKmCroHplf1TdtkQBsjAMi
         kgh6bGqXjqn/SICa7sdSelqfN0cbZ8Z7OoHkA1Te5wtgKXHnSi7n3GXsfFjB70gZjH
         OtRMADgY01hTgIASu4rZhLXCiX1sP+vwD7hUP470GxrTklAdcEOroJDPbnoIg0NhDp
         Cf/g/PAltYpHkzXO2l3NoWwIYzlnUIQ/SObdswJyPk0buMdCqROKFWdONa7IPlW1ph
         VSi27Npd/VcmMYcBGMPhbsjqaSUXwV/j96bgZ5z8qd2bJiFw/WxU06J0ihFDFExmCP
         63qWeP4JaEtqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/18 11:53 PM, Mike Rapoport wrote:
> Hi John,
> 
> Thanks for having documentation as a part of the patch. Some kernel-doc
> nits below.
> 
> On Mon, Dec 03, 2018 at 04:17:19PM -0800, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Introduces put_user_page(), which simply calls put_page().
>> This provides a way to update all get_user_pages*() callers,
>> so that they call put_user_page(), instead of put_page().
>>
>> Also introduces put_user_pages(), and a few dirty/locked variations,
>> as a replacement for release_pages(), and also as a replacement
>> for open-coded loops that release multiple pages.
>> These may be used for subsequent performance improvements,
>> via batching of pages to be released.
>>
>> This is the first step of fixing the problem described in [1]. The steps
>> are:
>>
>> 1) (This patch): provide put_user_page*() routines, intended to be used
>>    for releasing pages that were pinned via get_user_pages*().
>>
>> 2) Convert all of the call sites for get_user_pages*(), to
>>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>>    call sites, and will take some time.
>>
>> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>>    implement tracking of these pages. This tracking will be separate from
>>    the existing struct page refcounting.
>>
>> 4) Use the tracking and identification of these pages, to implement
>>    special handling (especially in writeback paths) when the pages are
>>    backed by a filesystem. Again, [1] provides details as to why that is
>>    desirable.
>>
>> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Christopher Lameter <cl@linux.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Jerome Glisse <jglisse@redhat.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  include/linux/mm.h | 20 ++++++++++++
>>  mm/swap.c          | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 100 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 5411de93a363..09fbb2c81aba 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -963,6 +963,26 @@ static inline void put_page(struct page *page)
>>  		__put_page(page);
>>  }
>>
>> +/*
>> + * put_user_page() - release a page that had previously been acquired via
>> + * a call to one of the get_user_pages*() functions.
> 
> Please add @page parameter description, otherwise kernel-doc is unhappy

Hi Mike,

Sorry I missed these kerneldoc points from your earlier review! I'll fix it
up now and it will show up in the next posting.

> 
>> + *
>> + * Pages that were pinned via get_user_pages*() must be released via
>> + * either put_user_page(), or one of the put_user_pages*() routines
>> + * below. This is so that eventually, pages that are pinned via
>> + * get_user_pages*() can be separately tracked and uniquely handled. In
>> + * particular, interactions with RDMA and filesystems need special
>> + * handling.
>> + */
>> +static inline void put_user_page(struct page *page)
>> +{
>> +	put_page(page);
>> +}
>> +
>> +void put_user_pages_dirty(struct page **pages, unsigned long npages);
>> +void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
>> +void put_user_pages(struct page **pages, unsigned long npages);
>> +
>>  #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>>  #define SECTION_IN_PAGE_FLAGS
>>  #endif
>> diff --git a/mm/swap.c b/mm/swap.c
>> index aa483719922e..bb8c32595e5f 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -133,6 +133,86 @@ void put_pages_list(struct list_head *pages)
>>  }
>>  EXPORT_SYMBOL(put_pages_list);
>>
>> +typedef int (*set_dirty_func)(struct page *page);
>> +
>> +static void __put_user_pages_dirty(struct page **pages,
>> +				   unsigned long npages,
>> +				   set_dirty_func sdf)
>> +{
>> +	unsigned long index;
>> +
>> +	for (index = 0; index < npages; index++) {
>> +		struct page *page = compound_head(pages[index]);
>> +
>> +		if (!PageDirty(page))
>> +			sdf(page);
>> +
>> +		put_user_page(page);
>> +	}
>> +}
>> +
>> +/*
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
> 
> Please put the parameters description next to the brief function
> description, as described in [1]
> 
> [1] https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation
> 

OK. 

> 
>> + *
>> + */
>> +void put_user_pages_dirty(struct page **pages, unsigned long npages)
>> +{
>> +	__put_user_pages_dirty(pages, npages, set_page_dirty);
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
> 
> Ditto

OK.

> 
>> + *
>> + */
>> +void put_user_pages_dirty_lock(struct page **pages, unsigned long npages)
>> +{
>> +	__put_user_pages_dirty(pages, npages, set_page_dirty_lock);
>> +}
>> +EXPORT_SYMBOL(put_user_pages_dirty_lock);
>> +
>> +/*
>> + * put_user_pages() - for each page in the @pages array, release the page
>> + * using put_user_page().
>> + *
>> + * Please see the put_user_page() documentation for details.
>> + *
>> + * @pages:  array of pages to be marked dirty and released.
>> + * @npages: number of pages in the @pages array.
>> + *
> 
> And here as well :)

OK.


thanks,
-- 
John Hubbard
NVIDIA
 
