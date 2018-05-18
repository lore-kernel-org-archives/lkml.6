Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbeERJuD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:50:03 -0400
Received: from foss.arm.com ([217.140.101.70]:46374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752541AbeERJse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:48:34 -0400
Subject: Re: [PATCH v2 2/2] KVM: arm/arm64: harden unmap_stage2_ptes in case
 end is not PAGE_SIZE aligned
To: Jia He <hejianet@gmail.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: Suzuki.Poulose@arm.com, linux-kernel@vger.kernel.org,
        jia.he@hxt-semitech.com
References: <1526635630-18917-1-git-send-email-hejianet@gmail.com>
 <1526635630-18917-2-git-send-email-hejianet@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <2185a61e-c157-e177-9bad-83b6f27fd784@arm.com>
Date: Fri, 18 May 2018 10:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526635630-18917-2-git-send-email-hejianet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 10:27, Jia He wrote:
> If it passes addr=0x202920000,size=0xfe00 to unmap_stage2_range->
> ...->unmap_stage2_ptes, unmap_stage2_ptes will get addr=0x202920000,
> end=0x20292fe00. After first while loop addr=0x202930000, end=0x20292fe00,
> then addr!=end. Thus it will touch another pages by put_pages() in the
> 2nd loop.
> 
> This patch fixes it by hardening the break condition of while loop.
> 
> Signed-off-by: jia.he@hxt-semitech.com
> ---
> v2: newly added
> 
>  virt/kvm/arm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 8dac311..45cd040 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -217,7 +217,7 @@ static void unmap_stage2_ptes(struct kvm *kvm, pmd_t *pmd,
>  
>  			put_page(virt_to_page(pte));
>  		}
> -	} while (pte++, addr += PAGE_SIZE, addr != end);
> +	} while (pte++, addr += PAGE_SIZE, addr < end);
>  
>  	if (stage2_pte_table_empty(start_pte))
>  		clear_stage2_pmd_entry(kvm, pmd, start_addr);
> 

I don't think this change is the right thing to do. You get that failure
because you're being passed a size that is not a multiple of PAGE_SIZE.
That's the mistake.

You should ensure that this never happens, rather than changing the page
table walkers (which are consistent with the way this kind of code is
written in other places of the kernel). As you mentioned in your first
patch, the real issue is that KSM is broken, and this is what should be
fixed.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
