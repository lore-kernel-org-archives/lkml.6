Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeA3QYO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:24:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbeA3QYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:24:12 -0500
Date: Tue, 30 Jan 2018 17:23:57 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH v2 3/3] KVM: VMX: make MSR bitmaps per-VCPU
Message-ID: <20180130162357.GE22015@flask>
References: <1517043027-7655-1-git-send-email-pbonzini@redhat.com>
 <1517043027-7655-4-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517043027-7655-4-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-27 09:50+0100, Paolo Bonzini:
> Place the MSR bitmap in struct loaded_vmcs, and update it in place
> every time the x2apic or APICv state can change.  This is rare and
> the loop can handle 64 MSRs per iteration, in a similar fashion as
> nested_vmx_prepare_msr_bitmap.
> 
> This prepares for choosing, on a per-VM basis, whether to intercept
> the SPEC_CTRL and PRED_CMD MSRs.
> 
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> @@ -10022,7 +10043,7 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
>  	int msr;
>  	struct page *page;
>  	unsigned long *msr_bitmap_l1;
> -	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.msr_bitmap;
> +	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;

The physical address of the nested msr_bitmap is never loaded into vmcs.

The resolution you provided had extra hunk in prepare_vmcs02_full():

+	vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));

I have queued that as:

+	if (cpu_has_vmx_msr_bitmap())
+		vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));

but it should be a part of the patch or a followup fix.

Is the branch already merged into PTI?

Thanks.

>  
>  	/* This shortcut is ok because we support only x2APIC MSRs so far. */
>  	if (!nested_cpu_has_virt_x2apic_mode(vmcs12))
> @@ -11397,7 +11418,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
>  	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
>  
>  	if (cpu_has_vmx_msr_bitmap())
> -		vmx_set_msr_bitmap(vcpu);
> +		vmx_update_msr_bitmap(vcpu);
>  
>  	if (nested_vmx_load_msr(vcpu, vmcs12->vm_exit_msr_load_addr,
>  				vmcs12->vm_exit_msr_load_count))
> -- 
> 1.8.3.1
> 
