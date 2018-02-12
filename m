Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753887AbeBLJiz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:38:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753849AbeBLJix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:38:53 -0500
Date: Mon, 12 Feb 2018 10:38:49 +0100
From: Andrew Jones <drjones@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 1/3] KVM: Introduce dedicated vCPUs hint
 KVM_HINTS_DEDICATED
Message-ID: <20180212093849.e6ahdj62boz5r65v@kamzik.brq.redhat.com>
References: <1518319786-1466-1-git-send-email-wanpengli@tencent.com>
 <1518319786-1466-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518319786-1466-2-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 11:29:44AM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> This patch introduces dedicated vCPUs hint KVM_HINTS_DEDICATED,  
> guest checks this feature bit to determine if they run on dedicated
> vCPUs, allowing optimizations.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  Documentation/virtual/kvm/cpuid.txt  | 12 +++++++++++-
>  arch/mips/include/asm/kvm_para.h     |  5 +++++
>  arch/powerpc/include/asm/kvm_para.h  |  5 +++++
>  arch/s390/include/asm/kvm_para.h     |  5 +++++
>  arch/x86/include/asm/kvm_para.h      |  6 ++++++
>  arch/x86/include/uapi/asm/kvm_para.h |  8 ++++++--
>  arch/x86/kernel/kvm.c                |  5 +++++
>  include/asm-generic/kvm_para.h       |  5 +++++
>  include/linux/kvm_para.h             |  5 +++++
>  9 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
> index dcab6dc..e283b88 100644
> --- a/Documentation/virtual/kvm/cpuid.txt
> +++ b/Documentation/virtual/kvm/cpuid.txt
> @@ -23,7 +23,7 @@ This function queries the presence of KVM cpuid leafs.
>  
>  
>  function: define KVM_CPUID_FEATURES (0x40000001)
> -returns : ebx, ecx, edx = 0
> +returns : ebx, ecx
>            eax = and OR'ed group of (1 << flag), where each flags is:

Now that the above line is getting repeated, we should fix it: s/and/an/

>  
>  
> @@ -62,3 +62,13 @@ KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
>                                     ||       || per-cpu warps are expected in
>                                     ||       || kvmclock.
>  ------------------------------------------------------------------------------
> +
> +          edx = and OR'ed group of (1 << flag), where each flags is:

And then copy the corrected version here.

Thanks,
drew

> +
> +
> +flag                               || value || meaning
> +================================================================================
> +KVM_HINTS_DEDICATED                ||     0 || guest checks this feature bit
> +                                   ||       || to determine if they run on dedicated
> +                                   ||       || vCPUs, allowing optimizations
> +---------------------------------------------------------------------------------
> diff --git a/arch/mips/include/asm/kvm_para.h b/arch/mips/include/asm/kvm_para.h
> index 60b1aa0..bd1f4ee 100644
> --- a/arch/mips/include/asm/kvm_para.h
> +++ b/arch/mips/include/asm/kvm_para.h
> @@ -94,6 +94,11 @@ static inline unsigned int kvm_arch_para_features(void)
>  	return 0;
>  }
>  
> +static inline unsigned int kvm_arch_hint_features(void)
> +{
> +	return 0;
> +}
> +
>  #ifdef CONFIG_MIPS_PARAVIRT
>  static inline bool kvm_para_available(void)
>  {
> diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
> index 336a91a..8e58c00 100644
> --- a/arch/powerpc/include/asm/kvm_para.h
> +++ b/arch/powerpc/include/asm/kvm_para.h
> @@ -61,6 +61,11 @@ static inline unsigned int kvm_arch_para_features(void)
>  	return r;
>  }
>  
> +static inline unsigned int kvm_arch_hint_features(void)
> +{
> +	return 0;
> +}
> +
>  static inline bool kvm_check_and_clear_guest_paused(void)
>  {
>  	return false;
> diff --git a/arch/s390/include/asm/kvm_para.h b/arch/s390/include/asm/kvm_para.h
> index 74eeec9..b2c935c 100644
> --- a/arch/s390/include/asm/kvm_para.h
> +++ b/arch/s390/include/asm/kvm_para.h
> @@ -193,6 +193,11 @@ static inline unsigned int kvm_arch_para_features(void)
>  	return 0;
>  }
>  
> +static inline unsigned int kvm_arch_hint_features(void)
> +{
> +	return 0;
> +}
> +
>  static inline bool kvm_check_and_clear_guest_paused(void)
>  {
>  	return false;
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 7b407dd..2c7d368 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -88,6 +88,7 @@ static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
>  #ifdef CONFIG_KVM_GUEST
>  bool kvm_para_available(void);
>  unsigned int kvm_arch_para_features(void);
> +unsigned int kvm_arch_hint_features(void);
>  void kvm_async_pf_task_wait(u32 token, int interrupt_kernel);
>  void kvm_async_pf_task_wake(u32 token);
>  u32 kvm_read_and_reset_pf_reason(void);
> @@ -115,6 +116,11 @@ static inline unsigned int kvm_arch_para_features(void)
>  	return 0;
>  }
>  
> +static inline unsigned int kvm_arch_hint_features(void)
> +{
> +	return 0;
> +}
> +
>  static inline u32 kvm_read_and_reset_pf_reason(void)
>  {
>  	return 0;
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 7a2ade4..e8f5dfb 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -10,8 +10,10 @@
>   */
>  #define KVM_CPUID_SIGNATURE	0x40000000
>  
> -/* This CPUID returns a feature bitmap in eax.  Before enabling a particular
> - * paravirtualization, the appropriate feature bit should be checked.
> +/* This CPUID returns two feature bitmaps in eax, edx. Before enabling
> + * a particular paravirtualization, the appropriate feature bit should
> + * be checked in eax. The performance hint feature bit should be checked
> + * in edx.
>   */
>  #define KVM_CPUID_FEATURES	0x40000001
>  #define KVM_FEATURE_CLOCKSOURCE		0
> @@ -27,6 +29,8 @@
>  #define KVM_FEATURE_PV_UNHALT		7
>  #define KVM_FEATURE_PV_TLB_FLUSH	9
>  
> +#define KVM_HINTS_DEDICATED      0
> +
>  /* The last 8 bits are used to indicate how to interpret the flags field
>   * in pvclock structure. If no bits are set, all flags are ignored.
>   */
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 4e37d1a..77a0723 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -604,6 +604,11 @@ unsigned int kvm_arch_para_features(void)
>  	return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_FEATURES);
>  }
>  
> +unsigned int kvm_arch_hint_features(void)
> +{
> +	return cpuid_edx(kvm_cpuid_base() | KVM_CPUID_FEATURES);
> +}
> +
>  static uint32_t __init kvm_detect(void)
>  {
>  	return kvm_cpuid_base();
> diff --git a/include/asm-generic/kvm_para.h b/include/asm-generic/kvm_para.h
> index 18c6abe..93e133d 100644
> --- a/include/asm-generic/kvm_para.h
> +++ b/include/asm-generic/kvm_para.h
> @@ -19,6 +19,11 @@ static inline unsigned int kvm_arch_para_features(void)
>  	return 0;
>  }
>  
> +static inline unsigned int kvm_arch_hint_features(void)
> +{
> +	return 0;
> +}
> +
>  static inline bool kvm_para_available(void)
>  {
>  	return false;
> diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
> index 51f6ef2..30503b7 100644
> --- a/include/linux/kvm_para.h
> +++ b/include/linux/kvm_para.h
> @@ -9,4 +9,9 @@ static inline bool kvm_para_has_feature(unsigned int feature)
>  {
>  	return !!(kvm_arch_para_features() & (1UL << feature));
>  }
> +
> +static inline bool kvm_hint_has_feature(unsigned int feature)
> +{
> +	return !!(kvm_arch_hint_features() & (1UL << feature));
> +}
>  #endif /* __LINUX_KVM_PARA_H */
> -- 
> 2.7.4
> 
