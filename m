Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeC0Ekh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:40:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbeC0Ekg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:40:36 -0400
Date: Tue, 27 Mar 2018 00:40:20 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate
 the next instruction"
Message-ID: <20180327044020.GB16974@char.us.oracle.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
 <1522116735-4861-3-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1522116735-4861-3-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270044
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R4egle027959

On Mon, Mar 26, 2018 at 07:12:15PM -0700, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> This patch introduces a Force Emulation Prefix (ud2a; .ascii "kvm") for 
> "emulate the next instruction", the codes will be executed by emulator 
> instead of processor, for testing purposes.

Can you expand a bit ? Why do you want this in KVM in the first place?
Should this be controlled by a boolean parameter? 
> 
> A testcase here:
> 
> #include <stdio.h>
> #include <string.h>
>    
> #define HYPERVISOR_INFO 0x40000000
>    
> #define CPUID(idx, eax, ebx, ecx, edx)\
>     asm volatile (\
>     "ud2a; .ascii \"kvm\"; 1: cpuid" \
>     :"=b" (*ebx), "=a" (*eax),"=c" (*ecx), "=d" (*edx)\
>         :"0"(idx) );  
>    
> void main()  
> {  
> 	unsigned int eax,ebx,ecx,edx;  
> 	char string[13];  
>    
> 	CPUID(HYPERVISOR_INFO, &eax, &ebx, &ecx, &edx);  
> 	*(unsigned int *)(string+0) = ebx;  
> 	*(unsigned int *)(string+4) = ecx;  
> 	*(unsigned int *)(string+8) = edx;  
>    
> 	string[12] = 0;  
> 	if (strncmp(string, "KVMKVMKVM\0\0\0",12) == 0)
> 		printf("kvm guest\n");  
> 	else  
> 		printf("bare hardware\n");  
> }
> 
> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 0f99833..90abed8 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -108,6 +108,9 @@ module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
>  static bool __read_mostly nested = 0;
>  module_param(nested, bool, S_IRUGO);
>  
> +static bool __read_mostly fep = 0;
> +module_param(fep, bool, S_IRUGO);
> +
>  static u64 __read_mostly host_xss;
>  
>  static bool __read_mostly enable_pml = 1;
> @@ -6218,8 +6221,21 @@ static int handle_machine_check(struct kvm_vcpu *vcpu)
>  static int handle_ud(struct kvm_vcpu *vcpu)
>  {
>  	enum emulation_result er;
> +	int emulation_type = EMULTYPE_TRAP_UD;
> +
> +	if (fep) {
> +		char sig[5]; /* ud2; .ascii "kvm" */
> +		struct x86_exception e;

Don't you want to do = { };
to memset it?
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
> 
