Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeBTJGF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:06:05 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:26768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750884AbeBTJGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:06:02 -0500
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
Thread-Index: AQHTpkHywewGFV4vb02SraHyjP+pPaOncfGAgAQOoBCAAJglgIAA7Fgw
Date: Tue, 20 Feb 2018 09:05:30 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838649208@FRAEML521-MBX.china.huawei.com>
References: <20180215094504.4972-1-shameerali.kolothum.thodi@huawei.com>
        <20180215094504.4972-2-shameerali.kolothum.thodi@huawei.com>
        <20180216134917.61b33f75@w520.home>
        <5FC3163CFD30C246ABAA99954A238FA838648AF9@FRAEML521-MBX.china.huawei.com>
 <20180219125113.6c493c08@w520.home>
In-Reply-To: <20180219125113.6c493c08@w520.home>
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



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Monday, February 19, 2018 7:51 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: eric.auger@redhat.com; pmorel@linux.vnet.ibm.com;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; John Garry <john.garry@huawei.com>; xuwei (O)
> <xuwei5@huawei.com>
> Subject: Re: [PATCH v3 1/6] vfio/type1: Introduce iova list and add iommu
> aperture validity check
> 
> On Mon, 19 Feb 2018 09:50:24 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
> > > -----Original Message-----
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Friday, February 16, 2018 8:49 PM
> > > On Thu, 15 Feb 2018 09:44:59 +0000
> > > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> > > > +			node->end = end;
> > > > +			continue;
> > > > +		}
> > > > +		/* Delete nodes after new end */
> > > > +		list_del(&node->list);
> > > > +		kfree(node);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int vfio_iommu_get_iova_copy(struct vfio_iommu *iommu,
> > > > +				struct list_head *iova_copy)
> > > > +{
> > > > +
> > > > +	struct list_head *iova = &iommu->iova_list;
> > > > +	struct vfio_iova *n;
> > > > +
> > > > +	list_for_each_entry(n, iova, list) {
> > > > +		int ret;
> > > > +
> > > > +		ret = vfio_insert_iova(n->start, n->end, iova_copy);
> > > > +		if (ret)
> > > > +			return ret;
> > >
> > > Let's delete and free any entries added to the copy here too.
> >
> > Ok. My original thought was caller will free up in case of error.
> 
> This comes down to Rusty's suggestions of how to make an API hard to
> misuse rather than simply easy to use to me.  Placing the onus on the
> caller to cleanup a list sounds simple, but the caller passed an empty
> list and the function failed, why should the caller bother to check if
> the function left any cruft on the list in the course of failing?  This
> is not a hard to misuse interface, in fact it's very easy to forget
> that cleanup.  Thanks,

Ok. I understand the concerns. I will sent out a revised one soon.

Thanks,
Shameer
