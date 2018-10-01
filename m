Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8330FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FBC208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FBC208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbeJAUvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:51:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49866 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbeJAUvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:51:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 897C57A9;
        Mon,  1 Oct 2018 07:13:19 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 601BA3F5B3;
        Mon,  1 Oct 2018 07:13:17 -0700 (PDT)
Subject: Re: [kvmtool PATCH v6 22/18] kvmtool: arm: Add support for creating
 VM with PA size
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        cdall@kernel.org, eric.auger@redhat.com, will.deacon@arm.com,
        dave.martin@arm.com, peter.maydell@linaro.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
 <20180926163258.20218-23-suzuki.poulose@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <0efe3696-e6fd-531d-c473-9dedf6b9d057@arm.com>
Date:   Mon, 1 Oct 2018 15:13:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926163258.20218-23-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/18 17:32, Suzuki K Poulose wrote:
> Specify the physical size for the VM encoded in the vm type.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arm/include/arm-common/kvm-arch.h |  6 +++++-
>   arm/kvm.c                         | 32 +++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
> index b29b4b1..d77f3ac 100644
> --- a/arm/include/arm-common/kvm-arch.h
> +++ b/arm/include/arm-common/kvm-arch.h
> @@ -44,7 +44,11 @@
>   
>   #define KVM_IRQ_OFFSET		GIC_SPI_IRQ_BASE
>   
> -#define KVM_VM_TYPE		0
> +extern unsigned long		kvm_arm_type;
> +extern void kvm__arch_init_hyp(struct kvm *kvm);
> +
> +#define KVM_VM_TYPE		kvm_arm_type
> +#define kvm__arch_init_hyp	kvm__arch_init_hyp
>   
>   #define VIRTIO_DEFAULT_TRANS(kvm)	\
>   	((kvm)->cfg.arch.virtio_trans_pci ? VIRTIO_PCI : VIRTIO_MMIO)
> diff --git a/arm/kvm.c b/arm/kvm.c
> index eac2ad2..c8db6b3 100644
> --- a/arm/kvm.c
> +++ b/arm/kvm.c
> @@ -11,6 +11,8 @@
>   #include <linux/kvm.h>
>   #include <linux/sizes.h>
>   
> +unsigned long kvm_arm_type;
> +
>   struct kvm_ext kvm_req_ext[] = {
>   	{ DEFINE_KVM_EXT(KVM_CAP_IRQCHIP) },
>   	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
> @@ -18,6 +20,36 @@ struct kvm_ext kvm_req_ext[] = {
>   	{ 0, 0 },
>   };
>   
> +#ifndef KVM_CAP_ARM_VM_IPA_SIZE
> +#define KVM_CAP_ARM_VM_IPA_SIZE	159
> +#endif

Note that when merged on top of 4.19-rc5, this is already 160. I assume 
this will be even different once this lands in mainline.

Thanks,

	M.

> +
> +#ifndef KVM_VM_TYPE_ARM_IPA_SIZE
> +#define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
> +#define KVM_VM_TYPE_ARM_IPA_SIZE(x)	\
> +	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
> +#endif
> +
> +void kvm__arch_init_hyp(struct kvm *kvm)
> +{
> +	int max_ipa;
> +
> +	if (!kvm->cfg.arch.phys_shift)
> +		kvm->cfg.arch.phys_shift = 40;
> +	if (kvm->cfg.arch.phys_shift == 40)
> +		return;
> +	max_ipa = ioctl(kvm->sys_fd,
> +			KVM_CHECK_EXTENSION, KVM_CAP_ARM_VM_IPA_SIZE);
> +	if (!max_ipa)
> +		die("Kernel doesn't support IPA size configuration\n");
> +	if ((kvm->cfg.arch.phys_shift > max_ipa) ||
> +	    (kvm->cfg.arch.phys_shift < 32))
> +		die("Requested PA size (%u) is not supported by the host"
> +		    " [32 - %u]bit\n",
> +		    kvm->cfg.arch.phys_shift, max_ipa);
> +	kvm_arm_type = KVM_VM_TYPE_ARM_IPA_SIZE(kvm->cfg.arch.phys_shift);
> +}
> +
>   bool kvm__arch_cpu_supports_vm(void)
>   {
>   	/* The KVM capability check is enough. */
> 


-- 
Jazz is not dead. It just smells funny...
