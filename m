Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A232150F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A232150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeJJAkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:40:55 -0400
Received: from foss.arm.com ([217.140.101.70]:41916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbeJJAkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:40:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEFA87A9;
        Tue,  9 Oct 2018 10:22:55 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131A83F5D3;
        Tue,  9 Oct 2018 10:22:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm/arm64: KVM: enable 32 bits kvm vcpu events
 support
To:     Dongjiu Geng <gengdongjiu@huawei.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, peter.maydell@linaro.org, drjones@redhat.com,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1539002088-21215-1-git-send-email-gengdongjiu@huawei.com>
 <1539002088-21215-3-git-send-email-gengdongjiu@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3e6a7a5f-3ff9-b7db-b1f6-87a8fdf5c20c@arm.com>
Date:   Tue, 9 Oct 2018 18:22:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539002088-21215-3-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/18 13:34, Dongjiu Geng wrote:
> The commit 539aee0edb9f ("KVM: arm64: Share the parts of
> get/set events useful to 32bit") shares the get/set events
> helper for arm64 and arm32, it is better also share the check
> for vcpu events capability to enable 32 bit kvm vcpu events
> support.
> 
> User space will check whether KVM supports vcpu events through
> KVM_CAP_VCPU_EVENTS IOCTL.

nit: User space will check whether KVM supports vcpu events by checking
the KVM_CAP_VCPU_EVENTS extension.

> 
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
> For the 32 bits kvm migration, it needs to enable the vcpu events,
> this patch will enable it. The user space QEMU patch is here:
> https://patchwork.ozlabs.org/patch/975615/
> ---
>   arch/arm64/kvm/reset.c | 1 -
>   virt/kvm/arm/arm.c     | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index fd37c53..e50245e 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -82,7 +82,6 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   		break;
>   	case KVM_CAP_SET_GUEST_DEBUG:
>   	case KVM_CAP_VCPU_ATTRIBUTES:
> -	case KVM_CAP_VCPU_EVENTS:
>   		r = 1;
>   		break;
>   	default:
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 40e79ea..64e5d97 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -212,6 +212,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_READONLY_MEM:
>   	case KVM_CAP_MP_STATE:
>   	case KVM_CAP_IMMEDIATE_EXIT:
> +	case KVM_CAP_VCPU_EVENTS:
>   		r = 1;
>   		break;
>   	case KVM_CAP_ARM_SET_DEVICE_ADDR:
> 
