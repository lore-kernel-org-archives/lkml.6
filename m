Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85DFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902EF21A38
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902EF21A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbeHFQXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:23:16 -0400
Received: from foss.arm.com ([217.140.101.70]:39716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbeHFQXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:23:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 579C27A9;
        Mon,  6 Aug 2018 07:13:58 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE1103F5D0;
        Mon,  6 Aug 2018 07:13:57 -0700 (PDT)
Date:   Mon, 6 Aug 2018 16:13:55 +0200
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Jia He <hejianet@gmail.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
Subject: Re: [PATCH 2/2] KVM: arm/arm64: vgic: no need to call
 spin_lock_irqsave/restore when irq is disabled
Message-ID: <20180806141355.GF5985@e113682-lin.lund.arm.com>
References: <1533304624-43250-1-git-send-email-jia.he@hxt-semitech.com>
 <1533304624-43250-2-git-send-email-jia.he@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533304624-43250-2-git-send-email-jia.he@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 09:57:04PM +0800, Jia He wrote:
> Because kvm_vgic_sync_hwstate currently is definitly in the context
> which irq is disabled (local_irq_disable/enable). There is no need to
> call spin_lock_irqsave/restore in vgic_fold_lr_state and vgic_prune_ap_list
> 
> This patch replace them with the spin_lock/unlock no irq version
> 
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  virt/kvm/arm/vgic/vgic-v2.c |  7 ++++---
>  virt/kvm/arm/vgic/vgic-v3.c |  7 ++++---
>  virt/kvm/arm/vgic/vgic.c    | 13 +++++++------
>  3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
> index a5f2e44..487f5f2 100644
> --- a/virt/kvm/arm/vgic/vgic-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-v2.c
> @@ -62,7 +62,8 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	struct vgic_v2_cpu_if *cpuif = &vgic_cpu->vgic_v2;
>  	int lr;
> -	unsigned long flags;
> +
> +	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
>  
>  	cpuif->vgic_hcr &= ~GICH_HCR_UIE;
>  
> @@ -83,7 +84,7 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
>  
>  		irq = vgic_get_irq(vcpu->kvm, vcpu, intid);
>  
> -		spin_lock_irqsave(&irq->irq_lock, flags);
> +		spin_lock(&irq->irq_lock);
>  
>  		/* Always preserve the active bit */
>  		irq->active = !!(val & GICH_LR_ACTIVE_BIT);
> @@ -126,7 +127,7 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
>  				vgic_irq_set_phys_active(irq, false);
>  		}
>  
> -		spin_unlock_irqrestore(&irq->irq_lock, flags);
> +		spin_unlock(&irq->irq_lock);
>  		vgic_put_irq(vcpu->kvm, irq);
>  	}
>  
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index cdce653..b66b513 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -46,7 +46,8 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
>  	struct vgic_v3_cpu_if *cpuif = &vgic_cpu->vgic_v3;
>  	u32 model = vcpu->kvm->arch.vgic.vgic_model;
>  	int lr;
> -	unsigned long flags;
> +
> +	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
>  
>  	cpuif->vgic_hcr &= ~ICH_HCR_UIE;
>  
> @@ -75,7 +76,7 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
>  		if (!irq)	/* An LPI could have been unmapped. */
>  			continue;
>  
> -		spin_lock_irqsave(&irq->irq_lock, flags);
> +		spin_lock(&irq->irq_lock);
>  
>  		/* Always preserve the active bit */
>  		irq->active = !!(val & ICH_LR_ACTIVE_BIT);
> @@ -118,7 +119,7 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
>  				vgic_irq_set_phys_active(irq, false);
>  		}
>  
> -		spin_unlock_irqrestore(&irq->irq_lock, flags);
> +		spin_unlock(&irq->irq_lock);
>  		vgic_put_irq(vcpu->kvm, irq);
>  	}
>  
> diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> index c22cea6..7cfdfbc 100644
> --- a/virt/kvm/arm/vgic/vgic.c
> +++ b/virt/kvm/arm/vgic/vgic.c
> @@ -593,10 +593,11 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	struct vgic_irq *irq, *tmp;
> -	unsigned long flags;
> +
> +	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
>  
>  retry:
> -	spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
> +	spin_lock(&vgic_cpu->ap_list_lock);
>  
>  	list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
>  		struct kvm_vcpu *target_vcpu, *vcpuA, *vcpuB;
> @@ -637,7 +638,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
>  		/* This interrupt looks like it has to be migrated. */
>  
>  		spin_unlock(&irq->irq_lock);
> -		spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
> +		spin_unlock(&vgic_cpu->ap_list_lock);
>  
>  		/*
>  		 * Ensure locking order by always locking the smallest
> @@ -651,7 +652,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
>  			vcpuB = vcpu;
>  		}
>  
> -		spin_lock_irqsave(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
> +		spin_lock(&vcpuA->arch.vgic_cpu.ap_list_lock);
>  		spin_lock_nested(&vcpuB->arch.vgic_cpu.ap_list_lock,
>  				 SINGLE_DEPTH_NESTING);
>  		spin_lock(&irq->irq_lock);
> @@ -676,7 +677,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
>  
>  		spin_unlock(&irq->irq_lock);
>  		spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
> -		spin_unlock_irqrestore(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
> +		spin_unlock(&vcpuA->arch.vgic_cpu.ap_list_lock);
>  
>  		if (target_vcpu_needs_kick) {
>  			kvm_make_request(KVM_REQ_IRQ_PENDING, target_vcpu);
> @@ -686,7 +687,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
>  		goto retry;
>  	}
>  
> -	spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
> +	spin_unlock(&vgic_cpu->ap_list_lock);
>  }
>  
>  static inline void vgic_fold_lr_state(struct kvm_vcpu *vcpu)
> -- 
> 1.8.3.1
> 
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
