Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232FBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB16A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB16A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJ3CEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:04:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:18234 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeJ3CEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:04:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 10:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="99721005"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.193])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2018 10:14:50 -0700
Date:   Mon, 29 Oct 2018 10:14:50 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Julian Stecklina <js@alien8.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] kvm, vmx: move CR2 context switch out of assembly
 path
Message-ID: <20181029171448.GA27762@linux.intel.com>
References: <74fa3809ea293cc05d37b1449b16e08480c4ddbd.1540822350.git.jsteckli@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74fa3809ea293cc05d37b1449b16e08480c4ddbd.1540822350.git.jsteckli@amazon.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 04:40:42PM +0100, Julian Stecklina wrote:
> The VM entry/exit path is a giant inline assembly statement. Simplify it
> by doing CR2 context switching in plain C. Move CR2 restore behind IBRS
> clearing, so we reduce the amount of code we execute with IBRS on.

I think it's worth documenting two things in the changelog:

  - Using {read,write}_cr2() means KVM will use pv_mmu_ops instead of
    open coding native_{read,write}_cr2().

  - The CR2 code has been done in assembly since KVM's genesis[1],
    which predates the addition of the paravirt ops[2], i.e. KVM isn't
    deliberately avoiding the paravirt ops.

The above info makes it trivially easy to review this patch from a
correctness standpoint.  With that:

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>


[1] Commit 6aa8b732ca01 ("[PATCH] kvm: userspace interface")
[2] Commit d3561b7fa0fb ("[PATCH] paravirt: header and stubs for paravirtualisation")
 
> Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
> Reviewed-by: Jan H. Schönherr <jschoenh@amazon.de>
> Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/vmx.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index ccc6a01..a6e5a5c 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11212,6 +11212,9 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	evmcs_rsp = static_branch_unlikely(&enable_evmcs) ?
>  		(unsigned long)&current_evmcs->host_rsp : 0;
>  
> +	if (read_cr2() != vcpu->arch.cr2)
> +		write_cr2(vcpu->arch.cr2);
> +
>  	if (static_branch_unlikely(&vmx_l1d_should_flush))
>  		vmx_l1d_flush(vcpu);
>  
> @@ -11231,13 +11234,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  		"2: \n\t"
>  		__ex("vmwrite %%" _ASM_SP ", %%" _ASM_DX) "\n\t"
>  		"1: \n\t"
> -		/* Reload cr2 if changed */
> -		"mov %c[cr2](%0), %%" _ASM_AX " \n\t"
> -		"mov %%cr2, %%" _ASM_DX " \n\t"
> -		"cmp %%" _ASM_AX ", %%" _ASM_DX " \n\t"
> -		"je 3f \n\t"
> -		"mov %%" _ASM_AX", %%cr2 \n\t"
> -		"3: \n\t"
>  		/* Check if vmlaunch of vmresume is needed */
>  		"cmpl $0, %c[launched](%0) \n\t"
>  		/* Load guest registers.  Don't clobber flags. */
> @@ -11298,8 +11294,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  		"xor %%r14d, %%r14d \n\t"
>  		"xor %%r15d, %%r15d \n\t"
>  #endif
> -		"mov %%cr2, %%" _ASM_AX "   \n\t"
> -		"mov %%" _ASM_AX ", %c[cr2](%0) \n\t"
>  
>  		"xor %%eax, %%eax \n\t"
>  		"xor %%ebx, %%ebx \n\t"
> @@ -11331,7 +11325,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  		[r14]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R14])),
>  		[r15]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R15])),
>  #endif
> -		[cr2]"i"(offsetof(struct vcpu_vmx, vcpu.arch.cr2)),
>  		[wordsize]"i"(sizeof(ulong))
>  	      : "cc", "memory"
>  #ifdef CONFIG_X86_64
> @@ -11365,6 +11358,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	/* Eliminate branch target predictions from guest mode */
>  	vmexit_fill_RSB();
>  
> +	vcpu->arch.cr2 = read_cr2();
> +
>  	/* All fields are clean at this point */
>  	if (static_branch_unlikely(&enable_evmcs))
>  		current_evmcs->hv_clean_fields |=
> -- 
> 2.7.4
> 
