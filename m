Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbeAaSCw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:02:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40892 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752824AbeAaSCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:02:50 -0500
Subject: Re: [PATCH 1/2] iommu: Fix iommu_unmap and iommu_unmap_fast return
 type
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: jroedel@suse.de
References: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1517363285-89304-2-git-send-email-suravee.suthikulpanit@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <eaa33cb6-3df0-6f95-59ea-e563076d7f76@arm.com>
Date: Wed, 31 Jan 2018 18:02:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517363285-89304-2-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On 31/01/18 01:48, Suravee Suthikulpanit wrote:
> Currently, iommu_unmap and iommu_unmap_fast return unmapped
> pages with size_t.  However, the actual value returned could
> be error codes (< 0), which can be misinterpreted as large
> number of unmapped pages. Therefore, change the return type to ssize_t.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd_iommu.c   |  6 +++---
>   drivers/iommu/intel-iommu.c |  4 ++--

Er, there are a few more drivers than that implementing iommu_ops ;)

It seems like it might be more sensible to fix the single instance of a 
driver returning -EINVAL (which appears to be a "should never happen if 
used correctly" kinda thing anyway) and leave the API-internal callback 
prototype as-is. I do agree the inconsistency of iommu_unmap() itself 
wants sorting, though (particularly the !IOMMU_API stubs which are wrong 
either way).

Robin.

>   drivers/iommu/iommu.c       | 16 ++++++++--------
>   include/linux/iommu.h       | 20 ++++++++++----------
>   4 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 7d5eb00..3609f51 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3030,11 +3030,11 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
>   	return ret;
>   }
>   
> -static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
> -			   size_t page_size)
> +static ssize_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
> +			       size_t page_size)
>   {
>   	struct protection_domain *domain = to_pdomain(dom);
> -	size_t unmap_size;
> +	ssize_t unmap_size;
>   
>   	if (domain->mode == PAGE_MODE_NONE)
>   		return -EINVAL;
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 4a2de34..15ba866 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5068,8 +5068,8 @@ static int intel_iommu_map(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> -static size_t intel_iommu_unmap(struct iommu_domain *domain,
> -				unsigned long iova, size_t size)
> +static ssize_t intel_iommu_unmap(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
>   {
>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>   	struct page *freelist = NULL;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3de5c0b..8f7da8a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1557,12 +1557,12 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   }
>   EXPORT_SYMBOL_GPL(iommu_map);
>   
> -static size_t __iommu_unmap(struct iommu_domain *domain,
> -			    unsigned long iova, size_t size,
> -			    bool sync)
> +static ssize_t __iommu_unmap(struct iommu_domain *domain,
> +			     unsigned long iova, size_t size,
> +			     bool sync)
>   {
>   	const struct iommu_ops *ops = domain->ops;
> -	size_t unmapped_page, unmapped = 0;
> +	ssize_t unmapped_page, unmapped = 0;
>   	unsigned long orig_iova = iova;
>   	unsigned int min_pagesz;
>   
> @@ -1617,15 +1617,15 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   	return unmapped;
>   }
>   
> -size_t iommu_unmap(struct iommu_domain *domain,
> -		   unsigned long iova, size_t size)
> +ssize_t iommu_unmap(struct iommu_domain *domain,
> +		    unsigned long iova, size_t size)
>   {
>   	return __iommu_unmap(domain, iova, size, true);
>   }
>   EXPORT_SYMBOL_GPL(iommu_unmap);
>   
> -size_t iommu_unmap_fast(struct iommu_domain *domain,
> -			unsigned long iova, size_t size)
> +ssize_t iommu_unmap_fast(struct iommu_domain *domain,
> +			 unsigned long iova, size_t size)
>   {
>   	return __iommu_unmap(domain, iova, size, false);
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 41b8c57..78df048 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -199,8 +199,8 @@ struct iommu_ops {
>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>   		   phys_addr_t paddr, size_t size, int prot);
> -	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
> -		     size_t size);
> +	ssize_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
> +			 size_t size);
>   	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
>   			 struct scatterlist *sg, unsigned int nents, int prot);
>   	void (*flush_iotlb_all)(struct iommu_domain *domain);
> @@ -299,10 +299,10 @@ extern void iommu_detach_device(struct iommu_domain *domain,
>   extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>   extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		     phys_addr_t paddr, size_t size, int prot);
> -extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> -			  size_t size);
> -extern size_t iommu_unmap_fast(struct iommu_domain *domain,
> -			       unsigned long iova, size_t size);
> +extern ssize_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> +			   size_t size);
> +extern ssize_t iommu_unmap_fast(struct iommu_domain *domain,
> +				unsigned long iova, size_t size);
>   extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   				struct scatterlist *sg,unsigned int nents,
>   				int prot);
> @@ -465,14 +465,14 @@ static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	return -ENODEV;
>   }
>   
> -static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> -			      size_t size)
> +static inline ssize_t iommu_unmap(struct iommu_domain *domain,
> +				  unsigned long iova, size_t size)
>   {
>   	return -ENODEV;
>   }
>   
> -static inline int iommu_unmap_fast(struct iommu_domain *domain, unsigned long iova,
> -				   int gfp_order)
> +static inline ssize_t iommu_unmap_fast(struct iommu_domain *domain,
> +				       unsigned long iova, int gfp_order)
>   {
>   	return -ENODEV;
>   }
> 
