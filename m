Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeBABzR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:55:17 -0500
Received: from ozlabs.org ([103.22.144.67]:50235 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeBABzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:55:15 -0500
Date: Thu, 1 Feb 2018 12:55:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>
Subject: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180201125512.7bc96674@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  virt/kvm/arm/arch_timer.c

between commit:

  36e5cfd410ad ("KVM: arm/arm64: Properly handle arch-timer IRQs after vtimer_save_state")

from Linus' tree and commits:

  70450a9fbe06 ("KVM: arm/arm64: Don't cache the timer IRQ level")
  13e59ece5b30 ("KVM: arm/arm64: Fix incorrect timer_is_pending logic")

from the kvm tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc virt/kvm/arm/arch_timer.c
index cc29a8148328,fb6bd9b9845e..000000000000
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@@ -92,27 -92,18 +92,26 @@@ static irqreturn_t kvm_arch_timer_handl
  {
  	struct kvm_vcpu *vcpu = *(struct kvm_vcpu **)dev_id;
  	struct arch_timer_context *vtimer;
 +	u32 cnt_ctl;
  
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
- 
- 	if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
 -	if (kvm_timer_should_fire(vtimer))
++	cnt_ctl = read_sysreg_el0(cntv_ctl);
++	cnt_ctl &= ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_STAT |
++		   ARCH_TIMER_CTRL_IT_MASK;
++	if (cnt_ctl == (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_STAT))
+ 		kvm_timer_update_irq(vcpu, true, vtimer);
+ 
+ 	if (static_branch_unlikely(&userspace_irqchip_in_use) &&
+ 	    unlikely(!irqchip_in_kernel(vcpu->kvm)))
  		kvm_vtimer_update_mask_user(vcpu);
  
  	return IRQ_HANDLED;
