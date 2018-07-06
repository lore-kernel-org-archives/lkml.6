Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF5C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D70B23FBA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D70B23FBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932934AbeGFL5S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:57:18 -0400
Received: from foss.arm.com ([217.140.101.70]:35328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932630AbeGFL5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:57:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55D1418A;
        Fri,  6 Jul 2018 04:57:17 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 670F83F5BA;
        Fri,  6 Jul 2018 04:57:16 -0700 (PDT)
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
To:     Christoph Hellwig <hch@lst.de>
Cc:     noring@nocrew.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, JuergenUrban@gmx.de
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5811ebe5-b2bd-efc1-bf54-a8f05432c4f8@arm.com>
Date:   Fri, 6 Jul 2018 12:57:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705193613.GA28905@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/18 20:36, Christoph Hellwig wrote:
>> -	BUG_ON(!ops);
>> -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
>> -
>>   	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>>   		return cpu_addr;
>>   
>> +	BUG_ON(!ops);
>> +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> 
> I think doing dma on a device without ops is completely broken no matter
> what you think of it, so I very much disagree with that part of the change.
> 
> Also while I don't think not having a dma mask is a good idea even for
> a driver purely using dma coherent pools.  If the pools really are on
> the device itself I can see why it might not matter, but for the case
> commonly used on some ARM SOCs where we just reserve memory for certain
> devices from a system pool it very much does matter.
> 
> There really is no good excuse to not set a coherent mask in the drivers.

Right, I was rather on the fence about this - on the one hand it is 
objectively wrong per the API for drivers to call dma_alloc_coherent() 
without a prior successful dma_set_coherent_mask() call, but then I 
thought that in the case when they're *only* using it as a proxy for 
dma_alloc_from_dev_coherent() and explicitly don't want regular 
allocations from kernel memory to ever happen, then maybe it might be 
somewhat reasonable. But indeed I hadn't really given enough thought to 
the reserved-memory carveout case, where we definitely don't want to let 
a legitimate warning be hidden on a developer's machine but hit by users 
with different system configurations.

Fredrik, are you happy to fix up your driver to initialise a suitable 
mask at probe time?

Robin.
