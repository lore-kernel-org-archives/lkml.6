Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeD3JmU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:42:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56938 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752509AbeD3JmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:42:18 -0400
Date: Mon, 30 Apr 2018 11:42:15 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        marc.zyngier@arm.com, cdall@kernel.org, peter.maydell@linaro.org,
        andre.przywara@arm.com
Subject: Re: [PATCH v5 07/12] KVM: arm/arm64: Helper to register a new
 redistributor region
Message-ID: <20180430094215.GB12204@C02W217FHV2R.local>
References: <1525079264-25533-1-git-send-email-eric.auger@redhat.com>
 <1525079264-25533-8-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525079264-25533-8-git-send-email-eric.auger@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 11:07:39AM +0200, Eric Auger wrote:
> We introduce a new helper that creates and inserts a new redistributor
> region into the rdist region list. This helper both handles the case
> where the redistributor region size is known at registration time
> and the legacy case where it is not (eventually depending on the number
> of online vcpus). Depending on pfns, we perform all the possible checks
> that we can do:
> 
> - end of memory crossing
> - incorrect alignment of the base address
> - collision with distributor region if already defined
> - collision with already registered rdist regions
> - check of the new index
> 
> Rdist regions must be inserted by increasing order of indices. Indices
> must be contiguous.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - inversed check in vgic_v3_rdist_overlap

Which is now in patch 6, but that looks fine to me, so I stand by my
reviewed-by on that patch.

> - use list_last_entry in vgic_v3_insert_redist_region
> - improve comment in vgic_v3_insert_redist_region
> - introduce vgic_dist_overlap
> ---
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 89 ++++++++++++++++++++++++++++++++--------
>  virt/kvm/arm/vgic/vgic.h         |  8 ++++
>  2 files changed, 81 insertions(+), 16 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index ce5c927..cbf8f4e 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -680,14 +680,63 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
>  	return ret;
>  }
>  
> -int vgic_v3_set_redist_base(struct kvm *kvm, u64 addr)
> +/**
> + * vgic_v3_insert_redist_region - Insert a new redistributor region
> + *
> + * Performs various checks before inserting the rdist region in the list.
> + * Those tests depend on whether the size of the rdist region is known
> + * (ie. count != 0). The list is sorted by rdist region index.
> + *
> + * @kvm: kvm handle
> + * @index: redist region index
> + * @base: base of the new rdist region
> + * @count: number of redistributors the region is made of (of 0 in the old style
> + * single region, whose size is induced from the number of vcpus)
> + *
> + * Return 0 on success, < 0 otherwise
> + */
> +static int vgic_v3_insert_redist_region(struct kvm *kvm, uint32_t index,
> +					gpa_t base, uint32_t count)
>  {
> -	struct vgic_dist *vgic = &kvm->arch.vgic;
> +	struct vgic_dist *d = &kvm->arch.vgic;
>  	struct vgic_redist_region *rdreg;
> +	struct list_head *rd_regions = &d->rd_regions;
> +	struct list_head *last = rd_regions->prev;
> +	size_t size = count * KVM_VGIC_V3_REDIST_SIZE;
>  	int ret;
>  
> -	/* vgic_check_ioaddr makes sure we don't do this twice */
> -	if (!list_empty(&vgic->rd_regions))
> +	/* single rdist region already set ?*/
> +	if (!count && !list_empty(rd_regions))
> +		return -EINVAL;
> +
> +	/* cross the end of memory ? */
> +	if (base + size < base)
> +		return -EINVAL;
> +
> +	if (list_empty(rd_regions)) {
> +		if (index != 0)
> +			return -EINVAL;
> +	} else {
> +		rdreg = list_entry(last, struct vgic_redist_region, list);

Looks like you may have forgotten to actually change this?

> +		if (index != rdreg->index + 1)
> +			return -EINVAL;
> +
> +		/* Cannot add an explicitly sized regions after legacy region */
> +		if (!rdreg->count)
> +			return -EINVAL;
> +	}
> +
> +	/*
> +	 * For legacy single-region redistributor regions (!count),
> +	 * check that the redistributor region does not overlap with the
> +	 * distributor's address space.
> +	 */
> +	if (!count && !IS_VGIC_ADDR_UNDEF(d->vgic_dist_base) &&
> +		vgic_dist_overlap(kvm, base, size))
> +		return -EINVAL;
> +
> +	/* collision with any other rdist region? */
> +	if (vgic_v3_rdist_overlap(kvm, base, size))
>  		return -EINVAL;
>  
>  	rdreg = kzalloc(sizeof(*rdreg), GFP_KERNEL);
> @@ -696,17 +745,29 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u64 addr)
>  
>  	rdreg->base = VGIC_ADDR_UNDEF;
>  
> -	ret = vgic_check_ioaddr(kvm, &rdreg->base, addr, SZ_64K);
> +	ret = vgic_check_ioaddr(kvm, &rdreg->base, base, SZ_64K);
>  	if (ret)
> -		goto out;
> +		goto free;
>  
> -	rdreg->base = addr;
> -	if (!vgic_v3_check_base(kvm)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	rdreg->base = base;
> +	rdreg->count = count;
> +	rdreg->free_index = 0;
> +	rdreg->index = index;
>  
> -	list_add(&rdreg->list, &vgic->rd_regions);
> +	list_add_tail(&rdreg->list, rd_regions);
> +	return 0;
> +free:
> +	kfree(rdreg);
> +	return ret;
> +}
> +
> +int vgic_v3_set_redist_base(struct kvm *kvm, u64 addr)
> +{
> +	int ret;
> +
> +	ret = vgic_v3_insert_redist_region(kvm, 0, addr, 0);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Register iodevs for each existing VCPU.  Adding more VCPUs
> @@ -717,10 +778,6 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u64 addr)
>  		return ret;
>  
>  	return 0;
> -
> -out:
> -	kfree(rdreg);
> -	return ret;
>  }
>  
>  int vgic_v3_has_attr_regs(struct kvm_device *dev, struct kvm_device_attr *attr)
> diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
> index e6e3ae9..6af7d8a 100644
> --- a/virt/kvm/arm/vgic/vgic.h
> +++ b/virt/kvm/arm/vgic/vgic.h
> @@ -272,6 +272,14 @@ vgic_v3_rd_region_size(struct kvm *kvm, struct vgic_redist_region *rdreg)
>  }
>  bool vgic_v3_rdist_overlap(struct kvm *kvm, gpa_t base, size_t size);
>  
> +static inline bool vgic_dist_overlap(struct kvm *kvm, gpa_t base, size_t size)
> +{
> +	struct vgic_dist *d = &kvm->arch.vgic;
> +
> +	return (base + size > d->vgic_dist_base) &&
> +		(base < d->vgic_dist_base + KVM_VGIC_V3_DIST_SIZE);
> +}
> +
>  int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
>  			 u32 devid, u32 eventid, struct vgic_irq **irq);
>  struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi);
> -- 
> 2.5.5
> 

Besides the nit about using list_last_entry():

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
