Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610BEC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A1520652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A1520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeICHPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:15:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:32637 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeICHPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:15:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2018 19:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,323,1531810800"; 
   d="scan'208";a="67902651"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2018 19:56:57 -0700
Cc:     baolu.lu@linux.intel.com, linuxarm@huawei.com
Subject: Re: [PATCH 3/7] vfio: add sdmdev support
To:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180903005204.26041-4-nek.in.cn@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4ea51b20-dcc1-db32-18eb-24a004ab9085@linux.intel.com>
Date:   Mon, 3 Sep 2018 10:55:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903005204.26041-4-nek.in.cn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/03/2018 08:52 AM, Kenneth Lee wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> SDMDEV is "Share Domain Mdev". It is a vfio-mdev. But differ from
> the general vfio-mdev, it shares its parent's IOMMU. If Multi-PASID
> support is enabled in the IOMMU (not yet in the current kernel HEAD),
> multiple process can share the IOMMU by different PASID. If it is not
> support, only one process can share the IOMMU with the kernel driver.
> 

If only for share domain purpose, I don't think it's necessary to create
a new device type.

> Currently only the vfio type-1 driver is updated to make it to be aware
> of.
> 
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>   drivers/vfio/Kconfig              |   1 +
>   drivers/vfio/Makefile             |   1 +
>   drivers/vfio/sdmdev/Kconfig       |  10 +
>   drivers/vfio/sdmdev/Makefile      |   3 +
>   drivers/vfio/sdmdev/vfio_sdmdev.c | 363 ++++++++++++++++++++++++++++++
>   drivers/vfio/vfio_iommu_type1.c   | 151 ++++++++++++-
>   include/linux/vfio_sdmdev.h       |  96 ++++++++
>   include/uapi/linux/vfio_sdmdev.h  |  29 +++
>   8 files changed, 648 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/vfio/sdmdev/Kconfig
>   create mode 100644 drivers/vfio/sdmdev/Makefile
>   create mode 100644 drivers/vfio/sdmdev/vfio_sdmdev.c
>   create mode 100644 include/linux/vfio_sdmdev.h
>   create mode 100644 include/uapi/linux/vfio_sdmdev.h
> 

[--cut for short --]

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index d9fd3188615d..ba73231d8692 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -41,6 +41,7 @@
>   #include <linux/notifier.h>
>   #include <linux/dma-iommu.h>
>   #include <linux/irqdomain.h>
> +#include <linux/vfio_sdmdev.h>
>   
>   #define DRIVER_VERSION  "0.2"
>   #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
> @@ -89,6 +90,8 @@ struct vfio_dma {
>   };
>   
>   struct vfio_group {
> +	/* iommu_group of mdev's parent device */
> +	struct iommu_group	*parent_group;
>   	struct iommu_group	*iommu_group;
>   	struct list_head	next;
>   };
> @@ -1327,6 +1330,109 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
>   	return ret;
>   }
>   
> +/* return 0 if the device is not sdmdev.
> + * return 1 if the device is sdmdev, the data will be updated with parent
> + *	device's group.
> + * return -errno if other error.
> + */
> +static int vfio_sdmdev_type(struct device *dev, void *data)
> +{
> +	struct iommu_group **group = data;
> +	struct iommu_group *pgroup;
> +	int (*_is_sdmdev)(struct device *dev);
> +	struct device *pdev;
> +	int ret = 1;
> +
> +	/* vfio_sdmdev module is not configurated */
> +	_is_sdmdev = symbol_get(vfio_sdmdev_is_sdmdev);
> +	if (!_is_sdmdev)
> +		return 0;
> +
> +	/* check if it belongs to vfio_sdmdev device */
> +	if (!_is_sdmdev(dev)) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	pdev = dev->parent;
> +	pgroup = iommu_group_get(pdev);
> +	if (!pgroup) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (group) {
> +		/* check if all parent devices is the same */
> +		if (*group && *group != pgroup)
> +			ret = -ENODEV;
> +		else
> +			*group = pgroup;
> +	}
> +
> +	iommu_group_put(pgroup);
> +
> +out:
> +	symbol_put(vfio_sdmdev_is_sdmdev);
> +
> +	return ret;
> +}
> +
> +/* return 0 or -errno */
> +static int vfio_sdmdev_bus(struct device *dev, void *data)
> +{
> +	struct bus_type **bus = data;
> +
> +	if (!dev->bus)
> +		return -ENODEV;
> +
> +	/* ensure all devices has the same bus_type */
> +	if (*bus && *bus != dev->bus)
> +		return -EINVAL;
> +
> +	*bus = dev->bus;
> +	return 0;
> +}
> +
> +/* return 0 means it is not sd group, 1 means it is, or -EXXX for error */
> +static int vfio_iommu_type1_attach_sdgroup(struct vfio_domain *domain,
> +					    struct vfio_group *group,
> +					    struct iommu_group *iommu_group)
> +{
> +	int ret;
> +	struct bus_type *pbus = NULL;
> +	struct iommu_group *pgroup = NULL;
> +
> +	ret = iommu_group_for_each_dev(iommu_group, &pgroup,
> +				       vfio_sdmdev_type);
> +	if (ret < 0)
> +		goto out;
> +	else if (ret > 0) {
> +		domain->domain = iommu_group_share_domain(pgroup);
> +		if (IS_ERR(domain->domain))
> +			goto out;
> +		ret = iommu_group_for_each_dev(pgroup, &pbus,
> +				       vfio_sdmdev_bus);
> +		if (ret < 0)
> +			goto err_with_share_domain;
> +
> +		if (pbus && iommu_capable(pbus, IOMMU_CAP_CACHE_COHERENCY))
> +			domain->prot |= IOMMU_CACHE;
> +
> +		group->parent_group = pgroup;
> +		INIT_LIST_HEAD(&domain->group_list);
> +		list_add(&group->next, &domain->group_list);
> +
> +		return 1;
> +	}

This doesn't match the function name. It only gets the domain from the
parent device. It hasn't been really attached.

> +
> +	return 0;
> +
> +err_with_share_domain:
> +	iommu_group_unshare_domain(pgroup);
> +out:
> +	return ret;
> +}
> +
>   static int vfio_iommu_type1_attach_group(void *iommu_data,
>   					 struct iommu_group *iommu_group)
>   {
> @@ -1335,8 +1441,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   	struct vfio_domain *domain, *d;
>   	struct bus_type *bus = NULL, *mdev_bus;
>   	int ret;
> -	bool resv_msi, msi_remap;
> -	phys_addr_t resv_msi_base;
> +	bool resv_msi = false, msi_remap;
> +	phys_addr_t resv_msi_base = 0;
>   
>   	mutex_lock(&iommu->lock);
>   
> @@ -1373,6 +1479,14 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   	if (mdev_bus) {
>   		if ((bus == mdev_bus) && !iommu_present(bus)) {
>   			symbol_put(mdev_bus_type);
> +
> +			ret = vfio_iommu_type1_attach_sdgroup(domain, group,
> +					iommu_group);
> +			if (ret < 0)
> +				goto out_free;
> +			else if (ret > 0)
> +				goto replay_check;

Here you get the domain from the parent device and save it for later
use. The actual attaching is ignored.

I don't think this follows the philosophy of this function. It actually
make all devices in the group with the same bus type to share a single
domain.

Further more, the parent domain might be a domain of type
IOMMU_DOMAIN_DMA. That will not be able to use as an
IOMMU_DOMAIN_UNMANAGED domain for iommu APIs.

Best regards,
Lu Baolu
