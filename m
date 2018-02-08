Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBHLUI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 06:20:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33268 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbeBHLUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 06:20:07 -0500
Subject: Re: [PATCH v1 02/16] irqchip: gicv3-its: Add helpers for handling
 52bit address
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, kristina.martsenko@arm.com,
        peter.maydell@linaro.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, Shanker Donthineni <shankerd@codeaurora.org>
References: <20180109190414.4017-1-suzuki.poulose@arm.com>
 <20180109190414.4017-3-suzuki.poulose@arm.com> <20180207151023.GD29286@cbox>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <a9e37c29-3be0-8759-a8e3-3e0a273e151d@arm.com>
Date: Thu, 8 Feb 2018 11:20:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207151023.GD29286@cbox>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 15:10, Christoffer Dall wrote:
> Hi Suzuki,
> 
> On Tue, Jan 09, 2018 at 07:03:57PM +0000, Suzuki K Poulose wrote:
>> Add helpers for encoding/decoding 52bit address in GICv3 ITS BASER
>> register. When ITS uses 64K page size, the 52bits of physical address
>> are encoded in BASER[47:12] as follows :
>>
>>   Bits[47:16] of the register => bits[47:16] of the physical address
>>   Bits[15:12] of the register => bits[51:48] of the physical address
>>                                  bits[15:0] of the physical address are 0.
>>
>> Also adds a mask for CBASER address. This will be used for adding 52bit
>> support for VGIC ITS. More importantly ignore the upper bits if 52bit
>> support is not enabled.
>>
>> Cc: Shanker Donthineni <shankerd@codeaurora.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---


>> +
>> +/*
>> + * With 64K page size, the physical address can be upto 52bit and
>> + * uses the following encoding in the GITS_BASER[47:12]:
>> + *
>> + * Bits[47:16] of the register => bits[47:16] of the base physical address.
>> + * Bits[15:12] of the register => bits[51:48] of the base physical address.
>> + *                                bits[15:0] of the base physical address are 0.
>> + * Clear the upper bits if the kernel doesn't support 52bits.
>> + */
>> +#define GITS_BASER_ADDR64K_LO_MASK	GENMASK_ULL(47, 16)
>> +#define GITS_BASER_ADDR64K_HI_SHIFT	12
>> +#define GITS_BASER_ADDR64K_HI_MOVE	(48 - GITS_BASER_ADDR64K_HI_SHIFT)
>> +#define GITS_BASER_ADDR64K_HI_MASK	(GITS_PA_HI_MASK << GITS_BASER_ADDR64K_HI_SHIFT)
>> +#define GITS_BASER_ADDR64K_TO_PHYS(x)					\
>> +	(((x) & GITS_BASER_ADDR64K_LO_MASK) | 				\
>> +	 (((x) & GITS_BASER_ADDR64K_HI_MASK) << GITS_BASER_ADDR64K_HI_MOVE))
>> +#define GITS_BASER_ADDR64K_FROM_PHYS(p)					\
>> +	(((p) & GITS_BASER_ADDR64K_LO_MASK) | 				\
>> +	 (((p) >> GITS_BASER_ADDR64K_HI_MOVE) & GITS_BASER_ADDR64K_HI_MASK))
> 
> I don't understand why you need this masking logic embedded in these
> macros?  Isn't it strictly an error if anyone passes a physical address
> with any of bits [51:48] set to the ITS on a system that doesn't support
> 52 bit PAs, and just silently masking off those bits could lead to some
> interesting cases.

What do you think is the best way to handle such cases ? May be I could add
some checks where we get those addresses and handle it before we use this
macro ?

> 
> This is also notably more difficult to read than the existing macro.
> 
> If anything, I think it would be more useful to have
> GITS_BASER_TO_PHYS(x) and GITS_PHYS_TO_BASER(x) which takes into account
> CONFIG_ARM64_64K_PAGES.

I thought the 64K_PAGES is not kernel page size, but the page-size configured
by the "requester" for ITS. So, it doesn't really mean CONFIG_ARM64_64K_PAGES.
But the other way around, we can't handle 52bit address unless CONFIG_ARM64_64K_PAGES
is selected. Also, if the guest uses a 4K page size and uses a 48 bit address,
we could potentially mask Bits[15:12] to 0, which is not nice.

So I still think we need to have a special macro for handling addresses with 64K
page size in ITS.

Thanks
Suzuki
