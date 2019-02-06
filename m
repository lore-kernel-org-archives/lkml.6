Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB34C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2D32073F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfBFP2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:28:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54502 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbfBFP2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:28:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA71780D;
        Wed,  6 Feb 2019 07:28:30 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B053F675;
        Wed,  6 Feb 2019 07:28:29 -0800 (PST)
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-4-hch@lst.de>
 <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com> <20190201161638.GJ6532@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f59852aa-394c-3165-f7c0-fa6cdcea059f@arm.com>
Date:   Wed, 6 Feb 2019 15:28:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201161638.GJ6532@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2019 16:16, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 03:24:45PM +0000, Robin Murphy wrote:
>> On 14/01/2019 09:41, Christoph Hellwig wrote:
>>> Directly iterating over the pages makes the code a bit simpler and
>>> prepares for the following changes.
>>
>> It also defeats the whole purpose of __iommu_dma_alloc_pages(), so I'm not
>> really buying the simplification angle - you've *seen* that code, right? ;)
> 
> How does it defeat the purpose of __iommu_dma_alloc_pages?

Because if iommu_map() only gets called at PAGE_SIZE granularity, then 
the IOMMU PTEs will be created at PAGE_SIZE (or smaller) granularity, so 
any effort to get higher-order allocations matching larger IOMMU block 
sizes is wasted, and we may as well have just done this:

	for (i = 0; i < count; i++) {
		struct page *page = alloc_page(gfp);
		...
		iommu_map(..., page_to_phys(page), PAGE_SIZE, ...);
	}

Really, it's a shame we have to split huge pages for the CPU remap, 
since in the common case the CPU MMU will have a matching block size, 
but IIRC there was something in vmap() or thereabouts that explicitly 
chokes on them.

Robin.
