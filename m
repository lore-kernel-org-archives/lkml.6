Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932070AbeCIOQ7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:16:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbeCIOQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:16:56 -0500
Date: Fri, 9 Mar 2018 11:16:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] target-i386: add KVM_HINTS_DEDICATED performance hint
Message-ID: <20180309141653.GA2871@localhost.localdomain>
References: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 06:15:25AM -0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Add KVM_HINTS_DEDICATED performance hint, guest checks this feature bit
> to determine if they run on dedicated vCPUs, allowing optimizations such 
> as usage of qspinlocks.  
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * add a new feature word
> 
>  target/i386/cpu.c | 14 ++++++++++++++
>  target/i386/cpu.h |  3 +++
>  target/i386/kvm.c |  4 ++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d70954b..e2974ad 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -358,6 +358,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EAX,
>          .tcg_features = TCG_KVM_FEATURES,
>      },
> +    [FEAT_KVM_HINTS] = {
> +        .feat_names = {
> +            "hint-dedicated", NULL, NULL, NULL,

I suggest naming it "kvm-hint-dedicated", to indicate it's
KVM-specific.

If there are no objections, I can rename it while applying.

With the rename:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>


> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EDX,
> +        .tcg_features = TCG_KVM_FEATURES,
> +    },
>      [FEAT_HYPERV_EAX] = {
>          .feat_names = {
>              NULL /* hv_msr_vp_runtime_access */, NULL /* hv_msr_time_refcount_access */,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index f91e37d..9f73692 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -475,6 +475,7 @@ typedef enum FeatureWord {
>      FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
>      FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
>      FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
> +    FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
>      FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
>      FEAT_HYPERV_EBX,    /* CPUID[4000_0003].EBX */
>      FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
> @@ -670,6 +671,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
>  
> +#define KVM_HINTS_DEDICATED (1U << 0)
> +
>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
>  
>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ad4b159..44ee524 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -383,6 +383,9 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>          if (!kvm_irqchip_in_kernel()) {
>              ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
>          }
> +    } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
> +        ret |= KVM_HINTS_DEDICATED;
> +        found = 1;
>      }
>  
>      /* fallback for older kernels */
> @@ -801,6 +804,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          c = &cpuid_data.entries[cpuid_i++];
>          c->function = KVM_CPUID_FEATURES | kvm_base;
>          c->eax = env->features[FEAT_KVM];
> +        c->edx = env->features[FEAT_KVM_HINTS];
>      }
>  
>      cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
> -- 
> 2.7.4
> 

-- 
Eduardo
