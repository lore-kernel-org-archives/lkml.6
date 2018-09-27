Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B61C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8D521582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8D521582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeI0VUX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:20:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50907 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727199AbeI0VUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:20:23 -0400
Received: from DGGEMA401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id AB848BB827A84;
        Thu, 27 Sep 2018 23:01:39 +0800 (CST)
Received: from DGGEMA523-MBX.china.huawei.com ([169.254.5.64]) by
 DGGEMA401-HUB.china.huawei.com ([10.3.20.42]) with mapi id 14.03.0399.000;
 Thu, 27 Sep 2018 23:01:35 +0800
From:   gengdongjiu <gengdongjiu@huawei.com>
To:     "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "drjones@redhat.com" <drjones@redhat.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm/arm64: KVM: share the check for vcpu events
 capability
Thread-Topic: [PATCH 2/2] arm/arm64: KVM: share the check for vcpu events
 capability
Thread-Index: AdRWchKkV2Om82NcRi2nhjbEK1PK0w==
Date:   Thu, 27 Sep 2018 15:01:35 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201E9CD77@dggema523-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.61.22]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi christoffer/marc,
   Could you review this simple patch to enable the 32 bit KVM vcpu event supports?  Because below user space patch depended on it. thanks
   https://patchwork.kernel.org/patch/10617601/


> subject: [PATCH 2/2] arm/arm64: KVM: share the check for vcpu events capability
> 
> The commit 539aee0edb9f ("KVM: arm64: Share the parts of get/set events useful to 32bit") shares the get/set events helper for arm64
> and arm32, it is better also share the check for vcpu events capability.
> 
> User space will check whether KVM supports vcpu events through KVM_CAP_VCPU_EVENTS IOCTL.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> For the 32 bit guest migration, it needs to enable the vcpu events
> 
> ---
>  arch/arm64/kvm/reset.c | 1 -
>  virt/kvm/arm/arm.c     | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c index fd37c53..e50245e 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -82,7 +82,6 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		break;
>  	case KVM_CAP_SET_GUEST_DEBUG:
>  	case KVM_CAP_VCPU_ATTRIBUTES:
> -	case KVM_CAP_VCPU_EVENTS:
>  		r = 1;
>  		break;
>  	default:
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c index 40e79ea..64e5d97 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -212,6 +212,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_READONLY_MEM:
>  	case KVM_CAP_MP_STATE:
>  	case KVM_CAP_IMMEDIATE_EXIT:
> +	case KVM_CAP_VCPU_EVENTS:
>  		r = 1;
>  		break;
>  	case KVM_CAP_ARM_SET_DEVICE_ADDR:
> --
> 1.9.1
> 

