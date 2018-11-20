Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26894C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB82A206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB82A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeKUBbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:31:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50518 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeKUBbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:31:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7528EBD;
        Tue, 20 Nov 2018 07:01:35 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 907753F5A0;
        Tue, 20 Nov 2018 07:01:34 -0800 (PST)
Subject: Re: [PATCH 1/2] swiotlb: Make DIRECT_MAPPING_ERROR viable
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1542722463.git.robin.murphy@arm.com>
 <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
 <20181120144918.GH10917@char.us.oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7ea5809e-1e1d-6bac-b723-9f55fafeaaae@arm.com>
Date:   Tue, 20 Nov 2018 15:01:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120144918.GH10917@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 14:49, Konrad Rzeszutek Wilk wrote:
> On Tue, Nov 20, 2018 at 02:09:52PM +0000, Robin Murphy wrote:
>> With the overflow buffer removed, we no longer have a unique address
>> which is guaranteed not to be a valid DMA target to use as an error
>> token. The DIRECT_MAPPING_ERROR value of 0 tries to at least represent
>> an unlikely DMA target, but unfortunately there are already SWIOTLB
>> users with DMA-able memory at physical address 0 which now gets falsely
>> treated as a mapping failure and leads to all manner of misbehaviour.
>>
>> The best we can do to mitigate that is flip DIRECT_MAPPING_ERROR to the
>> commonly-used all-bits-set value, since the last single byte of memory
>> is by far the least-likely-valid DMA target.
> 
> Are all the callers checking for DIRECT_MAPPING_ERROR or is it more of
> a comparison (as in if (!ret)) ?

dma_direct_map_page() and dma_direct_mapping_error() were already doing 
the right thing, and external callers must rely on the latter via 
dma_mapping_error() rather than trying to inspect the actual value 
themselves, since that varies between implementations anyway. AFAICS all 
the new return paths from swiotlb_map_page() are also robust in 
referencing the macro explicitly, so I think we're good.

Thanks,
Robin.

>> Fixes: dff8d6c1ed58 ("swiotlb: remove the overflow buffer")]
>> Reported-by: John Stultz <john.stultz@linaro.org>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   include/linux/dma-direct.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>> index bd73e7a91410..9de9c7ab39d6 100644
>> --- a/include/linux/dma-direct.h
>> +++ b/include/linux/dma-direct.h
>> @@ -5,7 +5,7 @@
>>   #include <linux/dma-mapping.h>
>>   #include <linux/mem_encrypt.h>
>>   
>> -#define DIRECT_MAPPING_ERROR		0
>> +#define DIRECT_MAPPING_ERROR		~(dma_addr_t)0
>>   
>>   #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>>   #include <asm/dma-direct.h>
>> -- 
>> 2.19.1.dirty
>>
