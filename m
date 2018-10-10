Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CE5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139CC21570
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GX6iYlam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139CC21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJJIBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:01:42 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12405 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJJIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:01:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbd4add0000>; Tue, 09 Oct 2018 17:42:05 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 09 Oct 2018 17:42:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 09 Oct 2018 17:42:10 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 10 Oct
 2018 00:42:09 +0000
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
To:     Andrew Morton <akpm@linux-foundation.org>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
Date:   Tue, 9 Oct 2018 17:42:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539132125; bh=0/cOM5Q11pG20KQwn4TM6fKMNGJ5A6LDYPCfCmX6u+w=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GX6iYlamPPgXc4j1UWs6eKNoZTNJaWHkRxHFVx8kYOU5FZrYIhkB18pVvd9wr7VA5
         2smUAc4P/byKYfIR+1ASGs6Ped29vuM5Ie5jCIcJ5MMpwr64BzvQQUaO/sgaqUx+Gk
         z3VK1I31A1nq9Dr7f177115p9JQRIF6eu6H7yJrIyLki9LYNnH1yDP6nWAxuTV1pME
         Np9wJeWw44kZvwbql2UgH4TjbA9ZxbBMg+h2gJC6V6869YhU4NlpayWUDTbgec1mHk
         dueqWTdun1xWb3wZdR9lUL8lSH30SVd7qRDJeksRswsIMmmB02VAsbGasiJ388Orj5
         VbRl68F1zIkuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 5:14 PM, Andrew Morton wrote:
> On Mon,  8 Oct 2018 14:16:22 -0700 john.hubbard@gmail.com wrote:
> 
>> From: John Hubbard <jhubbard@nvidia.com>
[...]
>> +/*
>> + * Pages that were pinned via get_user_pages*() should be released via
>> + * either put_user_page(), or one of the put_user_pages*() routines
>> + * below.
>> + */
>> +static inline void put_user_page(struct page *page)
>> +{
>> +	put_page(page);
>> +}
>> +
>> +static inline void put_user_pages_dirty(struct page **pages,
>> +					unsigned long npages)
>> +{
>> +	unsigned long index;
>> +
>> +	for (index = 0; index < npages; index++) {
>> +		if (!PageDirty(pages[index]))
> 
> Both put_page() and set_page_dirty() handle compound pages.  But
> because of the above statement, put_user_pages_dirty() might misbehave? 
> Or maybe it won't - perhaps the intent here is to skip dirtying the
> head page if the sub page is clean?  Please clarify, explain and add
> comment if so.
> 

Yes, technically, the accounting is wrong: we normally use the head page to 
track dirtiness, and here, that is not done. (Nor was it done before this
patch). However, it's not causing problems in code today because sub pages
are released at about the same time as head pages, so the head page does get 
properly checked at some point. And that means that set_page_dirty*() gets
called if it needs to be called. 

Obviously this is a little fragile, in that it depends on the caller behaving 
a certain way. And in any case, the long-term fix (coming later) *also* only
operates on the head page. So actually, instead of a comment, I think it's good 
to just insert

	page = compound_head(page);

...into these new routines, right now. I'll do that.

[...]
> 
> Otherwise looks OK.  Ish.  But it would be nice if that comment were to
> explain *why* get_user_pages() pages must be released with
> put_user_page().
> 

Yes, will do.

> Also, maintainability.  What happens if someone now uses put_page() by
> mistake?  Kernel fails in some mysterious fashion?  How can we prevent
> this from occurring as code evolves?  Is there a cheap way of detecting
> this bug at runtime?
> 

It might be possible to do a few run-time checks, such as "does page that came 
back to put_user_page() have the correct flags?", but it's harder (without 
having a dedicated page flag) to detect the other direction: "did someone page 
in a get_user_pages page, to put_page?"

As Jan said in his reply, converting get_user_pages (and put_user_page) to 
work with a new data type that wraps struct pages, would solve it, but that's
an awfully large change. Still...given how much of a mess this can turn into 
if it's wrong, I wonder if it's worth it--maybe? 

thanks,
-- 
John Hubbard
NVIDIA
 
