Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeDXVHG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:07:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbeDXVG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:06:59 -0400
Date: Tue, 24 Apr 2018 23:06:55 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        marc.zyngier@arm.com, cdall@kernel.org, peter.maydell@linaro.org,
        andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: Re: [PATCH v3 05/12] KVM: arm/arm64: Revisit Redistributor TYPER
 last bit computation
Message-ID: <20180424210655.GF4533@C02W217FHV2R.local>
References: <1523607658-9166-1-git-send-email-eric.auger@redhat.com>
 <1523607658-9166-6-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523607658-9166-6-git-send-email-eric.auger@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 10:20:51AM +0200, Eric Auger wrote:
> The TYPER of an redistributor reflects whether the rdist is
> the last one of the redistributor region. Let's compare the TYPER
> GPA against the address of the last occupied slot within the
> redistributor region.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index 49ca176..ce5c927 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -184,12 +184,17 @@ static unsigned long vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
>  					      gpa_t addr, unsigned int len)
>  {
>  	unsigned long mpidr = kvm_vcpu_get_mpidr_aff(vcpu);
> +	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> +	struct vgic_redist_region *rdreg = vgic_cpu->rdreg;
>  	int target_vcpu_id = vcpu->vcpu_id;
> +	gpa_t last_rdist_typer = rdreg->base + GICR_TYPER +
> +			(rdreg->free_index - 1) * KVM_VGIC_V3_REDIST_SIZE;
>  	u64 value;
>  
>  	value = (u64)(mpidr & GENMASK(23, 0)) << 32;
>  	value |= ((target_vcpu_id & 0xffff) << 8);
> -	if (target_vcpu_id == atomic_read(&vcpu->kvm->online_vcpus) - 1)
> +
> +	if (addr == last_rdist_typer)
>  		value |= GICR_TYPER_LAST;
>  	if (vgic_has_its(vcpu->kvm))
>  		value |= GICR_TYPER_PLPIS;
> -- 
> 2.5.5
> 

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
