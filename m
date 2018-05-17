Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeEQPDW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:03:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeEQPDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:03:21 -0400
Subject: Re: [PATCH] KVM: arm/arm64: add WARN_ON if size is not PAGE_SIZE
 aligned in unmap_stage2_range
To: Jia He <hejianet@gmail.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Minchan Kim <minchan@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jia.he@hxt-semitech.com
References: <1526537487-14804-1-git-send-email-hejianet@gmail.com>
 <698b0355-d430-86b8-cd09-83c6d9e566f8@arm.com>
 <fbb269c0-e915-a9f2-da3b-5ae3a2b31396@gmail.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <25dbb8c1-631f-c810-4d75-349a0b291cf8@arm.com>
Date: Thu, 17 May 2018 16:03:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fbb269c0-e915-a9f2-da3b-5ae3a2b31396@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/18 13:46, Jia He wrote:
> Hi Suzuki
> 
> On 5/17/2018 4:17 PM, Suzuki K Poulose Wrote:
>>
>> Hi Jia,
>>
>> On 17/05/18 07:11, Jia He wrote:
>>> I ever met a panic under memory pressure tests(start 20 guests and run
>>> memhog in the host).
>>
>> Please avoid using "I" in the commit description and preferably stick to
>> an objective description.
> 
> Thanks for the pointing
> 
>>
>>>
>>> The root cause might be what I fixed at [1]. But from arm kvm points of
>>> view, it would be better we caught the exception earlier and clearer.
>>>
>>> If the size is not PAGE_SIZE aligned, unmap_stage2_range might unmap the
>>> wrong(more or less) page range. Hence it caused the "BUG: Bad page
>>> state"
>>
>> I don't see why we should ever panic with a "positive" size value. Anyways,
>> the unmap requests must be in units of pages. So this check might be useful.
>>
>>
> 
> good question,
> 
> After further digging, maybe we need to harden the break condition as below?
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 7f6a944..dac9b2e 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -217,7 +217,7 @@ static void unmap_stage2_ptes(struct kvm *kvm, pmd_t *pmd,
> 
>                          put_page(virt_to_page(pte));
>                  }
> -       } while (pte++, addr += PAGE_SIZE, addr != end);
> +       } while (pte++, addr += PAGE_SIZE, addr < end);

I don't think this change is need as stage2_pgd_addr_end(addr, end) must return
the smaller of the next entry or end. Thus we can't miss "addr" == "end".

Suzuki
