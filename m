Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE2AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7042081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7042081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeKBPls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:41:48 -0400
Received: from verein.lst.de ([213.95.11.211]:48269 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbeKBPlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:41:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 68A4767329; Fri,  2 Nov 2018 07:35:42 +0100 (CET)
Date:   Fri, 2 Nov 2018 07:35:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de,
        m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, vdumpa@nvidia.com
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20181102063542.GA17073@lst.de>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com> <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 02:07:55PM +0000, Robin Murphy wrote:
> On 31/10/2018 20:03, Nicolin Chen wrote:
>> The addresses within a single page are always contiguous, so it's
>> not so necessary to allocate one single page from CMA area. Since
>> the CMA area has a limited predefined size of space, it might run
>> out of space in some heavy use case, where there might be quite a
>> lot CMA pages being allocated for single pages.
>>
>> This patch tries to skip CMA allocations of single pages and lets
>> them go through normal page allocations. This would save resource
>> in the CMA area for further more CMA allocations.
>
> In general, this seems to make sense to me. It does represent a theoretical 
> change in behaviour for devices which have their own CMA area somewhere 
> other than kernel memory, and only ever make non-atomic allocations, but 
> I'm not sure whether that's a realistic or common enough case to really 
> worry about.

Yes, I think we should make the decision in dma_alloc_from_contiguous
based on having a per-dev CMA area or not.  There is a lot of cruft in
this area that should be cleaned up while we're at it, like always
falling back to the normal page allocator if there is no CMA area or
nothing suitable found in dma_alloc_from_contiguous instead of
having to duplicate all that in the caller.
