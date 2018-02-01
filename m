Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeBAMkT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:40:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49556 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbeBAMkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:40:18 -0500
Subject: Re: [PATCH v3 15/18] arm/arm64: smccc: Make function identifiers an
 unsigned quantity
To: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Jones <drjones@redhat.com>, Hanjun Guo <guohanjun@huawei.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jon Masters <jcm@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20180201114657.7323-1-marc.zyngier@arm.com>
 <20180201114657.7323-16-marc.zyngier@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1c07ecaa-0a60-284d-1b85-0b4ea4522c48@arm.com>
Date: Thu, 1 Feb 2018 12:40:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180201114657.7323-16-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 11:46, Marc Zyngier wrote:
> Function identifiers are a 32bit, unsigned quantity. But we never
> tell so to the compiler, resulting in the following:
> 
>   4ac:   b26187e0        mov     x0, #0xffffffff80000001
> 
> We thus rely on the firmware narrowing it for us, which is not
> always a reasonable expectation.

I think technically it might be OK, since SMCCC states "A Function 
Identifier is passed in register W0.", which implies that a conforming 
implementation should also read w0, not x0, but it's certainly far 
easier to be completely right than to justify being possibly wrong.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: stable@vger.kernel.org
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   include/linux/arm-smccc.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index e1ef944ef1da..dd44d8458c04 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -14,14 +14,16 @@
>   #ifndef __LINUX_ARM_SMCCC_H
>   #define __LINUX_ARM_SMCCC_H
>   
> +#include <uapi/linux/const.h>
> +
>   /*
>    * This file provides common defines for ARM SMC Calling Convention as
>    * specified in
>    * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
>    */
>   
> -#define ARM_SMCCC_STD_CALL		0
> -#define ARM_SMCCC_FAST_CALL		1
> +#define ARM_SMCCC_STD_CALL	        _AC(0,U)
> +#define ARM_SMCCC_FAST_CALL	        _AC(1,U)
>   #define ARM_SMCCC_TYPE_SHIFT		31
>   
>   #define ARM_SMCCC_SMC_32		0
> 
