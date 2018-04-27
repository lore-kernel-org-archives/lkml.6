Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeD0TSE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:18:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932793AbeD0TSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:18:01 -0400
Date: Fri, 27 Apr 2018 21:17:58 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        marc.zyngier@arm.com, peter.maydell@linaro.org, andre.przywara@arm.com
Subject: Re: [PATCH v4 11/12] KVM: arm/arm64: Implement
 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
Message-ID: <20180427191758.GQ13249@C02W217FHV2R.local>
References: <1524838505-3823-1-git-send-email-eric.auger@redhat.com>
 <1524838505-3823-12-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524838505-3823-12-git-send-email-eric.auger@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, Apr 27, 2018 at 04:15:04PM +0200, Eric Auger wrote:
> Now all the internals are ready to handle multiple redistributor
> regions, let's allow the userspace to register them.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v3 -> v4:
> - vgic_v3_rdist_region_from_index is introduced in this patch
> 
> v2 -> v3:
> - early exit if vgic_v3_rdist_region_from_index() fails
> ---
>  virt/kvm/arm/vgic/vgic-kvm-device.c | 42 +++++++++++++++++++++++++++++++++++--
>  virt/kvm/arm/vgic/vgic-mmio-v3.c    |  4 ++--
>  virt/kvm/arm/vgic/vgic-v3.c         | 14 +++++++++++++
>  virt/kvm/arm/vgic/vgic.h            | 13 +++++++++++-
>  4 files changed, 68 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
> index e7b5a86..00e03d3 100644
> --- a/virt/kvm/arm/vgic/vgic-kvm-device.c
> +++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
> @@ -65,7 +65,8 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
>  {
>  	int r = 0;
>  	struct vgic_dist *vgic = &kvm->arch.vgic;
> -	phys_addr_t *addr_ptr, alignment;
> +	phys_addr_t *addr_ptr = NULL;
> +	phys_addr_t alignment;
>  	uint64_t undef_value = VGIC_ADDR_UNDEF;
>  
>  	mutex_lock(&kvm->lock);
> @@ -92,7 +93,7 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
>  		if (r)
>  			break;
>  		if (write) {
> -			r = vgic_v3_set_redist_base(kvm, *addr);
> +			r = vgic_v3_set_redist_base(kvm, 0, *addr, 0);
>  			goto out;
>  		}
>  		rdreg = list_first_entry(&vgic->rd_regions,
> @@ -103,6 +104,42 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
>  			addr_ptr = &rdreg->base;
>  		break;
>  	}
> +	case KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION:
> +	{
> +		struct vgic_redist_region *rdreg;
> +		uint8_t index;
> +
> +		r = vgic_check_type(kvm, KVM_DEV_TYPE_ARM_VGIC_V3);
> +		if (r)
> +			break;
> +
> +		index = *addr & KVM_VGIC_V3_RDIST_INDEX_MASK;
> +
> +		if (write) {
> +			gpa_t base = *addr & KVM_VGIC_V3_RDIST_BASE_MASK;
> +			uint32_t count = (*addr & KVM_VGIC_V3_RDIST_COUNT_MASK)
> +					>> KVM_VGIC_V3_RDIST_COUNT_SHIFT;
> +			uint8_t flags = (*addr & KVM_VGIC_V3_RDIST_FLAGS_MASK)
> +					>> KVM_VGIC_V3_RDIST_FLAGS_SHIFT;
> +
> +			if (!count || flags)
> +				r = -EINVAL;
> +			else
> +				r = vgic_v3_set_redist_base(kvm, index,
> +							    base, count);
> +			goto out;
> +		}
> +
> +		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
> +		if (!rdreg) {
> +			r = -ENODEV;
> +			goto out;
> +		}
> +
> +		*addr_ptr = rdreg->base & index &
> +			(uint64_t)rdreg->count << KVM_VGIC_V3_RDIST_COUNT_SHIFT;

This still looks wrong, please see my reply to v3.

Thanks,
-Christoffer
