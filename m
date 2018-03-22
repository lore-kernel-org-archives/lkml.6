Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeCVVsC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:48:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeCVVsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:48:01 -0400
Date: Thu, 22 Mar 2018 15:48:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, joro@8bytes.org,
        jroedel@suse.de
Subject: Re: [PATCH v5] vfio/type1: Adopt fast IOTLB flush interface when
 unmap IOVAs
Message-ID: <20180322154800.5c873f61@w520.home>
In-Reply-To: <20180222155915.543804e8@w520.home>
References: <1517466458-3523-1-git-send-email-suravee.suthikulpanit@amd.com>
        <20180222155915.543804e8@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2018 15:59:15 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu,  1 Feb 2018 01:27:38 -0500
> Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> 
> > VFIO IOMMU type1 currently upmaps IOVA pages synchronously, which requires
> > IOTLB flushing for every unmapping. This results in large IOTLB flushing
> > overhead when handling pass-through devices has a large number of mapped
> > IOVAs. This can be avoided by using the new IOTLB flushing interface.
> > 
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > ---
> > 
> > Changes from v4 (https://lkml.org/lkml/2018/1/31/153)
> >  * Change return type from ssize_t back to size_t since we no longer
> >    changing IOMMU API. Also update error handling logic accordingly.
> >  * In unmap_unpin_fast(), also sync when failing to allocate entry.
> >  * Some code restructuring and variable renaming.
> > 
> >  drivers/vfio/vfio_iommu_type1.c | 128 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 117 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index e30e29a..6041530 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -102,6 +102,13 @@ struct vfio_pfn {
> >  	atomic_t		ref_count;
> >  };
> >  
> > +struct vfio_regions {
> > +	struct list_head list;
> > +	dma_addr_t iova;
> > +	phys_addr_t phys;
> > +	size_t len;
> > +};
> > +
> >  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
> >  					(!list_empty(&iommu->domain_list))
> >  
> > @@ -648,11 +655,102 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
> >  	return i > npage ? npage : (i > 0 ? i : -EINVAL);
> >  }
> >  
> > +static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
> > +				struct list_head *regions)
> > +{
> > +	long unlocked = 0;
> > +	struct vfio_regions *entry, *next;
> > +
> > +	iommu_tlb_sync(domain->domain);
> > +
> > +	list_for_each_entry_safe(entry, next, regions, list) {
> > +		unlocked += vfio_unpin_pages_remote(dma,
> > +						    entry->iova,
> > +						    entry->phys >> PAGE_SHIFT,
> > +						    entry->len >> PAGE_SHIFT,
> > +						    false);
> > +		list_del(&entry->list);
> > +		kfree(entry);
> > +	}
> > +
> > +	cond_resched();
> > +
> > +	return unlocked;
> > +}
> > +
> > +/*
> > + * Generally, VFIO needs to unpin remote pages after each IOTLB flush.
> > + * Therefore, when using IOTLB flush sync interface, VFIO need to keep track
> > + * of these regions (currently using a list).
> > + *
> > + * This value specifies maximum number of regions for each IOTLB flush sync.
> > + */
> > +#define VFIO_IOMMU_TLB_SYNC_MAX		512
> > +
> > +static size_t unmap_unpin_fast(struct vfio_domain *domain,
> > +			       struct vfio_dma *dma, dma_addr_t *iova,
> > +			       size_t len, phys_addr_t phys, long *unlocked,
> > +			       struct list_head *unmapped_list,
> > +			       int *unmapped_cnt)
> > +{
> > +	size_t unmapped = 0;
> > +	struct vfio_regions *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> > +
> > +	if (entry) {
> > +		unmapped = iommu_unmap_fast(domain->domain, *iova, len);
> > +
> > +		if (!unmapped) {
> > +			kfree(entry);
> > +		} else {
> > +			iommu_tlb_range_add(domain->domain, *iova, unmapped);
> > +			entry->iova = *iova;
> > +			entry->phys = phys;
> > +			entry->len  = unmapped;
> > +			list_add_tail(&entry->list, unmapped_list);
> > +
> > +			*iova += unmapped;
> > +			(*unmapped_cnt)++;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Sync if the number of fast-unmap regions hits the limit
> > +	 * or in case of errors.
> > +	 */
> > +	if (*unmapped_cnt >= VFIO_IOMMU_TLB_SYNC_MAX || !unmapped) {
> > +		*unlocked += vfio_sync_unpin(dma, domain,
> > +					     unmapped_list);
> > +		*unmapped_cnt = 0;
> > +	}
> > +
> > +	return unmapped;
> > +}
> > +
> > +static size_t unmap_unpin_slow(struct vfio_domain *domain,
> > +			       struct vfio_dma *dma, dma_addr_t *iova,
> > +			       size_t len, phys_addr_t phys,
> > +			       long *unlocked)
> > +{
> > +	size_t unmapped = iommu_unmap(domain->domain, *iova, len);
> > +
> > +	if (unmapped) {
> > +		*unlocked += vfio_unpin_pages_remote(dma, *iova,
> > +						     phys >> PAGE_SHIFT,
> > +						     unmapped >> PAGE_SHIFT,
> > +						     false);
> > +		*iova += unmapped;
> > +		cond_resched();
> > +	}
> > +	return unmapped;
> > +}
> > +
> >  static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >  			     bool do_accounting)
> >  {
> >  	dma_addr_t iova = dma->iova, end = dma->iova + dma->size;
> >  	struct vfio_domain *domain, *d;
> > +	struct list_head unmapped_region_list;
> > +	int unmapped_region_cnt = 0;
> >  	long unlocked = 0;
> >  
> >  	if (!dma->size)
> > @@ -661,6 +759,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >  	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
> >  		return 0;
> >  
> > +	INIT_LIST_HEAD(&unmapped_region_list);  
> 
> Since I harassed Shameer about using LIST_HEAD() for the iova list
> extension, I feel obligated to note that it can also be used here.  If
> you approve I'll just remove the above INIT_LIST_HEAD() and declare
> unmapped_region_list as LIST_HEAD(unmapped_region_list);, no need to
> re-send.  Otherwise looks fine to me.  Thanks,

I went ahead with this option, applied to vfio next branch for v4.17.
Thanks,

Alex
