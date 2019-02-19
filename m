Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1937BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF54821905
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBSHmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:42:12 -0500
Received: from foss.arm.com ([217.140.101.70]:41304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfBSHmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:42:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3777780D;
        Mon, 18 Feb 2019 23:42:09 -0800 (PST)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A00143F720;
        Mon, 18 Feb 2019 23:42:04 -0800 (PST)
Subject: Re: [RFC PATCH 01/31] mm: migrate: Add exchange_pages to exchange two
 lists of pages.
To:     Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
References: <20190215220856.29749-1-zi.yan@sent.com>
 <20190215220856.29749-2-zi.yan@sent.com>
 <20190217112943.GP12668@bombadil.infradead.org>
 <65A1FFA0-531C-4078-9704-3F44819C3C07@nvidia.com>
 <2630a452-8c53-f109-1748-36b98076c86e@suse.cz>
 <53690FCD-B0BA-4619-8DF1-B9D721EE1208@nvidia.com>
 <20190218175224.GT12668@bombadil.infradead.org>
 <C84D2490-B6C6-4C7C-870F-945E31719728@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1ce6ae99-4865-df62-5f20-cb07ebb95327@arm.com>
Date:   Tue, 19 Feb 2019 13:12:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <C84D2490-B6C6-4C7C-870F-945E31719728@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/18/2019 11:29 PM, Zi Yan wrote:
> On 18 Feb 2019, at 9:52, Matthew Wilcox wrote:
> 
>> On Mon, Feb 18, 2019 at 09:51:33AM -0800, Zi Yan wrote:
>>> On 18 Feb 2019, at 9:42, Vlastimil Babka wrote:
>>>> On 2/18/19 6:31 PM, Zi Yan wrote:
>>>>> The purpose of proposing exchange_pages() is to avoid allocating any
>>>>> new
>>>>> page,
>>>>> so that we would not trigger any potential page reclaim or memory
>>>>> compaction.
>>>>> Allocating a temporary page defeats the purpose.
>>>>
>>>> Compaction can only happen for order > 0 temporary pages. Even if you
>>>> used
>>>> single order = 0 page to gradually exchange e.g. a THP, it should be
>>>> better than
>>>> u64. Allocating order = 0 should be a non-issue. If it's an issue, then
>>>> the
>>>> system is in a bad state and physically contiguous layout is a secondary
>>>> concern.
>>>
>>> You are right if we only need to allocate one order-0 page. But this also
>>> means
>>> we can only exchange two pages at a time. We need to add a lock to make sure
>>> the temporary page is used exclusively or we need to keep allocating
>>> temporary pages
>>> when multiple exchange_pages() are happening at the same time.
>>
>> You allocate one temporary page per thread that's doing an exchange_page().
> 
> Yeah, you are right. I think at most I need NR_CPU order-0 pages. I will try
> it. Thanks.

But the location of this temp page matters as well because you would like to
saturate the inter node interface. It needs to be either of the nodes where
the source or destination page belongs. Any other node would generate two
internode copy process which is not what you intend here I guess.
