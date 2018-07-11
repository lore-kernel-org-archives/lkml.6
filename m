Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F85C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F303920C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F303920C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbeGKRB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:01:57 -0400
Received: from foss.arm.com ([217.140.101.70]:40588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388056AbeGKRB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:01:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B9CD80D;
        Wed, 11 Jul 2018 09:56:44 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0C6F3F589;
        Wed, 11 Jul 2018 09:56:41 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] dma-mapping: Generalise dma_32bit_limit flag
To:     Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org
References: <cover.1531239284.git.robin.murphy@arm.com>
 <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
 <20180710180433.GB26285@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <868cead9-88a7-e58d-3452-a78e19be5f47@arm.com>
Date:   Wed, 11 Jul 2018 17:56:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710180433.GB26285@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/18 19:04, Christoph Hellwig wrote:
> On Tue, Jul 10, 2018 at 06:17:16PM +0100, Robin Murphy wrote:
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 8be8106270c2..95e185347e34 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -183,7 +183,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>>   	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
>>   	 * if the device itself might support it.
>>   	 */
>> -	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
>> +	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
>>   		return 0;
> 
> The comment above this check needs an updated (or just be removed).

Right, I'll give it a tweak. I could also do with actually getting the 
field name correct in via_no_dac_cb()...

> Also we still have a few architectures not using dma-direct. I guess
> most were doing fine without such limits anyway, but at least arm
> will probably need an equivalent check.

Indeed, once we've found an approach that everyone's happy with we can 
have a more thorough audit of exactly where else it needs to be applied. 
FWIW I'm not aware of any 32-bit Arm systems affected by this*, but if 
they do exist then at least there's no risk of regression since they've 
always been busted.

Robin.


* Not counting the somewhat-similar StrongArm DMA controller bug where 
one bit in the *middle* of the mask is unusable. Let's keep that 
confined to the Arm dmabounce code and never speak of it...
