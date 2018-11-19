Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4276A20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4276A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeKSXNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:13:10 -0500
Received: from foss.arm.com ([217.140.101.70]:56134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbeKSXNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:13:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9633A1596;
        Mon, 19 Nov 2018 04:49:37 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 196723F5AF;
        Mon, 19 Nov 2018 04:49:35 -0800 (PST)
Subject: Re: [PATCH] kvm: arm/arm64 : fix vm's hanging at startup time
To:     peng.hao2@zte.com.cn
Cc:     Mark Rutland <mark.rutland@arm.com>, julien.thierry@arm.com,
        andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        ard.bieshseuvel@linaro.org, leif.lindholm@linaro.org
References: <851b61b1-786b-ef64-b8c4-fe6926bdf9f9@arm.com>
 <201811171058376326562@zte.com.cn> <20181119091020.ejplmzkzo4jd72md@salmiak>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <01746207-c9bb-dc91-58d7-a66c0d971f88@arm.com>
Date:   Mon, 19 Nov 2018 12:49:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181119091020.ejplmzkzo4jd72md@salmiak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 09:10, Mark Rutland wrote:
> On Sat, Nov 17, 2018 at 10:58:37AM +0800, peng.hao2@zte.com.cn wrote:
>>> On 16/11/18 00:23, peng.hao2@zte.com.cn wrote:
>>>>> Hi,
>>>>>> When virtual machine starts, hang up.
>>>>>
>>>>> I take it you mean the *guest* hangs? Because it doesn't get a timer
>>>>> interrupt?
>>>>>
>>>>>> The kernel version of guest
>>>>>> is 4.16. Host support vgic_v3.
>>>>>
>>>>> Your host kernel is something recent, I guess?
>>>>>
>>>>>> It was mainly due to the incorrect vgic_irq's(intid=27) group value
>>>>>> during injection interruption. when kvm_vgic_vcpu_init is called,
>>>>>> dist is not initialized at this time. Unable to get vgic V3 or V2
>>>>>> correctly, so group is not set.
>>>>>
>>>>> Mmh, that shouldn't happen with (v)GICv3. Do you use QEMU (which
>>>>> version?) or some other userland tool?
>>>>>
>>>>
>>>> QEMU emulator version 3.0.50 .
>>>>
>>>>>> group is setted to 1 when vgic_mmio_write_group is invoked at some
>>>>>> time.
>>>>>> when irq->group=0 (intid=27), No ICH_LR_GROUP flag was set and
>>>>>> interrupt injection failed.
>>>>>>
>>>>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>>>>>> ---
>>>>>>   virt/kvm/arm/vgic/vgic-v3.c | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
>>>>>> index 9c0dd23..d101000 100644
>>>>>> --- a/virt/kvm/arm/vgic/vgic-v3.c
>>>>>> +++ b/virt/kvm/arm/vgic/vgic-v3.c
>>>>>> @@ -198,7 +198,7 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu,
>>>>>> struct vgic_irq *irq, int lr) if (vgic_irq_is_mapped_level(irq) &&
>>>>>> (val & ICH_LR_PENDING_BIT)) irq->line_level = false;
>>>>>>
>>>>>> -    if (irq->group)
>>>>>> +    if (model == KVM_DEV_TYPE_ARM_VGIC_V3)
>>>>>
>>>>> This is not the right fix, not only because it basically reverts the
>>>>> GICv3 part of 87322099052 (KVM: arm/arm64: vgic: Signal IRQs using
>>>>> their configured group).
>>>>>
>>>>> Can you try to work out why kvm_vgic_vcpu_init() is apparently called
>>>>> before dist->vgic_model is set, also what value it has?
>>>>> If I understand the code correctly, that shouldn't happen for a GICv3.
>>>>>
>>>> Even if the value of  group is correctly assigned in kvm_vgic_vcpu_init, the group is then written 0 through vgic_mmio_write_group.
>>>>   If the interrupt comes at this time, the interrupt injection fails.
>>>
>>> Does that mean that the guest is configuring its interrupts as Group0?
>>> That sounds wrong, Linux should configure all it's interrupts as
>>> non-secure group1.
>>
>> no, I think that uefi dose this, not linux.
>> 1. kvm_vgic_vcpu_init 
>> 2. vgic_create 
>> 3. kvm_vgic_dist_init 
>> 4.vgic_mmio_write_group: uefi as guest, write group=0
>> 5.vgic_mmio_write_group: linux as guest, write group=1
> 
> Is this the same issue fixed by EDK2 commit:
> 
> 66127011a544b90e ("ArmPkg/ArmGicDxe ARM: fix encoding for GICv3 interrupt acknowledge")
> 
> ... where EDK2 would try to use IAR0 rather than IAR1?
> 
> The commit messages notes this lead to a boot-time hang.

I managed to trigger an issue with a really old EFI implementation that
doesn't configure its interrupts as Group1, and yet tries to ACK its
interrupts using the Group1 accessor. Guess what? It is not going to work.

Commit c7fefb690661f2e38afcb8200bd318ecf38ab961 in the edk2 tree seems
to be the fix (I only assume it does, I haven't actually checked). A
recent build, as found in Debian Buster, works perfectly (tested with
both QEMU v2.12 and tip of tree).

Now, I really don't get what you're saying about Linux not getting
interrupts. How do you get to booting Linux if EFI is not making any
forward progress? Are you trying them independently?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
