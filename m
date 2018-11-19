Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2187FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2AB20817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2AB20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeKSTda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:33:30 -0500
Received: from foss.arm.com ([217.140.101.70]:52492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbeKSTd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:33:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B8F1596;
        Mon, 19 Nov 2018 01:10:28 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720DF3F5A0;
        Mon, 19 Nov 2018 01:10:26 -0800 (PST)
Date:   Mon, 19 Nov 2018 09:10:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     peng.hao2@zte.com.cn
Cc:     julien.thierry@arm.com, marc.zyngier@arm.com,
        andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        ard.bieshseuvel@linaro.org, leif.lindholm@linaro.org
Subject: Re: Re: [PATCH] kvm: arm/arm64 : fix vm's hanging at startup time
Message-ID: <20181119091020.ejplmzkzo4jd72md@salmiak>
References: <851b61b1-786b-ef64-b8c4-fe6926bdf9f9@arm.com>
 <201811171058376326562@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201811171058376326562@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 10:58:37AM +0800, peng.hao2@zte.com.cn wrote:
> >On 16/11/18 00:23, peng.hao2@zte.com.cn wrote:
> >>> Hi,
> >>>> When virtual machine starts, hang up.
> >>>
> >>> I take it you mean the *guest* hangs? Because it doesn't get a timer
> >>> interrupt?
> >>>
> >>>> The kernel version of guest
> >>>> is 4.16. Host support vgic_v3.
> >>>
> >>> Your host kernel is something recent, I guess?
> >>>
> >>>> It was mainly due to the incorrect vgic_irq's(intid=27) group value
> >>>> during injection interruption. when kvm_vgic_vcpu_init is called,
> >>>> dist is not initialized at this time. Unable to get vgic V3 or V2
> >>>> correctly, so group is not set.
> >>>
> >>> Mmh, that shouldn't happen with (v)GICv3. Do you use QEMU (which
> >>> version?) or some other userland tool?
> >>>
> >>
> >> QEMU emulator version 3.0.50 .
> >>
> >>>> group is setted to 1 when vgic_mmio_write_group is invoked at some
> >>>> time.
> >>>> when irq->group=0 (intid=27), No ICH_LR_GROUP flag was set and
> >>>> interrupt injection failed.
> >>>>
> >>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> >>>> ---
> >>>>   virt/kvm/arm/vgic/vgic-v3.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> >>>> index 9c0dd23..d101000 100644
> >>>> --- a/virt/kvm/arm/vgic/vgic-v3.c
> >>>> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> >>>> @@ -198,7 +198,7 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu,
> >>>> struct vgic_irq *irq, int lr) if (vgic_irq_is_mapped_level(irq) &&
> >>>> (val & ICH_LR_PENDING_BIT)) irq->line_level = false;
> >>>>
> >>>> -    if (irq->group)
> >>>> +    if (model == KVM_DEV_TYPE_ARM_VGIC_V3)
> >>>
> >>> This is not the right fix, not only because it basically reverts the
> >>> GICv3 part of 87322099052 (KVM: arm/arm64: vgic: Signal IRQs using
> >>> their configured group).
> >>>
> >>> Can you try to work out why kvm_vgic_vcpu_init() is apparently called
> >>> before dist->vgic_model is set, also what value it has?
> >>> If I understand the code correctly, that shouldn't happen for a GICv3.
> >>>
> >> Even if the value of  group is correctly assigned in kvm_vgic_vcpu_init, the group is then written 0 through vgic_mmio_write_group.
> >>   If the interrupt comes at this time, the interrupt injection fails.
> >
> >Does that mean that the guest is configuring its interrupts as Group0?
> >That sounds wrong, Linux should configure all it's interrupts as
> >non-secure group1.
> 
> no, I think that uefi dose this, not linux.
> 1. kvm_vgic_vcpu_init 
> 2. vgic_create 
> 3. kvm_vgic_dist_init 
> 4.vgic_mmio_write_group: uefi as guest, write group=0
> 5.vgic_mmio_write_group: linux as guest, write group=1

Is this the same issue fixed by EDK2 commit:

66127011a544b90e ("ArmPkg/ArmGicDxe ARM: fix encoding for GICv3 interrupt acknowledge")

... where EDK2 would try to use IAR0 rather than IAR1?

The commit messages notes this lead to a boot-time hang.

Thanks,
Mark.
