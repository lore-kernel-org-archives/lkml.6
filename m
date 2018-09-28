Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB54C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D94920676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D94920676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbeI1Xw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:52:28 -0400
Received: from foss.arm.com ([217.140.101.70]:54024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbeI1Xw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:52:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8811418A;
        Fri, 28 Sep 2018 10:27:41 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FA7C3F5BD;
        Fri, 28 Sep 2018 10:27:39 -0700 (PDT)
Subject: Re: [PATCH v6 06/18] kvm: arm/arm64: Allow arch specific
 configurations for VM
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        cdall@kernel.org, eric.auger@redhat.com, will.deacon@arm.com,
        dave.martin@arm.com, peter.maydell@linaro.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
 <20180926163258.20218-7-suzuki.poulose@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <fbca190b-473b-5dee-67be-c724392fd297@arm.com>
Date:   Fri, 28 Sep 2018 18:27:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926163258.20218-7-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 26/09/18 17:32, Suzuki K Poulose wrote:
> Allow the arch backends to perform VM specific initialisation.
> This will be later used to handle IPA size configuration and per-VM
> VTCR configuration on arm64.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm/include/asm/kvm_host.h   | 7 +++++++
>   arch/arm64/include/asm/kvm_host.h | 2 ++
>   arch/arm64/kvm/reset.c            | 7 +++++++
>   virt/kvm/arm/arm.c                | 5 +++--
>   4 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 3ad482d2f1eb..72d46418e1ef 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -354,4 +354,11 @@ static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
>   struct kvm *kvm_arch_alloc_vm(void);
>   void kvm_arch_free_vm(struct kvm *kvm);
>   
> +static inline int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)

This is a bit of a nit, but VM is a bit of an overloaded term in this 
context. Given what we do in the following patch (moving the global 
stage-2 init to be on a per VM -- virtual machine), I'd like to rename 
this to something less ambiguous.

How about kvm_arm_config_stage2? Or something along those lines?

No need to respin the series on this account, we can address it in a 
separate patch. But I think it would help understanding what is done where.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
