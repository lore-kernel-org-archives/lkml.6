Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751766AbeBWPPR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:15:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeBWPPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:15:15 -0500
Date: Fri, 23 Feb 2018 08:15:13 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH v5] vfio/type1: Adopt fast IOTLB flush interface when
 unmap IOVAs
Message-ID: <20180223081513.33f799f7@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191015A83@SHSMSX101.ccr.corp.intel.com>
References: <1517466458-3523-1-git-send-email-suravee.suthikulpanit@amd.com>
        <20180222155915.543804e8@w520.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D191015A83@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018 08:20:51 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson
> > Sent: Friday, February 23, 2018 6:59 AM
> > 
> > On Thu,  1 Feb 2018 01:27:38 -0500
> > Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> >   
> > > VFIO IOMMU type1 currently upmaps IOVA pages synchronously, which  
> > requires  
> > > IOTLB flushing for every unmapping. This results in large IOTLB flushing
> > > overhead when handling pass-through devices has a large number of  
> > mapped  
> > > IOVAs. This can be avoided by using the new IOTLB flushing interface.
> > >
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > > ---
> > >
> > > Changes from v4 (https://lkml.org/lkml/2018/1/31/153)
> > >  * Change return type from ssize_t back to size_t since we no longer
> > >    changing IOMMU API. Also update error handling logic accordingly.
> > >  * In unmap_unpin_fast(), also sync when failing to allocate entry.
> > >  * Some code restructuring and variable renaming.
> > >
> > >  drivers/vfio/vfio_iommu_type1.c | 128  
> > ++++++++++++++++++++++++++++++++++++----  
> > >  1 file changed, 117 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c  
> > b/drivers/vfio/vfio_iommu_type1.c  
> > > index e30e29a..6041530 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -102,6 +102,13 @@ struct vfio_pfn {
> > >  	atomic_t		ref_count;
> > >  };
> > >
> > > +struct vfio_regions {
> > > +	struct list_head list;
> > > +	dma_addr_t iova;
> > > +	phys_addr_t phys;
> > > +	size_t len;
> > > +};
> > > +
> > >  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
> > >  					(!list_empty(&iommu->domain_list))
> > >
> > > @@ -648,11 +655,102 @@ static int  
> > vfio_iommu_type1_unpin_pages(void *iommu_data,  
> > >  	return i > npage ? npage : (i > 0 ? i : -EINVAL);
> > >  }
> > >
> > > +static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain  
> > *domain,  
> > > +				struct list_head *regions)
> > > +{
> > > +	long unlocked = 0;
> > > +	struct vfio_regions *entry, *next;
> > > +
> > > +	iommu_tlb_sync(domain->domain);
> > > +
> > > +	list_for_each_entry_safe(entry, next, regions, list) {
> > > +		unlocked += vfio_unpin_pages_remote(dma,
> > > +						    entry->iova,
> > > +						    entry->phys >>  
> > PAGE_SHIFT,  
> > > +						    entry->len >> PAGE_SHIFT,
> > > +						    false);
> > > +		list_del(&entry->list);
> > > +		kfree(entry);
> > > +	}
> > > +
> > > +	cond_resched();
> > > +
> > > +	return unlocked;
> > > +}
> > > +
> > > +/*
> > > + * Generally, VFIO needs to unpin remote pages after each IOTLB flush.
> > > + * Therefore, when using IOTLB flush sync interface, VFIO need to keep  
> > track  
> > > + * of these regions (currently using a list).
> > > + *
> > > + * This value specifies maximum number of regions for each IOTLB flush  
> > sync.  
> > > + */
> > > +#define VFIO_IOMMU_TLB_SYNC_MAX		512
> > > +
> > > +static size_t unmap_unpin_fast(struct vfio_domain *domain,
> > > +			       struct vfio_dma *dma, dma_addr_t *iova,
> > > +			       size_t len, phys_addr_t phys, long *unlocked,
> > > +			       struct list_head *unmapped_list,
> > > +			       int *unmapped_cnt)
> > > +{
> > > +	size_t unmapped = 0;
> > > +	struct vfio_regions *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> > > +
> > > +	if (entry) {
> > > +		unmapped = iommu_unmap_fast(domain->domain, *iova,  
> > len);  
> > > +
> > > +		if (!unmapped) {
> > > +			kfree(entry);
> > > +		} else {
> > > +			iommu_tlb_range_add(domain->domain, *iova,  
> > unmapped);  
> > > +			entry->iova = *iova;
> > > +			entry->phys = phys;
> > > +			entry->len  = unmapped;
> > > +			list_add_tail(&entry->list, unmapped_list);
> > > +
> > > +			*iova += unmapped;
> > > +			(*unmapped_cnt)++;
> > > +		}
> > > +	}
> > > +
> > > +	/*
> > > +	 * Sync if the number of fast-unmap regions hits the limit
> > > +	 * or in case of errors.
> > > +	 */
> > > +	if (*unmapped_cnt >= VFIO_IOMMU_TLB_SYNC_MAX  
> > || !unmapped) {  
> > > +		*unlocked += vfio_sync_unpin(dma, domain,
> > > +					     unmapped_list);
> > > +		*unmapped_cnt = 0;
> > > +	}  
> 
> I'm not sure why returning ZERO is treated as only unmap error 
> here, but if looking at __iommu_unmap clearly there are other
> error codes returned also. I know it's not introduced by this
> patch but Alex, was it deliberately implemented such way under 
> any assumption or a typo?

iommu_unmap() returns a size_t, an unsigned type.  Suravee has another
patch in the iommu space to correct that function from trying to return
-errno.  Thanks,

Alex
