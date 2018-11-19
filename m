Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E647FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4862075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4862075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeKTGBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:01:52 -0500
Received: from foss.arm.com ([217.140.101.70]:38070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbeKTGBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:01:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC35080D;
        Mon, 19 Nov 2018 11:36:47 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 314983F5B7;
        Mon, 19 Nov 2018 11:36:46 -0800 (PST)
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
From:   Robin Murphy <robin.murphy@arm.com>
To:     Christoph Hellwig <hch@lst.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     konrad.wilk@oracle.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de>
 <9922f377-ee87-ba36-8d28-26af0f7822e5@arm.com>
Message-ID: <ad8ed3ba-12e8-3031-7c66-035b6d9ad6cd@arm.com>
Date:   Mon, 19 Nov 2018 19:36:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9922f377-ee87-ba36-8d28-26af0f7822e5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 16:37, Robin Murphy wrote:
> On 09/11/2018 07:49, Christoph Hellwig wrote:
>> On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
>>> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
>>> swiotlb_map_sg_attrs", I reproduce the hangs.
>>>
>>> Any suggestions for how to further debug what might be going wrong
>>> would be appreciated!
>>
>> Very odd.  In the end map_sg and map_page are defined to do the same
>> things to start with.  The only real issue we had in this area was:
>>
>> "[PATCH v2] of/device: Really only set bus DMA mask when appropriate"
>>
>> so with current mainline + that you still see a problem, and if you
>> rever the commit we are replying to it still goes away?
> 
> OK, after quite a bit of trying I have managed to provoke a 
> similar-looking problem with straight 4.20-rc1 on my Juno board - so far 
> my "reproducer" is to decompress a ~10GB .tar.xz off an external USB 
> hard disk, wherein after somewhere between 5 minutes and half an hour or 
> so it tends to falls over with xz choking on corrupt data and/or a USB 
> error.
> 
>  From the presentation, this really smells like there's some corner in 
> which we're either missing cache maintenance or doing it to the wrong 
> address - I've not seen any issues with Juno's main PCIe-attached I/O, 
> but the EHCI here is non-coherent (and 32-bit, so the bus_dma_mask thing 
> doesn't matter) as are the HiKey UFS and SD controller.
> 
> I'll keep digging...

OK, having brought my Hikey to life and reproduced John's stall with 
rc1, what's going on is that at some point dma_map_sg() returns 0, which 
causes the SCSI/UFS layer to go round in circles repeatedly trying to 
map the same list(s) equally unsuccessfully.

Why does dma_map_sg() fail? Turns out what we all managed to overlook is 
that this patch *does* introduce a subtle change in behaviour, in that 
previously the non-bounced case assigned dev_addr to sg->dma_address 
without looking at it; now with the swiotlb_map_page() call we check the 
return value against DIRECT_MAPPING_ERROR regardless of whether it was 
bounced or not.

Flash back to the other thread when I said "...but I suspect there may 
well be non-IOMMU platforms where DMA to physical address 0 is a thing 
:("? I have the 3GB Hikey where all the RAM is below 32 bits so SWIOTLB 
never ever bounces, but sure enough, guess where that RAM starts...

So in fact it looks like patch #4 technically introduces the first 
instance of this problem, we're just getting lucky not to hit it with a 
map_page/map_single case such that direct_mapping_error() would wrongly 
report failure for page 0. The bad news (for me) is that that can't have 
anything to do with my apparent memory corruption thing above, so now I 
still need to figure out what the hell is going on there.

Robin.
