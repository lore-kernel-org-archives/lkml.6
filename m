Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeEKPnQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:43:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57822 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeEKPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:43:14 -0400
Date: Fri, 11 May 2018 11:42:46 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 2/3] KVM: X86: Allow userspace to disable ioport intercept
Message-ID: <20180511154246.GH27459@char.us.oracle.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
 <1523943962-25415-3-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523943962-25415-3-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8890 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=708
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805110148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4BFhLQj021225

On Mon, Apr 16, 2018 at 10:46:01PM -0700, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Allow to disable ioport intercept by userspace.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Tim Shearer <tshearer@advaoptical.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  Documentation/virtual/kvm/api.txt | 11 +++++++++++
>  arch/x86/include/asm/kvm_host.h   |  2 ++
>  arch/x86/kvm/x86.c                |  5 +++++
>  include/uapi/linux/kvm.h          |  1 +
>  4 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 1c7958b..3d0488e 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4378,6 +4378,17 @@ all such vmexits.
>  
>  Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits.
>  
> +7.14 KVM_CAP_IOPORT_DISABLE_INTERCEPT
> +
> +Architectures: x86
> +Parameters: args[0] defines whether ioport intercept

"defines whether ioport intercept" -> "defines whether to intercept the provided ioport"

> +
> +When disable intercept (args[0] == 1), some ioports which frequently

When args[0] == 1 is one, that is disable intercept, some ioports..

> +access will not be intercepted.

Why not proide args[1] which will have the ioport in questions? Or an array
of them?

> +
> +When enable intercept (args[0] == 0), behavior is as if this facility
> +is unsupported.
> +
>  8. Other capabilities.
>  ----------------------
>  
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c25775f..2f29f64 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -808,6 +808,8 @@ struct kvm_arch {
>  	bool hlt_in_guest;
>  	bool pause_in_guest;
>  
> +	bool ioport_disable_intercept;
> +
>  	unsigned long irq_sources_bitmap;
>  	s64 kvmclock_offset;
>  	raw_spinlock_t tsc_write_lock;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 51ecd38..044e314 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2881,6 +2881,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_SPLIT_IRQCHIP:
>  	case KVM_CAP_IMMEDIATE_EXIT:
>  	case KVM_CAP_GET_MSR_FEATURES:
> +	case KVM_CAP_IOPORT_DISABLE_INTERCEPT:
>  		r = 1;
>  		break;
>  	case KVM_CAP_SYNC_REGS:
> @@ -4250,6 +4251,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  			kvm->arch.pause_in_guest = true;
>  		r = 0;
>  		break;
> +	case KVM_CAP_IOPORT_DISABLE_INTERCEPT:
> +		kvm->arch.ioport_disable_intercept = cap->args[0];
> +		r = 0;
> +		break;
>  	default:
>  		r = -EINVAL;
>  		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 1065006..92730d8 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -941,6 +941,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_BPB 152
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
> +#define KVM_CAP_IOPORT_DISABLE_INTERCEPT 155
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> -- 
> 2.7.4
> 
