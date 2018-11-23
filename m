Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0744EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE61820820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE61820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503495AbeKWVeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:34:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387655AbeKWVeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:34:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0E7D80F79;
        Fri, 23 Nov 2018 10:50:14 +0000 (UTC)
Received: from [10.36.116.235] (ovpn-116-235.ams2.redhat.com [10.36.116.235])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 990045D763;
        Fri, 23 Nov 2018 10:50:07 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v4 1/8] iommu: Add APIs for multiple domains per device
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com, kvm@vger.kernel.org
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-2-baolu.lu@linux.intel.com>
Message-ID: <51871885-05d2-febc-1dba-4d74108d0f46@redhat.com>
Date:   Fri, 23 Nov 2018 11:50:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181105073408.21815-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 23 Nov 2018 10:50:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On 11/5/18 8:34 AM, Lu Baolu wrote:
> Sharing a physical PCI device in a finer-granularity way
> is becoming a consensus in the industry. IOMMU vendors
> are also engaging efforts to support such sharing as well
> as possible. Among the efforts, the capability of support
> finer-granularity DMA isolation is a common requirement
> due to the security consideration. With finer-granularity
> DMA isolation, all DMA requests out of or to a subset of
> a physical PCI device can be protected by the IOMMU. As a
> result, there is a request in software to attach multiple
> domains to a physical PCI device. One example of such use
> model is the Intel Scalable IOV [1] [2]. The Intel vt-d
> 3.0 spec [3] introduces the scalable mode which enables
> PASID granularity DMA isolation.
> 
> This adds the APIs to support multiple domains per device.
> In order to ease the discussions, we call it 'a domain in
> auxiliary mode' or simply 'auxiliary domain' when multiple
> domains are attached to a physical device.
> 
> The APIs includes:
> 
> * iommu_get_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_CAPABILITY)
>   - Represents the ability of supporting multiple domains
>     per device.
> 
> * iommu_get_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_ENABLED)
>   - Checks whether the device identified by @dev is working
>     in auxiliary mode.
> 
> * iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_ENABLE)
>   - Enables the multiple domains capability for the device
>     referenced by @dev.
> 
> * iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_DISABLE)
>   - Disables the multiple domains capability for the device
>     referenced by @dev.
> 
> * iommu_attach_device_aux(domain, dev)
>   - Attaches @domain to @dev in the auxiliary mode. Multiple
>     domains could be attached to a single device in the
>     auxiliary mode with each domain representing an isolated
>     address space for an assignable subset of the device.
> 
> * iommu_detach_device_aux(domain, dev)
>   - Detach @domain which has been attached to @dev in the
>     auxiliary mode.
> 
> * iommu_domain_get_attr(domain, DOMAIN_ATTR_AUXD_ID)
>   - Return ID used for finer-granularity DMA translation.
>     For the Intel Scalable IOV usage model, this will be
>     a PASID. The device which supports Scalalbe IOV needs
s/Scalalbe/Scalable
>     to writes this ID to the device register so that DMA
s/writes/write
>     requests could be tagged with a right PASID prefix.
This is not crystal clear to me as the intel implementation returns the
default PASID and not the PASID of the aux domain.
> 
> Many people involved in discussions of this design.
> 
> Kevin Tian <kevin.tian@intel.com>
> Liu Yi L <yi.l.liu@intel.com>
> Ashok Raj <ashok.raj@intel.com>
> Sanjay Kumar <sanjay.k.kumar@intel.com>
> Jacob Pan <jacob.jun.pan@linux.intel.com>
> Alex Williamson <alex.williamson@redhat.com>
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> and some discussions can be found here [4].
> 
> [1] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
> [2] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
> [3] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
> [4] https://lkml.org/lkml/2018/7/26/4
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h | 52 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index edbdf5d6962c..0b7c96d1425e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2030,3 +2030,55 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
> +
> +/*
> + * Generic interfaces to get or set per device IOMMU attributions.
> + */
> +int iommu_get_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
> +{
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +
> +	if (ops && ops->get_dev_attr)
> +		return ops->get_dev_attr(dev, attr, data);
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(iommu_get_dev_attr);
> +
> +int iommu_set_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
> +{
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +
> +	if (ops && ops->set_dev_attr)
> +		return ops->set_dev_attr(dev, attr, data);
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(iommu_set_dev_attr);
> +
> +/*
> + * APIs to attach/detach a domain to/from a device in the
> + * auxiliary mode.
> + */
> +int iommu_attach_device_aux(struct iommu_domain *domain, struct device *dev)
> +{
> +	int ret = -ENODEV;
> +
> +	if (domain->ops->attach_dev_aux)
> +		ret = domain->ops->attach_dev_aux(domain, dev);
> +
> +	if (!ret)
> +		trace_attach_device_to_domain(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_attach_device_aux);
> +
> +void iommu_detach_device_aux(struct iommu_domain *domain, struct device *dev)
> +{
> +	if (domain->ops->detach_dev_aux) {
> +		domain->ops->detach_dev_aux(domain, dev);
> +		trace_detach_device_from_domain(dev);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(iommu_detach_device_aux);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a1d28f42cb77..9bf1b3f2457a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -126,6 +126,7 @@ enum iommu_attr {
>  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
>  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
>  	DOMAIN_ATTR_MAX,
> +	DOMAIN_ATTR_AUXD_ID,
>  };
>  
>  /* These are the possible reserved region types */
> @@ -156,6 +157,14 @@ struct iommu_resv_region {
>  	enum iommu_resv_type	type;
>  };
>  
> +/* Per device IOMMU attributions */
> +enum iommu_dev_attr {
> +	IOMMU_DEV_ATTR_AUXD_CAPABILITY,
> +	IOMMU_DEV_ATTR_AUXD_ENABLED,
> +	IOMMU_DEV_ATTR_AUXD_ENABLE,
> +	IOMMU_DEV_ATTR_AUXD_DISABLE,
> +};
> +
>  #ifdef CONFIG_IOMMU_API
>  
>  /**
> @@ -183,6 +192,8 @@ struct iommu_resv_region {
>   * @domain_window_enable: Configure and enable a particular window for a domain
>   * @domain_window_disable: Disable a particular window for a domain
>   * @of_xlate: add OF master IDs to iommu grouping
> + * @get_dev_attr: get per device IOMMU attributions
s/attributions/attributes here and other locations?
> + * @set_dev_attr: set per device IOMMU attributions
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>   */
>  struct iommu_ops {
> @@ -226,6 +237,15 @@ struct iommu_ops {
>  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>  	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
>  
> +	/* Get/set per device IOMMU attributions */
> +	int (*get_dev_attr)(struct device *dev,
> +			    enum iommu_dev_attr attr, void *data);
> +	int (*set_dev_attr)(struct device *dev,
> +			    enum iommu_dev_attr attr, void *data);
> +	/* Attach/detach aux domain */
> +	int (*attach_dev_aux)(struct iommu_domain *domain, struct device *dev);
> +	void (*detach_dev_aux)(struct iommu_domain *domain, struct device *dev);
> +
>  	unsigned long pgsize_bitmap;
>  };
>  
> @@ -398,6 +418,16 @@ void iommu_fwspec_free(struct device *dev);
>  int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
>  const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
>  
> +int iommu_get_dev_attr(struct device *dev,
> +		       enum iommu_dev_attr attr, void *data);
> +int iommu_set_dev_attr(struct device *dev,
> +		       enum iommu_dev_attr attr, void *data);
> +
> +extern int iommu_attach_device_aux(struct iommu_domain *domain,
> +				   struct device *dev);
> +extern void iommu_detach_device_aux(struct iommu_domain *domain,
> +				    struct device *dev);
> +
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -682,6 +712,28 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>  	return NULL;
>  }
>  
> +static inline int
> +iommu_get_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int
> +iommu_set_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int
> +iommu_attach_device_aux(struct iommu_domain *domain, struct device *dev)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void
> +iommu_detach_device_aux(struct iommu_domain *domain, struct device *dev)
> +{
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  #ifdef CONFIG_IOMMU_DEBUGFS
> 

Thanks

Eric
