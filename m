Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBIQeU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:34:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeBIQeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:34:19 -0500
Date: Fri, 9 Feb 2018 14:34:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: x86: Add dedicated vCPU hint
 KVM_HINTS_DEDICATED
Message-ID: <20180209163417.GM13981@localhost.localdomain>
References: <1518187673-70832-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518187673-70832-1-git-send-email-wanpengli@tencent.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 06:47:52AM -0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Waiman Long mentioned that:
> 
>  Generally speaking, unfair lock performs well for VMs with a small
>  number of vCPUs. Native qspinlock may perform better than pvqspinlock
>  if there is vCPU pinning and there is no vCPU over-commitment.
> 
> This patch adds a performance hint to allow hypervisor admin to choose
> the qspinlock to be used when a dedicated pCPU is available.
> 
> PV_DEDICATED = 1, PV_UNHALT = anything: default is qspinlock
> PV_DEDICATED = 0, PV_UNHALT = 1: default is Hybrid PV queued/unfair lock
> PV_DEDICATED = 0, PV_UNHALT = 0: default is tas
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * update to KVM_HINTS_DEDICATED
> 
>  Documentation/virtual/kvm/cpuid.txt  | 6 ++++++
>  arch/x86/include/uapi/asm/kvm_para.h | 2 ++
>  arch/x86/kernel/kvm.c                | 6 ++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
> index 87a7506..d54cc79 100644
> --- a/Documentation/virtual/kvm/cpuid.txt
> +++ b/Documentation/virtual/kvm/cpuid.txt
> @@ -66,3 +66,9 @@ KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
>                                     ||       || per-cpu warps are expected in
>                                     ||       || kvmclock.
>  ------------------------------------------------------------------------------
> +KVM_HINTS_DEDICATED                ||     0 || guest checks this feature bit
> +                                   ||       || to determine if they run on
> +                                   ||       || dedicated vCPUs, allowing opti-
> +                                   ||       || mizations such as usage of
> +                                   ||       || qspinlocks.

I assume you don't mean CPUID[0x40000001].EAX[bit 0] here,
because it is already used for KVM_FEATURE_CLOCKSOURCE.

I guess you will want a separate table for CPUID[0x40000001].EDX
bits?


> +------------------------------------------------------------------------------
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 6cfa9c8..d65b16b 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -28,6 +28,8 @@
>  #define KVM_FEATURE_PV_TLB_FLUSH	9
>  #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
>  
> +#define KVM_HINTS_DEDICATED 0
> +
>  /* The last 8 bits are used to indicate how to interpret the flags field
>   * in pvclock structure. If no bits are set, all flags are ignored.
>   */
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 971babe..7f4c92d 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -724,6 +724,12 @@ void __init kvm_spinlock_init(void)
>  {
>  	if (!kvm_para_available())
>  		return;
> +
> +	if (kvm_para_has_feature(KVM_HINTS_DEDICATED)) {

This is checking CPUID{0x40000001].EAX[bit 0]
(KVM_FEATURE_CLOCKSOURCE), isn't it?

> +		static_branch_disable(&virt_spin_lock_key);
> +		return;
> +	}
> +
>  	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
>  	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
>  		return;
> -- 
> 2.7.4
> 

-- 
Eduardo
