Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeBAKrN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:47:13 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37234 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeBAKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:47:10 -0500
X-Google-Smtp-Source: AH8x225Qh58c7O8iwl75VMl01V4h2CZkEAjuOs2/v/4W2DPy+OIlHOShA9pYWXwyKUMtxTeiosbpcg==
Date: Thu, 1 Feb 2018 11:47:07 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180201104707.GA21802@cbox>
References: <20180201125512.7bc96674@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201125512.7bc96674@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2018 at 12:55:12PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm tree got a conflict in:
> 
>   virt/kvm/arm/arch_timer.c
> 
> between commit:
> 
>   36e5cfd410ad ("KVM: arm/arm64: Properly handle arch-timer IRQs after vtimer_save_state")
> 
> from Linus' tree and commits:
> 
>   70450a9fbe06 ("KVM: arm/arm64: Don't cache the timer IRQ level")
>   13e59ece5b30 ("KVM: arm/arm64: Fix incorrect timer_is_pending logic")
> 
> from the kvm tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
While the suggested fix is functional it does result in some code
duplication, and the better resolution is the following:

diff --cc virt/kvm/arm/arch_timer.c
index cc29a8148328,fb6bd9b9845e..000000000000
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@@ -92,27 -92,18 +92,22 @@@ static irqreturn_t kvm_arch_timer_handl
  {
  	struct kvm_vcpu *vcpu = *(struct kvm_vcpu **)dev_id;
  	struct arch_timer_context *vtimer;
- 	u32 cnt_ctl;
  
 -	if (!vcpu) {
 -		pr_warn_once("Spurious arch timer IRQ on non-VCPU thread\n");
 -		return IRQ_NONE;
 -	}
 +	/*
 +	 * We may see a timer interrupt after vcpu_put() has been called which
 +	 * sets the CPU's vcpu pointer to NULL, because even though the timer
 +	 * has been disabled in vtimer_save_state(), the hardware interrupt
 +	 * signal may not have been retired from the interrupt controller yet.
 +	 */
 +	if (!vcpu)
 +		return IRQ_HANDLED;
  
  	vtimer = vcpu_vtimer(vcpu);
- 	if (!vtimer->irq.level) {
- 		cnt_ctl = read_sysreg_el0(cntv_ctl);
- 		cnt_ctl &= ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_STAT |
- 			   ARCH_TIMER_CTRL_IT_MASK;
- 		if (cnt_ctl == (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_STAT))
- 			kvm_timer_update_irq(vcpu, true, vtimer);
- 	}
+ 	if (kvm_timer_should_fire(vtimer))
+ 		kvm_timer_update_irq(vcpu, true, vtimer);
  
- 	if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
+ 	if (static_branch_unlikely(&userspace_irqchip_in_use) &&
+ 	    unlikely(!irqchip_in_kernel(vcpu->kvm)))
  		kvm_vtimer_update_mask_user(vcpu);
  
  	return IRQ_HANDLED;


Thanks,
-Christoffer
