Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E60C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8C720844
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8C720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbeKGJVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:21:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730700AbeKGJVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:21:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A40A3154876;
        Tue,  6 Nov 2018 23:54:01 +0000 (UTC)
Received: from w520.home (ovpn-116-133.phx2.redhat.com [10.3.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34BBC177AE;
        Tue,  6 Nov 2018 23:53:57 +0000 (UTC)
Date:   Tue, 6 Nov 2018 16:53:56 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in
 mdev_device
Message-ID: <20181106165356.44b59ec3@w520.home>
In-Reply-To: <20181105073408.21815-7-baolu.lu@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
        <20181105073408.21815-7-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 06 Nov 2018 23:54:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 15:34:06 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> A parent device might create different types of mediated
> devices. For example, a mediated device could be created
> by the parent device with full isolation and protection
> provided by the IOMMU. One usage case could be found on
> Intel platforms where a mediated device is an assignable
> subset of a PCI, the DMA requests on behalf of it are all
> tagged with a PASID. Since IOMMU supports PASID-granular
> translations (scalable mode in vt-d 3.0), this mediated
> device could be individually protected and isolated by an
> IOMMU.
> 
> This patch adds two new members in struct mdev_device:
> * iommu_device
>   - This, if set, indicates that the mediated device could
>     be fully isolated and protected by IOMMU via attaching
>     an iommu domain to this device. If empty, it indicates
>     using vendor defined isolation.
> 
> * iommu_domain
>   - This is a place holder for an iommu domain. A domain
>     could be store here for later use once it has been
>     attached to the iommu_device of this mdev.
> 
> Below helpers are added to set and get above iommu device
> and iommu domain pointers.
> 
> * mdev_set/get_iommu_device(dev, iommu_device)
>   - Set or get the iommu device which represents this mdev
>     in IOMMU's device scope. Drivers don't need to set the
>     iommu device if it uses vendor defined isolation.
> 
> * mdev_set/get_iommu_domain(domain)
>   - A iommu domain which has been attached to the iommu
>     device in order to protect and isolate the mediated
>     device will be kept in the mdev data structure and
>     could be retrieved later.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 36 ++++++++++++++++++++++++++++++++
>  drivers/vfio/mdev/mdev_private.h |  2 ++
>  include/linux/mdev.h             | 23 ++++++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 0212f0ee8aea..5119809225c5 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -390,6 +390,42 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>  	return 0;
>  }
>  
> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	mdev->iommu_device = iommu_device;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mdev_set_iommu_device);
> +
> +struct device *mdev_get_iommu_device(struct device *dev)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	return mdev->iommu_device;
> +}
> +EXPORT_SYMBOL(mdev_get_iommu_device);
> +
> +int mdev_set_iommu_domain(struct device *dev, void *domain)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	mdev->iommu_domain = domain;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mdev_set_iommu_domain);
> +
> +void *mdev_get_iommu_domain(struct device *dev)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	return mdev->iommu_domain;
> +}
> +EXPORT_SYMBOL(mdev_get_iommu_domain);
> +
>  static int __init mdev_init(void)
>  {
>  	return mdev_bus_register();
> diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
> index b5819b7d7ef7..c01518068e84 100644
> --- a/drivers/vfio/mdev/mdev_private.h
> +++ b/drivers/vfio/mdev/mdev_private.h
> @@ -34,6 +34,8 @@ struct mdev_device {
>  	struct list_head next;
>  	struct kobject *type_kobj;
>  	bool active;
> +	struct device *iommu_device;
> +	void *iommu_domain;
>  };
>  
>  #define to_mdev_device(dev)	container_of(dev, struct mdev_device, dev)
> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> index b6e048e1045f..c46777d3e568 100644
> --- a/include/linux/mdev.h
> +++ b/include/linux/mdev.h
> @@ -14,6 +14,29 @@
>  #define MDEV_H
>  
>  struct mdev_device;
> +struct iommu_domain;
> +
> +/*
> + * Called by the parent device driver to set the PCI device which represents

s/PCI //

There is no requirement or expectation that the device is PCI.

> + * this mdev in iommu protection scope. By default, the iommu device is NULL,
> + * that indicates using vendor defined isolation.
> + *
> + * @dev: the mediated device that iommu will isolate.
> + * @iommu_device: a pci device which represents the iommu for @dev.
> + *
> + * Return 0 for success, otherwise negative error value.
> + */
> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device);
> +
> +struct device *mdev_get_iommu_device(struct device *dev);
> +
> +/*
> + * Called by vfio iommu modules to save the iommu domain after a domain being
> + * attached to the mediated device.
> + */
> +int mdev_set_iommu_domain(struct device *dev, void *domain);
> +
> +void *mdev_get_iommu_domain(struct device *dev);

I can't say I really understand the purpose of this, the cover letter
indicates this is a placeholder, should we add it separately when we
have a requirement for it?  Thanks,

Alex
