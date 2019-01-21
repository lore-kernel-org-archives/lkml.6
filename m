Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F8DC2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F442085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfAUNZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:25:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbfAUNZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:25:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 563B980D;
        Mon, 21 Jan 2019 05:25:53 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D03E73F614;
        Mon, 21 Jan 2019 05:25:50 -0800 (PST)
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>, pratikp@codeaurora.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com>
Date:   Mon, 21 Jan 2019 13:25:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2019 10:50, Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>>
>> Hi,
>>
>>
>> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>>
>>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>>>>
>>>> Qualcomm SoCs have an additional level of cache called as
>>>> System cache, aka. Last level cache (LLC). This cache sits right
>>>> before the DDR, and is tightly coupled with the memory controller.
>>>> The clients using this cache request their slices from this
>>>> system cache, make it active, and can then start using it.
>>>> For these clients with smmu, to start using the system cache for
>>>> buffers and, related page tables [1], memory attributes need to be
>>>> set accordingly. This series add the required support.
>>>>
>>>
>>> Does this actually improve performance on reads from a device? The
>>> non-cache coherent DMA routines perform an unconditional D-cache
>>> invalidate by VA to the PoC before reading from the buffers filled by
>>> the device, and I would expect the PoC to be defined as lying beyond
>>> the LLC to still guarantee the architected behavior.
>>
>> We have seen performance improvements when running Manhattan
>> GFXBench benchmarks.
>>
> 
> Ah ok, that makes sense, since in that case, the data flow is mostly
> to the device, not from the device.
> 
>> As for the PoC, from my knowledge on sdm845 the system cache, aka
>> Last level cache (LLC) lies beyond the point of coherency.
>> Non-cache coherent buffers will not be cached to system cache also, and
>> no additional software cache maintenance ops are required for system cache.
>> Pratik can add more if I am missing something.
>>
>> To take care of the memory attributes from DMA APIs side, we can add a
>> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
>>
> 
> So does the device use the correct inner non-cacheable, outer
> writeback cacheable attributes if the SMMU is in pass-through?
> 
> We have been looking into another use case where the fact that the
> SMMU overrides memory attributes is causing issues (WC mappings used
> by the radeon and amdgpu driver). So if the SMMU would honour the
> existing attributes, would you still need the SMMU changes?

Even if we could force a stage 2 mapping with the weakest pagetable 
attributes (such that combining would work), there would still need to 
be a way to set the TCR attributes appropriately if this behaviour is 
wanted for the SMMU's own table walks as well.

Robin.
