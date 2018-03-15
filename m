Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeCOUkh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:40:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47602 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbeCOUkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:40:35 -0400
Message-ID: <5AAAD9A1.6090107@arm.com>
Date: Thu, 15 Mar 2018 20:37:53 +0000
From: James Morse <james.morse@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To: Dongjiu Geng <gengdongjiu@huawei.com>
CC: rkrcmar@redhat.com, corbet@lwn.net, christoffer.dall@linaro.org,
        marc.zyngier@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        rjw@rjwysocki.net, bp@alien8.de, lenb@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-acpi@vger.kernel.org, devel@acpica.org, huangshaoyu@huawei.com
Subject: Re: [PATCH v10 1/5] arm64: KVM: Prepare set virtual SEI syndrome
 value
References: <1520093380-42577-1-git-send-email-gengdongjiu@huawei.com> <1520093380-42577-2-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1520093380-42577-2-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

On 03/03/18 16:09, Dongjiu Geng wrote:
> Export one API to specify virtual SEI syndrome value
> for guest, and add a helper to get the VSESR_EL2 value.

This patch adds two helpers that nothing calls... its not big, please merge it
with the patch that uses these.


> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 413dc82..3294885 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -71,6 +71,11 @@ static inline void vcpu_set_hcr(struct kvm_vcpu *vcpu, unsigned long hcr)
>  	vcpu->arch.hcr_el2 = hcr;
>  }
>  
> +static inline unsigned long vcpu_get_vsesr(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.vsesr_el2;
> +}
> +
>  static inline void vcpu_set_vsesr(struct kvm_vcpu *vcpu, u64 vsesr)
>  {
>  	vcpu->arch.vsesr_el2 = vsesr;
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index a73f63a..3dc49b7 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -354,6 +354,8 @@ void handle_exit_early(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
>  
> +void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
> +
>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
>  
>  static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index 60666a0..78ecb28 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -186,3 +186,8 @@ void kvm_inject_vabt(struct kvm_vcpu *vcpu)
>  {
>  	pend_guest_serror(vcpu, ESR_ELx_ISV);
>  }
> +
> +void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome)
> +{
> +	pend_guest_serror(vcpu, syndrome & ESR_ELx_ISS_MASK);

If you move the ISS_MASK into pend_guest_serror(), you wouldn't need this at all.

It would be better if any validation were in the user-space helpers so we can
check user-space hasn't put something funny in the top bits.

> +}
> 


Thanks,

James
