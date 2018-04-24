Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933720AbeDXNQj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:16:39 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:36632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933702AbeDXNQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:33 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Joerg Roedel <joro@8bytes.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>
Subject: RE: [PATCH v6 4/7] iommu/dma: Move PCI window region reservation
 back into dma specific path.
Thread-Topic: [PATCH v6 4/7] iommu/dma: Move PCI window region reservation
 back into dma specific path.
Thread-Index: AQHT1wqIshoVBiw+zkKwZhnC1ptSYaQGZ1GQ
Date: Tue, 24 Apr 2018 13:16:19 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8386928A8@FRAEML521-MBX.china.huawei.com>
References: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
 <20180418114045.7968-5-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20180418114045.7968-5-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Could you please take a look at this patch and let me know.

I have rebased this to 4.17-rc1  and added Robin's R-by.

This series[1] is now pending on this patch as without this it will break few
ARM platforms[2]. 

Please take a look and let me know.

Thanks,
Shameer

[1] https://lkml.org/lkml/2018/4/18/293
[2] https://lkml.org/lkml/2018/3/14/881


> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: Wednesday, April 18, 2018 12:41 PM
> To: alex.williamson@redhat.com; eric.auger@redhat.com;
> pmorel@linux.vnet.ibm.com
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org; iommu@lists.linux-
> foundation.org; Linuxarm <linuxarm@huawei.com>; John Garry
> <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Shameerali
> Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Joerg Roedel
> <joro@8bytes.org>
> Subject: [PATCH v6 4/7] iommu/dma: Move PCI window region reservation
> back into dma specific path.
> 
> This pretty much reverts commit 273df9635385 ("iommu/dma: Make PCI
> window reservation generic")  by moving the PCI window region
> reservation back into the dma specific path so that these regions
> doesn't get exposed via the IOMMU API interface. With this change,
> the vfio interface will report only iommu specific reserved regions
> to the user space.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 54 ++++++++++++++++++++++----------------------
> ---
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
> + * ITS region reservation on ACPI based ARM platforms that may require HW
> MSI
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
> @@ -229,6 +205,23 @@ static int cookie_init_hw_msi_region(struct
> iommu_dma_cookie *cookie,
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
> @@ -238,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device
> *dev,
>  	LIST_HEAD(resv_regions);
>  	int ret = 0;
> 
> +	if (dev_is_pci(dev))
> +		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
> +
>  	iommu_get_resv_regions(dev, &resv_regions);
>  	list_for_each_entry(region, &resv_regions, list) {
>  		unsigned long lo, hi;
> --
> 2.7.4
> 
