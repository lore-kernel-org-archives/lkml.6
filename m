Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ED3216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57ED3216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeI0Vvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:51:41 -0400
Received: from verein.lst.de ([213.95.11.211]:45948 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbeI0Vvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:51:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8B80768B02; Thu, 27 Sep 2018 17:32:52 +0200 (CEST)
Date:   Thu, 27 Sep 2018 17:32:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/5] dma-direct: implement complete bus_dma_mask
 handling
Message-ID: <20180927153252.GE10566@lst.de>
References: <20180920185247.20037-1-hch@lst.de> <20180920185247.20037-5-hch@lst.de> <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:58:04PM +0100, Robin Murphy wrote:
>>   }
>>   #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>>   diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 3c404e33d946..64466b7ef67b 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -43,10 +43,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>>   			return false;
>>   		}
>>   -		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
>> +		if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
>
> Hmm... say *dev->dma_mask is 31 bits and dev->bus_dma_mask is 40 bits due 
> to a global DT property, we'll now scream where we didn't before even 
> though the bus mask is almost certainly irrelevant - is that desirable?

This is just the reporting in the error case - we'll only hit this
IFF dma_capable already returned false.  But if you don't want a message
here we can probably drop this hunk.

>> @@ -65,12 +66,18 @@ u64 dma_direct_get_required_mask(struct device *dev)
>>   {
>>   	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
>>   +	if (dev->bus_dma_mask && dev->bus_dma_mask < max_dma)
>> +		max_dma = dev->bus_dma_mask;
>
> Again, I think we could just do another min_not_zero() here. A device wired 
> to address only one single page of RAM isn't a realistic prospect (and we 
> could just flip the -1 and the shift in the max_dma calculation if we 
> *really* wanted to support such things).

This just seemed more readable to me than min_not_zero, but if others
prefer min_not_zero I can switch.
