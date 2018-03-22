Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeCVQWj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:22:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbeCVQWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:22:34 -0400
Date: Thu, 22 Mar 2018 10:21:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: <eric.auger@redhat.com>, <pmorel@linux.vnet.ibm.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 7/7] iommu/dma: Move PCI window region reservation
 back into dma specific path.
Message-ID: <20180322102148.29afce09@w520.home>
In-Reply-To: <20180315163509.17740-8-shameerali.kolothum.thodi@huawei.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
        <20180315163509.17740-8-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 16:35:09 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This pretty much reverts commit 273df9635385 ("iommu/dma: Make PCI
> window reservation generic")  by moving the PCI window region
> reservation back into the dma specific path so that these regions
> doesn't get exposed via the IOMMU API interface. With this change,
> the vfio interface will report only iommu specific reserved regions
> to the user space.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---

As currently ordered, we expose the iova list to the user in 5/7 with
the PCI window reservations still intact.  Isn't that a bisection
problem?  This patch should come before the iova list is expose to the
user.  This is otherwise independent, so I can pop it up in the stack on
commit, but I'd need an ack from Joerg and Robin to take it via my
tree.  Thanks,

Alex

>  drivers/iommu/dma-iommu.c | 54 ++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f05f3cf..ddcbbdb 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -167,40 +167,16 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
>   * @list: Reserved region list from iommu_get_resv_regions()
>   *
>   * IOMMU drivers can use this to implement their .get_resv_regions callback
> - * for general non-IOMMU-specific reservations. Currently, this covers host
> - * bridge windows for PCI devices and GICv3 ITS region reservation on ACPI
> - * based ARM platforms that may require HW MSI reservation.
> + * for general non-IOMMU-specific reservations. Currently, this covers GICv3
> + * ITS region reservation on ACPI based ARM platforms that may require HW MSI
> + * reservation.
>   */
>  void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>  {
> -	struct pci_host_bridge *bridge;
> -	struct resource_entry *window;
> -
> -	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
> -		iort_iommu_msi_get_resv_regions(dev, list) < 0)
> -		return;
> -
> -	if (!dev_is_pci(dev))
> -		return;
> -
> -	bridge = pci_find_host_bridge(to_pci_dev(dev)->bus);
> -	resource_list_for_each_entry(window, &bridge->windows) {
> -		struct iommu_resv_region *region;
> -		phys_addr_t start;
> -		size_t length;
> -
> -		if (resource_type(window->res) != IORESOURCE_MEM)
> -			continue;
>  
> -		start = window->res->start - window->offset;
> -		length = window->res->end - window->res->start + 1;
> -		region = iommu_alloc_resv_region(start, length, 0,
> -				IOMMU_RESV_RESERVED);
> -		if (!region)
> -			return;
> +	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
> +		iort_iommu_msi_get_resv_regions(dev, list);
>  
> -		list_add_tail(&region->list, list);
> -	}
>  }
>  EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>  
> @@ -229,6 +205,23 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
>  	return 0;
>  }
>  
> +static void iova_reserve_pci_windows(struct pci_dev *dev,
> +		struct iova_domain *iovad)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	struct resource_entry *window;
> +	unsigned long lo, hi;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		if (resource_type(window->res) != IORESOURCE_MEM)
> +			continue;
> +
> +		lo = iova_pfn(iovad, window->res->start - window->offset);
> +		hi = iova_pfn(iovad, window->res->end - window->offset);
> +		reserve_iova(iovad, lo, hi);
> +	}
> +}
> +
>  static int iova_reserve_iommu_regions(struct device *dev,
>  		struct iommu_domain *domain)
>  {
> @@ -238,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device *dev,
>  	LIST_HEAD(resv_regions);
>  	int ret = 0;
>  
> +	if (dev_is_pci(dev))
> +		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
> +
>  	iommu_get_resv_regions(dev, &resv_regions);
>  	list_for_each_entry(region, &resv_regions, list) {
>  		unsigned long lo, hi;
