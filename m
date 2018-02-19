Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbeBSJvF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:51:05 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:26625 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752109AbeBSJvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:51:03 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>
Subject: RE: [PATCH v3 1/6] vfio/type1: Introduce iova list and add iommu
 aperture validity check
Thread-Topic: [PATCH v3 1/6] vfio/type1: Introduce iova list and add iommu
 aperture validity check
Thread-Index: AQHTpkHywewGFV4vb02SraHyjP+pPaOncfGAgAQOoBA=
Date: Mon, 19 Feb 2018 09:50:24 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838648AF9@FRAEML521-MBX.china.huawei.com>
References: <20180215094504.4972-1-shameerali.kolothum.thodi@huawei.com>
        <20180215094504.4972-2-shameerali.kolothum.thodi@huawei.com>
 <20180216134917.61b33f75@w520.home>
In-Reply-To: <20180216134917.61b33f75@w520.home>
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

Hi Alex,

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, February 16, 2018 8:49 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: eric.auger@redhat.com; pmorel@linux.vnet.ibm.com;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; John Garry <john.garry@huawei.com>; xuwei (O)
> <xuwei5@huawei.com>
> Subject: Re: [PATCH v3 1/6] vfio/type1: Introduce iova list and add iommu
> aperture validity check
> 
> On Thu, 15 Feb 2018 09:44:59 +0000
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> 
> > This introduces an iova list that is valid for dma mappings. Make
> > sure the new iommu aperture window doesn't conflict with the current
> > one or with any existing dma mappings during attach.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 183
> +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 181 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> > index e30e29a..4726f55 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -60,6 +60,7 @@ MODULE_PARM_DESC(disable_hugepages,
> >
> >  struct vfio_iommu {
> >  	struct list_head	domain_list;
> > +	struct list_head	iova_list;
> >  	struct vfio_domain	*external_domain; /* domain for external user
> */
> >  	struct mutex		lock;
> >  	struct rb_root		dma_list;
> > @@ -92,6 +93,12 @@ struct vfio_group {
> >  	struct list_head	next;
> >  };
> >
> > +struct vfio_iova {
> > +	struct list_head	list;
> > +	dma_addr_t		start;
> > +	dma_addr_t		end;
> > +};
> > +
> >  /*
> >   * Guest RAM pinning working set or DMA target
> >   */
> > @@ -1192,6 +1199,142 @@ static bool vfio_iommu_has_sw_msi(struct
> iommu_group *group, phys_addr_t *base)
> >  	return ret;
> >  }
> >
> > +/*
> > + * This is a helper function to insert an address range to iova list.
> > + * The list starts with a single entry corresponding to the IOMMU
> > + * domain geometry to which the device group is attached. The list
> > + * aperture gets modified when a new domain is added to the container
> > + * if the new aperture doesn't conflict with the current one or with
> > + * any existing dma mappings. The list is also modified to exclude
> > + * any reserved regions associated with the device group.
> > + */
> > +static int vfio_insert_iova(phys_addr_t start, phys_addr_t end,
> > +				struct list_head *head)
> 
> The args seem more natural to me and have better consistency with the
> other functions re-ordered as (head, start, end).
> 
> Also, if the iova list is dma_addr_t, why are we using phys_addr_t for
> args?
> 
> > +{
> > +	struct vfio_iova *region;
> > +
> > +	region = kmalloc(sizeof(*region), GFP_KERNEL);
> > +	if (!region)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&region->list);
> > +	region->start = start;
> > +	region->end = end;
> > +
> > +	list_add_tail(&region->list, head);
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Check the new iommu aperture conflicts with existing aper or
> > + * with any existing dma mappings.
> > + */
> > +static bool vfio_iommu_aper_conflict(struct vfio_iommu *iommu,
> > +				     phys_addr_t start,
> > +				     phys_addr_t end)
> 
> Same here, why phys_addr_t when comparing to dma_addr_t?
> 
> > +{
> > +	struct vfio_iova *first, *last;
> > +	struct list_head *iova = &iommu->iova_list;
> > +
> > +	if (list_empty(iova))
> > +		return false;
> > +
> > +	/* Disjoint sets, return conflict */
> > +	first = list_first_entry(iova, struct vfio_iova, list);
> > +	last = list_last_entry(iova, struct vfio_iova, list);
> > +	if ((start > last->end) || (end < first->start))
> > +		return true;
> > +
> > +	/* Check for any existing dma mappings outside the new start */
> > +	if (start > first->start) {
> > +		if (vfio_find_dma(iommu, first->start, start - first->start))
> > +			return true;
> > +	}
> > +
> > +	/* Check for any existing dma mappings outside the new end */
> > +	if (end < last->end) {
> > +		if (vfio_find_dma(iommu, end + 1, last->end - end))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * Resize iommu iova aperture window. This is called only if the new
> > + * aperture has no conflict with existing aperture and dma mappings.
> > + */
> > +static int vfio_iommu_aper_resize(struct list_head *iova,
> > +				      dma_addr_t start,
> > +				      dma_addr_t end)
> 
> And here we're back to dma_addr_t, let's be consistent.

Ok. I will take care of all the above inconsistencies.

> > +{
> > +	struct vfio_iova *node, *next;
> > +
> > +	if (list_empty(iova))
> > +		return vfio_insert_iova(start, end, iova);
> > +
> > +	/* Adjust iova list start */
> > +	list_for_each_entry_safe(node, next, iova, list) {
> > +		if (start < node->start)
> > +			break;
> > +		if ((start >= node->start) && (start < node->end)) {
> > +			node->start = start;
> > +			break;
> > +		}
> > +		/* Delete nodes before new start */
> > +		list_del(&node->list);
> > +		kfree(node);
> > +	}
> > +
> > +	/* Adjust iova list end */
> > +	list_for_each_entry_safe(node, next, iova, list) {
> > +		if (end > node->end)
> > +			continue;
> > +
> 
> nit, extra blank line vs block above.
> 
> > +		if ((end >= node->start) && (end < node->end)) {
> 
> This test is still incorrect, if end == node->start, we get a zero
> sized range, we should have let it pass over to get deleted.  Therefore
> the first test should be (end > node->start).  The second test was
> changed and is now incorrect, if end == node->end, then we want to keep
> this range, not delete it.  This test should have remained (end <=
> node->end) as it was in the previous version.  IOW, my previous comment
> was applied to the wrong test.

Thanks. I got the test wrong for this case.

> > +			node->end = end;
> > +			continue;
> > +		}
> > +		/* Delete nodes after new end */
> > +		list_del(&node->list);
> > +		kfree(node);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int vfio_iommu_get_iova_copy(struct vfio_iommu *iommu,
> > +				struct list_head *iova_copy)
> > +{
> > +
> > +	struct list_head *iova = &iommu->iova_list;
> > +	struct vfio_iova *n;
> > +
> > +	list_for_each_entry(n, iova, list) {
> > +		int ret;
> > +
> > +		ret = vfio_insert_iova(n->start, n->end, iova_copy);
> > +		if (ret)
> > +			return ret;
> 
> Let's delete and free any entries added to the copy here too.

Ok. My original thought was caller will free up in case of error.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void vfio_iommu_insert_iova_copy(struct vfio_iommu *iommu,
> > +					struct list_head *iova_copy)
> > +{
> > +	struct list_head *iova = &iommu->iova_list;
> > +	struct vfio_iova *n, *next;
> > +
> > +	list_for_each_entry_safe(n, next, iova, list) {
> > +		list_del(&n->list);
> > +		kfree(n);
> > +	}
> > +
> > +	list_splice_tail(iova_copy, iova);
> > +}
> > +
> >  static int vfio_iommu_type1_attach_group(void *iommu_data,
> >  					 struct iommu_group *iommu_group)
> >  {
> > @@ -1202,6 +1345,9 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  	int ret;
> >  	bool resv_msi, msi_remap;
> >  	phys_addr_t resv_msi_base;
> > +	struct iommu_domain_geometry geo;
> > +	struct list_head iova_copy;
> > +	struct vfio_iova *iova, *iova_next;
> >
> >  	mutex_lock(&iommu->lock);
> >
> > @@ -1271,6 +1417,26 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  	if (ret)
> >  		goto out_domain;
> >
> > +	/* Get aperture info */
> > +	iommu_domain_get_attr(domain->domain,
> DOMAIN_ATTR_GEOMETRY, &geo);
> > +
> > +	if (vfio_iommu_aper_conflict(iommu, geo.aperture_start,
> > +					    geo.aperture_end)) {
> > +		ret = -EINVAL;
> > +		goto out_detach;
> > +	}
> > +
> > +	/* Get a copy of the current iova list and work on it */
> > +	INIT_LIST_HEAD(&iova_copy);
> 
> We could have just declared this as:
> 
> LIST_HEAD(iova_copy);
> 
> to avoid needing to init it separately.

Ok.

Thanks,
Shameer

> > +	ret = vfio_iommu_get_iova_copy(iommu, &iova_copy);
> > +	if (ret)
> > +		goto out_detach;
> > +
> > +	ret = vfio_iommu_aper_resize(&iova_copy, geo.aperture_start,
> > +							geo.aperture_end);
> > +	if (ret)
> > +		goto out_detach;
> > +
> >  	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
> >
> >  	INIT_LIST_HEAD(&domain->group_list);
> > @@ -1304,8 +1470,7 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  				list_add(&group->next, &d->group_list);
> >  				iommu_domain_free(domain->domain);
> >  				kfree(domain);
> > -				mutex_unlock(&iommu->lock);
> > -				return 0;
> > +				goto done;
> >  			}
> >
> >  			ret = iommu_attach_group(domain->domain,
> iommu_group);
> > @@ -1328,6 +1493,9 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  	}
> >
> >  	list_add(&domain->next, &iommu->domain_list);
> > +done:
> > +	/* Delete the old one and insert new iova list */
> > +	vfio_iommu_insert_iova_copy(iommu, &iova_copy);
> >
> >  	mutex_unlock(&iommu->lock);
> >
> > @@ -1337,6 +1505,8 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  	iommu_detach_group(domain->domain, iommu_group);
> >  out_domain:
> >  	iommu_domain_free(domain->domain);
> > +	list_for_each_entry_safe(iova, iova_next, &iova_copy, list)
> > +		kfree(iova);
> 
> Let's do the list_del() too, it's making me squirm that it's not here
> and this is not a performance path.
> 
> >  out_free:
> >  	kfree(domain);
> >  	kfree(group);
> > @@ -1475,6 +1645,7 @@ static void *vfio_iommu_type1_open(unsigned
> long arg)
> >  	}
> >
> >  	INIT_LIST_HEAD(&iommu->domain_list);
> > +	INIT_LIST_HEAD(&iommu->iova_list);
> >  	iommu->dma_list = RB_ROOT;
> >  	mutex_init(&iommu->lock);
> >  	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
> > @@ -1502,6 +1673,7 @@ static void vfio_iommu_type1_release(void
> *iommu_data)
> >  {
> >  	struct vfio_iommu *iommu = iommu_data;
> >  	struct vfio_domain *domain, *domain_tmp;
> > +	struct vfio_iova *iova, *iova_next;
> >
> >  	if (iommu->external_domain) {
> >  		vfio_release_domain(iommu->external_domain, true);
> > @@ -1517,6 +1689,13 @@ static void vfio_iommu_type1_release(void
> *iommu_data)
> >  		list_del(&domain->next);
> >  		kfree(domain);
> >  	}
> > +
> > +	list_for_each_entry_safe(iova, iova_next,
> > +				 &iommu->iova_list, list) {
> > +		list_del(&iova->list);
> > +		kfree(iova);
> > +	}
> > +
> >  	kfree(iommu);
> >  }
> >
