Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeC1Gzo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:55:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53576 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeC1Gzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:55:40 -0400
MIME-Version: 1.0
Message-ID: <490b19a2-3a40-4abb-b993-743c22ef43a5@default>
Date: Tue, 27 Mar 2018 23:55:32 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: <kernellwp@gmail.com>
Cc: <konrad.wilk@oracle.com>, <rkrcmar@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <andrew.cooper3@citrix.com>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] KVM: X86: Add Force Emulation Prefix for "emulate
 the next instruction"
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8845 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280066
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2S6tpJZ019496


----- kernellwp@gmail.com wrote:

> From: Wanpeng Li <wanpengli@tencent.com>
> 
> There is no easy way to force KVM to run an instruction through the
> emulator 
> (by design as that will expose the x86 emulator as a significant
> attack-surface).
> However, we do wish to expose the x86 emulator in case we are testing
> it
> (e.g. via kvm-unit-tests). Therefore, this patch adds a "force
> emulation prefix"
> that is designed to raise #UD which KVM will trap and it's #UD
> exit-handler will
> match "force emulation prefix" to run instruction after prefix by the
> x86 emulator.
> To not expose the x86 emulator by default, we add a module parameter
> that should 
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
>  arch/x86/kvm/x86.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e3a60ab..40e2f78 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -146,6 +146,9 @@ bool __read_mostly enable_vmware_backdoor =
> false;
>  module_param(enable_vmware_backdoor, bool, S_IRUGO);
>  EXPORT_SYMBOL_GPL(enable_vmware_backdoor);
>  
> +static bool __read_mostly force_emulation_prefix = false;
> +module_param(force_emulation_prefix, bool, S_IRUGO);
> +
>  #define KVM_NR_SHARED_MSRS 16
>  
>  struct kvm_shared_msrs_global {
> @@ -4843,8 +4846,21 @@
> EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
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
> -- 
> 2.7.4

Reviewed-by: Liran Alon <liran.alon@oracle.com>
