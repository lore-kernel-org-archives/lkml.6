Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A65C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4566D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4566D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeKUAsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:48:02 -0500
Received: from foss.arm.com ([217.140.101.70]:49632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbeKUAsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:48:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1535BEBD;
        Tue, 20 Nov 2018 06:18:40 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78A303F5A0;
        Tue, 20 Nov 2018 06:18:34 -0800 (PST)
Date:   Tue, 20 Nov 2018 15:18:32 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] KVM: arm/arm64: vgic: Do not cond_resched_lock()
 with IRQs disabled
Message-ID: <20181120141832.GA11162@e113682-lin.lund.arm.com>
References: <1542647279-46609-1-git-send-email-julien.thierry@arm.com>
 <1542647279-46609-2-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542647279-46609-2-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:07:56PM +0000, Julien Thierry wrote:
> To change the active state of an MMIO, halt is requested for all vcpus of
> the affected guest before modifying the IRQ state. This is done by calling
> cond_resched_lock() in vgic_mmio_change_active(). However interrupts are
> disabled at this point and running a vcpu cannot get rescheduled.

"running a vcpu cannot get rescheduled" ?

> 
> Solve this by waiting for all vcpus to be halted after emmiting the halt
> request.
> 
> Fixes commit 6c1b7521f4a07cc63bbe2dfe290efed47cdb780a ("KVM: arm/arm64:
> Factor out functionality to get vgic mmio requester_vcpu")
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: stable@vger.kernel.org
> ---
>  virt/kvm/arm/vgic/vgic-mmio.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
> index f56ff1c..eefd877 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio.c
> @@ -313,27 +313,6 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
> 
>  	spin_lock_irqsave(&irq->irq_lock, flags);
> 
> -	/*
> -	 * If this virtual IRQ was written into a list register, we
> -	 * have to make sure the CPU that runs the VCPU thread has
> -	 * synced back the LR state to the struct vgic_irq.
> -	 *
> -	 * As long as the conditions below are true, we know the VCPU thread
> -	 * may be on its way back from the guest (we kicked the VCPU thread in
> -	 * vgic_change_active_prepare)  and still has to sync back this IRQ,
> -	 * so we release and re-acquire the spin_lock to let the other thread
> -	 * sync back the IRQ.
> -	 *
> -	 * When accessing VGIC state from user space, requester_vcpu is
> -	 * NULL, which is fine, because we guarantee that no VCPUs are running
> -	 * when accessing VGIC state from user space so irq->vcpu->cpu is
> -	 * always -1.
> -	 */
> -	while (irq->vcpu && /* IRQ may have state in an LR somewhere */
> -	       irq->vcpu != requester_vcpu && /* Current thread is not the VCPU thread */
> -	       irq->vcpu->cpu != -1) /* VCPU thread is running */
> -		cond_resched_lock(&irq->irq_lock);
> -
>  	if (irq->hw) {
>  		vgic_hw_irq_change_active(vcpu, irq, active, !requester_vcpu);
>  	} else {
> @@ -368,8 +347,18 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
>   */
>  static void vgic_change_active_prepare(struct kvm_vcpu *vcpu, u32 intid)
>  {
> -	if (intid > VGIC_NR_PRIVATE_IRQS)
> +	if (intid > VGIC_NR_PRIVATE_IRQS) {
> +		struct kvm_vcpu *tmp;
> +		int i;
> +
>  		kvm_arm_halt_guest(vcpu->kvm);
> +
> +		/* Wait for each vcpu to be halted */
> +		kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
> +			while (tmp->cpu != -1)
> +				cond_resched();

We used to have something like this which Andre then found out it could
deadlock the system, because the VCPU making this request wouldn't have
called kvm_arch_vcpu_put, and its cpu value would still have a value.

That's why we have the vcpu && vcpu != requester check.


Thanks,

    Christoffer
