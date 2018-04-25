Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755346AbeDYQhx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:37:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42846 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754649AbeDYQhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:37:50 -0400
Subject: Re: [PATCH v2 09/17] kvm: arm64: Make stage2 page table layout
 dynamic
To: Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: ard.biesheuvel@linaro.org, kvm@vger.kernel.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kristina.martsenko@arm.com,
        pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
References: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
 <1522156531-28348-10-git-send-email-suzuki.poulose@arm.com>
 <2359e848-8068-ea25-e44e-e8cfcbc9b467@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <47e8d106-524b-67d3-9220-69569d5e7195@arm.com>
Date: Wed, 25 Apr 2018 17:37:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2359e848-8068-ea25-e44e-e8cfcbc9b467@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/18 17:35, Julien Grall wrote:
> Hi Suzuki,
> 
> On 27/03/18 14:15, Suzuki K Poulose wrote:
>> So far we had a static stage2 page table handling code, based on a
>> fixed IPA of 40bits. As we prepare for a configurable IPA size per
>> VM, make the our stage2 page table code dynamic to do the right thing
>> for a given VM.
>>
>> Support for the IPA size configuration needs other changes in the way
>> we configure the EL2 registers (VTTBR and VTCR). So, the IPA is still
>> fixed to 40bits. The patch also moves the kvm_page_empty() in asm/kvm_mmu.h
>> to the top, before including the asm/stage2_pgtable.h to avoid a forward
>> declaration.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/kvm_mmu.h              |  16 +-
>>   arch/arm64/include/asm/stage2_pgtable-nopmd.h |  42 ------
>>   arch/arm64/include/asm/stage2_pgtable-nopud.h |  39 -----
>>   arch/arm64/include/asm/stage2_pgtable.h       | 203 +++++++++++++++++---------
>>   4 files changed, 145 insertions(+), 155 deletions(-)
>>   delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopmd.h
>>   delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopud.h
>>
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index 594c4e6..bc133ce 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -18,9 +18,10 @@
>>   #ifndef __ARM64_KVM_MMU_H__
>>   #define __ARM64_KVM_MMU_H__
>> +#include <asm/cpufeature.h>
>>   #include <asm/page.h>
>>   #include <asm/memory.h>
>> -#include <asm/cpufeature.h>
> 
> OOI, why was the include of cpufeature.h moved earlier?

I think it was a minor cleanup to keep the includes in order. I will either
mention it or drop it from the hunk altogether.

Cheers
Suzuki
