Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbeBTIba (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:31:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60736 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeBTIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:31:28 -0500
Date: Tue, 20 Feb 2018 09:31:29 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Woodhouse <dwmw@amazon.co.uk>
cc: karahmed@amazon.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        jmattson@google.com, rkrcmar@redhat.com, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com, mingo@kernel.org
Subject: Re: [PATCH v3 2/4] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
In-Reply-To: <1519037457-7643-3-git-send-email-dwmw@amazon.co.uk>
Message-ID: <alpine.DEB.2.21.1802200854010.24268@nanos.tec.linutronix.de>
References: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk> <1519037457-7643-3-git-send-email-dwmw@amazon.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018, David Woodhouse wrote:
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 0995c6a..34cbce3 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -141,9 +141,16 @@ enum spectre_v2_mitigation {
>  	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
>  	SPECTRE_V2_RETPOLINE_GENERIC,
>  	SPECTRE_V2_RETPOLINE_AMD,
> -	SPECTRE_V2_IBRS,
> +	SPECTRE_V2_IBRS_ALL,
>  };
>  
> +extern enum spectre_v2_mitigation spectre_v2_enabled;
> +
> +static inline bool spectre_v2_ibrs_all(void)
> +{
> +	return spectre_v2_enabled == SPECTRE_V2_IBRS_ALL;
> +}
> +
>  extern char __indirect_thunk_start[];
>  extern char __indirect_thunk_end[];
>  
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index bfca937..505c467 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -88,12 +88,14 @@ static const char *spectre_v2_strings[] = {
>  	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
>  	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
>  	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
> +	[SPECTRE_V2_IBRS_ALL]			= "Mitigation: Enhanced IBRS",
>  };
>  
>  #undef pr_fmt
>  #define pr_fmt(fmt)     "Spectre V2 : " fmt
>  
> -static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
> +enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
> +EXPORT_SYMBOL_GPL(spectre_v2_enabled);
>  
>  #ifdef RETPOLINE
>  static bool spectre_v2_bad_module;
> @@ -237,6 +239,16 @@ static void __init spectre_v2_select_mitigation(void)
>  
>  	case SPECTRE_V2_CMD_FORCE:
>  	case SPECTRE_V2_CMD_AUTO:
> +		if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES)) {
> +			u64 ia32_cap = 0;
> +
> +			rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
> +			if (ia32_cap & ARCH_CAP_IBRS_ALL) {

Hmm. We already read the MSR in cpu/common.c to check for the RDCL_NO
bit. Shouldn't we just read it once and set a feature bit for IBRS_ALL?

> +				mode = SPECTRE_V2_IBRS_ALL;
> +				wrmsrl(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS);
> +				goto ibrs_all;
> +			}
> +		}
>  		if (IS_ENABLED(CONFIG_RETPOLINE))
>  			goto retpoline_auto;
>  		break;

> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 3dec126..5dfeb11 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -3387,13 +3387,14 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  		vmx->spec_ctrl = data;
>  
> -		if (!data)
> +		if (!data && !spectre_v2_ibrs_all())
>  			break;
>  
>  		/*
>  		 * For non-nested:
>  		 * When it's written (to non-zero) for the first time, pass
> -		 * it through.
> +		 * it through unless we have IBRS_ALL and it should just be
> +		 * set for ever.

A non zero write is going to disable the intercept only when IBRS_ALL
is on. The comment says is should be set forever, i.e. not changeable by
the guest. So the condition should be:

		if (!data || spectre_v2_ibrs_all())
			break;
Hmm?

>  		 *
>  		 * For nested:
>  		 * The handling of the MSR bitmap for L2 guests is done in
> @@ -9451,7 +9452,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	 * is no need to worry about the conditional branch over the wrmsr
>  	 * being speculatively taken.
>  	 */
> -	if (vmx->spec_ctrl)
> +	if (!spectre_v2_ibrs_all() && vmx->spec_ctrl)
>  		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);

Which matches the code here.

Thanks,

	tglx
