Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeBHLAw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 06:00:52 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35441 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeBHLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 06:00:50 -0500
X-Google-Smtp-Source: AH8x2241WjaJ2bJZDn674noY8MkagGSNkeqf9zohgNZ1rHzpJOnHJTWbMm/S8ZfwuAbmscqt1hpvYQ==
Date: Thu, 8 Feb 2018 12:00:47 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, kristina.martsenko@arm.com,
        peter.maydell@linaro.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, Christoffer Dall <cdall@linaro.org>
Subject: Re: [PATCH v1 06/16] kvm: arm/arm64: Fix stage2_flush_memslot for 4
 level page table
Message-ID: <20180208110047.GI29286@cbox>
References: <20180109190414.4017-1-suzuki.poulose@arm.com>
 <20180109190414.4017-7-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109190414.4017-7-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2018 at 07:04:01PM +0000, Suzuki K Poulose wrote:
> So far we have only supported 3 level page table with fixed IPA of 40bits.
> Fix stage2_flush_memslot() to accommodate for 4 level tables.
> 

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 761787befd3b..e6548c85c495 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -375,7 +375,8 @@ static void stage2_flush_memslot(struct kvm *kvm,
>  	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
>  	do {
>  		next = stage2_pgd_addr_end(addr, end);
> -		stage2_flush_puds(kvm, pgd, addr, next);
> +		if (!stage2_pgd_none(*pgd))
> +			stage2_flush_puds(kvm, pgd, addr, next);
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> -- 
> 2.13.6
> 
