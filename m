Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F401BECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95C621525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95C621525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbeITQFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:05:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732238AbeITQFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:05:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E91330917AF;
        Thu, 20 Sep 2018 10:22:24 +0000 (UTC)
Received: from [10.36.117.87] (ovpn-117-87.ams2.redhat.com [10.36.117.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 239466963D;
        Thu, 20 Sep 2018 10:22:18 +0000 (UTC)
Subject: Re: [PATCH v5 06/18] kvm: arm/arm64: Allow arch specific
 configurations for VM
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, dave.martin@arm.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-7-suzuki.poulose@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <27461411-7c9d-7ea4-da39-b8f4628911ef@redhat.com>
Date:   Thu, 20 Sep 2018 12:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180917104144.19188-7-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 20 Sep 2018 10:22:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
> Allow the arch backends to perform VM specific initialisation.
> This will be later used to handle IPA size configuration and per-VM
> VTCR configuration on arm64.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  arch/arm/include/asm/kvm_host.h   | 7 +++++++
>  arch/arm64/include/asm/kvm_host.h | 2 ++
>  arch/arm64/kvm/reset.c            | 7 +++++++
>  virt/kvm/arm/arm.c                | 5 +++--
>  4 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 3ad482d2f1eb..72d46418e1ef 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -354,4 +354,11 @@ static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
>  struct kvm *kvm_arch_alloc_vm(void);
>  void kvm_arch_free_vm(struct kvm *kvm);
>  
> +static inline int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
> +{
> +	if (type)
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  #endif /* __ARM_KVM_HOST_H__ */
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 3d6d7336f871..b04280ae1be0 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -513,4 +513,6 @@ void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu);
>  struct kvm *kvm_arch_alloc_vm(void);
>  void kvm_arch_free_vm(struct kvm *kvm);
>  
> +int kvm_arm_config_vm(struct kvm *kvm, unsigned long type);
> +
>  #endif /* __ARM64_KVM_HOST_H__ */
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index e37c78bbe1ca..b0c07dab5cb3 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -133,3 +133,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	/* Reset timer */
>  	return kvm_timer_vcpu_reset(vcpu);
>  }
> +
> +int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
> +{
> +	if (type)
> +		return -EINVAL;
> +	return 0;
> +}
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index c92053bc3f96..327d0fd28380 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -120,8 +120,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  {
>  	int ret, cpu;
>  
> -	if (type)
> -		return -EINVAL;
> +	ret = kvm_arm_config_vm(kvm, type);
> +	if (ret)
> +		return ret;
>  
>  	kvm->arch.last_vcpu_ran = alloc_percpu(typeof(*kvm->arch.last_vcpu_ran));
>  	if (!kvm->arch.last_vcpu_ran)
> 
