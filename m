Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E8EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BBE217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfBFT4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:56:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:60444 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfBFT4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:56:43 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 11:56:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,341,1544515200"; 
   d="scan'208";a="114223336"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.14])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2019 11:56:42 -0800
Date:   Wed, 6 Feb 2019 11:56:42 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 19/27] kvm: Adapt assembly for PIE support
Message-ID: <20190206195642.GD9575@linux.intel.com>
References: <20190131192533.34130-1-thgarnie@chromium.org>
 <20190131192533.34130-20-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131192533.34130-20-thgarnie@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:24:26AM -0800, Thomas Garnier wrote:
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible. The new __ASM_MOVABS macro is used to
> get the address of a symbol on both 32 and 64-bit with PIE support.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> ---
>  arch/x86/include/asm/kvm_host.h | 8 ++++++--
>  arch/x86/kernel/kvm.c           | 6 ++++--
>  arch/x86/kvm/svm.c              | 4 ++--
>  arch/x86/kvm/vmx/vmx.c          | 2 +-
>  4 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4660ce90de7f..fdb3307d5fe1 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1498,9 +1498,13 @@ asmlinkage void kvm_spurious_fault(void);
>  	".pushsection .fixup, \"ax\" \n" \
>  	"667: \n\t" \
>  	cleanup_insn "\n\t"		      \
> -	"cmpb $0, kvm_rebooting \n\t"	      \
> +	"cmpb $0, kvm_rebooting" __ASM_SEL(, (%%rip)) " \n\t" \
>  	"jne 668b \n\t"      		      \
> -	__ASM_SIZE(push) " $666b \n\t"	      \
> +	__ASM_SIZE(push) "$0 \n\t"		\
> +	__ASM_SIZE(push) "%%" _ASM_AX " \n\t"		\
> +	_ASM_MOVABS " $666b, %%" _ASM_AX "\n\t"	\
> +	_ASM_MOV " %%" _ASM_AX ", " __ASM_SEL(4, 8) "(%%" _ASM_SP ") \n\t" \
> +	__ASM_SIZE(pop) "%%" _ASM_AX " \n\t"		\

This blob isn't very intuitive to begin with, and the extra stack
shenanigans are a bit much when PIE is disabled.  What about breaking
out the behavior to separate helper macros to keep the simpler code
for non-PIE and to make the code somewhat self-documenting?  E.g.:

#ifndef CONFIG_X86_PIE
#define KVM_PUSH_FAULTING_INSN_RIP	 __ASM_SIZE(push) " $666b \n\t"
#else
#define KVM_PUSH_FAULTING_INSN_RIP					   \
	__ASM_SIZE(push) "$0 \n\t"					   \
	__ASM_SIZE(push) "%%" _ASM_AX " \n\t"				   \
	_ASM_MOVABS " $666b, %%" _ASM_AX "\n\t"				   \
	_ASM_MOV " %%" _ASM_AX ", " __ASM_SEL(4, 8) "(%%" _ASM_SP ") \n\t" \
	__ASM_SIZE(pop) "%%" _ASM_AX " \n\t"
#endif

#define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)	\
	"666: " insn "\n\t" \
	"668: \n\t"                           \
	".pushsection .fixup, \"ax\" \n" \
	"667: \n\t" \
	cleanup_insn "\n\t"		      \
	"cmpb $0, kvm_rebooting" __ASM_SEL(, (%%rip)) " \n\t" \
	"jne 668b \n\t"      		      \
	KVM_PUSH_FAULTING_INSN_RIP		\
	"jmp kvm_spurious_fault \n\t"	      \
	".popsection \n\t" \
	_ASM_EXTABLE(666b, 667b)

>  	"jmp kvm_spurious_fault \n\t"	      \
>  	".popsection \n\t" \
>  	_ASM_EXTABLE(666b, 667b)
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5c93a65ee1e5..f6eb02004e43 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c

This change to arch/x86/kernel/kvm.c should be done in a separate patch
as it affects the kernel itself when running as a guest under KVM,
whereas arch/x86/kvm/**/* and arch/x86/include/asm/kvm_host.h affect
KVM as a host, i.e. the KVM module.  Case in point, the below bug causes
a kernel panic when running as a KVM guest but has no impact on the KVM
module.

> @@ -826,8 +826,10 @@ asm(
>  ".global __raw_callee_save___kvm_vcpu_is_preempted;"
>  ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
>  "__raw_callee_save___kvm_vcpu_is_preempted:"
> -"movq	__per_cpu_offset(,%rdi,8), %rax;"
> -"cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
> +"leaq	__per_cpu_offset(%rip), %rax;"
> +"movq	(%rax,%rdi,8), %rax;"
> +"addq	" __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rip), %rax;"

This is wrong, it's directly accessing the per-cpu offset of 'steal_time'
as a virtual address, e.g. without PIE enabled:

    0xffffffff8104820b <+11>:    add    0x7efccffe(%rip),%rax        # 0x15210 <steal_time+16>

This results in kernel panics due to unhandled page faults:

    [    0.001453] BUG: unable to handle kernel paging request at 0000000000015210
    [    0.001453] #PF error: [normal kernel read fault]

I think you want something like the following, except that the whole
point of handcoded assembly is to avoid modifying registers other than
RAX, i.e. modifying RDI is a no-no.

    "leaq   " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rip), %rdi;"
    "cmpb   $0, (%rax,%rdi,1);"


And similar to the comment on ____kvm_handle_fault_on_reboot(), what
about wrapping the PIE-specific version in an ifdef?

> +"cmpb	$0, (%rax);"
>  "setne	%al;"
>  "ret;"
>  ".popsection");
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index f13a3a24d360..26abb82b1b67 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -706,12 +706,12 @@ static u32 svm_msrpm_offset(u32 msr)
>  
>  static inline void clgi(void)
>  {
> -	asm volatile (__ex("clgi"));
> +	asm volatile (__ex("clgi") : :);
>  }
>  
>  static inline void stgi(void)
>  {
> -	asm volatile (__ex("stgi"));
> +	asm volatile (__ex("stgi") : :);
>  }
>  
>  static inline void invlpga(unsigned long addr, u32 asid)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4341175339f3..3275761a7375 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2161,7 +2161,7 @@ static void vmclear_local_loaded_vmcss(void)
>   */
>  static void kvm_cpu_vmxoff(void)
>  {
> -	asm volatile (__ex("vmxoff"));
> +	asm volatile (__ex("vmxoff") :::);
>  
>  	intel_pt_handle_vmx(0);
>  	cr4_clear_bits(X86_CR4_VMXE);
> -- 
> 2.20.1.495.gaa96b0ce6b-goog
> 
