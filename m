Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeDCPBc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:01:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33790 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeDCPBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:01:30 -0400
Subject: Re: [PATCH v2 11/17] kvm: arm64: Configure VTCR per VM
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, cdall@kernel.org,
        marc.zyngier@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        ard.biesheuvel@linaro.org, peter.maydell@linaro.org,
        kristina.martsenko@arm.com, mark.rutland@arm.com
References: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
 <1522156531-28348-12-git-send-email-suzuki.poulose@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <be9e8c47-8366-2d8f-8d8d-b8d2f978107b@arm.com>
Date: Tue, 3 Apr 2018 15:58:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522156531-28348-12-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 27/03/18 14:15, Suzuki K Poulose wrote:
> We set VTCR_EL2 very early during the stage2 init and don't
> touch it ever. This is fine as we had a fixed IPA size. This
> patch changes the behavior to set the VTCR for a given VM,
> depending on its stage2 table. The common configuration for
> VTCR is still performed during the early init as we have to
> retain the hardware access flag update bits (VTCR_EL2_HA)
> per CPU (as they are only set for the CPUs which are capabile).

(Nit: capable)


> The bits defining the number of levels in the page table (SL0)
> and and the size of the Input address to the translation (T0SZ)
> are programmed for each VM upon entry to the guest.

> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 870f4b1..5ccd3ae 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -164,6 +164,12 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
>  static void __hyp_text __activate_vm(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
> +	u64 vtcr = read_sysreg(vtcr_el2);
> +
> +	vtcr &= ~VTCR_EL2_PRIVATE_MASK;
> +	vtcr |= VTCR_EL2_SL0(kvm_stage2_levels(kvm)) |
> +		VTCR_EL2_T0SZ(kvm_phys_shift(kvm));
> +	write_sysreg(vtcr, vtcr_el2);
>  	write_sysreg(kvm->arch.vttbr, vttbr_el2);
>  }

Do we need to set this register for tlb maintenance too?
e.g. tlbi for a 3-level-stage2 vm when a 2-level-stage2 vm's vtcr is loaded...

(The ARM-ARM has 'Any of the bits of VTCR_EL2 are permitted to be cached in a TLB'.)


Thanks,

James
