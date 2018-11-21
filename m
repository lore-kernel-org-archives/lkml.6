Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF02DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD922146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD922146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeKUSoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:44:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbeKUSoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:44:12 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C816596B9046F;
        Wed, 21 Nov 2018 16:10:37 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 16:10:33 +0800
Subject: Re: Resend: How to handle the SMMU RAS Error in the kernel
To:     James Morse <james.morse@arm.com>,
        gengdongjiu <gengdj.1984@gmail.com>
CC:     <robin.murphy@arm.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        <xuqiang36@huawei.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
 <c8a1d0e7-338b-05e1-2d52-f13223515f49@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <7a93bf1b-7b7b-240e-bc74-68bf0ee18ac9@huawei.com>
Date:   Wed, 21 Nov 2018 16:10:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c8a1d0e7-338b-05e1-2d52-f13223515f49@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
   Thanks for the mail.

On 2018/11/20 2:05, James Morse wrote:
> Hi gengdongjiu,
> 
> On 17/11/2018 15:41, gengdongjiu wrote:
>> In the current kernel, it only handles three kinds of error, which is
>> memory error, PCIE device and ARM process. But now the SMMU already
>> support the RAS, how to handle the SMMU RAS error in the kernel?
> 
> What errors are being detected here?
> 
> I don't know much about the SMMU, but I think we should start with a list of
> errors that we want to handle.

In our platform, the SMMU RAS error mainly include below which flow the SMMU spec:
1. one bit ECC error, reported as CE.
2. two bits ECC error, reported as UEU.
3. fetch error in the SMMUv3 spec, reported as UER.

The 2 and 3 should be handled, but I do not know how do recovery to it.

> 
> 
> Is this a v8.2 fault handling interrupt from the SMMU taken to EL3?
> Or a cpu-access that was returned as external-abort? or a device access that was
> told external-abort?
it flows v8.2 RAS spec, it is a v8.2 fault handling interrupt from the SMMU taken to EL3.

> 
> What do we intend to do with this error information? Does the DMA layer have
> error handling we can hook this into?

we can get the DMA layer error from the RAS registers, such as DMA read errors.
may be the handle method is disabling this SMMU to avoid propagation.

> 
> Is this just another interface for memory-errors? (e.g the SMMU provides a
> device/address pair and the kernel works out the physical page to run
> memory_failure() on)
I need to check more.

> 
> 
>> I check the UEFI_SPEC_2.7, the ACPI's CPER have the IOMMU type, but it
>> seems the IOMMU type only are specific to AMD’s IOMMU specification,
> 
> ... and Intel VT-d. It looks like UEFI generalises all these as types of 'DMAr'.
yes, it is.

> 
> 
>> not have the ARM’s IOMMU section type, can we reuse this IOMMU section
>> type for the ARM SMMU?
> 
> The architecture specific records for AMD? No. Even if the information was the
> same, the presence of this record tells you its an AMD IOMMU, which its not.
> 
> The generic error section? Maybe.
> 
> Assuming the 'fault reason' list in Table 285 is sufficient to cover our list or
> errors, we can use the 'DMAr Generic Errors' section, (N.2.11.1), to describe
> the generic bits of the error ... but SMMU doesn't have an 'Architecture Type',
> so we at least need to get one allocated.
> 
> We will probably need an architecture specific 'DMAr Error Section'.
> 
> 
> I think adding the UEFI bits is probably the 'easy' bit. We should start with a
> list of errors, and the error handling code. This way we know what we need to
> add to the spec.

The list of SMMU RAS error is shown below, but I still do not know how to handle it.
1. one bit ECC error
2. two bits ECC error
3. fetch error in the SMMUv3 spec

> 
> 
> 
> Thanks,
> 
> James
> 
> .
> 

