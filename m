Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeC2V3j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:29:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752594AbeC2V3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:29:36 -0400
Date: Thu, 29 Mar 2018 23:29:33 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 2/2] KVM: X86: Add Force Emulation Prefix for "emulate
 the next instruction"
Message-ID: <20180329212932.GA27107@flask>
References: <1522198134-2709-1-git-send-email-wanpengli@tencent.com>
 <1522198134-2709-3-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522198134-2709-3-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-27 17:48-0700, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> There is no easy way to force KVM to run an instruction through the emulator 
> (by design as that will expose the x86 emulator as a significant attack-surface).
> However, we do wish to expose the x86 emulator in case we are testing it
> (e.g. via kvm-unit-tests). Therefore, this patch adds a "force emulation prefix"
> that is designed to raise #UD which KVM will trap and it's #UD exit-handler will
> match "force emulation prefix" to run instruction after prefix by the x86 emulator.
> To not expose the x86 emulator by default, we add a module parameter that should 
> be off by default.
> 
> A simple testcase here:
> 
> #include <stdio.h>
> #include <string.h>
>    
> #define HYPERVISOR_INFO 0x40000000
>    
> #define CPUID(idx, eax, ebx, ecx, edx) \
>     asm volatile (\
>     "ud2a; .ascii \"kvm\"; cpuid" \
>     :"=b" (*ebx), "=a" (*eax), "=c" (*ecx), "=d" (*edx) \
>         :"0"(idx) );  
>    
> void main()  
> {  
> 	unsigned int eax, ebx, ecx, edx;  
> 	char string[13];  
>    
> 	CPUID(HYPERVISOR_INFO, &eax, &ebx, &ecx, &edx);  
> 	*(unsigned int *)(string + 0) = ebx;  
> 	*(unsigned int *)(string + 4) = ecx;  
> 	*(unsigned int *)(string + 8) = edx;  
>    
> 	string[12] = 0;  
> 	if (strncmp(string, "KVMKVMKVM\0\0\0", 12) == 0)
> 		printf("kvm guest\n");  
> 	else  
> 		printf("bare hardware\n");  
> }
> 
> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> @@ -146,6 +146,9 @@ bool __read_mostly enable_vmware_backdoor = false;
>  module_param(enable_vmware_backdoor, bool, S_IRUGO);
>  EXPORT_SYMBOL_GPL(enable_vmware_backdoor);
>  
> +static bool __read_mostly force_emulation_prefix = false;
> +module_param(force_emulation_prefix, bool, S_IRUGO);
> +
>  #define KVM_NR_SHARED_MSRS 16
>  
>  struct kvm_shared_msrs_global {
> @@ -4843,8 +4846,21 @@ EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
>  int handle_ud(struct kvm_vcpu *vcpu)
>  {
>  	enum emulation_result er;
> +	int emulation_type = EMULTYPE_TRAP_UD;
> +
> +	if (force_emulation_prefix) {
> +		char sig[5]; /* ud2; .ascii "kvm" */
> +		struct x86_exception e;
> +
> +		kvm_read_guest_virt(&vcpu->arch.emulate_ctxt,
> +				kvm_get_linear_rip(vcpu), sig, sizeof(sig), &e);
> +		if (memcmp(sig, "\xf\xbkvm", sizeof(sig)) == 0) {
> +			emulation_type = 0;
> +			kvm_rip_write(vcpu, kvm_rip_read(vcpu) + sizeof(sig));
> +		}
> +	}
>  
> -	er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
> +	er = emulate_instruction(vcpu, emulation_type);
>  	if (er == EMULATE_USER_EXIT)
>  		return 0;
>  	if (er != EMULATE_DONE)

The code afterwards is going to inject an #UD if the emulation failed.
I think that preserving the cpu state and forwarding the emulation
failure to userspace would be more useful.  The change would probably be
best as:

  		if (memcmp(sig, "\xf\xbkvm", sizeof(sig)) == 0) {
  			kvm_rip_write(vcpu, kvm_rip_read(vcpu) + sizeof(sig));
  			return emulate_instruction(vcpu, 0) == EMULATE_DONE;
  		}

Looks great otherwise, thanks.

(We want to use this in emulate.c kvm-unit-test that currently fails
 because of a hack that doesn't work anymore.)
