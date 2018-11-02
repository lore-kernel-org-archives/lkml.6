Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68E3C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB352084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB352084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbeKCDxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:53:49 -0400
Received: from foss.arm.com ([217.140.101.70]:45396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbeKCDxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:53:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D66E5A78;
        Fri,  2 Nov 2018 11:45:35 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DD2E3F71E;
        Fri,  2 Nov 2018 11:45:35 -0700 (PDT)
Date:   Fri, 2 Nov 2018 19:45:33 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Lance Roy <ldr709@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 16/16] KVM: arm/arm64: vgic: Replace spin_is_locked()
 with lockdep
Message-ID: <20181102184533.GA12057@e113682-lin.lund.arm.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-17-ldr709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003053902.6910-17-ldr709@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:39:02PM -0700, Lance Roy wrote:
> lockdep_assert_held() is better suited to checking locking requirements,
> since it won't get confused when someone else holds the lock. This is
> also a step towards possibly removing spin_is_locked().
> 
> Signed-off-by: Lance Roy <ldr709@gmail.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: <kvmarm@lists.cs.columbia.edu>

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

> ---
>  virt/kvm/arm/vgic/vgic.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> index 7cfdfbc910e0..50e25438fb3c 100644
> --- a/virt/kvm/arm/vgic/vgic.c
> +++ b/virt/kvm/arm/vgic/vgic.c
> @@ -196,7 +196,7 @@ void vgic_irq_set_phys_active(struct vgic_irq *irq, bool active)
>   */
>  static struct kvm_vcpu *vgic_target_oracle(struct vgic_irq *irq)
>  {
> -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
> +	lockdep_assert_held(&irq->irq_lock);
>  
>  	/* If the interrupt is active, it must stay on the current vcpu */
>  	if (irq->active)
> @@ -273,7 +273,7 @@ static void vgic_sort_ap_list(struct kvm_vcpu *vcpu)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  
> -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
> +	lockdep_assert_held(&vgic_cpu->ap_list_lock);
>  
>  	list_sort(NULL, &vgic_cpu->ap_list_head, vgic_irq_cmp);
>  }
> @@ -311,7 +311,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
>  {
>  	struct kvm_vcpu *vcpu;
>  
> -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
> +	lockdep_assert_held(&irq->irq_lock);
>  
>  retry:
>  	vcpu = vgic_target_oracle(irq);
> @@ -702,7 +702,7 @@ static inline void vgic_fold_lr_state(struct kvm_vcpu *vcpu)
>  static inline void vgic_populate_lr(struct kvm_vcpu *vcpu,
>  				    struct vgic_irq *irq, int lr)
>  {
> -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
> +	lockdep_assert_held(&irq->irq_lock);
>  
>  	if (kvm_vgic_global_state.type == VGIC_V2)
>  		vgic_v2_populate_lr(vcpu, irq, lr);
> @@ -736,7 +736,7 @@ static int compute_ap_list_depth(struct kvm_vcpu *vcpu,
>  
>  	*multi_sgi = false;
>  
> -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
> +	lockdep_assert_held(&vgic_cpu->ap_list_lock);
>  
>  	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
>  		int w;
> @@ -761,7 +761,7 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
>  	bool multi_sgi;
>  	u8 prio = 0xff;
>  
> -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
> +	lockdep_assert_held(&vgic_cpu->ap_list_lock);
>  
>  	count = compute_ap_list_depth(vcpu, &multi_sgi);
>  	if (count > kvm_vgic_global_state.nr_lr || multi_sgi)
> -- 
> 2.19.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
