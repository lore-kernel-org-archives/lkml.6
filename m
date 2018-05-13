Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbeEMIEW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:04:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeEMIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:04:20 -0400
MIME-Version: 1.0
Message-ID: <f0028b5a-101a-4f19-80b8-a00926bc68dd@default>
Date: Sun, 13 May 2018 01:03:53 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: <kernellwp@gmail.com>
Cc: <rkrcmar@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <junaids@google.com>
Subject: Re: [PATCH 2/2] KVM: X86: Fix loss of CR3_PCID_INVD bit when guest
 writes CR3
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8891 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=937
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805130085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4D84Tr7007550


----- kernellwp@gmail.com wrote:

> From: Wanpeng Li <wanpengli@tencent.com>
> 
> SDM volume 3, section 4.10.4:
> 
> * MOV to CR3. The behavior of the instruction depends on the value of
> CR4.PCIDE:
> — If CR4.PCIDE = 1 and bit 63 of the instruction’s source operand is
> 1, the 
>   instruction is not required to invalidate any TLB entries or entries
> in 
>   paging-structure caches.
> 
> The CR3_PCID_INVD bit should not be removed if CR4.PCIDE = 1 when
> guest writes 
> CR3, this patch fixes it.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Junaid Shahid <junaids@google.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9a90668..438f140 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -849,11 +849,13 @@ EXPORT_SYMBOL_GPL(kvm_set_cr4);
>  
>  int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>  {
> +	unsigned long cr3_check = cr3;
> +
>  #ifdef CONFIG_X86_64
>  	bool pcid_enabled = kvm_read_cr4_bits(vcpu, X86_CR4_PCIDE);
>  
>  	if (pcid_enabled)
> -		cr3 &= ~CR3_PCID_INVD;
> +		cr3_check &= ~CR3_PCID_INVD;
>  #endif
>  
>  	if (cr3 == kvm_read_cr3(vcpu) && !pdptrs_changed(vcpu)) {
> @@ -863,7 +865,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned
> long cr3)
>  	}
>  
>  	if (is_long_mode(vcpu) &&
> -	    (cr3 & rsvd_bits(cpuid_maxphyaddr(vcpu), 63)))
> +	    (cr3_check & rsvd_bits(cpuid_maxphyaddr(vcpu), 63)))
>  		return 1;
>  	else if (is_pae(vcpu) && is_paging(vcpu) &&
>  		   !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
> -- 
> 2.7.4

This commit doesn't seem correct to me.

According to Intel SDM "MOV—Move to/from Control Registers":
"If CR4.PCIDE = 1, bit 63 of the source operand to MOV to CR3 determines whether the instruction
invalidates entries in the TLBs and the paging-structure caches
(see Section 4.10.4.1, “Operations that Invalidate TLBs and Paging-Structure Caches,”
in the Intel® 64 and IA-32 Architectures Software Developer’s Manual, Volume 3A).
The instruction does not modify bit 63 of CR3, which is reserved and always 0."

However, after this commit kvm_set_cr3() will update vcpu->arch.cr3 to have bit CR3_PCID_INVD set.
Which is wrong as it should be reserved and always 0.
