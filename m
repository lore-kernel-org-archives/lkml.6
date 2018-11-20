Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A3DC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83692075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83692075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeKUBHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:07:17 -0500
Received: from foss.arm.com ([217.140.101.70]:49976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbeKUBHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:07:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E405EBD;
        Tue, 20 Nov 2018 06:37:49 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EDF83F5A0;
        Tue, 20 Nov 2018 06:37:47 -0800 (PST)
Subject: Re: [PATCH 1/4] KVM: arm/arm64: vgic: Do not cond_resched_lock() with
 IRQs disabled
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de, stable@vger.kernel.org
References: <1542647279-46609-1-git-send-email-julien.thierry@arm.com>
 <1542647279-46609-2-git-send-email-julien.thierry@arm.com>
 <20181120141832.GA11162@e113682-lin.lund.arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <0e12d8a7-2a76-e04a-ab18-ed9fc69d5d47@arm.com>
Date:   Tue, 20 Nov 2018 14:37:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120141832.GA11162@e113682-lin.lund.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 14:18, Christoffer Dall wrote:
> On Mon, Nov 19, 2018 at 05:07:56PM +0000, Julien Thierry wrote:
>> To change the active state of an MMIO, halt is requested for all vcpus of
>> the affected guest before modifying the IRQ state. This is done by calling
>> cond_resched_lock() in vgic_mmio_change_active(). However interrupts are
>> disabled at this point and running a vcpu cannot get rescheduled.
> 
> "running a vcpu cannot get rescheduled" ?
> 
>>
>> Solve this by waiting for all vcpus to be halted after emmiting the halt
>> request.
>>
>> Fixes commit 6c1b7521f4a07cc63bbe2dfe290efed47cdb780a ("KVM: arm/arm64:
>> Factor out functionality to get vgic mmio requester_vcpu")
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  virt/kvm/arm/vgic/vgic-mmio.c | 33 +++++++++++----------------------
>>  1 file changed, 11 insertions(+), 22 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
>> index f56ff1c..eefd877 100644
>> --- a/virt/kvm/arm/vgic/vgic-mmio.c
>> +++ b/virt/kvm/arm/vgic/vgic-mmio.c
>> @@ -313,27 +313,6 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
>>
>>  	spin_lock_irqsave(&irq->irq_lock, flags);
>>
>> -	/*
>> -	 * If this virtual IRQ was written into a list register, we
>> -	 * have to make sure the CPU that runs the VCPU thread has
>> -	 * synced back the LR state to the struct vgic_irq.
>> -	 *
>> -	 * As long as the conditions below are true, we know the VCPU thread
>> -	 * may be on its way back from the guest (we kicked the VCPU thread in
>> -	 * vgic_change_active_prepare)  and still has to sync back this IRQ,
>> -	 * so we release and re-acquire the spin_lock to let the other thread
>> -	 * sync back the IRQ.
>> -	 *
>> -	 * When accessing VGIC state from user space, requester_vcpu is
>> -	 * NULL, which is fine, because we guarantee that no VCPUs are running
>> -	 * when accessing VGIC state from user space so irq->vcpu->cpu is
>> -	 * always -1.
>> -	 */
>> -	while (irq->vcpu && /* IRQ may have state in an LR somewhere */
>> -	       irq->vcpu != requester_vcpu && /* Current thread is not the VCPU thread */
>> -	       irq->vcpu->cpu != -1) /* VCPU thread is running */
>> -		cond_resched_lock(&irq->irq_lock);
>> -
>>  	if (irq->hw) {
>>  		vgic_hw_irq_change_active(vcpu, irq, active, !requester_vcpu);
>>  	} else {
>> @@ -368,8 +347,18 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
>>   */
>>  static void vgic_change_active_prepare(struct kvm_vcpu *vcpu, u32 intid)
>>  {
>> -	if (intid > VGIC_NR_PRIVATE_IRQS)
>> +	if (intid > VGIC_NR_PRIVATE_IRQS) {
>> +		struct kvm_vcpu *tmp;
>> +		int i;
>> +
>>  		kvm_arm_halt_guest(vcpu->kvm);
>> +
>> +		/* Wait for each vcpu to be halted */
>> +		kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
>> +			while (tmp->cpu != -1)
>> +				cond_resched();
> 
> We used to have something like this which Andre then found out it could
> deadlock the system, because the VCPU making this request wouldn't have
> called kvm_arch_vcpu_put, and its cpu value would still have a value.
> 
> That's why we have the vcpu && vcpu != requester check.

Ah, I now remember that one. I guess it is a matter of skipping the
requester vcpu in the kvm_for_each_vcpu loop.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
