Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EBCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C84216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C84216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeI0Wd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:33:59 -0400
Received: from foss.arm.com ([217.140.101.70]:36894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbeI0Wd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:33:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2C6E7A9;
        Thu, 27 Sep 2018 09:14:58 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0EEF3F5B3;
        Thu, 27 Sep 2018 09:14:57 -0700 (PDT)
Subject: Re: [PATCH 4/5] dma-direct: implement complete bus_dma_mask handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-5-hch@lst.de>
 <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
 <20180927153252.GE10566@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
Date:   Thu, 27 Sep 2018 17:14:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927153252.GE10566@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/18 16:32, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 03:58:04PM +0100, Robin Murphy wrote:
>>>    }
>>>    #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>>>    diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 3c404e33d946..64466b7ef67b 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -43,10 +43,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>>>    			return false;
>>>    		}
>>>    -		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
>>> +		if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
>>
>> Hmm... say *dev->dma_mask is 31 bits and dev->bus_dma_mask is 40 bits due
>> to a global DT property, we'll now scream where we didn't before even
>> though the bus mask is almost certainly irrelevant - is that desirable?
> 
> This is just the reporting in the error case - we'll only hit this
> IFF dma_capable already returned false.  But if you don't want a message
> here we can probably drop this hunk.

It was only a question of consistency - whatever the reason was to avoid 
warning for small device masks before, it's not obvious why it wouldn't 
still apply in the presence of nonzero but larger bus mask. The fact 
that the current check is there at all implied to me that we're 
expecting less-capable device to hit this often and thus wanted to avoid 
being noisy. If that's not the case then it's fine as-is AFAIC.

>>> @@ -65,12 +66,18 @@ u64 dma_direct_get_required_mask(struct device *dev)
>>>    {
>>>    	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
>>>    +	if (dev->bus_dma_mask && dev->bus_dma_mask < max_dma)
>>> +		max_dma = dev->bus_dma_mask;
>>
>> Again, I think we could just do another min_not_zero() here. A device wired
>> to address only one single page of RAM isn't a realistic prospect (and we
>> could just flip the -1 and the shift in the max_dma calculation if we
>> *really* wanted to support such things).
> 
> This just seemed more readable to me than min_not_zero, but if others
> prefer min_not_zero I can switch.

Nah, just checking whether there were any intentionally different 
assumptions compared to the couple of other places in the patch where 
min_not_zero() *is* used. If it's purely a style thing then no worries 
(personally I'd have written it yet another way anyway).

Robin.
