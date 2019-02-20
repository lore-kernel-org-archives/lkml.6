Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2979C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F64421773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfBTEii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:38:38 -0500
Received: from foss.arm.com ([217.140.101.70]:52290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfBTEih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:38:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35A33A78;
        Tue, 19 Feb 2019 20:38:37 -0800 (PST)
Received: from [10.162.40.115] (p8cg001049571a15.blr.arm.com [10.162.40.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49C113F720;
        Tue, 19 Feb 2019 20:38:33 -0800 (PST)
Subject: Re: [RFC PATCH 01/31] mm: migrate: Add exchange_pages to exchange two
 lists of pages.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
 <1ce6ae99-4865-df62-5f20-cb07ebb95327@arm.com>
 <20190219125619.GA12668@bombadil.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <749d5674-9e85-1fe9-4a3b-1d6ad06948b4@arm.com>
Date:   Wed, 20 Feb 2019 10:08:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190219125619.GA12668@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/19/2019 06:26 PM, Matthew Wilcox wrote:
> On Tue, Feb 19, 2019 at 01:12:07PM +0530, Anshuman Khandual wrote:
>> But the location of this temp page matters as well because you would like to
>> saturate the inter node interface. It needs to be either of the nodes where
>> the source or destination page belongs. Any other node would generate two
>> internode copy process which is not what you intend here I guess.
> That makes no sense.  It should be allocated on the local node of the CPU
> performing the copy.  If the CPU is in node A, the destination is in node B
> and the source is in node C, then you're doing 4k worth of reads from node C,
> 4k worth of reads from node B, 4k worth of writes to node C followed by
> 4k worth of writes to node B.  Eventually the 4k of dirty cachelines on
> node A will be written back from cache to the local memory (... or not,
> if that page gets reused for some other purpose first).
> 
> If you allocate the page on node B or node C, that's an extra 4k of writes
> to be sent across the inter-node link.

Thats right there will be an extra remote write. My assumption was that the CPU
performing the copy belongs to either node B or node C.
