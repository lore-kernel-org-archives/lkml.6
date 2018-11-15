Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26623C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7702086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7702086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbeKPArR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:47:17 -0500
Received: from foss.arm.com ([217.140.101.70]:34884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbeKPArR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:47:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A42AEBD;
        Thu, 15 Nov 2018 06:39:11 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 494673F5CF;
        Thu, 15 Nov 2018 06:39:10 -0800 (PST)
Date:   Thu, 15 Nov 2018 14:39:06 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  kvm: arm/arm64 : fix vm's hanging at startup time
Message-ID: <20181115143906.5c2302d5@donnerap.cambridge.arm.com>
In-Reply-To: <1542294848-73839-1-git-send-email-peng.hao2@zte.com.cn>
References: <1542294848-73839-1-git-send-email-peng.hao2@zte.com.cn>
Organization: ARM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 23:14:08 +0800
Peng Hao <peng.hao2@zte.com.cn> wrote:

Hi,

> When virtual machine starts, hang up.

I take it you mean the *guest* hangs? Because it doesn't get a timer
interrupt?

> The kernel version of guest
> is 4.16. Host support vgic_v3.

Your host kernel is something recent, I guess?

> It was mainly due to the incorrect vgic_irq's(intid=27) group value
> during injection interruption. when kvm_vgic_vcpu_init is called,
> dist is not initialized at this time. Unable to get vgic V3 or V2
> correctly, so group is not set.

Mmh, that shouldn't happen with (v)GICv3. Do you use QEMU (which
version?) or some other userland tool?

> group is setted to 1 when vgic_mmio_write_group is invoked at some
> time.
> when irq->group=0 (intid=27), No ICH_LR_GROUP flag was set and
> interrupt injection failed.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  virt/kvm/arm/vgic/vgic-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index 9c0dd23..d101000 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -198,7 +198,7 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu,
> struct vgic_irq *irq, int lr) if (vgic_irq_is_mapped_level(irq) &&
> (val & ICH_LR_PENDING_BIT)) irq->line_level = false;
>  
> -	if (irq->group)
> +	if (model == KVM_DEV_TYPE_ARM_VGIC_V3)

This is not the right fix, not only because it basically reverts the
GICv3 part of 87322099052 (KVM: arm/arm64: vgic: Signal IRQs using
their configured group).

Can you try to work out why kvm_vgic_vcpu_init() is apparently called
before dist->vgic_model is set, also what value it has?
If I understand the code correctly, that shouldn't happen for a GICv3.

Cheers,
Andre.

>  		val |= ICH_LR_GROUP;
>  
>  	val |= (u64)irq->priority << ICH_LR_PRIORITY_SHIFT;

