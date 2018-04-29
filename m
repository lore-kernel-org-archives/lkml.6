Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeD2MfW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 08:35:22 -0400
Received: from foss.arm.com ([217.140.101.70]:52442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753221AbeD2MfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 08:35:20 -0400
Date: Sun, 29 Apr 2018 14:35:16 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        marc.zyngier@arm.com, peter.maydell@linaro.org, andre.przywara@arm.com
Subject: Re: [PATCH v4 08/12] KVM: arm/arm64: Check vcpu redist base before
 registering an iodev
Message-ID: <20180429123516.GD7512@C02W217FHV2R.local>
References: <1524838505-3823-1-git-send-email-eric.auger@redhat.com>
 <1524838505-3823-9-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524838505-3823-9-git-send-email-eric.auger@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 04:15:01PM +0200, Eric Auger wrote:
> As we are going to register several redist regions,
> vgic_register_all_redist_iodevs() may be called several times. We need
> to register a redist_iodev for a given vcpu only once. So let's
> check if the base address has already been set. Initialize this latter
> in kvm_vgic_vcpu_early_init().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

> ---
>  virt/kvm/arm/vgic/vgic-init.c    | 3 +++
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> index 6456371..7e040e7 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -82,6 +82,9 @@ void kvm_vgic_vcpu_early_init(struct kvm_vcpu *vcpu)
>  	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
>  	spin_lock_init(&vgic_cpu->ap_list_lock);
>  
> +	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
> +	vgic_cpu->sgi_iodev.base_addr = VGIC_ADDR_UNDEF;
> +
>  	/*
>  	 * Enable and configure all SGIs to be edge-triggered and
>  	 * configure all PPIs as level-triggered.
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index cbf8f4e..1b1e07f 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -592,6 +592,9 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
>  	gpa_t rd_base, sgi_base;
>  	int ret;
>  
> +	if (!IS_VGIC_ADDR_UNDEF(vgic_cpu->rd_iodev.base_addr))
> +		return 0;
> +
>  	/*
>  	 * We may be creating VCPUs before having set the base address for the
>  	 * redistributor region, in which case we will come back to this
> -- 
> 2.5.5
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
