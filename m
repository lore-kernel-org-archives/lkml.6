Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbeBSTn3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:43:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753466AbeBSTn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:43:27 -0500
Date: Mon, 19 Feb 2018 12:43:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>
Subject: Re: [PATCH v3 2/6] vfio/type1: Check reserve region conflict and
 update iova list
Message-ID: <20180219124321.4ad37e4d@w520.home>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838648B14@FRAEML521-MBX.china.huawei.com>
References: <20180215094504.4972-1-shameerali.kolothum.thodi@huawei.com>
        <20180215094504.4972-3-shameerali.kolothum.thodi@huawei.com>
        <20180216141810.55d754da@w520.home>
        <5FC3163CFD30C246ABAA99954A238FA838648B14@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018 10:00:53 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Friday, February 16, 2018 9:18 PM
> > 
> > On Thu, 15 Feb 2018 09:45:00 +0000
> > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> > > +	iommu_get_group_resv_regions(iommu_group, &group_resv_regions);
> > > +
> > > +	if (vfio_iommu_resv_conflict(iommu, &group_resv_regions)) {
> > > +		ret = -EINVAL;
> > > +		goto out_detach;
> > > +	}
> > > +
> > >  	/* Get a copy of the current iova list and work on it */
> > >  	INIT_LIST_HEAD(&iova_copy);
> > >  	ret = vfio_iommu_get_iova_copy(iommu, &iova_copy);
> > > @@ -1437,6 +1512,10 @@ static int vfio_iommu_type1_attach_group(void  
> > *iommu_data,  
> > >  	if (ret)
> > >  		goto out_detach;
> > >
> > > +	ret = vfio_iommu_resv_exclude(&iova_copy, &group_resv_regions);
> > > +	if (ret)
> > > +		goto out_detach;
> > > +
> > >  	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
> > >
> > >  	INIT_LIST_HEAD(&domain->group_list);
> > > @@ -1497,6 +1576,9 @@ static int vfio_iommu_type1_attach_group(void  
> > *iommu_data,  
> > >  	/* Delete the old one and insert new iova list */
> > >  	vfio_iommu_insert_iova_copy(iommu, &iova_copy);
> > >
> > > +	list_for_each_entry_safe(resv, resv_next, &group_resv_regions, list)
> > > +		kfree(resv);  
> > 
> > list_del() here and below, also this can be done after the mutex unlock.  
> 
> Ok. I thought that as the reserved regions are local to this function, list_del() is
> not required.  Same for the iova_copy in the first patch as well(which I missed to
> comment there).

What you have works (afaik), it just seems sloppy to me to have free'd
entries in the list, even as the destructor, as this is not a
performance critical path.  Is this more common elsewhere in the kernel
than I suspect?  Thanks,

Alex
