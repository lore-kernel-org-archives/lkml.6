Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5CDECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A682083B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A682083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbeGMRCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:02:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:5188 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbeGMRCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:02:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 09:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,348,1526367600"; 
   d="scan'208";a="54164198"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.135])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2018 09:46:50 -0700
Date:   Fri, 13 Jul 2018 09:46:50 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Masatake YAMATO <yamato@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kvm/vmx: don't read current->thread.{fs,gs}base of
 legacy tasks
Message-ID: <20180713164650.GA14830@linux.intel.com>
References: <20180711173718.8850-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711173718.8850-1-vkuznets@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 07:37:18PM +0200, Vitaly Kuznetsov wrote:
> When we switched from doing rdmsr() to reading FS/GS base values from
> current->thread we completely forgot about legacy 32-bit userspaces which
> we still support in KVM (why?). task->thread.{fsbase,gsbase} are only
> synced for 64-bit processes, calling save_fsgs_for_kvm() and using
> its result from current is illegal for legacy processes.
> 
> There's no ARCH_SET_FS/GS prctls for legacy applications. Base MSRs are,
> however, not always equal to zero. Intel's manual says (3.4.4 Segment
> Loading Instructions in IA-32e Mode):
> 
> "In order to set up compatibility mode for an application, segment-load
> instructions (MOV to Sreg, POP Sreg) work normally in 64-bit mode. An
> entry is read from the system descriptor table (GDT or LDT) and is loaded
> in the hidden portion of the segment register.
> ...
> The hidden descriptor register fields for FS.base and GS.base are
> physically mapped to MSRs in order to load all address bits supported by
> a 64-bit implementation.
> "
> 
> The issue was found by strace test suite where 32-bit ioctl_kvm_run test
> started segfaulting.
> 
> Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> Bisected-by: Masatake YAMATO <yamato@redhat.com>
> Fixes: 42b933b59721 ("x86/kvm/vmx: read MSR_{FS,KERNEL_GS}_BASE from current->thread")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 559a12b6184d..65968649b365 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2560,6 +2560,7 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  #ifdef CONFIG_X86_64
>  	int cpu = raw_smp_processor_id();
> +	unsigned long fsbase, kernel_gsbase;

Because bikeshedding is fun, what do you think about using fs_base and
kernel_gs_base for these names?  I have a series that touches this
code and also adds local variables for {FS,GS}.base and {FS,GS}.sel.
I used {fs,gs}_base and {fs,gs}_sel to be consistent with the
vmx->host_state nomenclature (the local variables are used to update
the associated vmx->host_state variables), but I'll change my patches
if you have a strong preference for omitting the underscore.

>  #endif
>  	int i;
>  
> @@ -2575,12 +2576,20 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>  	vmx->host_state.gs_ldt_reload_needed = vmx->host_state.ldt_sel;
>  
>  #ifdef CONFIG_X86_64
> -	save_fsgs_for_kvm();
> -	vmx->host_state.fs_sel = current->thread.fsindex;
> -	vmx->host_state.gs_sel = current->thread.gsindex;
> -#else
> -	savesegment(fs, vmx->host_state.fs_sel);
> -	savesegment(gs, vmx->host_state.gs_sel);
> +	if (likely(is_64bit_mm(current->mm))) {
> +		save_fsgs_for_kvm();
> +		vmx->host_state.fs_sel = current->thread.fsindex;
> +		vmx->host_state.gs_sel = current->thread.gsindex;
> +		fsbase = current->thread.fsbase;
> +		kernel_gsbase = current->thread.gsbase;
> +	} else {
> +#endif
> +		savesegment(fs, vmx->host_state.fs_sel);
> +		savesegment(gs, vmx->host_state.gs_sel);
> +#ifdef CONFIG_X86_64
> +		fsbase = read_msr(MSR_FS_BASE);
> +		kernel_gsbase = read_msr(MSR_KERNEL_GS_BASE);
> +	}
>  #endif
>  	if (!(vmx->host_state.fs_sel & 7)) {
>  		vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
> @@ -2600,10 +2609,10 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>  	savesegment(ds, vmx->host_state.ds_sel);
>  	savesegment(es, vmx->host_state.es_sel);
>  
> -	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
> +	vmcs_writel(HOST_FS_BASE, fsbase);
>  	vmcs_writel(HOST_GS_BASE, cpu_kernelmode_gs_base(cpu));
>  
> -	vmx->msr_host_kernel_gs_base = current->thread.gsbase;
> +	vmx->msr_host_kernel_gs_base = kernel_gsbase;
>  	if (is_long_mode(&vmx->vcpu))
>  		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
>  #else
> -- 
> 2.14.4
> 
