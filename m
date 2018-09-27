Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABE8216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABE8216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeI0V0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:26:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36060 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbeI0V0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:26:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A4C7A9;
        Thu, 27 Sep 2018 08:07:53 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E746D3F5BD;
        Thu, 27 Sep 2018 08:07:51 -0700 (PDT)
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory
 size
To:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-6-hch@lst.de>
 <985079efc3296ac45de1e6344d7916c42fc7cbdd.camel@kernel.crashing.org>
 <20180927134954.GB8281@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7a34c74f-7c83-84bb-441b-a729adce2beb@arm.com>
Date:   Thu, 27 Sep 2018 16:07:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927134954.GB8281@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ oops, I should have looked at the replies first, now I see Ben already 
had the same thing to say about #3... ]

On 27/09/18 14:49, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 11:50:14AM +1000, Benjamin Herrenschmidt wrote:
>>> -	 * to be able to satisfy them - either by not supporting more physical
>>> -	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
>>> -	 * architecture needs to use an IOMMU instead of the direct mapping.
>>> -	 */
>>> -	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
>>> +	u64 min_mask;
>>> +
>>> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
>>> +		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
>>> +	else
>>> +		min_mask = min_t(u64, DMA_BIT_MASK(32),
>>> +				 (max_pfn - 1) << PAGE_SHIFT);
>>> +
>>> +	if (mask >= phys_to_dma(dev, min_mask))
>>>   		return 0;
>>
>> nitpick ... to be completely "correct", I would have written
>>
>> 	if (IS_ENABLED(CONFIG_ZONE_DMA))
>> 		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
>> 	else
>> 		min_mask = DMA_BIT_MASK(32);
>>
>> 	min_mask = min_t(u64, min_mask,	(max_pfn - 1) << PAGE_SHIFT);
>>
>> In "theory" it's also ok to have a mask < ZONE_DMA_BITS as long as it's
>> big enough to fit all memory :-)
> 
> Yeah, we could do that.

FWIW I like it even if just for looking slightly more readable. With 
that fixup,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
