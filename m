Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeBLHTM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 02:19:12 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34256 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeBLHTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 02:19:10 -0500
X-Google-Smtp-Source: AH8x224p1cJoM5SYlA8mZAZj+71+jklKclyf6qBgB/xSwXrpp3Z+vk0BYe0HPc00rf0478sziIBosw==
Date: Mon, 12 Feb 2018 08:19:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180212071905.tjsu56rvru7smss4@gmail.com>
References: <20180212122735.19094883@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212122735.19094883@canb.auug.org.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the tip tree got a conflict in:
> 
>   arch/x86/kvm/vmx.c
> 
> between commit:
> 
>   c992384bde84 ("KVM: vmx: speed up MSR bitmap merge")
> 
> from Linus' tree and commit:
> 
>   ff37dc0cd96c ("KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MSR bitmap")
> 
> from the tip tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/x86/kvm/vmx.c
> index f427723dc7db,91e3539cba02..000000000000
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@@ -10136,7 -10127,12 +10136,10 @@@ static void nested_get_vmcs12_pages(str
>   			(unsigned long)(vmcs12->posted_intr_desc_addr &
>   			(PAGE_SIZE - 1)));
>   	}
> - 	if (!nested_vmx_prepare_msr_bitmap(vcpu, vmcs12))
>  -	if (cpu_has_vmx_msr_bitmap() &&
>  -	    nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS) &&
>  -	    nested_vmx_merge_msr_bitmap(vcpu, vmcs12))
> ++	if (nested_vmx_prepare_msr_bitmap(vcpu, vmcs12))
> + 		vmcs_set_bits(CPU_BASED_VM_EXEC_CONTROL,
> + 			      CPU_BASED_USE_MSR_BITMAPS);
> + 	else
>   		vmcs_clear_bits(CPU_BASED_VM_EXEC_CONTROL,
>   				CPU_BASED_USE_MSR_BITMAPS);
>   }
>
> @@@ -10224,14 -10220,9 +10227,14 @@@ static inline bool nested_vmx_prepare_m
>   	 *    updated to reflect this when L1 (or its L2s) actually write to
>   	 *    the MSR.
>   	 */
> - 	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
> - 	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
> + 	bool pred_cmd = !msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
> + 	bool spec_ctrl = !msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
>   
>  +	/* Nothing to do if the MSR bitmap is not in use.  */
>  +	if (!cpu_has_vmx_msr_bitmap() ||
>  +	    !nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS))
>  +		return false;
>  +
>   	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
>   	    !pred_cmd && !spec_ctrl)
>   		return false;

The resolution looks good to me, I did a similar resolution and diffed the 
linux-next version to the tip:msater version.

Thanks,

	Ingo
