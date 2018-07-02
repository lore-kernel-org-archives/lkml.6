Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087BCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C070325B77
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C070325B77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeGBUot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:44:49 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10151 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeGBUor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:44:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3a8ec00000>; Mon, 02 Jul 2018 13:44:48 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 02 Jul 2018 13:44:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 02 Jul 2018 13:44:46 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 20:44:46 +0000
Subject: Re: [PATCH v2 5/6] mm: track gup pages with page->dma_pinned_* fields
To:     Jan Kara <jack@suse.cz>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
 <20180702005654.20369-6-jhubbard@nvidia.com>
 <20180702095331.n5zfz35d3invl5al@quack2.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <bb798475-ebf3-7b02-409f-8c4347fa6674@nvidia.com>
Date:   Mon, 2 Jul 2018 13:43:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702095331.n5zfz35d3invl5al@quack2.suse.cz>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 02:53 AM, Jan Kara wrote:
> On Sun 01-07-18 17:56:53, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
> ...
> 
>> @@ -904,12 +907,24 @@ static inline void get_page(struct page *page)
>>  	 */
>>  	VM_BUG_ON_PAGE(page_ref_count(page) <= 0, page);
>>  	page_ref_inc(page);
>> +
>> +	if (unlikely(PageDmaPinned(page)))
>> +		__get_page_for_pinned_dma(page);
>>  }
>>  
>>  static inline void put_page(struct page *page)
>>  {
>>  	page = compound_head(page);
>>  
>> +	/* Because the page->dma_pinned_* fields are unioned with
>> +	 * page->lru, there is no way to do classical refcount-style
>> +	 * decrement-and-test-for-zero. Instead, PageDmaPinned(page) must
>> +	 * be checked, in order to safely check if we are allowed to decrement
>> +	 * page->dma_pinned_count at all.
>> +	 */
>> +	if (unlikely(PageDmaPinned(page)))
>> +		__put_page_for_pinned_dma(page);
>> +
> 
> These two are just wrong. You cannot make any page reference for
> PageDmaPinned() account against a pin count. First, it is just conceptually
> wrong as these references need not be long term pins, second, you can
> easily race like:
> 
> Pinner				Random process
> 				get_page(page)
> pin_page_for_dma()
> 				put_page(page)
> 				 -> oops, page gets unpinned too early
> 

I'll drop this approach, without mentioning any of the locking that is hiding in
there, since that was probably breaking other rules anyway. :) Thanks for your
patience in reviewing this.

> So you really have to create counterpart to get_user_pages() - like
> put_user_page() or whatever... It is inconvenient to have to modify all GUP
> users but I don't see a way around that. 

OK, there will be a long-ish pause, while I go visit all the gup sites. I count about
88 callers, which is not nearly as crazy as my first casual grep showed, but still
quite a chunk, since I have to track down where each one does its put_page call(s).

It's definitely worth the effort, though. These pins just plain need some special
handling in order to get everything correct.


thanks,
-- 
John Hubbard
NVIDIA
