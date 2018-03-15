Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbeCOUmj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:42:39 -0400
Received: from foss.arm.com ([217.140.101.70]:47728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752847AbeCOUmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:42:37 -0400
Message-ID: <5AAADA1B.2030601@arm.com>
Date: Thu, 15 Mar 2018 20:39:55 +0000
From: James Morse <james.morse@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To: Dongjiu Geng <gengdongjiu@huawei.com>
CC: rkrcmar@redhat.com, corbet@lwn.net, christoffer.dall@linaro.org,
        marc.zyngier@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        rjw@rjwysocki.net, bp@alien8.de, lenb@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-acpi@vger.kernel.org, devel@acpica.org, huangshaoyu@huawei.com
Subject: Re: [PATCH v10 2/5] arm64: KVM: export the capability to set guest
 SError syndrome
References: <1520093380-42577-1-git-send-email-gengdongjiu@huawei.com> <1520093380-42577-3-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1520093380-42577-3-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

On 03/03/18 16:09, Dongjiu Geng wrote:
> Before user space injects a SError, it needs to know whether it can
> specify the guest Exception Syndrome, so KVM should tell user space
> whether it has such capability.

> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index fc3ae95..8a3d708 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4415,3 +4415,14 @@ Parameters: none
>  This capability indicates if the flic device will be able to get/set the
>  AIS states for migration via the KVM_DEV_FLIC_AISM_ALL attribute and allows
>  to discover this without having to create a flic device.
> +
> +8.14 KVM_CAP_ARM_SET_SERROR_ESR
> +
> +Architectures: arm, arm64
> +
> +This capability indicates that userspace can specify syndrome value reported to
> +guest OS when guest takes a virtual SError interrupt exception.

"when userspace triggers a virtual SError"... how?


> +If KVM has this capability, userspace can only specify the ISS field for the ESR
> +syndrome, can not specify the EC field which is not under control by KVM.

Where do I put the ESR?
If you re-order this after the patch that adds the API, you can describe how
this can be used.


Thanks,

James



> +If this virtual SError is taken to EL1 using AArch64, this value will be reported
> +into ISS filed of ESR_EL1.
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 3256b92..38c8a64 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -77,6 +77,9 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ARM_PMU_V3:
>  		r = kvm_arm_support_pmu_v3();
>  		break;
> +	case KVM_CAP_ARM_INJECT_SERROR_ESR:
> +		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
> +		break;
>  	case KVM_CAP_SET_GUEST_DEBUG:
>  	case KVM_CAP_VCPU_ATTRIBUTES:
>  		r = 1;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 8fb90a0..3587b33 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -934,6 +934,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_AIS_MIGRATION 150
>  #define KVM_CAP_PPC_GET_CPU_CHAR 151
>  #define KVM_CAP_S390_BPB 152
> +#define KVM_CAP_ARM_INJECT_SERROR_ESR 153
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> 
