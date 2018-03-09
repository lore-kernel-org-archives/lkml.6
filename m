Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeCIOVd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:21:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52674 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeCIOVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:21:32 -0500
Subject: Re: [PATCH] KVM:arm/arm64: dcache need be coherent unconditionally
To: Peng Hao <peng.hao2@zte.com.cn>, christoffer.dall@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <1520633703-15121-1-git-send-email-peng.hao2@zte.com.cn>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <90dba814-2aa3-e0e3-9021-4c349c9f9165@arm.com>
Date: Fri, 9 Mar 2018 14:21:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520633703-15121-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/18 22:15, Peng Hao wrote:
> For emulation devices just like vga, keeping coherent dcache between
> guest and host timely is needed.
> Now the display of vnc-viewer will not update continuously and the
> patch can fix up.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  virt/kvm/arm/mmu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index ec62d1c..4a28395e 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1416,8 +1416,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			kvm_set_pfn_dirty(pfn);
>  		}
>  
> -		if (fault_status != FSC_PERM)
> -			clean_dcache_guest_page(pfn, PMD_SIZE);
> +		clean_dcache_guest_page(pfn, PMD_SIZE);
>  
>  		if (exec_fault) {
>  			new_pmd = kvm_s2pmd_mkexec(new_pmd);
> @@ -1438,8 +1437,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			mark_page_dirty(kvm, gfn);
>  		}
>  
> -		if (fault_status != FSC_PERM)
> -			clean_dcache_guest_page(pfn, PAGE_SIZE);
> +		clean_dcache_guest_page(pfn, PAGE_SIZE);
>  
>  		if (exec_fault) {
>  			new_pte = kvm_s2pte_mkexec(new_pte);
> 

I'm sorry, but I have to NAK this.

You're papering over the fundamental issue that you're accessing a
cacheable alias of a non cacheable memory. The architecture is very
clear about why this doesn't work, and KVM implements the architecture.

If you want this to work, map your VGA device as cacheable, add cache
maintenance to QEMU, or use another frame-buffer emulation that doesn't
require such a gack.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
