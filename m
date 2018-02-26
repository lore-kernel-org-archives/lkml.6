Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeBZWFx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:05:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751994AbeBZWFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:05:51 -0500
Subject: Re: [PATCH v4 4/6] vfio/type1: check dma map request is within a
 valid iova range
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com
References: <20180221122209.9292-1-shameerali.kolothum.thodi@huawei.com>
 <20180221122209.9292-5-shameerali.kolothum.thodi@huawei.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        john.garry@huawei.com, xuwei5@hisilicon.com,
        Robin Murphy <robin.murphy@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <818b3bc3-e2e1-e8df-8cca-17e6ecaf4ef9@redhat.com>
Date: Mon, 26 Feb 2018 23:05:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180221122209.9292-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

[Adding Robin in CC]
On 21/02/18 13:22, Shameer Kolothum wrote:
> This checks and rejects any dma map request outside valid iova
> range.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index a80884e..3049393 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -970,6 +970,23 @@ static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  	return ret;
>  }
>  
> +/*
> + * Check dma map request is within a valid iova range
> + */
> +static bool vfio_iommu_iova_dma_valid(struct vfio_iommu *iommu,
> +				dma_addr_t start, dma_addr_t end)
> +{
> +	struct list_head *iova = &iommu->iova_list;
> +	struct vfio_iova *node;
> +
> +	list_for_each_entry(node, iova, list) {
> +		if ((start >= node->start) && (end <= node->end))
> +			return true;
I am now confused by the fact this change will prevent existing QEMU
from working with this series on some platforms. For instance QEMU virt
machine GPA space collides with Seattle PCI host bridge windows. On ARM
the smmu and smmuv3 drivers report the PCI host bridge windows as
reserved regions which does not seem to be the case on other platforms.
The change happened in commit 273df9635385b2156851c7ee49f40658d7bcb29d
(iommu/dma: Make PCI window reservation generic).

For background, we already discussed the topic after LPC 2016. See
https://www.spinics.net/lists/kernel/msg2379607.html.

So is it the right choice to expose PCI host bridge windows as reserved
regions? If yes shouldn't we make a difference between those and MSI
windows in this series and do not reject any user space DMA_MAP attempt
within PCI host bridge windows.

Thanks

Eric
> +	}
> +
> +	return false;
> +}
> +
>  static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  			   struct vfio_iommu_type1_dma_map *map)
>  {
> @@ -1008,6 +1025,11 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  		goto out_unlock;
>  	}
>  
> +	if (!vfio_iommu_iova_dma_valid(iommu, iova, iova + size - 1)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
>  	if (!dma) {
>  		ret = -ENOMEM;
> 
