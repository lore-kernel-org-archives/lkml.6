Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeEBHgR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:36:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750895AbeEBHgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:36:13 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Cc: x86@kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support
References: <20180416105033.28778-1-vkuznets@redhat.com>
Date: Wed, 02 May 2018 09:36:09 +0200
In-Reply-To: <20180416105033.28778-1-vkuznets@redhat.com> (Vitaly Kuznetsov's
        message of "Mon, 16 Apr 2018 12:50:33 +0200")
Message-ID: <8736zatspi.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Enlightened MSR-Bitmap is a natural extension of Enlightened VMCS:
> Hyper-V Top Level Functional Specification states:
>
> "The L1 hypervisor may collaborate with the L0 hypervisor to make MSR
> accesses more efficient. It can enable enlightened MSR bitmaps by setting
> the corresponding field in the enlightened VMCS to 1. When enabled, the L0
> hypervisor does not monitor the MSR bitmaps for changes. Instead, the L1
> hypervisor must invalidate the corresponding clean field after making
> changes to one of the MSR bitmaps."
>
> I reached out to Hyper-V team for additional details and I got the
> following information:
>
> "Current Hyper-V implementation works as following:
>
> If the enlightened MSR bitmap is not enabled:
> - All MSR accesses of L2 guests cause physical VM-Exits
>
> If the enlightened MSR bitmap is enabled:
> - Physical VM-Exits for L2 accesses to certain MSRs (currently FS_BASE,
>   GS_BASE and KERNEL_GS_BASE) are avoided, thus making these MSR accesses
>   faster."
>
> I tested my series with a tight rdmsrl loop in L2, for KERNEL_GS_BASE the
> results are:
>
> Without Enlightened MSR-Bitmap: 1300 cycles/read
> With Enlightened MSR-Bitmap: 120 cycles/read
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Tested-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> - Changes since 'v1': drop 'enable_emsr_bitmap' static key usage
>   [Paolo Bonzini]
> - Added 'Tested-by' from Lan Tianyu. Hope it stands after the changes.

Ping? :-)

> ---
>  arch/x86/include/asm/hyperv-tlfs.h |  9 ++++++++-
>  arch/x86/kvm/vmx.c                 | 25 +++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 1c602ad4bda8..26e7e2240066 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -300,6 +300,9 @@ struct ms_hyperv_tsc_page {
>  /* TSC emulation after migration */
>  #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
>
> +/* Nested features (CPUID 0x4000000A) EAX */
> +#define HV_X64_NESTED_MSR_BITMAP		BIT(19)
> +
>  struct hv_reenlightenment_control {
>  	__u64 vector:8;
>  	__u64 reserved1:8;
> @@ -665,7 +668,11 @@ struct hv_enlightened_vmcs {
>  	u32 hv_clean_fields;
>  	u32 hv_padding_32;
>  	u32 hv_synthetic_controls;
> -	u32 hv_enlightenments_control;
> +	struct {
> +		u32 nested_flush_hypercall:1;
> +		u32 msr_bitmap:1;
> +		u32 reserved:30;
> +	} hv_enlightenments_control;
>  	u32 hv_vp_id;
>
>  	u64 hv_vm_id;
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index b2f8a700aeef..babc9ef121a4 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -1090,6 +1090,16 @@ static inline u16 evmcs_read16(unsigned long field)
>  	return *(u16 *)((char *)current_evmcs + offset);
>  }
>
> +static inline void evmcs_touch_msr_bitmap(void)
> +{
> +	if (unlikely(!current_evmcs))
> +		return;
> +
> +	if (current_evmcs->hv_enlightenments_control.msr_bitmap)
> +		current_evmcs->hv_clean_fields &=
> +			~HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP;
> +}
> +
>  static void evmcs_load(u64 phys_addr)
>  {
>  	struct hv_vp_assist_page *vp_ap =
> @@ -1174,6 +1184,7 @@ static inline u32 evmcs_read32(unsigned long field) { return 0; }
>  static inline u16 evmcs_read16(unsigned long field) { return 0; }
>  static inline void evmcs_load(u64 phys_addr) {}
>  static inline void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
> +static inline void evmcs_touch_msr_bitmap(void) {}
>  #endif /* IS_ENABLED(CONFIG_HYPERV) */
>
>  static inline bool is_exception_n(u32 intr_info, u8 vector)
> @@ -4218,6 +4229,14 @@ static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
>  		if (!loaded_vmcs->msr_bitmap)
>  			goto out_vmcs;
>  		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
> +
> +		if (static_branch_unlikely(&enable_evmcs) &&
> +		    (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
> +			struct hv_enlightened_vmcs *evmcs =
> +				(struct hv_enlightened_vmcs *)loaded_vmcs->vmcs;
> +
> +			evmcs->hv_enlightenments_control.msr_bitmap = 1;
> +		}
>  	}
>  	return 0;
>
> @@ -5335,6 +5354,9 @@ static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bit
>  	if (!cpu_has_vmx_msr_bitmap())
>  		return;
>
> +	if (static_branch_unlikely(&enable_evmcs))
> +		evmcs_touch_msr_bitmap();
> +
>  	/*
>  	 * See Intel PRM Vol. 3, 20.6.9 (MSR-Bitmap Address). Early manuals
>  	 * have the write-low and read-high bitmap offsets the wrong way round.
> @@ -5370,6 +5392,9 @@ static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitm
>  	if (!cpu_has_vmx_msr_bitmap())
>  		return;
>
> +	if (static_branch_unlikely(&enable_evmcs))
> +		evmcs_touch_msr_bitmap();
> +
>  	/*
>  	 * See Intel PRM Vol. 3, 20.6.9 (MSR-Bitmap Address). Early manuals
>  	 * have the write-low and read-high bitmap offsets the wrong way round.

-- 
  Vitaly
