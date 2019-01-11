Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35833C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF6920878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfAKWo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:44:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAKWoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:44:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA0CD356F3;
        Fri, 11 Jan 2019 22:44:24 +0000 (UTC)
Received: from x1.home (ovpn-116-25.phx2.redhat.com [10.3.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 875A46A6A7;
        Fri, 11 Jan 2019 22:44:20 +0000 (UTC)
Date:   Fri, 11 Jan 2019 15:44:19 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@linux.intel.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com, ashok.raj@intel.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        peter.maydell@linaro.org
Subject: Re: [RFC v3 03/21] iommu: Introduce bind_guest_msi
Message-ID: <20190111154419.502b3850@x1.home>
In-Reply-To: <20190108102633.17482-4-eric.auger@redhat.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
        <20190108102633.17482-4-eric.auger@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 11 Jan 2019 22:44:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Jan 2019 11:26:15 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> On ARM, MSI are translated by the SMMU. An IOVA is allocated
> for each MSI doorbell. If both the host and the guest are exposed
> with SMMUs, we end up with 2 different IOVAs allocated by each.
> guest allocates an IOVA (gIOVA) to map onto the guest MSI
> doorbell (gDB). The Host allocates another IOVA (hIOVA) to map
> onto the physical doorbell (hDB).
> 
> So we end up with 2 untied mappings:
>          S1            S2
> gIOVA    ->    gDB
>               hIOVA    ->    gDB
                               ^^^ hDB

> Currently the PCI device is programmed by the host with hIOVA
> as MSI doorbell. So this does not work.
> 
> This patch introduces an API to pass gIOVA/gDB to the host so
> that gIOVA can be reused by the host instead of re-allocating
> a new IOVA. So the goal is to create the following nested mapping:
> 
>          S1            S2
> gIOVA    ->    gDB     ->    hDB
> 
> and program the PCI device with gIOVA MSI doorbell.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - add a struct device handle
> ---
>  drivers/iommu/iommu.c      | 10 ++++++++++
>  include/linux/iommu.h      | 13 +++++++++++++
>  include/uapi/linux/iommu.h |  6 ++++++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b2e248770508..ea11442e7054 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1431,6 +1431,16 @@ static void __iommu_detach_device(struct iommu_domain *domain,
>  	trace_detach_device_from_domain(dev);
>  }
>  
> +int iommu_bind_guest_msi(struct iommu_domain *domain, struct device *dev,
> +			 struct iommu_guest_msi_binding *binding)
> +{
> +	if (unlikely(!domain->ops->bind_guest_msi))
> +		return -ENODEV;
> +
> +	return domain->ops->bind_guest_msi(domain, dev, binding);
> +}
> +EXPORT_SYMBOL_GPL(iommu_bind_guest_msi);
> +
>  void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
>  {
>  	struct iommu_group *group;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 96d59886f230..244c1a3d5989 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -235,6 +235,9 @@ struct iommu_ops {
>  	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
>  				struct iommu_cache_invalidate_info *inv_info);
>  
> +	int (*bind_guest_msi)(struct iommu_domain *domain, struct device *dev,
> +			      struct iommu_guest_msi_binding *binding);
> +
>  	unsigned long pgsize_bitmap;
>  };
>  
> @@ -301,6 +304,9 @@ extern int iommu_set_pasid_table(struct iommu_domain *domain,
>  extern int iommu_cache_invalidate(struct iommu_domain *domain,
>  				struct device *dev,
>  				struct iommu_cache_invalidate_info *inv_info);
> +extern int iommu_bind_guest_msi(struct iommu_domain *domain, struct device *dev,
> +				struct iommu_guest_msi_binding *binding);
> +
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> @@ -724,6 +730,13 @@ iommu_cache_invalidate(struct iommu_domain *domain,
>  	return -ENODEV;
>  }
>  
> +static inline
> +int iommu_bind_guest_msi(struct iommu_domain *domain, struct device *dev,
> +			 struct iommu_guest_msi_binding *binding)
> +{
> +	return -ENODEV;
> +}
> +
>  #endif /* CONFIG_IOMMU_API */
>  
>  #ifdef CONFIG_IOMMU_DEBUGFS
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 4605f5cfac84..f28cd9a1aa96 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -142,4 +142,10 @@ struct iommu_cache_invalidate_info {
>  	__u64		arch_id;
>  	__u64		addr;
>  };
> +
> +struct iommu_guest_msi_binding {
> +	__u64		iova;
> +	__u64		gpa;
> +	__u32		granule;

What's granule?  The size?  This looks a lot like just a stage 1
mapping interface, I can't really figure out from the description how
this matches to any specific MSI mapping.  Zero comments in the code
or headers here about how this is supposed to work.  Thanks,

Alex
