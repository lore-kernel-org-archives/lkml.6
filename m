Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F7FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0642420825
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0642420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbeKOTuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:50:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58726 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387911AbeKOTuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:50:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07F9680D;
        Thu, 15 Nov 2018 01:42:58 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7C333F718;
        Thu, 15 Nov 2018 01:42:56 -0800 (PST)
Subject: Re: [PATCH] kvm: arm/arm64 : fix vm's hanging at startup time
To:     Peng Hao <peng.hao2@zte.com.cn>, christoffer.dall@arm.com,
        marc.zyngier@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <1542294848-73839-1-git-send-email-peng.hao2@zte.com.cn>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <63a0ea72-e0ce-b3e4-4fda-f1a359754cc5@arm.com>
Date:   Thu, 15 Nov 2018 09:42:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1542294848-73839-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 15/11/18 15:14, Peng Hao wrote:
> When virtual machine starts, hang up. The kernel version of guest
> is 4.16. Host support vgic_v3.

I don't understand the issue here. the vgic_irq->group field does not 
exist in 4.16 (neither in the first nor the last version). Nor does the 
line you are modifying.

Both exist in mainline, but what you are mentioning shouldn't be an 
issue in mainline since vgic_irq->group gets initialized in 
kvm_vgic_vcpu_init for SGIs and PPIs (i.e. intid < 32) which includes 
your interrupt.

Cheers,

> It was mainly due to the incorrect vgic_irq's(intid=27) group value
> during injection interruption. when kvm_vgic_vcpu_init is called,
> dist is not initialized at this time. Unable to get vgic V3 or V2
> correctly, so group is not set.
> group is setted to 1 when vgic_mmio_write_group is invoked at some
> time.
> when irq->group=0 (intid=27), No ICH_LR_GROUP flag was set and
> interrupt injection failed.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>   virt/kvm/arm/vgic/vgic-v3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index 9c0dd23..d101000 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -198,7 +198,7 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>   	if (vgic_irq_is_mapped_level(irq) && (val & ICH_LR_PENDING_BIT))
>   		irq->line_level = false;
>   
> -	if (irq->group)
> +	if (model == KVM_DEV_TYPE_ARM_VGIC_V3)
>   		val |= ICH_LR_GROUP;
>   
>   	val |= (u64)irq->priority << ICH_LR_PRIORITY_SHIFT;
> 

-- 
Julien Thierry
